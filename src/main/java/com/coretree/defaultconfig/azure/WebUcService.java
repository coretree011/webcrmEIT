package com.coretree.defaultconfig.azure;

import java.io.IOException;
import java.net.UnknownHostException;
import java.nio.ByteOrder;
import java.security.Principal;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.NoSuchElementException;
import java.util.concurrent.atomic.AtomicBoolean;
import java.util.concurrent.locks.Lock;
import java.util.concurrent.locks.ReentrantReadWriteLock;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ApplicationListener;
import org.springframework.messaging.core.MessageSendingOperations;
import org.springframework.messaging.handler.annotation.MessageExceptionHandler;
import org.springframework.messaging.handler.annotation.MessageMapping;
import org.springframework.messaging.simp.SimpMessagingTemplate;
import org.springframework.messaging.simp.annotation.SendToUser;
import org.springframework.messaging.simp.broker.BrokerAvailabilityEvent;
import org.springframework.stereotype.Service;
import org.springframework.web.bind.annotation.RestController;

import com.coretree.defaultconfig.main.mapper.CallbackMapper;
import com.coretree.defaultconfig.main.mapper.OrganizationMapper;
import com.coretree.defaultconfig.main.mapper.UserLogMapper;
import com.coretree.defaultconfig.main.model.Callback;
import com.coretree.defaultconfig.main.model.OrgStatatistics;
import com.coretree.defaultconfig.main.model.UserLog;
import com.coretree.defaultconfig.mapper.Customer2;
import com.coretree.defaultconfig.mapper.Customer2Mapper;
import com.coretree.defaultconfig.mapper.SmsMapper_sample;
import com.coretree.defaultconfig.mapper.Sms_sample;
import com.coretree.defaultconfig.statis.mapper.CallStatMapper;
import com.coretree.defaultconfig.statis.model.CallStat;
import com.coretree.event.HaveGotUcMessageEventArgs;
import com.coretree.event.IEventHandler;
import com.coretree.event.IEventHandler2;
import com.coretree.event.LogedoutEventArgs;
import com.coretree.models.GroupWareData;
import com.coretree.models.Organization;
import com.coretree.models.SmsData;
import com.coretree.models.UcMessage;
import com.coretree.socket.UcServer;
import com.coretree.util.Const4pbx;

@Service
@RestController
public class WebUcService implements
        ApplicationListener<BrokerAvailabilityEvent> ,
        IEventHandler<HaveGotUcMessageEventArgs>,
        ITelStatusService,
        IEventHandler2<LogedoutEventArgs> {

    private static final Log logger = LogFactory.getLog(WebUcService.class);

	private final MessageSendingOperations<String> messagingTemplate;
	private final SimpMessagingTemplate msgTemplate;

    //private ITelStatusService ucservice;

    private UcServer uc;

	private AtomicBoolean brokerAvailable = new AtomicBoolean();
	private ByteOrder byteorder = ByteOrder.BIG_ENDIAN;
	// private ByteOrder byteorder = ByteOrder.LITTLE_ENDIAN;

    @Autowired
    private WebUcServiceConfig configs;

    @Autowired
	private OrganizationMapper organizationMapper;

    @Autowired
	private Customer2Mapper custMapper;

    @Autowired
	private CallStatMapper callstatMapper;

    @Autowired
	private SmsMapper_sample smsMapper;

    @Autowired
	private CallbackMapper cbmapper;

    @Autowired
	private UserLogMapper userlogmapper;

	private List<CallStat> curcalls = new ArrayList<CallStat>();
	private static List<Organization> organizations;
	private List<Sms_sample> smsrunning = new ArrayList<Sms_sample>();
	
	private final ReentrantReadWriteLock rwl = new ReentrantReadWriteLock();
    private final Lock r = rwl.readLock();
    private final Lock w = rwl.writeLock();
    
    @Autowired
    public WebUcService(MessageSendingOperations<String> messagingTemplate, SimpMessagingTemplate msgTemplate) {
        this.messagingTemplate = messagingTemplate;
        this.msgTemplate = msgTemplate;
        
        organizations = new ArrayList<Organization>();
    }

////////////////////////////
    
    private void LeaveLogs(Organization organization) {
//		UserLog userlog = new UserLog();
//		userlog.setEmpNo(organization.getEmpNo());
//		userlog.setAgentStatCd(organization.getAgentStatCd());
//		userlog.setStartTimestamp(organization.getStartdate());
//		userlog.setEndTimestamp();
    	
    	// userlogmapper.addUserLog(userlog);
		userlogmapper.addLog(organization);
    }

    public void UpdateOrganization(Organization organization) {
    	organization.setPrevAgentStatCd(organization.getAgentStatCd());
    	organization.setPrevStartdate(organization.getStartdate());
    	
    	organization.setAgentStatCd(String.valueOf(organization.getTempval()));
    	organization.setStartdate(LocalDateTime.now());
    }
    
	private void usersState() {
    	OrgStatatistics orgstates = new OrgStatatistics();
    	
    	// orgstates.setTotal(organizations.size());
    	orgstates.setTotal((int)(organizations.stream().filter(x -> x.getAgentStatCd().equals("110") == false).count()));
    	orgstates.setReady((int)organizations.stream().filter(x -> x.getAgentStatCd().equals("1011")).count());
    	orgstates.setAfter((int)organizations.stream().filter(x -> x.getAgentStatCd().equals("1012")).count());
    	orgstates.setBusy((int)organizations.stream().filter(x -> x.getAgentStatCd().equals("1016")).count());
    	orgstates.setLeft((int)organizations.stream().filter(x -> x.getAgentStatCd().equals("1013")).count());
    	orgstates.setRest((int)organizations.stream().filter(x -> x.getAgentStatCd().equals("1014")).count());
    	orgstates.setEdu((int)organizations.stream().filter(x -> x.getAgentStatCd().equals("1015")).count());
    	orgstates.setLogedin((int)organizations.stream().filter(x -> x.getAgentStatCd().equals("1018")).count());
    	orgstates.setLogedout((int)organizations.stream().filter(x -> x.getAgentStatCd().equals("1017")).count());
    	// orgstates.setLogedin(orgstates.getReady() + orgstates.getAfter() + orgstates.getBusy() + orgstates.getLeft() + orgstates.getEdu());
    	// orgstates.setLogedout(orgstates.getTotal() - orgstates.getLogedin());
		
    	// this.msgTemplate.convertAndSendToUser("/topic/orgstates", orgstates);
    	this.messagingTemplate.convertAndSend("/topic/orgstates", orgstates);
	}
	
	@MessageMapping("/call" )
	public void queueCallMessage(UcMessage message, Principal principal) {
		
		//logger.debug("::::::queueCallMessage------>" + principal);
		//System.out.println("::::::queueCallMessage------>" + message.toString());
		logger.debug(message.cmd+ ":=================>>>" + message);
		
		Organization organization = null;
		r.lock();
		try {
			organization = organizations.stream().filter(x -> x.getExtensionNo().equals(message.extension)).findFirst().get();
		} catch (NoSuchElementException | NullPointerException e) {
			organization = null;
		} finally {
			r.unlock();
		}
		
		switch (message.cmd) {
			case Const4pbx.WS_REQ_EXTENSION_STATE:
				message.cmd = Const4pbx.WS_RES_EXTENSION_STATE;
				for (Organization organ : organizations) {
					message.extension = organ.getExtensionNo();
					message.status = Integer.valueOf(organ.getAgentStatCd());
					this.msgTemplate.convertAndSendToUser(principal.getName(), "/queue/groupware", message);
				}
				this.usersState();
				break;
			case Const4pbx.WS_REQ_SET_EXTENSION_STATE:
				// Organization orgnization = organizations.stream().filter(x -> x.getExtensionNo().equals(message.extension)).findFirst().get();
				// logger.debug(orgnization);
				break;
			case Const4pbx.WS_REQ_RELOAD_USER:
				break;
			case Const4pbx.WS_REQ_CHANGE_EXTENSION_STATE:
				switch (message.status) {
					case Const4pbx.WS_VALUE_EXTENSION_STATE_READY:
						switch (Integer.valueOf(organization.getAgentStatCd())) {
							case Const4pbx.WS_VALUE_EXTENSION_STATE_READY:
								message.cmd = Const4pbx.WS_RES_CHANGE_EXTENSION_STATE;
								message.status = Const4pbx.UC_STATUS_FAIL;
								message.statusmsg = Const4pbx.WS_VALUE_EXTENSION_STATE_SAMEASNOW;
								this.msgTemplate.convertAndSendToUser(principal.getName(), "/queue/groupware", message);
								break;
							case Const4pbx.WS_VALUE_EXTENSION_STATE_AFTER:
							case Const4pbx.WS_VALUE_EXTENSION_STATE_LEFT:
							case Const4pbx.WS_VALUE_EXTENSION_STATE_REST:
							case Const4pbx.WS_VALUE_EXTENSION_STATE_EDU:
							case Const4pbx.WS_VALUE_EXTENSION_STATE_LOGEDON:
							case Const4pbx.WS_VALUE_EXTENSION_STATE_LOGEDOUT:
								organization.setTempval(message.status);
								this.RequestToPbx(message);
								break;
							default:
								message.cmd = Const4pbx.WS_RES_CHANGE_EXTENSION_STATE;
								message.status = Const4pbx.UC_STATUS_FAIL;
								message.statusmsg = Const4pbx.WS_VALUE_EXTENSION_STATE_WRONGREQ;
								this.msgTemplate.convertAndSendToUser(principal.getName(), "/queue/groupware", message);
								break;
						}
						break;
					case Const4pbx.WS_VALUE_EXTENSION_STATE_AFTER:
						switch (Integer.valueOf(organization.getAgentStatCd())) {
							case Const4pbx.WS_VALUE_EXTENSION_STATE_AFTER:
								message.cmd = Const4pbx.WS_RES_CHANGE_EXTENSION_STATE;
								message.status = Const4pbx.UC_STATUS_FAIL;
								message.statusmsg = Const4pbx.WS_VALUE_EXTENSION_STATE_SAMEASNOW;
								this.msgTemplate.convertAndSendToUser(principal.getName(), "/queue/groupware", message);
								// this.messagingTemplate.convertAndSend("/topic/ext.state." + organization.getExtensionNo(), message);
								break;
							case Const4pbx.WS_VALUE_EXTENSION_STATE_LEFT:
							case Const4pbx.WS_VALUE_EXTENSION_STATE_REST:
							case Const4pbx.WS_VALUE_EXTENSION_STATE_EDU:
							case Const4pbx.WS_VALUE_EXTENSION_STATE_LOGEDON:
							case Const4pbx.WS_VALUE_EXTENSION_STATE_LOGEDOUT:
								organization.setTempval(message.status);
								this.UpdateOrganization(organization);
								this.LeaveLogs(organization);
								
								message.cmd = Const4pbx.UC_REPORT_SRV_STATE;
								this.messagingTemplate.convertAndSend("/topic/ext.state." + organization.getExtensionNo(), message);
								this.usersState();
								
								message.cmd = Const4pbx.WS_RES_CHANGE_EXTENSION_STATE;
								message.status = Const4pbx.UC_STATUS_SUCCESS;
								message.statusmsg = message.status;
								this.msgTemplate.convertAndSendToUser(principal.getName(), "/queue/groupware", message);
								break;
							case Const4pbx.WS_VALUE_EXTENSION_STATE_READY:
								organization.setTempval(message.status);
								this.RequestToPbx(message);
								break;
							default:
								message.cmd = Const4pbx.WS_RES_CHANGE_EXTENSION_STATE;
								message.status = Const4pbx.UC_STATUS_FAIL;
								message.statusmsg = Const4pbx.WS_VALUE_EXTENSION_STATE_WRONGREQ;
								this.msgTemplate.convertAndSendToUser(principal.getName(), "/queue/groupware", message);
								// this.messagingTemplate.convertAndSend("/topic/ext.state." + organization.getExtensionNo(), message);
								break;
						}
						break;
					case Const4pbx.WS_VALUE_EXTENSION_STATE_LEFT:
						switch (Integer.valueOf(organization.getAgentStatCd())) {
							case Const4pbx.WS_VALUE_EXTENSION_STATE_LEFT:
								message.cmd = Const4pbx.WS_RES_CHANGE_EXTENSION_STATE;
								message.status = Const4pbx.UC_STATUS_FAIL;
								message.statusmsg = Const4pbx.WS_VALUE_EXTENSION_STATE_SAMEASNOW;
								this.msgTemplate.convertAndSendToUser(principal.getName(), "/queue/groupware", message);
								// this.messagingTemplate.convertAndSend("/topic/ext.state." + organization.getExtensionNo(), message);
								break;
							case Const4pbx.WS_VALUE_EXTENSION_STATE_AFTER:
							case Const4pbx.WS_VALUE_EXTENSION_STATE_REST:
							case Const4pbx.WS_VALUE_EXTENSION_STATE_EDU:
							case Const4pbx.WS_VALUE_EXTENSION_STATE_LOGEDON:
							case Const4pbx.WS_VALUE_EXTENSION_STATE_LOGEDOUT:
								organization.setTempval(message.status);
								this.UpdateOrganization(organization);
								this.LeaveLogs(organization);
								
								message.cmd = Const4pbx.UC_REPORT_SRV_STATE;
								this.messagingTemplate.convertAndSend("/topic/ext.state." + organization.getExtensionNo(), message);
								this.usersState();
								
								message.cmd = Const4pbx.WS_RES_CHANGE_EXTENSION_STATE;
								message.status = Const4pbx.UC_STATUS_SUCCESS;
								message.statusmsg = message.status;
								this.msgTemplate.convertAndSendToUser(principal.getName(), "/queue/groupware", message);
								break;
							case Const4pbx.WS_VALUE_EXTENSION_STATE_READY:
								organization.setTempval(message.status);
								this.RequestToPbx(message);
								break;
							default:
								message.cmd = Const4pbx.WS_RES_CHANGE_EXTENSION_STATE;
								message.status = Const4pbx.UC_STATUS_FAIL;
								message.statusmsg = Const4pbx.WS_VALUE_EXTENSION_STATE_WRONGREQ;
								this.msgTemplate.convertAndSendToUser(principal.getName(), "/queue/groupware", message);
								// this.messagingTemplate.convertAndSend("/topic/ext.state." + organization.getExtensionNo(), message);
								break;
						}
						break;
					case Const4pbx.WS_VALUE_EXTENSION_STATE_REST:
						switch (Integer.valueOf(organization.getAgentStatCd())) {
							case Const4pbx.WS_VALUE_EXTENSION_STATE_REST:
								message.cmd = Const4pbx.WS_RES_CHANGE_EXTENSION_STATE;
								message.status = Const4pbx.UC_STATUS_FAIL;
								message.statusmsg = Const4pbx.WS_VALUE_EXTENSION_STATE_SAMEASNOW;
								this.msgTemplate.convertAndSendToUser(principal.getName(), "/queue/groupware", message);
								// this.messagingTemplate.convertAndSend("/topic/ext.state." + organization.getExtensionNo(), message);
								break;
							case Const4pbx.WS_VALUE_EXTENSION_STATE_AFTER:
							case Const4pbx.WS_VALUE_EXTENSION_STATE_LEFT:
							case Const4pbx.WS_VALUE_EXTENSION_STATE_EDU:
							case Const4pbx.WS_VALUE_EXTENSION_STATE_LOGEDON:
							case Const4pbx.WS_VALUE_EXTENSION_STATE_LOGEDOUT:
								organization.setTempval(message.status);
								this.UpdateOrganization(organization);
								this.LeaveLogs(organization);
								
								message.cmd = Const4pbx.UC_REPORT_SRV_STATE;
								this.messagingTemplate.convertAndSend("/topic/ext.state." + organization.getExtensionNo(), message);
								this.usersState();
								
								message.cmd = Const4pbx.WS_RES_CHANGE_EXTENSION_STATE;
								message.status = Const4pbx.UC_STATUS_SUCCESS;
								message.statusmsg = message.status;
								this.msgTemplate.convertAndSendToUser(principal.getName(), "/queue/groupware", message);
								break;
							case Const4pbx.WS_VALUE_EXTENSION_STATE_READY:
								organization.setTempval(message.status);
								this.RequestToPbx(message);
								break;
							default:
								message.cmd = Const4pbx.WS_RES_CHANGE_EXTENSION_STATE;
								message.status = Const4pbx.UC_STATUS_FAIL;
								message.statusmsg = Const4pbx.WS_VALUE_EXTENSION_STATE_WRONGREQ;
								this.msgTemplate.convertAndSendToUser(principal.getName(), "/queue/groupware", message);
								// this.messagingTemplate.convertAndSend("/topic/ext.state." + organization.getExtensionNo(), message);
								break;
						}
						break;
					case Const4pbx.WS_VALUE_EXTENSION_STATE_EDU:
						switch (Integer.valueOf(organization.getAgentStatCd())) {
							case Const4pbx.WS_VALUE_EXTENSION_STATE_EDU:
								message.cmd = Const4pbx.WS_RES_CHANGE_EXTENSION_STATE;
								message.status = Const4pbx.UC_STATUS_FAIL;
								message.statusmsg = Const4pbx.WS_VALUE_EXTENSION_STATE_SAMEASNOW;
								this.msgTemplate.convertAndSendToUser(principal.getName(), "/queue/groupware", message);
								// this.messagingTemplate.convertAndSend("/topic/ext.state." + organization.getExtensionNo(), message);
								break;
							case Const4pbx.WS_VALUE_EXTENSION_STATE_AFTER:
							case Const4pbx.WS_VALUE_EXTENSION_STATE_LEFT:
							case Const4pbx.WS_VALUE_EXTENSION_STATE_REST:
							case Const4pbx.WS_VALUE_EXTENSION_STATE_LOGEDON:
							case Const4pbx.WS_VALUE_EXTENSION_STATE_LOGEDOUT:
								organization.setTempval(message.status);
								this.UpdateOrganization(organization);
								this.LeaveLogs(organization);
								
								message.cmd = Const4pbx.UC_REPORT_SRV_STATE;
								this.messagingTemplate.convertAndSend("/topic/ext.state." + organization.getExtensionNo(), message);
								this.usersState();
								
								message.cmd = Const4pbx.WS_RES_CHANGE_EXTENSION_STATE;
								message.status = Const4pbx.UC_STATUS_SUCCESS;
								message.statusmsg = message.status;
								this.msgTemplate.convertAndSendToUser(principal.getName(), "/queue/groupware", message);
								break;
							case Const4pbx.WS_VALUE_EXTENSION_STATE_READY:
								organization.setTempval(message.status);
								this.RequestToPbx(message);
								break;
							default:
								message.cmd = Const4pbx.WS_RES_CHANGE_EXTENSION_STATE;
								message.status = Const4pbx.UC_STATUS_FAIL;
								message.statusmsg = Const4pbx.WS_VALUE_EXTENSION_STATE_WRONGREQ;
								this.msgTemplate.convertAndSendToUser(principal.getName(), "/queue/groupware", message);
								// this.messagingTemplate.convertAndSend("/topic/ext.state." + organization.getExtensionNo(), message);
								break;
						}
						break;
					case Const4pbx.WS_VALUE_EXTENSION_STATE_LOGEDON:
						switch (Integer.valueOf(organization.getAgentStatCd())) {
							case Const4pbx.WS_VALUE_EXTENSION_STATE_LOGEDON:
								message.cmd = Const4pbx.WS_RES_CHANGE_EXTENSION_STATE;
								message.status = Const4pbx.UC_STATUS_FAIL;
								message.statusmsg = Const4pbx.WS_VALUE_EXTENSION_STATE_SAMEASNOW;
								this.msgTemplate.convertAndSendToUser(principal.getName(), "/queue/groupware", message);
								// this.messagingTemplate.convertAndSend("/topic/ext.state." + organization.getExtensionNo(), message);
								break;
							case Const4pbx.WS_VALUE_EXTENSION_STATE_READY:
							case Const4pbx.WS_VALUE_EXTENSION_STATE_AFTER:
							case Const4pbx.WS_VALUE_EXTENSION_STATE_LEFT:
							case Const4pbx.WS_VALUE_EXTENSION_STATE_REST:
							case Const4pbx.WS_VALUE_EXTENSION_STATE_EDU:
							case Const4pbx.WS_VALUE_EXTENSION_STATE_LOGEDOUT:
								organization.setTempval(message.status);
								this.RequestToPbx(message);
								break;
							default:
								message.cmd = Const4pbx.WS_RES_CHANGE_EXTENSION_STATE;
								message.status = Const4pbx.UC_STATUS_FAIL;
								message.statusmsg = Const4pbx.WS_VALUE_EXTENSION_STATE_WRONGREQ;
								this.msgTemplate.convertAndSendToUser(principal.getName(), "/queue/groupware", message);
								// this.messagingTemplate.convertAndSend("/topic/ext.state." + organization.getExtensionNo(), message);
								break;
						}
						break;
					case Const4pbx.WS_VALUE_EXTENSION_STATE_LOGEDOUT:
						switch (Integer.valueOf(organization.getAgentStatCd())) {
							case Const4pbx.WS_VALUE_EXTENSION_STATE_LOGEDOUT:
								message.cmd = Const4pbx.WS_RES_CHANGE_EXTENSION_STATE;
								message.status = Const4pbx.UC_STATUS_FAIL;
								message.statusmsg = Const4pbx.WS_VALUE_EXTENSION_STATE_SAMEASNOW;
								this.msgTemplate.convertAndSendToUser(principal.getName(), "/queue/groupware", message);
								// this.messagingTemplate.convertAndSend("/topic/ext.state." + organization.getExtensionNo(), message);
								break;
							case Const4pbx.WS_VALUE_EXTENSION_STATE_READY:
							case Const4pbx.WS_VALUE_EXTENSION_STATE_AFTER:
							case Const4pbx.WS_VALUE_EXTENSION_STATE_LEFT:
							case Const4pbx.WS_VALUE_EXTENSION_STATE_REST:
							case Const4pbx.WS_VALUE_EXTENSION_STATE_EDU:
							case Const4pbx.WS_VALUE_EXTENSION_STATE_LOGEDON:
								organization.setTempval(message.status);
								this.RequestToPbx(message);
								break;
							default:
								message.cmd = Const4pbx.WS_RES_CHANGE_EXTENSION_STATE;
								message.status = Const4pbx.UC_STATUS_FAIL;
								message.statusmsg = Const4pbx.WS_VALUE_EXTENSION_STATE_WRONGREQ;
								this.msgTemplate.convertAndSendToUser(principal.getName(), "/queue/groupware", message);
								// this.messagingTemplate.convertAndSend("/topic/ext.state." + organization.getExtensionNo(), message);
								break;
						}
						break;
					default:
	//					Organization organization;
	//					r.lock();
	//					try {
	//						organization = organizations.stream().filter(x -> x.getExtensionNo().equals(message.extension)).findFirst().get();
	//					} catch (NoSuchElementException | NullPointerException e) {
	//						organization = null;
	//					} finally {
	//						r.unlock();
	//					}
	
						this.RequestToPbx(message);
						// organization.setTempval(message.cmd);
						break;
				}
				break;
			default:
				this.RequestToPbx(message);
				organization.setTempval(message.cmd);
				break;
		}
	}

	@MessageMapping("/sendmsg")
	public void queueSmsMessage(SmsData message) {
		switch (message.getCmd()) {
			case Const4pbx.UC_SMS_SEND_REQ:
				this.SendSms(message);
				break;
			default:
				break;
		}
	}

	@MessageExceptionHandler
	@SendToUser("/queue/errors")
	public String handleException(Throwable exception) {
		logger.error("handleException : " + exception.getMessage());
		return exception.getMessage();
	}
    
////////////////////////////    
	
	
	private void InitializeUserState() {
		organizations = organizationMapper.getUsers();
        for(Organization org : organizations) {
        	org.LogedoutEventHandler.addEventHandler(this);
        }
		
		sendExtensionStatus();
	}
	
	private void sendExtensionStatus() {
		UcMessage msg = new UcMessage();
		msg.cmd = Const4pbx.UC_BUSY_EXT_REQ;

		try {
			this.uc.Send(msg);
		} catch (UnknownHostException e) {
			e.printStackTrace();
		}
	}
	
	
////////////////////////////	
    
	@Override
    public void RequestToPbx(UcMessage msg) {
        try {
            //logger.debug("RequestToPbx------>>>"+ msg);
            uc.Send(msg);
            logger.debug("RequestToPbx------>>>"+ msg);
        } 
        catch (UnknownHostException e) {
           logger.error("RequestToPbx",e);
        }
    }

    @Override
    public void SendSms(SmsData msg) {
        try {
            uc.Send(msg);
        } catch (UnknownHostException e) {
            logger.error("SendSms",e);
        }
    }

    @Override
    public void onApplicationEvent(BrokerAvailabilityEvent event) {
    	
        this.brokerAvailable.set(event.isBrokerAvailable());
        
        uc = new UcServer(configs.getPbxip(), 31001, 1, this.byteorder);
        uc.HaveGotUcMessageEventHandler.addEventHandler(this);
        // uc.regist();

        InitializeUserState();
    }

    @Override
	public void eventReceived(Object sender, HaveGotUcMessageEventArgs e) {
		// when a message have been arrived from the groupware socket 31001, an event raise.
		// DB
		GroupWareData data = new GroupWareData(e.getItem(), byteorder);
		
		logger.debug("<<<---------" + data.toString());

		if (!this.brokerAvailable.get()) return;

		UcMessage payload;

		switch (data.getCmd()) {
			case Const4pbx.UC_REGISTER_RES:
			case Const4pbx.UC_UNREGISTER_RES:
			case Const4pbx.UC_BUSY_EXT_RES:
				break;
			case Const4pbx.UC_SMS_SEND_RES:
				this.PassReportSms(e.getItem());
				break;
			case Const4pbx.UC_REPORT_EXT_STATE:
				for (Organization organization : organizations) {
					if (organization.getExtensionNo().equals(data.getExtension())) {
						organization.setAgentStatCd(String.valueOf(data.getStatus()));
					}
				}
				if (data.getCallee().isEmpty()) break;
			case Const4pbx.UC_REPORT_SRV_STATE:
			case Const4pbx.UC_SET_SRV_RES:
			case Const4pbx.UC_CLEAR_SRV_RES:
			case Const4pbx.UC_REPORT_WAITING_COUNT:
				this.PassReportExtState(data);
				break;
			case Const4pbx.UC_SMS_INFO_REQ:
				this.PassReportSms2(e.getItem());
				break;
			case Const4pbx.UC_SEND_INPUT_DATA_REQ:
				data.setCmd(Const4pbx.UC_SEND_INPUT_DATA_RES);
				data.setStatus(Const4pbx.UC_STATUS_SUCCESS);
				try {
					this.uc.Send(data);
					
					Callback cb = new Callback();
					LocalDateTime localdatetime = LocalDateTime.now();
					DateTimeFormatter df = DateTimeFormatter.ofPattern("yyyyMMdd");
					cb.setResDate(localdatetime.format(df));
					df = DateTimeFormatter.ofPattern("HHmmss");
					cb.setResHms(localdatetime.format(df));
					cb.setGenDirNo(data.getCallee());
					// cb.setResTelNo(data.getCaller());
					cb.setResTelNo(data.getInputData());
					
					cbmapper.insTCallback(cb);
					
				} catch (IOException e1) {
					System.err.println(String.format("Has failed to send %s", e1.getStackTrace().toString()));
				} catch (Exception e2) {
					e2.printStackTrace();
				}
				break;
			default:
				if (data.getExtension() == null) return;
				if (data.getExtension().isEmpty()) return;

				// Organization organization = organizationMapper.selectByExt(data.getExtension());
				Organization organization = organizations.stream().filter(x -> x.getExtensionNo().equals(data.getExtension())).findFirst().get();

				if (organization.getEmpNo() == null) return;
				if (organization.getEmpNm().isEmpty()) return;

				payload = new UcMessage();
				payload.cmd = data.getCmd();
				payload.extension = data.getExtension();
				payload.caller = data.getCaller();
				payload.callee = data.getCallee();
				try {
					payload.status = Integer.valueOf(data.getUserAgent());
				} catch (NumberFormatException e3) {
					e3.printStackTrace();
				}

				logger.debug("******userName==>"+ organization.getEmpNo());
				this.msgTemplate.convertAndSendToUser(organization.getEmpNo(), "/queue/groupware", payload);
				break;
		}
	}

	private void PassReportExtState(GroupWareData data) {
		UcMessage payload = new UcMessage();
		payload.cmd = data.getCmd();
		payload.direct = data.getDirect();
		payload.extension = data.getExtension();
		payload.caller = data.getCaller();
		payload.callee = data.getCallee();
		payload.unconditional = data.getUnconditional();
		payload.status = data.getStatus();
		payload.responseCode = data.getResponseCode();

		Organization organization = null;

		r.lock();
		try
		{
			organization = organizations.stream().filter(x -> x.getExtensionNo().equals(data.getExtension())).findFirst().get();
		} catch (NoSuchElementException | NullPointerException e) {
			return;
		} finally {
			r.unlock();
		}
		
		// logger.info("******PassReportExtState:" + data.getCmd());

		switch (data.getCmd()) {
			case Const4pbx.UC_REPORT_WAITING_COUNT:
				this.messagingTemplate.convertAndSend("/topic/ext.state." + data.getExtension(), payload);
				break;
			case Const4pbx.UC_CLEAR_SRV_RES:
				if (data.getStatus() == Const4pbx.UC_STATUS_SUCCESS) {
					// organization.setAgentStatCd(String.valueOf(Const4pbx.WS_VALUE_EXTENSION_STATE_READY));
					organization.setTempval(Const4pbx.WS_VALUE_EXTENSION_STATE_READY);
					organization.setTempstr("");
					this.UpdateOrganization(organization);
					this.LeaveLogs(organization);
					
					payload.cmd = Const4pbx.WS_RES_CHANGE_EXTENSION_STATE;
					payload.status = Const4pbx.UC_STATUS_SUCCESS;
					payload.statusmsg = Const4pbx.WS_VALUE_EXTENSION_STATE_READY;
					this.msgTemplate.convertAndSendToUser(organization.getEmpNo(), "/queue/groupware", payload);
					
					payload.cmd = Const4pbx.UC_REPORT_SRV_STATE;
					this.messagingTemplate.convertAndSend("/topic/ext.state." + data.getExtension(), payload);
					
					this.usersState();
				}
				break;
			case Const4pbx.UC_SET_SRV_RES:
				if (data.getStatus() == Const4pbx.UC_STATUS_SUCCESS) {
					this.UpdateOrganization(organization);
					this.LeaveLogs(organization);
					
					// organization.setAgentStatCd(String.valueOf(organization.getTempval()));

					switch (data.getResponseCode()) {
						case Const4pbx.UC_SRV_UNCONDITIONAL:
							organization.setTempstr(data.getUnconditional());
							break;
						case Const4pbx.UC_SRV_NOANSWER:
							organization.setTempstr(data.getNoanswer());
							break;
						case Const4pbx.UC_SRV_BUSY:
							organization.setTempstr(data.getBusy());
							break;
					}
				} else {
					this.msgTemplate.convertAndSendToUser(organization.getEmpNo(), "/queue/groupware", payload);
				}
				break;
			case Const4pbx.UC_REPORT_SRV_STATE:
				payload.status = Integer.valueOf(organization.getAgentStatCd());
				this.messagingTemplate.convertAndSend("/topic/ext.state." + organization.getExtensionNo(), payload);
				this.usersState();
				
				/*
				if (organization.getAgentStatCd().equals(Const4pbx.WS_VALUE_EXTENSION_STATE_READY)
						|| organization.getAgentStatCd().equals(String.valueOf(Const4pbx.WS_VALUE_EXTENSION_STATE_AFTER))
						|| organization.getAgentStatCd().equals(String.valueOf(Const4pbx.WS_VALUE_EXTENSION_STATE_LEFT)) 
						|| organization.getAgentStatCd().equals(String.valueOf(Const4pbx.WS_VALUE_EXTENSION_STATE_REST))
						|| organization.getAgentStatCd().equals(String.valueOf(Const4pbx.WS_VALUE_EXTENSION_STATE_EDU))) {
					payload.status = organization.getAgentStatCd();

					this.messagingTemplate.convertAndSend("/topic/ext.state." + data.getExtension(), payload);
					this.usersState();
				}
				*/
				
				/*
				if (data.getStatus() == Const4pbx.UC_STATUS_SUCCESS) {
					if (organization.getTempval() == Const4pbx.WS_VALUE_EXTENSION_STATE_READY
							|| organization.getTempval() == Const4pbx.WS_VALUE_EXTENSION_STATE_AFTER
							|| organization.getTempval() == Const4pbx.WS_VALUE_EXTENSION_STATE_LEFT 
							|| organization.getTempval() == Const4pbx.WS_VALUE_EXTENSION_STATE_REST
							|| organization.getTempval() == Const4pbx.WS_VALUE_EXTENSION_STATE_EDU) {
						
						organization.setAgentStatCd(String.valueOf(organization.getTempval()));

						UserLog userlog = new UserLog();
						userlog.setEmpNo(organization.getEmpNm());
						userlog.setAgentStatCd(organization.getAgentStatCd());
						this.WriteUserLogs(userlog);
						
						payload.status = String.valueOf(organization.getTempval());

						this.messagingTemplate.convertAndSend("/topic/ext.state." + data.getExtension(), payload);
						this.usersState();
					}
				} else {
					organization.setTempval(-1);
					payload.status = String.valueOf(Const4pbx.UC_STATUS_FAIL);

					this.messagingTemplate.convertAndSend("/topic/ext.state." + data.getExtension(), payload);
				}
				*/
				break;
			case Const4pbx.UC_REPORT_EXT_STATE:
				CallStat callstat = null;

				switch (data.getDirect()) {
					case Const4pbx.UC_DIRECT_INCOMING:

						r.lock();
						try {
							callstat = curcalls.stream().filter(x -> x.getCallId().equals(String.valueOf(data.getStartCallSec()) + String.valueOf(data.getStartCallUSec()))).findFirst().get();
						} catch (NullPointerException | NoSuchElementException e) {
							callstat = null;
						} finally {
							r.unlock();
						}

						switch (data.getStatus()) {
							case Const4pbx.UC_CALL_STATE_IDLE:
								if (callstat != null) {
									if (callstat.getStatus() == Const4pbx.UC_CALL_STATE_RINGING) {
										callstat.setAgentTransYn("N");
										callstatMapper.updateCallStatEnd(callstat);
										
										w.lock();
										try {
											curcalls.removeIf(x -> x.getCallId().equals(String.valueOf(data.getStartCallSec()) + String.valueOf(data.getStartCallUSec())));
										} finally {
											w.unlock();
										}
									} else if (callstat.getStatus() == Const4pbx.UC_CALL_STATE_BUSY) {
										callstat.setStatus(data.getStatus());
										callstat.setAgentTransYn("Y");
										callstat.setCallStatSec((int)((new Date().getTime() - callstat.getSdate().getTime()) / 1000));
										callstatMapper.updateCallStatEnd(callstat);

										w.lock();
										try {
											curcalls.removeIf(x -> x.getCallId().equals(String.valueOf(data.getStartCallSec()) + String.valueOf(data.getStartCallUSec())));
										} finally {
											w.unlock();
										}
									}
									this.messagingTemplate.convertAndSend("/topic/ext.state." + data.getExtension(), payload);
									// System.err.println("IDLE curcalls.size(): " + curcalls.size());
								}
								break;
							case Const4pbx.UC_CALL_STATE_INVITING:
							case Const4pbx.UC_CALL_STATE_RINGING:
								if (callstat == null) {
									callstat = new CallStat();
									callstat.setCallId(String.valueOf(data.getStartCallSec()) + String.valueOf(data.getStartCallUSec()));
									callstat.setExtension(data.getExtension());
									callstat.setTelNo(data.getCaller());
									callstat.setStatus(data.getStatus());
									callstat.setCallTypCd(String.valueOf(data.getDirect()));
									callstat.setEmpNo(organization.getEmpNo());
									
									LocalDateTime localdatetime = LocalDateTime.now();
									DateTimeFormatter df = DateTimeFormatter.ofPattern("yyyyMMdd");
									callstat.setRegDate(localdatetime.format(df));
							
									df = DateTimeFormatter.ofPattern("HHmmss");
									callstat.setRegHms(localdatetime.format(df));
									
									w.lock();
									try {
										curcalls.add(callstat);
									} finally {
										w.unlock();
									}

									callstatMapper.insertCallStat(callstat);
									this.messagingTemplate.convertAndSend("/topic/ext.state." + data.getExtension(), payload);
									// System.err.println("INCOMMING Ringing curcalls.size(): " + curcalls.size());
								}
								break;
							case Const4pbx.UC_CALL_STATE_BUSY:
								if (callstat != null) {
									callstat.setStatus(data.getStatus());
									callstat.setSdate(new Date());
									callstat.setAgentTransYn("Y");
									
									this.messagingTemplate.convertAndSend("/topic/ext.state." + data.getExtension(), payload);
									// System.err.println("BUSY curcalls.size(): " + curcalls.size());
								}
								break;
						}

						if (callstat != null) {
							callstat.setStatus(data.getStatus());

							if (organization != null) {
								Customer2 cust = custMapper.findByExt(data.getCaller());

								if (cust != null) {
									payload.callername = cust.getCust_nm();
									payload.cust_no = cust.getCust_cd();
								}
								if (organization != null) {
									payload.calleename = organization.getEmpNo();
								}

								payload.callid = callstat.getCallId();
								this.msgTemplate.convertAndSendToUser(organization.getEmpNo(), "/queue/groupware", payload);
							}
						}
						break;
					case Const4pbx.UC_DIRECT_OUTGOING:
						r.lock();
						try {
							callstat = curcalls.stream().filter(x -> x.getCallId().equals(String.valueOf(data.getStartCallSec()) + String.valueOf(data.getStartCallUSec()))).findFirst().get();
						} catch (NullPointerException | NoSuchElementException e) {
							callstat = null;
						} finally {
							r.unlock();
						}

						switch (data.getStatus()) {
							case Const4pbx.UC_CALL_STATE_IDLE:
								if (callstat != null) {
									if (callstat.getStatus() == Const4pbx.UC_CALL_STATE_RINGING) {
										callstat.setAgentTransYn("N");
										callstatMapper.updateCallStatEnd(callstat);

										w.lock();
										try {
											curcalls.removeIf(x -> x.getTelNo().equals(data.getCaller()) && x.getExtension().equals(data.getCallee()));
										} finally {
											w.unlock();
										}
									} else if (callstat.getStatus() == Const4pbx.UC_CALL_STATE_BUSY) {
										callstat.setStatus(data.getStatus());
										callstat.setAgentTransYn("Y");
										callstat.setCallStatSec((int)((new Date().getTime() - callstat.getSdate().getTime()) / 1000));
										callstatMapper.updateCallStatEnd(callstat);

										w.lock();
										try {
											curcalls.removeIf(x -> x.getCallId().equals(String.valueOf(data.getStartCallSec()) + String.valueOf(data.getStartCallUSec())));
										} finally {
											w.unlock();
										}
									}
									this.messagingTemplate.convertAndSend("/topic/ext.state." + data.getExtension(), payload);
									// System.err.println("IDLE curcalls.size(): " + curcalls.size());
								}
								break;
							case Const4pbx.UC_CALL_STATE_INVITING:
								if (callstat == null) {

									callstat = new CallStat();
									callstat.setCallId(String.valueOf(data.getStartCallSec()) + String.valueOf(data.getStartCallUSec()));
									callstat.setExtension(data.getExtension());
									callstat.setTelNo(data.getCallee());
									callstat.setStatus(data.getStatus());
									callstat.setCallTypCd(String.valueOf(data.getDirect()));
									callstat.setEmpNo(organization.getEmpNo());
									
									LocalDateTime localdatetime = LocalDateTime.now();
									DateTimeFormatter df = DateTimeFormatter.ofPattern("yyyyMMdd");
									callstat.setRegDate(localdatetime.format(df));
									
									df = DateTimeFormatter.ofPattern("HHmmss");
									callstat.setRegHms(localdatetime.format(df));

									w.lock();
									try {
										curcalls.add(callstat);
									} finally {
										w.unlock();
									}

									callstatMapper.insertCallStat(callstat);
									this.messagingTemplate.convertAndSend("/topic/ext.state." + data.getExtension(), payload);
								}
								break;
							case Const4pbx.UC_CALL_STATE_BUSY:
								if (callstat != null) {
									callstat.setSdate(new Date());
									callstat.setStatus(data.getStatus());
									
									this.messagingTemplate.convertAndSend("/topic/ext.state." + data.getExtension(), payload);
									System.err.println("BUSY curcalls.size(): " + curcalls.size());
								}
								break;
						}

						if (callstat != null) {
							callstat.setStatus(data.getStatus());

							if (organization != null) {
								Customer2 cust = custMapper.findByExt(data.getCallee());

								if (cust != null) {
									payload.calleename = cust.getCust_nm();
									payload.cust_no = cust.getCust_no();
								}
								if (organization != null) {
									payload.callername = organization.getEmpNo();
								}

								payload.callid = callstat.getCallId();
								this.msgTemplate.convertAndSendToUser(organization.getEmpNo(), "/queue/groupware", payload);
							}
						}
						break;
					default:
						this.messagingTemplate.convertAndSend("/topic/ext.state." + data.getExtension(), payload);
						break;
				}
				
				this.usersState();
				break;
		}
	}

	private void PassReportSms(byte[] bytes) {
		SmsData data = new SmsData(bytes, byteorder);
		Sms_sample sms = new Sms_sample();
		sms.setExt(data.getFrom_ext());
		sms.setCusts_tel(data.getReceiverphones());
		sms.setContents(data.getMessage());
		sms.setIdx(smsMapper.add(sms));

		r.lock();
		try {
			this.smsrunning.add(sms);
		} finally {
			r.unlock();
		}
	}

	private void PassReportSms2(byte[] bytes) {
		SmsData data = new SmsData(bytes, byteorder);
		data.setCmd(Const4pbx.UC_SMS_INFO_RES);
		if (data.getStatus() == Const4pbx.UC_STATUS_FAIL) {
			data.setStatus(Const4pbx.UC_STATUS_FAIL);
		} else {
			data.setStatus(Const4pbx.UC_STATUS_SUCCESS);
		}
		this.SendSms(data);

		Organization organization = organizations.stream().filter(x -> x.getExtensionNo().equals(data.getFrom_ext())).findFirst().get();

		if (organization.getEmpNo() == null) return;
		if (organization.getEmpNo().isEmpty()) return;

		UcMessage payload = new UcMessage();
		payload.cmd = data.getCmd();
		payload.extension = data.getFrom_ext();
		payload.status = data.getStatus();

		Sms_sample runningsms = null;

		r.lock();
		try {
			runningsms = smsrunning.stream().filter(x -> x.getExt().equals(data.getFrom_ext())).findFirst().get();
			runningsms.setResult(data.getStatus());
			payload.status = data.getStatus();
			smsMapper.setresult(runningsms);
		} catch (NoSuchElementException | NullPointerException e) {
			payload.status = Const4pbx.WS_STATUS_ING_NOTFOUND;
		} catch (Exception e) {

		} finally {
			r.unlock();
		}

		w.lock();
		try {
			smsrunning.removeIf(x -> x.equals(data.getFrom_ext()));
		} catch (UnsupportedOperationException | NullPointerException e) {
			payload.status = Const4pbx.WS_STATUS_ING_UNSUPPORTED;
		} finally {
			w.unlock();
		}

		this.msgTemplate.convertAndSendToUser(organization.getEmpNo(), "/queue/groupware", payload);
	}

	@Override
	public void EventReceived2(Object sender, LogedoutEventArgs e) {
		Organization org = (Organization)sender;
		
		UcMessage payload = new UcMessage();
		payload.cmd = Const4pbx.UC_REPORT_EXT_STATE;
		payload.extension = org.getExtensionNo();
		payload.status = Const4pbx.WS_VALUE_EXTENSION_STATE_LOGEDOUT;
		
		this.messagingTemplate.convertAndSend("/topic/ext.state." + org.getExtensionNo(), payload);
		this.usersState();
	}
}
