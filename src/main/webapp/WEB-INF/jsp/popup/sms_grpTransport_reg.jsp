<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<script type="text/javascript">
$(document).ready(function() {
	var tmpResultCnt = 0;
	var smsArr = new Array();
	var grpSmsObj = new Object();
	var papGrpSmsTrnsfer = {
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


	$("#pop_grpSendResDate").datepicker({
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
	
	$("input[name=pop_grpSendResDate]").val(date.getFullYear() +'-'+ month +'-'+ day);
	$("input[name=pop_grpSendResHms]").val(hour +':'+ min);
	
	
	$.ajax({
		url : "/popup/smsList",
		type : "post",
		data : "",
		contentType : 'application/json; charset=utf-8',
		success : function(result) {
			$('#pop_grpCateCd').append('<option value=' + '' + '></option>');
		    for ( var i = 0; i < result.length; i++) {
					$('#pop_grpCateCd').append('<option value='+result[i].cateCd+'>' + result[i].cateNm + '</option>');
		    } 
		}
	});
	

	jui.ready(["grid.xtable","ui.paging"], function(xtable, paging) {

		var data;
		var data_size;
		var page = 1;
		var result_data;
		
		pop_smsGrpList = xtable("#pop_smsGrpList", {
			resize : true,
			scrollHeight: 150,
			width:545,
	        buffer: "s-page",
	        bufferCount: 30,
	        tpl: {
	            row: $("#tpl_row_smsTransfer").html(),
	            none: $("#tpl_none_smsTransfer").html()
	        }
		});

		$("#bt_smsGrpList").click(function() {
		var sms = {
				custNo : "",
			};

		sms.custNo = $("input[name=pop_grpTransCustNo]").val(); 
			$.ajax({
				url : "/main/customerListGrpSms",
				type : "post",
				contentType : 'application/json; charset=utf-8',
				data : JSON.stringify(sms),
				success : function(result) {
					if(result != ""){
						page=1;
						tmpResultCnt = result.length;
						$("#totalPerson").text("");
						$("#totalPerson").text("총 인원 : "+ tmpResultCnt + "명");
						pop_smsGrpList.update(result);
						pop_smsGrpList.resize();
						paging_smsTransfer.reload(pop_smsGrpList.count());
					}else{
						pop_smsGrpList.reset();
						paging_smsTransfer.reload(pop_smsGrpList.count());
					}
				}
			});
		});
			paging_smsTransfer = paging("#paging_smsTransfer", {
		      pageCount: 30,
		      event: {
		          page: function(pNo) {
		        	  pop_smsGrpList.page(pNo);
		          }
		       },
		       tpl: {
		           pages: $("#tpl_pages_smsTransfer").html()
		       }
		});
	});

$("#bt_smsGrpTransfer").click(function() {
		 smsArr = new Array();
		$('.trGrpSms').each(function(index){
			var num = index+1;	
					grpSmsObj = new Object();
					grpSmsObj.custNo = document.querySelectorAll(".grpSmsCustNo")[index].innerHTML;
					grpSmsObj.custNm = document.querySelectorAll(".grpSmsCustNm")[index].innerHTML;
					grpSmsObj.sendTelNo = document.querySelectorAll(".grpSendTelNo")[index].value;
					grpSmsObj.cateCd = $('#pop_grpCateCd option:selected').val();
					grpSmsObj.sendTypCd = "1001";
					grpSmsObj.sendResDate = $("input[name=pop_grpSendResDate]").val().replace(/-/gi, "");
					grpSmsObj.sendResHms = $("input[name=pop_grpSendResHms]").val();
					grpSmsObj.sendCd = "1001";
					grpSmsObj.empNo = $("input[name=empNo]").val();
					grpSmsObj.empNm = $("input[name=empNm]").val();
					grpSmsObj.sendComment = replaceAll($("textarea[name=grpSendComment]").val(),"{}",grpSmsObj.custNm);

					smsArr.push(grpSmsObj);
			});

		 if(regularCheck()){
				$.ajax({
					url : "/main/insertGrpSms",
					type : "post",
					contentType : 'application/json; charset=utf-8',
					data : JSON.stringify(smsArr),
					success : function(result) {
						if(result == 1){
							msgboxActive('SMS 전송 등록', 'SMS 전송 \"예약\"이 완료되었습니다.');
							$("#win_14_1").hide();
						}else{
							msgboxActive('SMS 전송 등록', 'SMS 전송 \"예약\"이 완료되지 않았습니다. 다시 시도해주세요.');
						}
					}
				});
			}    
	});

$("#bt_minusCheck").click(function() {
	var allLength = 0;
	var chkLength = 0;
	var result = "";
	allLength = pop_smsGrpList.size();
	for(var i = 0; i< allLength; i++){
		if($("#pSms_"+i+" input[name=sPop_chk]:checked").is(":checked")){
			chkLength += 1;
			if(result == ""){
				result = $("#"+i+" input[name=sPop_chk]").val();
				$("#pSms_"+i).remove();
				result = "";
			}
		}
	}
	tmpResultCnt = tmpResultCnt - chkLength;
	$("#totalPerson").text("");
	$("#totalPerson").text("총 인원 : "+ tmpResultCnt + "명");
	});
	
});

function grpSenTypChange(){

	var popSmsCtg = {
			cateCd : "",
			customName : "",
		};

	popSmsCtg.cateCd = $('#pop_grpCateCd option:selected').val();
	popSmsCtg.customName = "{}";
	$.ajax({
		url : "/popup/smsOne",
		type : "post",
		data : JSON.stringify(popSmsCtg),
		contentType : 'application/json; charset=utf-8',
		success : function(result) {
			$("textarea[name=grpSendComment]").val(result.cateComment);
		}
	});
}

function pop_sms_chkAll(){
    if($("#sPop_chk").prop("checked")){
        $("input[name=sPop_chk]").prop("checked",true);
    }else{
        $("input[name=sPop_chk]").prop("checked",false);
    }
}
</script>
<script id="tpl_row_smsTransfer" type="text/template">
		<tr id="pSms_<!= row.index !>" class="trGrpSms">
			<td align ="center"><input type="checkbox" name="sPop_chk" value="<!= custNo !>"/></td>
			<td align ="center" class="grpSmsCustNo"><!= custNo !></td>
			<td align ="center" class="grpSmsCustNm"><!= custNm !></td>
			<td align ="center" class="grpSmsTsendTelNo"><input type="text" class="grpSendTelNo" name ="grpSendTelNo" value="<!= tel1No !>" size="15"></td>
		</tr>
</script>
<script id="tpl_none_smsTransfer" type="text/template">
    <tr height ="100px">
        <td colspan="4" class="none" align="center">데이터가 존재하지 않습니다.</td>
    </tr>
</script>
<script id="tpl_pages_smsTransfer" type="text/template">
    <! for(var i = 0; i < pages.length; i++) { !>
    <a href="#" class="page"><!= pages[i] !></a>
    <! } !>
</script>
<div class="head">
	<a href="#" class="close"><i class="icon-exit"></i></a>
	<table width="100%" border="0" align="center" cellpadding="0"
		cellspacing="0">
		<tr>
			<td class="poptitle"
				style="background-image: url(../resources/jui-master/img/theme/jennifer/pop.png);">
				SMS 단체문자 전송 등록
			</td>
		</tr>
	</table>
</div>
<body class="jui">
	<table width="100%" border="0" cellspacing="0" cellpadding="0">
		<tr>
			<td width="50%" align="left" valign="top">
				<table border="0" cellpadding="0" cellspacing="0">
					<tr>
						<td class="td01">발송일시<sup style="color:red; font-weight: bold;">*</sup>&nbsp;</td>
						<td height="22">
							<input type="text" id="pop_grpSendResDate" name="pop_grpSendResDate" class="input mini" value="" style="width: 82px" /> 
							<input type="text" name="pop_grpSendResHms" class="input mini" value="" style="width: 55px" />
							<input type="hidden" name="pop_grpTransCustNo" class="input mini" value="" style="width: 55px" />
							<a id="bt_smsGrpList" hidden="hidden"></a>
						</td>
					</tr>
					<tr>
						<td class="td01">전송유형<sup style="color:red; font-weight: bold;">*</sup>&nbsp;</td>
						<td height="28"><select id="pop_grpCateCd" onchange="grpSenTypChange();"></select><a id="bt_smsGrpTransfer" class="btn small focus">전송</a></td>
					</tr>
					<tr>
						<td>&nbsp;</td>
						<td align="left" valign="bottom"><textarea name="grpSendComment" class="input" style="height: 102px; width: 485px"></textarea></td>
					</tr>
				</table>
				<table width="100%" border="0" cellpadding="0" cellspacing="0">
				      <tr>
						<td>&nbsp;</td>
						<td height="28" style="padding-left: 3px;">
							<a id="bt_minusCheck" class="btn small focus">제외</a>
							<a id="bt_minusDupNum" class="btn small focus">중복전화번호 제거</a>
						</td>
						<td id="totalPerson" align="right" style="padding-right: 15px;"></td>
			          </tr>
		        </table>
			    <table class="table classic hover"  id="pop_smsGrpList" width="100%" style="padding-left: 10px;">
			      <thead>
			        <tr>
			          <th class="th01" style="width:30px"><input type="checkbox" id="sPop_chk" onclick="javascript:pop_sms_chkAll();"/></th>
			          <th class="th01" style="width:125px">고객번호</th>
			          <th style="width:100px">고객명</th>
			          <th style="width:auto">전송 전화번호</th>
		            </tr>
		          </thead>
			      <tbody></tbody>
		        </table>
				<div id="paging_smsTransfer" class="paging" style="margin-left: 10px; width: 535px;">
				    <a href="#" class="prev" style="left:0">이전</a>
				    <div class="list"></div>
				    <a href="#" class="next">다음</a>
				</div>
			</td>
		</tr>
	</table>
</div>