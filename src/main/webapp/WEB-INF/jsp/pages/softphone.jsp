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
	});

	function showReceiveFrame(message) {
		console.log("message--->" + message);
	}
	
	function disconnect(){
		stompDisconnect();
		location.href = "<c:url value='/logout'/>";
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
		//case UC_REPORT_EXT_STATE:	//콜응답 관련 상태
		//	break;
		
			
		//EIT
		case UC_EIT_CALL_RINGING:
			//
			break;
			
		case UC_EIT_CALL_DIALING:
			//
			break;
			
		case UC_EIT_CALL_IDLE:
			//
			break;
			
		case UC_EIT_CALL_BUSY:	
			//
			break;
			
		case UC_EIT_CALL_STATE: //콜 etc 상태변경시 
			//
			break;
			
		case UC_EIT_WEB_ERROR:
			//
			break;
			
		default:
			break;
		}
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
	    <td >
	    	<a id="ready" class="softbtn small focus" href="javascript:ctiReady();">대기</a>&nbsp;
	    	<a id="notReady" class="softbtn small focus" href="javascript:ctiAfterWork();">후처리</a>&nbsp;
	    	<a id="notReady" class="softbtn small focus" href="javascript:ctiNotReady_Left();">이석</a>&nbsp;
	    	<a id="notReady" class="softbtn small focus" href="javascript:ctiNotReady_Rest();">휴식</a>&nbsp;
	    	<a id="notReady" class="softbtn small focus" href="javascript:ctiNotReady_Edu();">교육</a>&nbsp;
		    <td width="165" align="center" >
		    	<input type="text" name="sp_telNo" class="softinput mini" value="" style="width:155px" />
		    	<input type="hidden" name="sp_extNo" class="softinput mini" value="<%=session.getAttribute("extensionNo") %>" style="width:155px" />
		    	<input type="hidden" name="sp_custNo" class="softinput mini" value="" style="width:155px" />
		    </td>
		    <td >
		    	<a id="dial" class="softbtn small focus" href="javascript:ctiDial();">걸기</a>&nbsp;
		    	<a id="answer" class="softbtn small focus" href="javascript:ctiAnswer();">받기</a>&nbsp;
		    	<a id="pickUp" class="softbtn normal focus" href="javascript:ctiPickUp();">당겨받기</a>&nbsp;
		    	<a id="drop" class="softbtn small focus" href="javascript:ctiDrop();">끊기</a>&nbsp;
		    	<a id="hold" class="softbtn small focus" href="javascript:ctiHold();">보류</a>&nbsp;
		    	<a id="unhold" class="softbtn normal focus" href="javascript:ctiUnhold();">보류해제</a>&nbsp;
		    	<a id="transfer" class="softbtn small focus" href="javascript:ctiTransfer();">호전환</a>&nbsp;
	    		<a class="softbtn small focus" href="javascript:test();">초기화</a>&nbsp;
		    	<!-- <a id="" class="softbtn normal focus" href="javascript:disconnect();">로그아웃</a> -->
		    </td>
      </tr>
	  <tr>
	    <td height="3" colspan="3" align="center" ></td>
      </tr>
      <tr>
        <td><input type="text" class="darkinput mini" name="sp_state" value="" style="width:336px" /></td>
        <td align="center"></td>
        <td><input type="text" class="darkinput mini" name="sp_msg" value="" style="width:575px" /></td>
      </tr>     
</table>
</body>
</html>
