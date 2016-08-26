<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<script>
var paramCouncellerPresent = {
		leadStartDate : "",
		leadEndDate : "",
		empNm : ""
};

var paramCouncellerPresentExcel = {
		leadStartDate : "",
		leadEndDate : "",
		empNm : "",
		radioValue : ""
};

var radioSelect;
jui.ready(["grid.xtable","ui.paging"], function(xtable, paging) {
	tab_councellerPresent = xtable("#tab_councellerPresent", {
		resize : true,
		scrollHeight: 390,
		width : 1105,
        scrollWidth: 1100,
        buffer: "s-page",
        bufferCount: 50,
        tpl: {
            row: $("#tpl_row_counceller").html(),
            none: $("#tpl_none_counceller").html()
        }
	});
	
	paging_councellerPresent = paging("#paging_councellerPresent", {
	      pageCount: 100,
	      event: {
	          page: function(pNo) {
	        	  tab_councellerPresent.page(pNo);
	          }
	       },
	       tpl: {
	           pages: $("#tpl_pages_counceller").html()
	       }
	});
	
	$("#bt_councellerPresentPopup").click(function() {
		$.ajax({
			url : "/code/selectEmpNm",
			type : "post",
			contentType : 'application/json; charset=utf-8',
			data : JSON.stringify(param),
			success : function(result) {
				$('#select_councellerPresentEmpNm').empty();
				$('#select_councellerPresentEmpNm').append('<option value=' + '' + '></li>');
			    for ( var i = 0; i < result.length; i++) {
						$('#select_councellerPresentEmpNm').append('<option value='+result[i].empNm+'>' + result[i].empNm + '</option>');
			    } 			
			}
		});
		
		var date = new Date();
		var month = date.getMonth() + 1;
		month = month < 10 ? '0' + month : month;
		var day = date.getDate();
		day = day < 10 ? '0' + day : day;

		$("#txt_leadStartDate").val(setYesterday(date.getFullYear() +'-'+ month +'-'+ day));
		$("#txt_leadEndDate").val(date.getFullYear() +'-'+ month +'-'+ day);
		
		tab_councellerPresent.update();
		
	});
	
	$("#bt_councellerPresentSelect").click(function() { 
		if(document.getElementById("radio_councellerNoagg").checked == true){
			radioSelect = document.getElementById("radio_councellerNoagg").value;
			paramCouncellerPresent.leadStartDate  = $("#txt_leadStartDate").val().replace(/-/gi, ""); 
			paramCouncellerPresent.leadEndDate  = $("#txt_leadEndDate").val().replace(/-/gi, ""); 
			paramCouncellerPresent.empNm = $("#select_councellerPresentEmpNm option:selected").val();
			$.ajax({
				url : "/popup/councellerPresentList",
				type : "post",
				contentType : 'application/json; charset=utf-8',
				data : JSON.stringify(paramCouncellerPresent),
				success : function(result) {
					if(result != ""){
						page=1;
						tab_councellerPresent.update(result);
						tab_councellerPresent.resize(); 
						paging_councellerPresent.reload(tab_councellerPresent.count());
					}else{
						tab_councellerPresent.resize(); 
						paging_councellerPresent.reload(tab_councellerPresent.count());
					}
				}
			});
		}else if(document.getElementById("radio_councellerDay").checked == true){
			radioSelect = document.getElementById("radio_councellerDay").value;
			paramCouncellerPresent.leadStartDate  = $("#txt_leadStartDate").val().replace(/-/gi, ""); 
			paramCouncellerPresent.leadEndDate  = $("#txt_leadEndDate").val().replace(/-/gi, ""); 
			paramCouncellerPresent.empNm = $("#select_councellerPresentEmpNm option:selected").val();
			$.ajax({
				url : "/popup/councellerPresentList",
				type : "post",
				contentType : 'application/json; charset=utf-8',
				data : JSON.stringify(paramCouncellerPresent),
				success : function(result) {
					if(result != ""){
						page=1;
						tab_councellerPresent.update(result);
						tab_councellerPresent.resize(); 
					}else{
						tab_councellerPresent.resize(); 
					}
				}
			});
		}else if(document.getElementById("radio_councellerMonth").checked == true){
			radioSelect = document.getElementById("radio_councellerMonth").value;
			var startDate =  $("#txt_leadStartDate").val().replace(/-/gi, ""); 
			var endDate = $("#txt_leadEndDate").val().replace(/-/gi, ""); 
			paramCouncellerPresent.leadStartDate  = startDate.substr(0,6);
			paramCouncellerPresent.leadEndDate  = endDate.substr(0,6);
			paramCouncellerPresent.empNm = $("#select_councellerPresentEmpNm option:selected").val();
			
			$.ajax({
				url : "/popup/councellerPresentListMonth",
				type : "post",
				contentType : 'application/json; charset=utf-8',
				data : JSON.stringify(paramCouncellerPresent),
				success : function(result) {
					if(result != ""){
						page=1;
						tab_councellerPresent.update(result);
						tab_councellerPresent.resize(); 
					}else{
						tab_councellerPresent.resize(); 
					}
				}
			});
		}else if(document.getElementById("radio_councellerYear").checked == true){
			radioSelect = document.getElementById("radio_councellerYear").value;
			var startDate =  $("#txt_leadStartDate").val().replace(/-/gi, ""); 
			var endDate = $("#txt_leadEndDate").val().replace(/-/gi, ""); 
			paramCouncellerPresent.leadStartDate  = startDate.substr(0,4);
			paramCouncellerPresent.leadEndDate  = endDate.substr(0,4);
			paramCouncellerPresent.empNm = $("#select_councellerPresentEmpNm option:selected").val();
			
			$.ajax({
				url : "/popup/councellerPresentListYear",
				type : "post",
				contentType : 'application/json; charset=utf-8',
				data : JSON.stringify(paramCouncellerPresent),
				success : function(result) {
					if(result != ""){
						page=1;
						tab_councellerPresent.update(result);
						tab_councellerPresent.resize(); 
					}else{
						tab_councellerPresent.resize(); 
					}
				}
			});
		}
		
	});
 	
 	/* 엑셀다운로드 */ 
 	$("#bt_councellerPresentCSV").click(function() {
 		var empNm2 = $("input[name=empNm]").val();
 		paramCouncellerPresentExcel.radioValue = radioSelect;
 		
 		if(paramCouncellerPresentExcel.radioValue == 1 || paramCouncellerPresentExcel.radioValue == 2){
 			paramCouncellerPresentExcel.leadStartDate  = $("#txt_leadStartDate").val().replace(/-/gi, ""); 
 	 		paramCouncellerPresentExcel.leadEndDate  = $("#txt_leadEndDate").val().replace(/-/gi, ""); 
 	 		paramCouncellerPresentExcel.empNm = $("#select_councellerPresentEmpNm option:selected").val();
 		}else if(paramCouncellerPresentExcel.radioValue == 3){
 			var startDate =  $("#txt_leadStartDate").val().replace(/-/gi, ""); 
			var endDate = $("#txt_leadEndDate").val().replace(/-/gi, ""); 
			paramCouncellerPresent.leadStartDate  = startDate.substr(0,6);
			paramCouncellerPresent.leadEndDate  = startDate.substr(0,6);
			paramCouncellerPresent.empNm = $("#select_councellerPresentEmpNm option:selected").val();
 		}else if(paramCouncellerPresentExcel.radioValue == 4){
 			var startDate =  $("#txt_leadStartDate").val().replace(/-/gi, ""); 
			var endDate = $("#txt_leadEndDate").val().replace(/-/gi, ""); 
			paramCouncellerPresent.leadStartDate  = startDate.substr(0,4);
			paramCouncellerPresent.leadEndDate  = startDate.substr(0,4);
			paramCouncellerPresent.empNm = $("#select_councellerPresentEmpNm option:selected").val();
 		}
		
		$("#ifraCounceller").attr("src", "/popup/agentStatListExcel?startDate="+paramCouncellerPresentExcel.leadStartDate+"&endDate="+paramCouncellerPresentExcel.leadEndDate + "&empNm=" + paramCouncellerPresentExcel.empNm + "&empNm2="+empNm2 + "&radioValue=" + paramCouncellerPresentExcel.radioValue); 	 	
 	});
 	
});	
</script>
<script id="tpl_row_counceller" type="text/template">
	<tr class="tr03">
		<td align ="center"><!= startDate !></td>
		<td><!= empNm !></td>
		<td><!= totIbAgTransCount !></td>
		<td><!= totIbAgTransTime !></td>
		<td><!= totOutCount !></td>
		<td><!= totOutTime !></td>
		<td><!= totExtCount !></td>
		<td><!= totExtTime !></td>
		<td><!= agtStat1001Time !></td>
		<td><!= agtStat1002Time !></td>
		<td><!= agtStat1003Time !></td>
		<td><!= agtStat1004Time !></td>
		<td><!= agtStat1005Time !></td>
	</tr>
</script>
<script id="tpl_none_counceller" type="text/template">
    <tr height ="380">
        <td colspan="13" class="none" align="center">데이터가 존재하지 않습니다.</td>
    </tr>
</script>
<script id="tpl_pages_counceller" type="text/template">
    <! for(var i = 0; i < pages.length; i++) { !>
    <a href="#" class="page" onclick="fn_page();"><!= pages[i] !></a>
    <! } !>
</script>
<script>
$(document).ready(function() {
	$("#txt_leadStartDate").datepicker({
		showMonthAfterYear : true,
		changeMonth : true,
		changeYear : true,
		dateFormat : "yy-mm-dd",
		dayNamesMin : ["일","월","화","수","목","금","토"],
		monthNamesShort : ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'],
		nextText:'다음 달',
        prevText:'이전 달'
	});

	$("#txt_leadEndDate").datepicker({
		showMonthAfterYear : true,
		changeMonth : true,
		changeYear : true,
		dateFormat : "yy-mm-dd",
		dayNamesMin : ["일","월","화","수","목","금","토"],
		monthNamesShort : ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'],
		nextText:'다음 달',
        prevText:'이전 달'
	});
	
});
</script>
<div class="head">
	<a href="#" class="close"><i class="icon-exit"></i></a>
	<table width="100%" border="0" align="center" cellpadding="0"
		cellspacing="0">
		<tr>
			<td class="poptitle"
				style="background-image: url(../resources/jui-master/img/theme/jennifer/pop.png);">
				상담원 통계</td>
		</tr>
	</table>
</div>
<div class="body"  style="overflow-y:hidden">
	<table width="100%" border="0" align="center" cellpadding="0"
		cellspacing="0" style="margin-bottom: 2px;">
		<tr>
			<td width="60" class="td01">인입일자</td>
			<td align="left" class="td02">
				<input type="text" class="input mini" id="txt_leadStartDate"  style="width: 82px" />
				<input type="text" class="input mini" id="txt_leadEndDate"  style="width: 82px" /> 
			</td>
			<td width="60" class="td01">상담원</td>
			<td align="left" class="td02">
				<select id="select_councellerPresentEmpNm"></select>
			</td>
			<td width="290">
				<input type="radio" name="radio_counceller" value="1" id="radio_councellerNoagg" checked> 시간대별 
				<input type="radio" name="radio_counceller" value="2" id="radio_councellerDay"> 일별 
				<input type="radio" name="radio_counceller" value="3" id="radio_councellerMonth"> 월별
				<input type="radio" name="radio_counceller" value="4" id="radio_councellerYear"> 연도별
			</td>
		    <td width="200" align="right" class="td01">
			   	<a class="btn small focus" id="bt_councellerPresentSelect">조 회</a> 
		      	<a class="btn small focus" id="bt_councellerPresentCSV">엑셀 다운로드</a>
		    </td>
		</tr>
	</table>
	<table class="table special hover" id="tab_councellerPresent" width="100%">
		<colgroup>
			<col width="90px">
			<col width="90px">
			<col width="80px">
			<col width="80px">
			<col width="80px">
			<col width="80px">
			<col width="80px">
			<col width="80px">
			<col width="90px">
			<col width="90px">
			<col width="90px">
			<col width="90px">
			<col width="auto">
		</colgroup>
		<thead>
			<tr>
				<th scope="col" rowspan="2">일자</th>
				<th scope="col" rowspan="2">상담원</th>
				<th scope="colgroup" colspan="2">인바운드</th>
				<th scope="colgroup" colspan="2">아웃바운드</th>
				<th scope="colgroup" colspan="2">내선통화</th>
				<th scope="colgroup" colspan="5">상담원상태</th>
			</tr>
			<tr>
				<th scope="col">건수</th>
				<th scope="col">시간</th>
				<th scope="col">건수</th>
				<th scope="col">시간</th>
				<th scope="col">건수</th>
				<th scope="col">시간</th>
				<th scope="col">대기</th>
				<th scope="col">후처리</th>
				<th scope="col">이석</th>
				<th scope="col">휴식</th>
				<th scope="col">교육</th>
			</tr>
		</thead>
		<tbody>
		</tbody>
	</table> 
	<div id="paging_councellerPresent" class="paging" style="margin-top: 3px;">
	    <a href="#" class="prev" style="left:0" onclick="fn_page();">이전</a>
	    <div class="list"></div>
	    <a href="#" class="next" onclick="fn_page();">다음</a>
	</div>
	<iframe id="ifraCounceller" name="ifraCounceller" style="display:none;"></iframe>
</div>