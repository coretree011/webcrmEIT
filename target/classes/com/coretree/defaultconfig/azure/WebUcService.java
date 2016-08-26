package com.coretree.defaultconfig.azure;

import java.io.IOException;
import java.net.UnknownHostException;
import java.nio.ByteOrder;
import java.security.Principal;
import java.sql.Timestamp;
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
import com.coretree.defaultconfig.mapper.Call;
import com.coretree.defaultconfig.mapper.CallMapper;
import com.coretree.defaultconfig.mapper.Customer2;
import com.coretree.defaultconfig.mapper.Customer2Mapper;
import com.coretree.defaultconfig.mapper.SmsMapper_sample;
import com.coretree.defaultconfig.mapper.Sms_sample;
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

//	@Autowired
//	private MemberMapper memberMapper;
	@Autowired
	private OrganizationMapper organizationMapper;	
	@Autowired
	private Customer2Mapper custMapper;
	@Autowired
	private CallMapper callMapper;
	@Autowired
	private SmsMapper_sample smsMapper;
	@Autowired
	private CallbackMapper cbmapper;
	@Autowired
	private UserLogMapper userlogmapper;
	
	//
	//@Autowired
	//private Principal pInfo;
	
	private List<Call> curcalls = new ArrayList<Call>();
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
    
    private void WriteUserLogs(UserLog userlog) {
    	Organization organization;
    	
    	try {
        	userlogmapper.addUserLog(userlog);
    	} catch (NoSuchElementException | NullPointerException e) {
    		organization = null;
    	} 
    }

    public static void UpdateUsersStates(String emp_no) {
    	Organization organization;
    	
    	try {
        	organization = organizations.stream().filter(x -> x.getEmpNo().equals(emp_no)).findFirst().get();
        	organization.setStartdate(new Date());
    	} catch (NoSuchElementException | NullPointerException e) {
    		organization = null;
    	}
    }
    
	private void usersState() {
    	OrgStatatistics orgstates = new OrgStatatistics();
    	
    	orgstates.setTotal(organizations.size());
    	orgstates.setReady((int)organizations.stream().filter(x -> x.getAgentStatCd().equals("1001")).count());
    	orgstates.setAfter((int)organizations.stream().filter(x -> x.getAgentStatCd().equals("1002")).count());
    	orgstates.setBusy((int)organizations.stream().filter(x -> x.getAgentStatCd().equals("1006")).count());
    	orgstates.setLeft((int)organizations.stream().filter(x -> x.getAgentStatCd().equals("1003")).count());
    	orgstates.setRest((int)organizations.stream().filter(x -> x.getAgentStatCd().equals("1004")).count());
    	orgstates.setEdu((int)organizations.stream().filter(x -> x.getAgentStatCd().equals("1005")).count());
    	orgstates.setLogedin(orgstates.getReady() + orgstates.getAfter() + orgstates.getBusy() + orgstates.getLeft() + orgstates.getEdu());
    	orgstates.setLogedout(orgstates.getTotal() - orgstates.getLogedin());
		
    	// this.msgTemplate.convertAndSendToUser("/topic/orgstates", orgstates);
    	this.messagingTemplate.convertAndSend("/topic/orgstates", orgstates);
	}
	
	@MessageMapping("/call" )
	public void queueCallMessage(UcMessage message, Principal principal) {
		
		//logger.debug("::::::queueCallMessage------>" + principal);
		System.out.println("::::::queueCallMessage------>" + message.toString());
		logger.debug(message.cmd+ ":=================>>>" + message);
		
		switch (message.cmd) {
			case Const4pbx.WS_REQ_EXTENSION_STATE:
				message.cmd = Const4pbx.WS_RES_EXTENSION_STATE;
				for (Organization m : organizations) {
					message.extension = m.getExtensionNo();
					message.status = m.getAgentStatCd();
					this.msgTemplate.convertAndSendToUser(principal.getName(), "/queue/groupware", message);
				}
				break;
			case Const4pbx.WS_REQ_SET_EXTENSION_STATE:
				Organization orgnization = organizations.stream().filter(x -> x.getExtensionNo().equals(message.extension)).findFirst().get();

				logger.debug(orgnization);
				break;
			case Const4pbx.WS_REQ_RELOAD_USER:
				break;
			case Const4pbx.WS_VALUE_EXTENSION_STATE_READY:
			case Const4pbx.WS_VALUE_EXTENSION_STATE_AFTER:
			case Const4pbx.WS_VALUE_EXTENSION_STATE_LEFT:
			case Const4pbx.WS_VALUE_EXTENSION_STATE_REST:
			case Const4pbx.WS_VALUE_EXTENSION_STATE_EDU:
				UpdateUsersStates(principal.getName());
			case Const4pbx.WS_VALUE_EXTENSION_STATE_LOGEDOUT:
				Organization organization;
				r.lock();
				try {
					organization = organizations.stream().filter(x -> x.getExtensionNo().equals(message.extension)).findFirst().get();
				} catch (NoSuchElementException | NullPointerException e) {
					organization = null;
				} finally {
					r.unlock();
				}

				this.RequestToPbx(message);
				organization.setTempval(message.cmd);
				
				UserLog userlog = new UserLog();
				userlog.setEmpNo(principal.getName());
				userlog.setAgentStatCd(String.valueOf(message.cmd));
				this.WriteUserLogs(userlog);
				break;
			default:
				this.RequestToPbx(message);
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
					//cb.setResTelNo(data.getCaller());
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
				payload.status = data.getUserAgent();

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
		payload.status = String.valueOf(data.getStatus());
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
		
		logger.info("******PassReportExtState:" + data.getCmd());

		switch (data.getCmd()) {
			case Const4pbx.UC_REPORT_WAITING_COUNT:
				this.messagingTemplate.convertAndSend("/topic/ext.state." + data.getExtension(), payload);
				break;
			case Const4pbx.UC_CLEAR_SRV_RES:
				if (data.getStatus() == Const4pbx.UC_STATUS_SUCCESS) {
					organization.setAgentStatCd(String.valueOf(Const4pbx.WS_VALUE_EXTENSION_STATE_READY));
					organization.setTempstr("");
					payload.status = organization.getAgentStatCd();
					this.messagingTemplate.convertAndSend("/topic/ext.state." + data.getExtension(), payload);
				}
				break;
			case Const4pbx.UC_SET_SRV_RES:
				if (data.getStatus() == Const4pbx.UC_STATUS_SUCCESS) {
					organization.setAgentStatCd(String.valueOf(organization.getTempval()));
					if (data.getResponseCode() == Const4pbx.UC_SRV_UNCONDITIONAL) {
						organization.setTempstr(data.getUnconditional());
					} else if (data.getResponseCode() == Const4pbx.UC_SRV_NOANSWER) {
						organization.setTempstr(data.getNoanswer());
					} else if (data.getResponseCode() == Const4pbx.UC_SRV_BUSY) {
						organization.setTempstr(data.getBusy());
					}
				}
				break;
			case Const4pbx.UC_REPORT_SRV_STATE:
				if (organization.getAgentStatCd().equals(Const4pbx.WS_VALUE_EXTENSION_STATE_READY)
						|| organization.getAgentStatCd().equals(String.valueOf(Const4pbx.WS_VALUE_EXTENSION_STATE_AFTER))
						|| organization.getAgentStatCd().equals(String.valueOf(Const4pbx.WS_VALUE_EXTENSION_STATE_LEFT)) 
						|| organization.getAgentStatCd().equals(String.valueOf(Const4pbx.WS_VALUE_EXTENSION_STATE_REST))
						|| organization.getAgentStatCd().equals(String.valueOf(Const4pbx.WS_VALUE_EXTENSION_STATE_EDU))) {
					payload.status = organization.getAgentStatCd();

					this.messagingTemplate.convertAndSend("/topic/ext.state." + data.getExtension(), payload);
					this.usersState();
				}
				break;
			case Const4pbx.UC_REPORT_EXT_STATE:
				Call call = null;

				switch (data.getDirect()) {
					case Const4pbx.UC_DIRECT_INCOMING:

						r.lock();
						try {
							call = curcalls.stream().filter(x -> x.getExtension().equals(data.getCallee())
									&& x.getCust_tel().equals(data.getCaller())).findFirst().get();
						} catch (NullPointerException | NoSuchElementException e) {
							call = null;
						} finally {
							r.unlock();
						}

						switch (data.getStatus()) {
							case Const4pbx.UC_CALL_STATE_IDLE:
								if (call != null) {
									if (call.getStatus() == Const4pbx.UC_CALL_STATE_RINGING) {
										callMapper.modiEnd(call);

										w.lock();
										try {
											curcalls.removeIf(x -> x.getCust_tel().equals(data.getCaller()) && x.getExtension().equals(data.getCallee()));
										} finally {
											w.unlock();
										}
									} else if (call.getStatus() == Const4pbx.UC_CALL_STATE_BUSY) {
										call.setStatus(data.getStatus());
										call.setEnddate(new Timestamp(System.currentTimeMillis()));
										callMapper.modiStatus(call);

										w.lock();
										try {
											curcalls.removeIf(x -> x.getCust_tel().equals(data.getCaller()) && x.getExtension().equals(data.getCallee()));
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
								if (call == null) {
									call = new Call();
									call.setExtension(data.getExtension());
									call.setCust_tel(data.getCaller());
									call.setStatus(data.getStatus());
									call.setDirect(data.getDirect());
									call.setUsername(organization.getEmpNo());

									w.lock();
									try {
										curcalls.add(call);
									} finally {
										w.unlock();
									}

									callMapper.add(call);
									this.messagingTemplate.convertAndSend("/topic/ext.state." + data.getExtension(), payload);
									//System.err.println("RINGING curcalls.size(): " + curcalls.size());
								}
								break;
							case Const4pbx.UC_CALL_STATE_BUSY:
								if (call != null) {
									call.setStartdate(new Timestamp(System.currentTimeMillis()));
									call.setStatus(data.getStatus());
									callMapper.modiStatus(call);
									this.messagingTemplate.convertAndSend("/topic/ext.state." + data.getExtension(), payload);
									// System.err.println("BUSY curcalls.size(): " + curcalls.size());
								}
								break;
						}

						if (call != null) {
							call.setStatus(data.getStatus());

							// Member member = memberMapper.selectByExt(data.getExtension());
							if (organization != null) {
								Customer2 cust = custMapper.findByExt(data.getCaller());

								if (cust != null) {
									payload.callername = cust.getCust_nm();
									payload.cust_no = cust.getCust_cd();
								}
								if (organization != null) {
									payload.calleename = organization.getEmpNo();
								}

								payload.call_idx = call.getIdx();
								this.msgTemplate.convertAndSendToUser(organization.getEmpNo(), "/queue/groupware", payload);
							}
						}
						break;
					case Const4pbx.UC_DIRECT_OUTGOING:
						r.lock();
						try {
							call = curcalls.stream().filter(x -> x.getExtension().equals(data.getExtension())
									&& x.getCust_tel().equals(data.getCallee())).findFirst().get();
						} catch (NullPointerException | NoSuchElementException e) {
							call = null;
						} finally {
							r.unlock();
						}

						switch (data.getStatus()) {
							case Const4pbx.UC_CALL_STATE_IDLE:
								if (call != null) {
									if (call.getStatus() == Const4pbx.UC_CALL_STATE_RINGING) {
										callMapper.modiEnd(call);

										w.lock();
										try {
											curcalls.removeIf(x -> x.getCust_tel().equals(data.getCaller()) && x.getExtension().equals(data.getCallee()));
										} finally {
											w.unlock();
										}
									} else if (call.getStatus() == Const4pbx.UC_CALL_STATE_BUSY) {
										call.setStatus(data.getStatus());
										call.setEnddate(new Timestamp(System.currentTimeMillis()));
										callMapper.modiStatus(call);

										w.lock();
										try {
											curcalls.removeIf(x -> x.getCust_tel().equals(data.getCallee()) && x.getExtension().equals(data.getExtension()));
										} finally {
											w.unlock();
										}
									}
									this.messagingTemplate.convertAndSend("/topic/ext.state." + data.getExtension(), payload);
									System.err.println("IDLE curcalls.size(): " + curcalls.size());
								}
								break;
							case Const4pbx.UC_CALL_STATE_INVITING:
								if (call == null) {
									// Member member = memberMapper.selectByExt(data.getExtension());

									call = new Call();
									call.setExtension(data.getExtension());
									call.setCust_tel(data.getCallee());
									call.setStartdate(new Timestamp(System.currentTimeMillis()));
									call.setStatus(data.getStatus());
									call.setDirect(data.getDirect());
									call.setUsername(organization.getEmpNo());

									w.lock();
									try {
										curcalls.add(call);
									} finally {
										w.unlock();
									}

									callMapper.add(call);
									this.messagingTemplate.convertAndSend("/topic/ext.state." + data.getExtension(), payload);
								}
								break;
							case Const4pbx.UC_CALL_STATE_BUSY:
								if (call != null) {
									call.setStartdate(new Timestamp(System.currentTimeMillis()));
									call.setStatus(data.getStatus());
									callMapper.modiStatus(call);
									this.messagingTemplate.convertAndSend("/topic/ext.state." + data.getExtension(), payload);
									System.err.println("BUSY curcalls.size(): " + curcalls.size());
								}
								break;
						}

						if (call != null) {
							call.setStatus(data.getStatus());

							// Member member = memberMapper.selectByExt(data.getExtension());
							
							if (organization != null) {
								Customer2 cust = custMapper.findByExt(data.getCallee());

								if (cust != null) {
									payload.calleename = cust.getCust_nm();
									payload.cust_no = cust.getCust_no();
								}
								if (organization != null) {
									payload.callername = organization.getEmpNo();
								}

								payload.call_idx = call.getIdx();
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
		payload.status = String.valueOf(data.getStatus());

		Sms_sample runningsms = null;

		r.lock();
		try {
			runningsms = smsrunning.stream().filter(x -> x.getExt().equals(data.getFrom_ext())).findFirst().get();
			runningsms.setResult(data.getStatus());
			payload.status = String.valueOf(data.getStatus());
			smsMapper.setresult(runningsms);
		} catch (NoSuchElementException | NullPointerException e) {
			payload.status.equals(String.valueOf(Const4pbx.WS_STATUS_ING_NOTFOUND));
		} catch (Exception e) {

		} finally {
			r.unlock();
		}

		w.lock();
		try {
			smsrunning.removeIf(x -> x.equals(data.getFrom_ext()));
		} catch (UnsupportedOperationException | NullPointerException e) {
			payload.status.equals(String.valueOf(Const4pbx.WS_STATUS_ING_UNSUPPORTED));
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
		payload.status = String.valueOf(Const4pbx.WS_VALUE_EXTENSION_STATE_LOGEDOUT);
		
		this.messagingTemplate.convertAndSend("/topic/ext.state." + org.getExtensionNo(), payload);
		this.usersState();
	}
}
