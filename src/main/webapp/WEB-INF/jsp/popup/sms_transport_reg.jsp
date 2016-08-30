<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<script type="text/javascript">
$(document).ready(function() {

	var papSmsTrnsfer = {
			custNo : "",
			custNm : "",
			sendTelNo : "",
			sendTypCd : "",
			sendResDate : "",
			sendResHms : "",
			sendCd : "",
			cateCd : "",
			empNo : "",
			empNm : "",
			sendComment : "",
		};
	
	$("#pop_sendResDate").datepicker({
	showMonthAfterYear : true,
	changeMonth : true,
	changeYear : true,
	dateFormat : "yy-mm-dd",
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
	
	$("input[name=pop_sendResDate]").val(date.getFullYear() +'-'+ month +'-'+ day);
	$("input[name=pop_sendResHms]").val(hour +':'+ min);
	
	
	$.ajax({
		url : "/popup/smsList",
		type : "post",
		data : "",
		contentType : 'application/json; charset=utf-8',
		success : function(result) {
			$('#pop_cateCd').append('<option value=' + '' + '></option>');
		    for ( var i = 0; i < result.length; i++) {
					$('#pop_cateCd').append('<option value='+result[i].cateCd+'>' + result[i].cateNm + '</option>');
		    } 
		    $('#pop_cateCd').css("width","110px");
		}
	});

$("#bt_smsTransfer").click(function() {
		papSmsTrnsfer.custNo = $("input[name=custNo]").val();
		papSmsTrnsfer.custNm = $("input[name=custNm]").val();
		papSmsTrnsfer.sendTelNo = $("input[name=pop_sendTelNo]").val();
		papSmsTrnsfer.cateCd = $('#pop_cateCd option:selected').val();
		papSmsTrnsfer.sendTypCd = "1001";
		papSmsTrnsfer.sendResDate = $("input[name=pop_sendResDate]").val().replace(/-/gi, "");
		papSmsTrnsfer.sendResHms = $("input[name=pop_sendResHms]").val();
		papSmsTrnsfer.sendCd = "1001";
		papSmsTrnsfer.empNo = $("input[name=empNo]").val();
		papSmsTrnsfer.empNm = $("input[name=empNm]").val();
		papSmsTrnsfer.sendComment = $("textarea[name=sendComment]").val();

		if(papSmsTrnsfer.sendResDate == ""){
			msgboxActive('SMS 전송 등록', '발송일시를 입력해주세요.');
			//alert("발송일시를 입력해주세요.");
		}else if(papSmsTrnsfer.sendTypCd == ""){
			msgboxActive('SMS 전송 등록', '전송유형을 선택해주세요.');
			//alert("전송유형을 선택해주세요.");
		}else if(papSmsTrnsfer.sendComment == ""){
			msgboxActive('SMS 전송 등록', '전송 내용이 없습니다.');
			//alert("전송 내용이 없습니다.");
		}else if(papSmsTrnsfer.sendTelNo == ""){
			msgboxActive('SMS 전송 등록', '전송 할 번호가 없습니다.');
			//alert("전송 할 번호가 없습니다.");
		}else{
			if(regularCheck()){
				$.ajax({
					url : "/main/insertSms",
					type : "post",
					contentType : 'application/json; charset=utf-8',
					data : JSON.stringify(papSmsTrnsfer),
					success : function(result) {
						if(result == 1){
							//alert("등록되었습니다.");
							msgboxActive('SMS 전송 등록', 'SMS 전송 \"예약\"이 완료되었습니다.');
							$("#win_14").hide();
							$("#smsSearch").click();
						}else{
							msgboxActive('SMS 전송 등록', 'SMS 전송 \"예약\"이 완료되지 않았습니다. 다시 시도해주세요.');
							//alert("실패했습니다.");
						}
					}
				});
			}
		}
	});
});

function senTypChange(){

	var popSmsCtg = {
			cateCd : "",
			customName : "",
		};

	popSmsCtg.cateCd = $('#pop_cateCd option:selected').val();
	popSmsCtg.customName = $("input[name=custNm]").val();
	$.ajax({
		url : "/popup/smsOne",
		type : "post",
		data : JSON.stringify(popSmsCtg),
		contentType : 'application/json; charset=utf-8',
		success : function(result) {
			$("textarea[name=sendComment]").val(result.cateComment);
		}
	});
}
</script>
<div class="head">
	<a href="#" class="close"><i class="icon-exit"></i></a>
	<table width="100%" border="0" align="center" cellpadding="0"
		cellspacing="0">
		<tr>
			<td class="poptitle"
				style="background-image: url(../resources/jui-master/img/theme/jennifer/pop.png);">
				SMS 전송 등록
			</td>
		</tr>
	</table>
</div>
<div class="body">
	<table width="100%" border="0" cellspacing="0" cellpadding="0">
		<tr>
			<td width="100%" align="left" valign="top">
				<table border="0"cell padding="0" cellspacing="0">
					<tr>
						<td class="td01" width="65">전송번호<sup style="color:red; font-weight: bold;">*</sup>&nbsp;</td>
						<td height="22">
							<input type="text" name="pop_sendTelNo" class="input mini" value="" style="width: 110px;"/> 
						</td>
						<td class="td01">발송일시<sup style="color:red; font-weight: bold;">*</sup>&nbsp;</td>
						<td height="22">
							<input type="text" id="pop_sendResDate" name="pop_sendResDate" class="input mini" value="" style="width: 82px" /> 
							<input type="text" name="pop_sendResHms" class="input mini" value="" style="width: 55px" />
						</td>
					</tr>
					<tr>
						<td class="td01">전송유형<sup style="color:red; font-weight: bold;">*</sup>&nbsp;</td>
						<td height="28" colspan="3"><select id="pop_cateCd" onchange="senTypChange();"></select><a id="bt_smsTransfer" class="btn small focus">전송</a></td>
					</tr>
					<tr>
						<td>&nbsp;</td>
						<td align="left" valign="bottom" colspan="3"><textarea name="sendComment" class="input" style="height: 98px; width: 485px"></textarea></td>
					</tr>
				</table>
			</td>
		</tr>
	</table>
</div>