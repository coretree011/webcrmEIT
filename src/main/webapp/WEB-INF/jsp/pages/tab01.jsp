<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<!DOCTYPE HTML>
<html>
<head>
<title>[JUI Library] - CSS/Tab</title>

<!-- <link rel="stylesheet" href="../resources/jui-master/dist/ui.css" />
	<link rel="stylesheet" href="../resources/jui-master/dist/ui-jennifer.css" />
	<link rel="stylesheet" href="../resources/jui-master/dist/ui.min.css" />
	<link rel="stylesheet" href="../resources/jui-master/dist/grid.css" />
	<link rel="stylesheet" href="../resources/jui-master/dist/grid.min.css" />
	<link rel="stylesheet" href="../resources/jui-master/dist/grid-jennifer.css" />
	<link rel="stylesheet" href="../resources/jui-master/dist/grid-jennifer.min.css" /> -->
<%-- <%@ include file="../common/jui_common.jsp"%> --%>

<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<style type="text/css">
body {
	margin-top: 0px;
}

.body.fit {
	margin-top: 5px;
}

.tab.top {
	margin-bottom: 1px;
}
</style>
<script type="text/javascript">
$(document).ready(function() {

	var mainCustomer = {
			custCd : "",
			custNm : "",
			tel1No : "",
			tel2No : "",
			tel3No : "",
			faxNo : "",
			addr : "",
			emailId : "",
			custNote : "",
			gradeCd : "",
			custTypCd : "",
			recogTypCd : "",
			sexCd : "",
			birthDate : "",
			coRegNo : "",
			lastCounDate : ""
		};

	var mainCoun = {
			counSeq : "",
			custNo : "",
			custNm : "",
			tel1No : "",
			callTypCd : "",
			counStartDate : "",
			counStartHms : "",
			counEndDate : "",
			counEndHms : "",
			counCd : "",
			empNo : "",
			empNm : "",
			counNote : ""
		};

	var mainRes = {
			custNo : "",
			custNm : "",
			resTelNo : "",
			resDate : "",
			resHms : "",
			counCd : "",
			empNo : "",
			empNm : "",
			resNote : ""
		};

	var mainParam = {
			lcd : ""
		};

	
	var mainCallResult = {
			lcd : "1009",
		};

	$.ajax({
		url : "/code/selecCodeList",
		type : "post",
		data : JSON.stringify(mainCallResult),
		contentType : 'application/json; charset=utf-8',
		success : function(result) {
			$('#callResult').append('<option value=' + '' + '></option>');
		    for ( var i = 0; i < result.length; i++) {
					$('#callResult').append('<option value='+result[i].scd+'>' + result[i].scdNm + '</option>');
		    } 
		}
	});

	mainParam.lcd = "1013";
	$.ajax({
		url : "/code/selecCodeList",
		type : "post",
		data : JSON.stringify(mainParam),
		contentType : 'application/json; charset=utf-8',
		success : function(result) {
			$('#tab1_gradeCd').append('<option value=' + '' + '></option>');
		    for ( var i = 0; i < result.length; i++) {
					$('#tab1_gradeCd').append('<option value='+result[i].scd+'>' + result[i].scdNm + '</option>');
		    } 
		    $('#tab1_gradeCd').css("width","120px");
		}
	});

	mainParam.lcd = "1014";
	$.ajax({
		url : "/code/selecCodeList",
		type : "post",
		data : JSON.stringify(mainParam),
		contentType : 'application/json; charset=utf-8',
		success : function(result) {
			$('#tab1_custTypCd').append('<option value=' + '' + '></option>');
		    for ( var i = 0; i < result.length; i++) {
					$('#tab1_custTypCd').append('<option value='+result[i].scd+'>' + result[i].scdNm + '</option>');
		    } 
		    $('#tab1_custTypCd').css("width","120px");
		}
	});

	mainParam.lcd = "1015";
	$.ajax({
		url : "/code/selecCodeList",
		type : "post",
		data : JSON.stringify(mainParam),
		contentType : 'application/json; charset=utf-8',
		success : function(result) {
			$('#tab1_recogTypCd').append('<option value=' + '' + '></option>');
		    for ( var i = 0; i < result.length; i++) {
					$('#tab1_recogTypCd').append('<option value='+result[i].scd+'>' + result[i].scdNm + '</option>');
		    } 
		    $('#tab1_recogTypCd').css("width","120px");
		}
	});
	
	jui.ready([ "ui.tab" ], function(tab) {
		tab_1 = tab("#tab_1", {
			event : {
				change : function(data) {
					$("ul.tab_up li").removeClass("checked");
					$("ul.tab_up li i").removeClass("icon-arrow1");

					var a = data.index + 1;

					$("ul.tab_up li:nth-child(" + a + ")").addClass("checked");
					$("ul.tab_up li:nth-child(" + a + ") i").addClass(
							"icon-arrow1");
				}
			},
			target : "#tab_contents_1",
			index : 0
		});

		tab_2 = tab("#tab_2", {
			event : {
				change : function(data) {
					$("ul.tab_down li").removeClass("checked");
					$("ul.tab_down li i").removeClass("icon-arrow1");

					var a = data.index + 1;

					$("ul.tab_down li:nth-child(" + a + ")")
							.addClass("checked");
					$("ul.tab_down li:nth-child(" + a + ") i").addClass(
							"icon-arrow1");
				}
			},
			target : "#tab_contents_2",
			index : 0
		});
	});

	$("#tab1_resDate").datepicker({
		showMonthAfterYear : true,
		changeMonth : true,
		changeYear : true,
		dateFormat : "yy-mm-dd",
		dayNamesMin : ["일","월","화","수","목","금","토"],
		monthNamesShort : ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'],
		nextText:'다음 달',
        prevText:'이전 달'
	});

	$("#birthDate").datepicker({
		showMonthAfterYear : true,
		changeMonth : true,
		changeYear : true,
		dateFormat : "yy-mm-dd",
		yearRange : "-80:+0",
		dayNamesMin : ["일","월","화","수","목","금","토"],
		monthNamesShort : ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'],
		nextText:'다음 달',
        prevText:'이전 달'
	});

	var date = new Date();
	var month = date.getMonth() + 1;
	month = month < 10 ? '0' + month : month;
	var day = date.getDate();
	day = day < 10 ? '0' + day : day;
	var hour = date.getHours() + 1;
	hour = hour < 10 ? '0' + hour : hour;
	var min = date.getMinutes();
	min = min < 10 ? '0' + min : min;
	
	$("input[name=tab1_resDate]").val(date.getFullYear() +'-'+ month +'-'+ day);
	$("input[name=tab1_resHms]").val(hour +':'+ min);
/* 	
	$("input[name=custCd]").change(function() {
		var radioValue = $(this).val();
		if(radioValue == "1002"){
			if($("#sCust").children("sup").size() < 1){
				$("#sCust").append("<sup style='color:red; font-weight: bold;'>*</sup>");	
			}
		}else{
			if($("#sCust").children("sup").size() > 0){
				$("#sCust").children("sup").remove();
			}	
		}
	}); */
	
	$("#bt_reset").click(function() {
		$("input[name=custNo]").val("");
		$("input[name=custNm]").val("");
		$("input[name=tel1No]").val("");
		$("input[name=tel2No]").val("");
		$("input[name=tel3No]").val("");
		$("input[name=faxNo]").val("");
		$("input[name=addr]").val("");
		$("input[name=emailId]").val("");
		$("input[name=custNote]").val("");
		$("#tab1_gradeCd").val("");
		$("#tab1_custTypCd").val("");
		$("#tab1_recogTypCd").val("");
		$("input[name=sexCd]").val("1001");
		$("input[name=birthDate]").val("");
		$("input[name=coRegNo]").val("");
		$("input[name=lastCounDate]").val("");
		$("input[name=tab1_resTelNo]").val("");
		$("input[name=tab5_custNo]").val("");
	});
	
	$("#bt_custSave").click(function() {
		mainCustomer.custNo = $("input[name=custNo]").val();
		mainCustomer.custCd = $("input[name=custCd]:checked").val();
		mainCustomer.custNm = $("input[name=custNm]").val();
		mainCustomer.tel1No = $("input[name=tel1No]").val();
		mainCustomer.tel2No = $("input[name=tel2No]").val();
		mainCustomer.tel3No = $("input[name=tel3No]").val();
		mainCustomer.faxNo = $("input[name=faxNo]").val();
		mainCustomer.addr = $("input[name=addr]").val();
		mainCustomer.emailId = $("input[name=emailId]").val();
		mainCustomer.custNote = $("input[name=custNote]").val();
		mainCustomer.gradeCd = $("#tab1_gradeCd option:selected").val();
		mainCustomer.custTypCd = $("#tab1_custTypCd option:selected").val();
		mainCustomer.recogTypCd = $("#tab1_recogTypCd option:selected").val();
		mainCustomer.sexCd = $("input[name=tsexCd]:checked").val();
		mainCustomer.birthDate = $("input[name=birthDate]").val().replace(/-/gi, "");
		mainCustomer.coRegNo = $("input[name=coRegNo]").val().replace(/-/gi, "");
		mainCustomer.lastCounDate = $("input[name=lastCounDate]").val().replace(/-/gi, "");
		
		if(mainCustomer.custCd == "1002"){
			/* if(mainCustomer.custNo == ""){
				alert("고객번호를 입력해주세요.");
			}else  */
			if(mainCustomer.custNm == ""){
				alert("고객명을 입력해주세요.");
			}else if(mainCustomer.tel1No == ""){
				alert("핸드폰번호를 입력해주세요.");
			}else{
				if(regularCheck()){
					$.ajax({
						url : "/main/existCoustomer",
						type : "post",
						contentType : 'application/json; charset=utf-8',
						data : JSON.stringify(mainCustomer),
						success : function(result) {
							if(result == "2000"){
								alert("등록되었습니다.");
								tab1_customer_one(mainCustomer.custNo);
							}else if(result == "2100"){
								alert("정보가 수정되었습니다.");
								tab1_customer_one(mainCustomer.custNo);
							}else if(result == "4100"){
								alert("고객번호(사업자번호)를 확인하세요.");
							}
						}
					});
				}
			}
		}else{
			if(mainCustomer.custNm == ""){
				alert("고객명을 입력해주세요.");
			}else if(mainCustomer.tel1No == ""){
				alert("핸드폰번호를 입력해주세요.");
			}else{
				if(regularCheck()){
					$.ajax({
						url : "/main/existCoustomer",
						type : "post",
						contentType : 'application/json; charset=utf-8',
						data : JSON.stringify(mainCustomer),
						success : function(result) {
							if(result == "1000"){
								alert("정보가 수정되었습니다.");
								tab1_customer_one(mainCustomer.custNo);
							}else if(result == "1100"){
								if(confirm("기존에 고객명, 핸드폰번호가 존재합니다. \n수정하시겠습니까?")){
									$.ajax({
										url : "/main/updateCustomer",
										type : "post",
										contentType : 'application/json; charset=utf-8',
										data : JSON.stringify(mainCustomer),
										success : function(result) {
											if(result == 1){
												alert("수정되었습니다.");
												tab1_customer_one(mainCustomer.custNo);
											}
										}
									});
								}
							}else if(result == "1001"){
								$.ajax({
									url : "/main/insertCustomer",
									type : "post",
									contentType : 'application/json; charset=utf-8',
									data : JSON.stringify(mainCustomer),
									success : function(result) {
										if(result != "0"){
											alert("등록되었습니다.");
											tab1_customer_one(result);
										}else{
											alert("실패했습니다.");
											}
									}
								});
							}else if(result == "1101"){
								if(confirm("기존에 고객명, 핸드폰번호가 존재합니다. \n입력하시겠습니까?")){
									$.ajax({
										url : "/main/insertCustomer",
										type : "post",
										contentType : 'application/json; charset=utf-8',
										data : JSON.stringify(mainCustomer),
										success : function(result) {
											if(result != "0"){
												alert("등록되었습니다.");
												tab1_customer_one(result);
											}else{
												alert("실패했습니다.");
												}
										}
									});
								}
							}
						}
					});
				}
			}
		} 
	});
	
	$("#bt_custDelete").click(function() {
		mainCustomer.custNo = $("input[name=custNo]").val();
		if(mainCustomer.custNo != ""){
				$.ajax({
					url : "/main/deleteCustomerOne",
					type : "post",
					contentType : 'application/json; charset=utf-8',
					data : JSON.stringify(mainCustomer),
					success : function(result) {
						if(result == 1){
							alert("삭제되었습니다.");
							location.reload();
						}else{
							alert("실패했습니다.");
						}
					}
				});
		}else{
			alert("삭제할 고객 번호를 입력해주세요.");
		}
});
	
	$("#bt_counSave").click(function() {
		mainCoun.counSeq = $("input[name=counSeq]").val();
		mainCoun.custNo = $("input[name=custNo]").val();
		mainCoun.custNm = $("input[name=custNm]").val();
		mainCoun.telNo = $("input[name=tel1No]").val();
		mainCoun.callTypCd = $("input[name=callTypCd]").val();
		mainCoun.counStartDate = $("input[name=counStartDate]").val();
		mainCoun.counStartHms = $("input[name=counStartHms]").val();
		mainCoun.counEndDate = $("input[name=counEndDate]").val();
		mainCoun.counEndHms = $("input[name=counEndHms]").val();
		mainCoun.counCd = $("#callResult option:selected").val();
		mainCoun.empNo = $("input[name=empNo]").val();
		mainCoun.empNm = $("input[name=empNm]").val();
		mainCoun.counNote = $("input[name=counNote]").val();

		if(mainCoun != null){
			if(mainCoun.custNo == ""){
				alert("고객번호를 입력해주세요.");
			}else if(mainCoun.counCd == ""){
				alert("통화결과를 선택해주세요.");
			}else{
				if(mainCoun.counSeq == ""){
					$.ajax({
						url : "/main/insertCounsel",
						type : "post",
						contentType : 'application/json; charset=utf-8',
						data : JSON.stringify(mainCoun),
						success : function(result) {
							if(result > 0){
								alert("저장되었습니다.");
								counReset();
								$("#counSearch").click();
							}else{
								alert("실패했습니다.");
							}
						}
					});
				}else{
					$.ajax({
						url : "/main/updateCounsel",
						type : "post",
						contentType : 'application/json; charset=utf-8',
						data : JSON.stringify(mainCoun),
						success : function(result) {
							if(result == 1){
								alert("수정되었습니다.");
								counReset();
								$("#counSearch").click();
							}else{
								alert("실패했습니다.");
							}
						}
					});
				}
			}
		}
});
	
	$("#bt_resSave").click(function() {
		mainRes.custNo = $("input[name=custNo]").val();
		mainRes.custNm = $("input[name=custNm]").val();
		mainRes.resTelNo = $("input[name=tab1_resTelNo]").val();
		mainRes.resDate = $("input[name=tab1_resDate]").val().replace(/-/gi, "");
		mainRes.resHms = $("input[name=tab1_resHms]").val();
		mainRes.counCd = "1001";
		mainRes.empNo = $("input[name=empNo]").val();
		mainRes.empNm = $("input[name=empNm]").val();
		mainRes.resNote = $("input[name=tab1_resNote]").val();
		if(mainRes != null){
			if(mainRes.custNo == ""){
				alert("고객번호를 입력해주세요.");
			}else if(mainRes.resDate == ""){
				alert("예약일시를 입력해주세요.");
			}else if(mainRes.resTelNo == ""){
				alert("예약전화번호를 입력해주세요.");
			}else{
				if(regularCheck()){
					$.ajax({
						url : "/main/insertReservation",
						type : "post",
						contentType : 'application/json; charset=utf-8',
						data : JSON.stringify(mainRes),
						success : function(result) {
							if(result == 1){
								alert("저장되었습니다.");
								reservReset();
							}else{
								alert("실패했습니다.");
							}
						}
					});
				}
			}
		}
});
});
function counReset(){
	$("#callResult").val("");
	$("input[name=counNote]").val("");
	$("input[name=counSeq]").val("");
}
function reservReset(){
	var date = new Date();
	var month = date.getMonth() + 1;
	month = month < 10 ? '0' + month : month;
	var day = date.getDate();
	day = day < 10 ? '0' + day : day;
	var hour = date.getHours() + 1;
	hour = hour < 10 ? '0' + hour : hour;
	var min = date.getMinutes();
	min = min < 10 ? '0' + min : min;
	
	$("input[name=tab1_resDate]").val(date.getFullYear() +'-'+ month +'-'+ day);
	$("input[name=tab1_resHms]").val(hour +':'+ min);
	$("input[name=tab1_resNote]").val("");
}
function tab1_customer_one(custNo){
	var tab1_param = {
			custNo : ""
		};
	
	tab1_param.custNo = custNo;
	$("input[name=tab5_custNo]").val(custNo);
	$("input[name=tab6_custNo]").val(custNo);
	$.ajax({
		url : "/main/customerOne",
		type : "post",
		contentType : 'application/json; charset=utf-8',
		data : JSON.stringify(tab1_param),
		success : function(result) {
			if(result != ""){
				$("input[name=custNo]").val(result.custNo);
				$("input[name=tab5_custNo]").val(result.custNo);
				$("input[name=tab6_custNo]").val(result.custNo);
				$("input[name=custNm]").val(result.custNm);
				if(result.custCd =="1001"){
					$("input:radio[name='custCd']:radio[value='1001']").prop("checked",true);
					$("input:radio[name='custCd']:radio[value='1002']").prop("checked",false);
				}else if(result.custCd =="1002"){
					$("input:radio[name='custCd']:radio[value='1001']").prop("checked",false);
					$("input:radio[name='custCd']:radio[value='1002']").prop("checked",true);
				}else{
					$("input:radio[name='custCd']:radio[value='1001']").prop("checked",false);
					$("input:radio[name='custCd']:radio[value='1002']").prop("checked",false);
				}
				$("input[name=addr]").val(result.addr);
				$("input[name=tel1No]").val(result.tel1No);
				$("input[name=tab1_resTelNo]").val(result.tel1No);
				$("input[name=tel2No]").val(result.tel2No);
				$("input[name=tel3No]").val(result.tel3No);
				$("input[name=faxNo]").val(result.faxNo);
				$("input[name=emailId]").val(result.emailId);
				if(result.sexCd =="1001"){
					$("input:radio[name='tsexCd']:radio[value='1001']").prop("checked",true);
					$("input:radio[name='tsexCd']:radio[value='1002']").prop("checked",false);
				}else if(result.sexCd == "1002"){
					$("input:radio[name='tsexCd']:radio[value='1001']").prop("checked",false);
					$("input:radio[name='tsexCd']:radio[value='1002']").prop("checked",true);
				}else{
					$("input:radio[name='tsexCd']:radio[value='1001']").prop("checked",false);
					$("input:radio[name='tsexCd']:radio[value='1002']").prop("checked",false);
				}
				$("input[name=birthDate]").val(result.birthDate);
				$("#tab1_gradeCd").val(result.gradeCd);
				$("#tab1_custTypCd").val(result.custTypCd);
				$("#tab1_recogTypCd").val(result.recogTypCd);
				$("input[name=coRegNo]").val(result.coRegNo);
				$("input[name=lastCounDate]").val(result.lastCounDate);
				$("input[name=custNote]").val(result.custNote);
			}
		}
	});	
	$("#counSearch").click();
	$("#smsSearch").click();
}

function regularCheck(){
	if(!regularExpCheck($("input[name=tel1No]").val(),"phoneNum")){
		alert("핸드폰번호가 올바른 형식이 아닙니다.");
		return false;
	}else if(!regularExpCheck($("input[name=tel2No]").val(),"phoneNum")){
		alert("직장번호가 올바른 형식이 아닙니다.");
		return false;
	}else if(!regularExpCheck($("input[name=tel3No]").val(),"phoneNum")){
		alert("자택번호가 올바른 형식이 아닙니다.");
		return false;
	}else if(!regularExpCheck($("input[name=faxNo]").val(),"phoneNum")){
		alert("팩스번호가 올바른 형식이 아닙니다.");
		return false;
	}else if(!regularExpCheck($("input[name=emailId]").val(),"email")){
		alert("E-Mail이 올바른 형식이 아닙니다.");
		return false;
	}else if(!regularExpCheck($("input[name=tab1_resTelNo]").val(),"phoneNum")){
		alert("핸드폰번호가 올바른 형식이 아닙니다.");
		return false;
	}else if(!regularExpCheck($("input[name=tab1_resHms]").val(),"time")){ 
		alert("시간이 올바른 형식이 아닙니다.");
		return false;
	}else if(!regularExpCheck($("input[name=pop_sendResHms]").val(),"time")){
		alert("시간이 올바른 형식이 아닙니다.");
		return false;
	}else{
		return true;	
	}
}
function tab1_customer_one2(param,value){
	var customer = {
			telNo : "",
			custNm : "",
			custNo : ""
		};
	if(param == "custNm"){
		customer.custNm = value;
	}else if(param == "telNo"){
		customer.telNo = value;
	}else if(param == "custNo"){
		customer.custNo = value;
	}
	$.ajax({
		url : "/main/customerList",
		type : "post",
		contentType : 'application/json; charset=utf-8',
		data : JSON.stringify(customer),
		success : function(result) {
			if(result != ""){
				if(result.length == 1){
					$("input[name=custNo]").val(result[0].custNo);
					$("input[name=tab5_custNo]").val(result[0].custNo);
					$("input[name=tab6_custNo]").val(result[0].custNo);
					$("input[name=custNm]").val(result[0].custNm);
					if(result[0].custCd =="1001"){
						$("input:radio[name='custCd']:radio[value='1001']").prop("checked",true);
						$("input:radio[name='custCd']:radio[value='1002']").prop("checked",false);
					}else if(result.custCd =="1002"){
						$("input:radio[name='custCd']:radio[value='1001']").prop("checked",false);
						$("input:radio[name='custCd']:radio[value='1002']").prop("checked",true);
					}else{
						$("input:radio[name='custCd']:radio[value='1001']").prop("checked",false);
						$("input:radio[name='custCd']:radio[value='1002']").prop("checked",false);
					}
					$("input[name=addr]").val(result[0].addr);
					$("input[name=tel1No]").val(result[0].tel1No);
					$("input[name=tab1_resTelNo]").val(result[0].tel1No);
					$("input[name=tel2No]").val(result[0].tel2No);
					$("input[name=tel3No]").val(result[0].tel3No);
					$("input[name=faxNo]").val(result[0].faxNo);
					$("input[name=emailId]").val(result[0].emailId);
					if(result[0].sexCd =="1001"){
						$("input:radio[name='tsexCd']:radio[value='1001']").prop("checked",true);
						$("input:radio[name='tsexCd']:radio[value='1002']").prop("checked",false);
					}else if(result.sexCd == "1002"){
						$("input:radio[name='tsexCd']:radio[value='1001']").prop("checked",false);
						$("input:radio[name='tsexCd']:radio[value='1002']").prop("checked",true);
					}else{
						$("input:radio[name='tsexCd']:radio[value='1001']").prop("checked",false);
						$("input:radio[name='tsexCd']:radio[value='1002']").prop("checked",false);
					}
					//$("input[name=tsexCd]").val(result[0].sexCd);
					$("input[name=birthDate]").val(result[0].birthDate);
					$("#tab1_gradeCd").val(result[0].gradeCd);
					$("#tab1_custTypCd").val(result[0].custTypCd);
					$("#tab1_recogTypCd").val(result[0].recogTypCd);
					$("input[name=coRegNo]").val(result[0].coRegNo);
					$("input[name=lastCounDate]").val(result[0].lastCounDate);
					$("input[name=custNote]").val(result[0].custNote);
				}else if(result.length > 1){
					win_13.show();
					if(param == "custNm"){
						$("input[name=tab2_custNm]").val(value);
					}else if(param == "telNo"){
						$("input[name=tab2_telNo]").val(value);
					}
					popCustomerList();
					$("input[name=tab2_custNm]").val("");
				}
			}else{
				alert("일치하는 고객정보가 없습니다.");
				$("#click_tab1").click();
				$("#bt_reset").click();
				counReset();
				$("input[name=tel1No]").val(customer.telNo);
				$("input[name=tab1_resTelNo]").val(customer.telNo);
				//고객정보화면 clear 
			}
		}
	});
}

function tab01_dial(param){
	if(param == "tel1No"){
		if($("input[name=tel1No]").val() != ""){
			 $("input[name=sp_telNo]").val($("input[name=tel1No]").val());
			 ctiDial();
		}else{
			alert("번호를 입력 후 눌러주세요.");
		}
	}else if(param == "tel2No"){
		if($("input[name=tel2No]").val() != ""){
			 $("input[name=sp_telNo]").val($("input[name=tel2No]").val());
			 ctiDial();
		}else{
			alert("번호를 입력 후 눌러주세요.");
		}
	}else if(param == "tel3No"){
		if($("input[name=tel3No]").val() != ""){
			 $("input[name=sp_telNo]").val($("input[name=tel3No]").val());
			 ctiDial();
		}else{
			alert("번호를 입력 후 눌러주세요.");
		}
	}
}
</script>
</head>
<body class="jui">
	<table width="100%" border="0" align="center" cellpadding="0" cellspacing="0">
		<tr>
			<td>
				<table width="100%" border="0" cellpadding="0" cellspacing="0" class="table01" style="margin-bottom: 2px;">
					<tr>
						<td>
							<table width="100%" border="0" cellpadding="0"	cellspacing="0">
								<tr>
 									<td width="52" class="td01" id="sCust">고객번호</td>
									<td width="150" class="td02">
										<input type="text" name= "custNo" class="input mini" style="width: 120px" size="10"
												 onkeydown="javascript: if (event.keyCode == 13) {tab1_customer_one2('custNo',this.value);}"/>
									</td>
									<td width="45" class="td01">고객명<sup style="color:red; font-weight: bold;">*</sup></td>
									<td width=150 class="td02">
										<input type="text" name= "custNm" class="input mini" style="width: 120px" size="8"
												 onkeydown="javascript: if (event.keyCode == 13) {tab1_customer_one2('custNm',this.value);}"/>
									</td>
									<td width="55" class="td01">고객유형<sup style="color:red; font-weight: bold;">*</sup></td>
									<td width=150 class="td02">
										<input type="radio" name="custCd" value="1001" checked> 일반 
										<input type="radio" name="custCd" value="1002"> 사업자 
									<td width="60" class="td01">사업자번호</td>
									<td width=150 class="td02">
										<input type="text" name= "coRegNo" class="input mini" style="width: 120px" size="12" />
									</td>
									<td colspan="2" align="right" class="td01">
										<a class="btn small focus" id="bt_reset">초기화</a> 
										<a class="btn small focus" id="bt_custSave">저장</a>
										<a class="btn small focus" id="bt_custDelete">삭제</a>
									</td>
								</tr>
								<tr>
									<td width="50" class="td01">핸드폰<sup style="color:red; font-weight: bold;">*</sup></td>
									<td class="td02">
										<input type="text" name= "tel1No" class="input mini" value="" maxlength="20" style="width: 120px; float: left;" 
												onfocus="OnCheckPhone(this)" onKeyup="OnCheckPhone(this)" onkeydown="javascript: if (event.keyCode == 13) {tab1_customer_one2('telNo',this.value);}"/>
										<img src="../resources/jui-master/img/icon/tell.png" width="24" height="22" border="0" onclick="tab01_dial('tel1No');" style="cursor:pointer;">
									</td>
									<td width="45" class="td01">직장</td>
									<td class="td02">
										<input type="text" name= "tel2No" class="input mini" value="" maxlength="20" style="width: 120px; float: left;" onfocus="OnCheckPhone(this)" onKeyup="OnCheckPhone(this)"/>
										<img src="../resources/jui-master/img/icon/tell.png" width="24" height="22" border="0" onclick="tab01_dial('tel2No');" style="cursor:pointer;">
									</td>
									<td width="55" class="td01">자택</td>
									<td class="td02">
										<input type="text" name= "tel3No" class="input mini" value="" maxlength="20" style="width: 120px; float: left;" onfocus="OnCheckPhone(this)" onKeyup="OnCheckPhone(this)"/>
										<img src="../resources/jui-master/img/icon/tell.png" width="24" height="22" border="0" onclick="tab01_dial('tel3No');" style="cursor:pointer;">
									</td>
									<td width="55" class="td01">FAX</td>
									<td class="td02">
										<input type="text" name= "faxNo" class="input mini" value="" maxlength="20" style="width: 120px" onfocus="OnCheckPhone(this)" onKeyup="OnCheckPhone(this)"/>
									</td>
									<td width="60" class="td01">성별</td>
									<td class="td02">
										<input type="radio" name="tsexCd" value="1001"> 남 
										<input type="radio" name="tsexCd" value="1002"> 여 
									</td>
								</tr>
								<tr>
									<td width="50" class="td01">생년월일</td>
									<td class="td02">
										<input type="text" id="birthDate" name= "birthDate" class="input mini" style="width: 120px" size="10" />
									</td>
									<td width="45" class="td01">등급</td>
									<td class="td02">
										<select id="tab1_gradeCd"></select>
									</td>
									<td width="45" class="td01">고객구분</td>
									<td class="td02">
										<select id="tab1_custTypCd"></select>
									</td>
									<td width="45" class="td01">인지경로</td>
									<td class="td02">
										<select id="tab1_recogTypCd"></select>
									</td>
									<td width="55" class="td01">최종통화일</td>
									<td class="td02">
										<input type="text" name= "lastCounDate" class="input mini" style="width: 110px" size="10" />
									</td>
								</tr>
								<tr>
									<td width="50" class="td01">E-Mail</td>
									<td colspan="3" class="td02">
										<input type="text" name= "emailId" class="input mini" value="" style="width: 330px" />
									</td>
									<td width="50" class="td01">주소</td>
									<td colspan="5" class="td02">
										<input type="text" name= "addr" class="input mini" style="width: 554px" />
									</td>
								</tr>
								<tr>
									<td width="55" class="td01">비고</td>
									<td colspan="9" class="td02">
									 	<input type="text" name= "custNote" class="input mini" style="width: 977px"/>
										<input type="hidden" name="empNm" class="input mini" value="<%=session.getAttribute("empNm")%>" /> 
										<input type="hidden" name="empNo" class="input mini" value="<%=session.getAttribute("empNo")%>" /> 
										<input type="hidden" name="callTypCd" class="input mini" value="1001"/> 
										<input type="hidden" name="custInsert" class="input mini" value="<%=session.getAttribute("custInsert")%>" /> 
									 </td>
								</tr>
							</table>
						</td>
					</tr>
			</table>
	</table>
	<table width="100%" border="0" align="center" cellpadding="0" cellspacing="0" style="margin-bottom: 2px;">
		<tr>
			<td>
				<div class="panel">
					<div class="head">
						<strong>상담이력 등록</strong>
					</div>
					<div class="body">
						<table width="100%" border="0" cellspacing="0" cellpadding="0">
							<tr>
								<td>
									<table width="100%" border="0" cellpadding="0" cellspacing="0">
										<tr>
											<td colspan="6"></td>
										</tr>
										<tr>
											<td width="10"></td>
											<td width="52" class="td01">통화결과<sup style="color:red; font-weight: bold;">*</sup></td>
											<td>
												<select id="callResult"></select>
											</td>
											<td width="25" class="td01">메모</td>
											<td>
												<input type="text" name="counNote" class="input mini" value="" style="width: 820px" />
												<input type="hidden" name="counSeq" class="input mini" value=""/>
											</td>
											<td width="50" align="right" class="td01">
												<a class="btn small focus" id="bt_counSave">저 장</a>
											</td>
										</tr>
									</table>
							</tr>
						</table>
					</div>
			</td>
		</tr>
	</table>
	<table width="100%" border="0" align="center" cellpadding="0" cellspacing="0">
		<tr>
			<td>
				<div class="panel">
					<div class="head">
						<strong>상담예약 등록</strong>
					</div>
					<div class="body">
						<table width="100%" border="0" cellspacing="0" cellpadding="0">
							<tr>
								<td>
									<table width="100%" border="0" cellpadding="0" cellspacing="0">
										<tr>
											<td width="10"></td>
											<td width="52" class="td01">예약일시<sup style="color:red; font-weight: bold;">*</sup></td>
											<td>
												<span class="td02"> 
												<input type="text"class="input mini" id="tab1_resDate" name="tab1_resDate" value="" style="width: 82px" />
												<input type="text"class="input mini" name="tab1_resHms" value="" style="width: 60px" maxlength="5"/>
												</span>
											</td>
											<td class="td01">예약전화번호<sup style="color:red; font-weight: bold;">*</sup></td>
											<td>
												<span class="td02"> 
												<input type="text" class="input mini" name="tab1_resTelNo" value="" maxlength="14" style="width: 120px" onfocus="OnCheckPhone(this);" onKeyup="OnCheckPhone(this);"/>
												</span>
											</td>
											<td width="25" class="td01">메모</td>
											<td>
												<input type="text" class="input mini" name="tab1_resNote" value="" style="width: 500px" />
											</td>
											<td width="50" align="right" class="td01" id="bt_resSave"><a class="btn small focus">저 장</a></td>
										</tr>
									</table>
								</td>
							</tr>
						</table>
					</div>
			</td>
		</tr>
	</table>
			<div style="height: 45%" id="test">
				<%-- <%@ include file="./pages/tab05.jsp"%> --%>
				<table width="100%" border="0" align="center" cellpadding="0"cellspacing="0">
					<tr>
						<td>
							<ul id="tab_2" class="tab top tab_down" style="margin-top: 2px;">
								<li class="checked"><a href="#tab05" style="padding-bottom: 9px;">상담이력 <i class="icon-arrow1"></i></a>
								<li><a href="#tab06" style="padding-bottom: 9px;">SMS발송/이력<i></i></a></li>
							</ul>

							<div id="tab_contents_2">
								<div id="tab05"><%@ include file="./tab05.jsp"%></div>
								<div id="tab06"><%@ include file="./tab06.jsp"%></div>
							</div>
						</td>
					</tr>
				</table>
			</div>
</body>
</html>