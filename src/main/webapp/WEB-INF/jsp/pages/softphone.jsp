<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE HTML>
<html>
<head>
	<title>[JUI Library] - CSS/Tab</title>

<!-- <link rel="stylesheet" href="../resources/jui-master/dist/ui.css">
<link rel="stylesheet" href="../resources/jui-master/dist/ui-jennifer.css">
<link rel="stylesheet" href="../resources/jui-master/dist/grid.css">
<link rel="stylesheet" href="../resources/jui-master/dist/grid-jennifer.css" />	 -->
<%@ include file = "../common/jui_common.jsp" %>
<style type="text/css">
#empInfo{
	font-family: sans-serif;
	font-size: 12px;
  }
</style>
<script src="../resources/js/sockjs-0.3.4.js"></script>
<script src="../resources/js/stomp.js"></script>
<script src="../resources/js/MessageValues.js"></script>
<script src="../resources/js/softphone.js"></script>
<script type="text/javascript">
	$(document).ready(function() {
		stompConnect();
		
	   	jui.ready([ "ui.combo" ], function(combo) {
		   combo_1 = combo("#combo_1", {
	       index: 2,
	       event: {
		           change: function(data) {
	               alert("text(" + data.text + "), value(" + data.value + ")");
		           	}
		        }
		    });
		});   
	   	buttonState("RESET");
 
		/* 소프트폰 메뉴 slide 기능 */
/*		$(".notReadyMenu>a").click(function() {
			$(".notReadyMenu>a").removeClass("active");
			$(this).addClass("active");
			$(".notReadyMenu a i").removeClass("icon-arrow1");
			$(this).find("i").addClass("icon-arrow1");

			var submenu = $(this).next("ul");
			$(".subNotReadyMenu").slideUp();
			submenu.slideToggle();
		});

		$(".subNotReadyMenu>li").click(function() {
			$(".subNotReadyMenu>li").removeClass("active");
			$(this).addClass("active");

		}); */
		
		jui.ready([ "ui.dropdown" ], function(dropdown) {
		    subNotReady = dropdown("#subNotReady", {
		        close: true,
		        event: {
		            change: function(data) {
		            	if(data.value == "left"){
		            		ctiNotReady_Left();
		            	}else if(data.value == "rest"){
		            		ctiNotReady_Rest();
		            	}else if(data.value == "edu"){
		            		ctiNotReady_Edu();
		            	}
		            }
		        }
		    });
		});
	});

	function showReceiveFrame(message) {
		console.log("message--->" + message);
	}
	
	function disconnect(){
		ctiAfterWork();
		ctiLogout();
		stompDisconnect();
		location.href = "<c:url value='/logout'/>";
	}

	function ctiLogout() {
		var extension = $("input[name=sp_extNo]").val();
		console.log("ctiLogout extensionNumber==>" + extension);
		requestCallLogout(extension);
	}

	function ctiReady() {
		var extension = $("input[name=sp_extNo]").val();
		console.log("ctiReady extensionNumber==>" + extension);
		requestCallReady(extension);
	}

	function ctiAfterWork() {
		var extension = $("input[name=sp_extNo]").val();
		requestAferCallWork(extension);
	}

	function ctiNotReady_Left() {
		var extension = $("input[name=sp_extNo]").val();
		requestCallNotReady_Left(extension);
	}

	function ctiNotReady_Rest() {
		var extension = $("input[name=sp_extNo]").val();
		requestCallNotReady_Rest(extension);
	}

	function ctiNotReady_Edu() {
		var extension = $("input[name=sp_extNo]").val();
		requestCallNotReady_Edu(extension);
	}

	function ctiDial() {
		var extension = $("input[name=sp_extNo]").val();
		var callee = $("input[name=sp_telNo]").val();
		console.log("ctiDial extensionNumber==>" + extension);
		console.log("ctiDial callingPhoneNumber==>" + callee);
		requestCallDial(extension, extension, callee);
	}

	function ctiAnswer() {
		var extension = $("input[name=sp_extNo]").val();
		var callee = $("input[name=sp_telNo]").val();
		console.log("ctiAnswer extensionNumber==>" + extension);
		console.log("ctiAnswer callingPhoneNumber==>" + callee);
		requestCallAnswer(extension, extension, callee);
	}

	// drop
	function ctiDrop() {
		var extension =  $("input[name=sp_extNo]").val();
		var requestCallInfo;
		
		requestCallInfo = getRequestCallInfo(extension, "ctiDrop");
		requestCallDrop(extension, requestCallInfo.caller, requestCallInfo.callee);
	}

	// hold
	function ctiHold() {
		var extension = $("input[name=sp_extNo]").val();
		var requestCallInfo;
		
		requestCallInfo = getRequestCallInfo(extension, "ctiHold");
		requestCallHold(extension, requestCallInfo.caller, requestCallInfo.callee);
		//requestCallHold(extension, caller, callee);
	}
	
	// unhold
	function ctiUnhold() {
		var extension = $("input[name=sp_extNo]").val();
		var requestCallInfo;
		
		requestCallInfo = getRequestCallInfo(extension, "ctiUnhold");
		requestCallUnhold(extension, requestCallInfo.caller, requestCallInfo.callee);
		//requestCallUnhold(extension, caller, callee);
	}
	
	// 다른 내선에 벨울리는 것 당겨받기
	function ctiPickUp() {
		var extension = $("input[name=sp_extNo]").val();
		console.log("ctiPickUp extensionNumber==>" + extension);

		var callee = $("input[name=sp_telNo]").val();
		console.log("ctiPickUp callee==>" + callee);
		
		requestCallPickUp(extension, callee);
	}

	// 수신입장에서 호전환 할때
	function ctiTransfer() {
		var extension = $("input[name=sp_extNo]").val();
		console.log("ctiTransfer extensionNumber==>" + extension);
		
		var callee = extension;
		console.log("ctiTransfer callee==>" + callee);

		var caller = $("input[name=sp_custNo]").val();
		console.log("ctiTransfer caller==>" + caller);
		
		var unconditional = $("input[name=sp_telNo]").val();
		console.log("ctiTransfer unconditional==>" + unconditional);
		
		requestCallTransfer(extension, caller, callee, unconditional);
	}
	function test(){
		requestQueryExtensionState("");
		requestQueryBusyExtensions();
	}

	// 성공 이벤트
	function receiveCoreTreeEvent(event) {
		console.log("<<~~~~~receiveCoreTreeEvent: id=" + getEventId(event) + " , direct=" + getEventDirect(event) + " , status=" + getEventStatus(event));
		showReceiveFrame("receiveCoreTreeEvent:" + event.toJson());
		var ctiCallMsg = "";
		var ctiMsg = "";
		switch (event.id) {
		case UC_MAKE_CALL_RES: //전화걸기 응답
			//
			break;
		
		case UC_DROP_CALL_RES: //전화끊기 응답
			//
			break;
		
		//added
		case UC_ANWSER_CALL_RES:
			//
			break;
			
		//added
		case UC_PICKUP_CALL_RES:
			//
			break;							
		
		case UC_HOLD_CALL_RES: //hold
			//
			break;
			
		case UC_ACTIVE_CALL_RES: //unhold
			//
			break;
		
		//added
		case UC_TRANSFER_CALL_RES:
			//
			break;
			
		case UC_SMS_INFO_RES: //reserved
			//
			break;
			
		//--> UC_EIT_CALL_STATE	
		//case WS_RES_EXTENSION_STATE:
		//	break;

		//--> UC_EIT_CALL_STATE	
		//case UC_REPORT_SRV_STATE:
		//	break;
			
		//!!! 주요한 이벤트는 EIT 이벤트로 재정의했지만, 그외 이벤트도 체크 필요??
		case UC_REPORT_EXT_STATE:	//콜응답 관련 상태
			if(event.direct == 11){
				ctiCallMsg = "전화 연결중";
			}
			break;
		
			
		//EIT
		case UC_EIT_CALL_RINGING:
			//
			ctiMsg = event.caller +" 전화가 왔습니다!!!!!!";
			tab1_customer_one2("telNo",event.caller);
			break;
			
		case UC_EIT_CALL_DIALING:
			//
			ctiCallMsg = "전화 연결중";
			break;
			
		case UC_EIT_CALL_IDLE:
			//
				//ctiCallMsg = "전화 연결중";
			if(event.direct == 11 || event.direct == 12){
				ctiAfterWork();	
			}else{
				ctiCallMsg = "온라인";
			}
			break;
			
		case UC_EIT_CALL_BUSY:	
			//
			ctiCallMsg = "통화중";
			$("input[name=sp_msg]").val("");
			break;
			
		case UC_EIT_CALL_DROP:	
			//
			ctiAfterWork();
			break;
			
		case UC_EIT_CALL_STATE: //콜 etc 상태변경시 
			//
			console.log("@@@@@UC_EIT_CALL_STATE==>" + event.extension + "::::::::::::::"+ event.status);
			if(event.extension != ""){
				$("#ext_"+event.extension+"_state").text(eventExtensionStateMsg(event.status));
			}
			if(Number($("input[name=sp_extNo]").val()) == event.extension){
				ctiCallMsg= eventExtensionStateMsg(event.status);
			}
			break;
			
		case UC_REPORT_WAITING_COUNT: //콜 etc 상태변경시 
			//
			console.log("@@@@@UC_REPORT_WAITING_COUNT==>" + event.responseCode + "::::::::::::::"+ event.direct);
			if(event.responseCode != ""){
				$("input[name=waitCnt]").val(event.responseCode);
			}
			break;
			
		case UC_EIT_WEB_ERROR:
			//
			break;
			
		default:
			break;
		}
		$("input[name=sp_state]").val(ctiCallMsg);
		$("input[name=sp_msg]").val(ctiMsg);
	}
	function eventExtensionStateMsg(status){
		var stateMsg = "";
		switch(status){
		case 111 :
			stateMsg = "대기";
				break;
		case 114 :
			stateMsg = "통화중";
				break;
		case 1001 :
			stateMsg = "온라인";
				break;
		case 1002 :
			stateMsg = "후처리";
				break;
		case 1003 :
			stateMsg = "이석";
				break;
		case 1004 :
			stateMsg = "휴식";
				break;
		case 1005 :
			stateMsg = "교육";
				break;
		case 1006 :
			stateMsg = "통화중";
				break;
		case 1007 :
			stateMsg = "로그아웃";
				break;
		}

		return stateMsg;
	}
	// 성공 이벤트
	function receiveCoreTreeUsersStateEvent(event) {
		console.log("<<~~~~~receiveCoreTreeUsersStateEvent");
		$("input[name=totEmp]").val(event.total);
		$("input[name=totLogin]").val(event.logedin);
		$("input[name=totLogout]").val(event.logedout);
		$("input[name=totReady]").val(event.ready);
		$("input[name=totNotready]").val(event.after + event.left + event.rest + event.edu);
		$("input[name=totEstablish]").val(event.busy);
	}
	// 에러 이벤트
	function receiveCoreTreeEventError(event) {
		console.log("<<~~~~~receiveCoreTreeEventError!! : id=" + getEventId(event) + " , direct=" + getEventDirect(event) + " , status=" + getEventStatus(event));
		showReceiveFrame("receiveCoreTreeEventError!! :" + event.toJson());
		
		switch (event.id) {
		case UC_MAKE_CALL_RES: //전화걸기 응답
			//
			break;
		
		case UC_DROP_CALL_RES: //전화끊기 응답
			//
			break;

		//added
		case UC_ANWSER_CALL_RES:
			//
			break;

		//added
		case UC_PICKUP_CALL_RES:
			//
			break;
			
		case UC_HOLD_CALL_RES:
			//
			break;
			
		case UC_ACTIVE_CALL_RES:
			//
			break;

		//added
		case UC_TRANSFER_CALL_RES:
			//
			break;
			
		case UC_SMS_INFO_RES:
			//
			break;
			
		//--> UC_EIT_CALL_STATE	
		//case WS_RES_EXTENSION_STATE:
		//	break;
			
		//--> UC_EIT_CALL_STATE	
		//case UC_REPORT_SRV_STATE:
		//	break;

		
		//EIT
		case UC_EIT_WEB_ERROR:
			console.log("<<~~~~~ Web Error: " + event.message); 
			//
			break;							
			
		default:
			break;
		}
	}
	
</script>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
</head>
<body class="jui">
	<table border="0"cellpadding="0" cellspacing="0">
	  <tr>
	    <td>
	    	<a id="ready" class="softbtn small focus" href="javascript:ctiReady();">대기</a>&nbsp;
	    	<a id="notReady" class="softbtn small focus" href="javascript:ctiAfterWork();">후처리</a>&nbsp;
    	</td>
    	<td>
    		<a class="softbtn small focus" href="javascript:subNotReady.show();">이석<i class="icon-arrow1"></i></a>
	    	<div id="subNotReady" class="dropdown large">
			    <div class="anchor"></div>
			    <ul style="width: 120px;">
			        <li value="left">이석</li>
					<li value="rest">휴식</li>
					<li value="edu">교육</li>
			    </ul>
			</div>
    	</td>
<!--     	<div class="notReadyMenu" style="float: left;">
		    	<a class="softbtn small focus" >이석<i class="icon-arrow1"></i></a>
		    	<ul class="subNotReadyMenu" style="display: none;"> 
					<li><a id="notReady_left" class="softbtn small focus" href="javascript:ctiNotReady_Left();">이석</a>&nbsp;</li>
					<li><a id="notReady_rest" class="softbtn small focus" href="javascript:ctiNotReady_Rest();">휴식</a>&nbsp;</li>
					<li><a id="notReady_edu" class="softbtn small focus" href="javascript:ctiNotReady_Edu();">교육</a>&nbsp;</li>
				</ul>
			</div> -->
	    <td width="165">
	    	<input type="text" name="sp_telNo" class="softinput mini" value="" style="width:155px" />
	    	<input type="hidden" name="sp_extNo" class="softinput mini" value="<%=session.getAttribute("extensionNo") %>" style="width:155px" />
	    	<input type="hidden" name="sp_custNo" class="softinput mini" value="" style="width:155px" />
	    </td>
	    <td>
	    	<a id="dial" class="softbtn small focus" href="javascript:ctiDial();">걸기</a>&nbsp;
	    	<a id="answer" class="softbtn small focus" href="javascript:ctiAnswer();">받기</a>&nbsp;
	    	<a id="pickUp" class="softbtn normal focus" href="javascript:ctiPickUp();">당겨받기</a>&nbsp;
	    	<a id="drop" class="softbtn small focus" href="javascript:ctiDrop();">끊기</a>&nbsp;
	    	<a id="hold" class="softbtn small focus" href="javascript:ctiHold();">보류</a>&nbsp;
	    	<a id="unhold" class="softbtn normal focus" href="javascript:ctiUnhold();">보류해제</a>&nbsp;
	    	<a id="transfer" class="softbtn small focus" href="javascript:ctiTransfer();">호전환</a>&nbsp;
    		<a class="softbtn small focus" href="javascript:test();">초기화</a>&nbsp; 
	    </td>
	    <td align="right" width="200px;"> 
    		<label id="empInfo"> [<%= session.getAttribute("empNm") %>, <%= session.getAttribute("empNo") %>]</label>
	    	<a id="" class="softbtn normal focus" href="javascript:disconnect();">로그아웃</a>
	    </td>
      </tr>
	  <tr>
	    <td height="3" align="center" ></td>
      </tr>
      <tr>
        <td colspan="2"><input type="text" class="darkinput mini" name="sp_state" value="" style="width: 197px;"/></td>
        <td align="center"></td>
        <td><input type="text" class="darkinput mini" name="sp_msg" value="" style="width: 563px;"/></td>
      </tr>     
</table>
</body>
</html>
