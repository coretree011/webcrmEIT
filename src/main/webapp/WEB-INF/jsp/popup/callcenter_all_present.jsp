<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<script>
var paramCallCenter = {
		startDate : "",
		endDate : ""
};
var paramCallCenterExcel = {
		startDate : "",
		endDate : "",
		radioValue : "",
};

var radioSelect;

jui.ready(["grid.xtable","ui.paging"], function(xtable, paging) {
	tab_callcenterList = xtable("#tab_callcenterList", {
		resize : true,
		scrollHeight: 390,
		width : 1105,
        scrollWidth: 1100,
        buffer: "s-page",
        bufferCount: 100,
        tpl: {
            row: $("#tpl_row_callcenter").html(),
            none: $("#tpl_none_callcenter").html()
        }
	});

	paging_callCenter = paging("#paging_callCenter", {
	      pageCount: 100,
	      event: {
	          page: function(pNo) {
	        	  tab_callcenterList.page(pNo);
	          }
	       },
	       tpl: {
	           pages: $("#tpl_pages_callcenter").html()
	       }
	});
	
	$("#bt_callcenterPopup").click(function() {
		var date = new Date();
		var month = date.getMonth() + 1;
		month = month < 10 ? '0' + month : month;
		var day = date.getDate();
		day = day < 10 ? '0' + day : day;

		$("#bt_startDate").val(setYesterday(date.getFullYear() +'-'+ month +'-'+ day));
		$("#bt_endDate").val(date.getFullYear() +'-'+ month +'-'+ day);
		
		tab_callcenterList.update();
	});
	
	$("#bt_callcenterList").click(function() {
		if(document.getElementById("radio_callcenterNoagg").checked == true){
			radioSelect = document.getElementById("radio_callcenterNoagg").value;
			paramCallCenter.startDate = $("#bt_startDate").val().replace(/-/gi, ""); 
			paramCallCenter.endDate = $("#bt_endDate").val().replace(/-/gi, ""); 
			
			$.ajax({
				url : "/popup/callStatSelect",
				type : "post",
				contentType : 'application/json; charset=utf-8',
				data : JSON.stringify(paramCallCenter),
				success : function(result) {
					if(result != ""){
						page=1;
						tab_callcenterList.update(result);
						tab_callcenterList.resize(); 
						paging_callCenter.reload(tab_callcenterList.count());
					}else{
						tab_callcenterList.resize(); 
						paging_callCenter.reload(tab_callcenterList.count());
					}
				}
			}); 
		}else if(document.getElementById("radio_callcenterDay").checked == true){
			radioSelect = document.getElementById("radio_callcenterDay").value;
			paramCallCenter.startDate = $("#bt_startDate").val().replace(/-/gi, ""); 
			paramCallCenter.endDate = $("#bt_endDate").val().replace(/-/gi, ""); 
			
			$.ajax({
				url : "/popup/callStatSelectDay",
				type : "post",
				contentType : 'application/json; charset=utf-8',
				data : JSON.stringify(paramCallCenter),
				success : function(result) {
					if(result != ""){
						page=1;
						tab_callcenterList.update(result);
						tab_callcenterList.resize(); 
					}else{
						tab_callcenterList.resize(); 
					}
				}
			});
		}else if(document.getElementById("radio_callcenterMonth").checked == true){
			radioSelect = document.getElementById("radio_callcenterMonth").value;
			var startDate = $("#bt_startDate").val().replace(/-/gi, ""); 
			var endDate = $("#bt_endDate").val().replace(/-/gi, ""); 
			paramCallCenter.startDate = startDate.substr(0,6);
			paramCallCenter.endDate = endDate.substr(0,6);
			
	    	$.ajax({
				url : "/popup/callStatSelectMonth",
				type : "post",
				contentType : 'application/json; charset=utf-8',
				data : JSON.stringify(paramCallCenter),
				success : function(result) {
					if(result != ""){
						page=1;
						tab_callcenterList.update(result);
						tab_callcenterList.resize(); 
					}else{
						tab_callcenterList.resize(); 
					}
				}
			});
		}else if(document.getElementById("radio_callcenterYear").checked == true){
			radioSelect = document.getElementById("radio_callcenterYear").value;
			var startDate = $("#bt_startDate").val().replace(/-/gi, ""); 
			var endDate = $("#bt_endDate").val().replace(/-/gi, ""); 
			paramCallCenter.startDate = startDate.substr(0,4);
			paramCallCenter.endDate = endDate.substr(0,4);
			
	    	$.ajax({
				url : "/popup/callStatSelectYear",
				type : "post",
				contentType : 'application/json; charset=utf-8',
				data : JSON.stringify(paramCallCenter),
				success : function(result) {
					if(result != ""){
						page=1;
						tab_callcenterList.update(result);
						tab_callcenterList.resize(); 
					}else{
						tab_callcenterList.resize(); 
					}
				}
			});
		}
		
	});
	
	/* 엑셀 다운로드 */
	$("#bt_callcenterCSV").click(function() {
		var empNm = $("input[name=empNm]").val();
		paramCallCenterExcel.radioValue = radioSelect;
		
		if(paramCallCenterExcel.radioValue == 1 || paramCallCenterExcel.radioValue == 2){
			paramCallCenterExcel.startDate = $("#bt_startDate").val().replace(/-/gi, ""); 
			paramCallCenterExcel.endDate = $("#bt_endDate").val().replace(/-/gi, ""); 
		}else if(paramCallCenterExcel.radioValue == 3){
			var startDate = $("#bt_startDate").val().replace(/-/gi, ""); 
			var endDate = $("#bt_endDate").val().replace(/-/gi, ""); 
			paramCallCenterExcel.startDate = startDate.substr(0,6);
			paramCallCenterExcel.endDate = startDate.substr(0,6);
		}else if(paramCallCenterExcel.radioValue == 4){
			var startDate = $("#bt_startDate").val().replace(/-/gi, ""); 
			var endDate = $("#bt_endDate").val().replace(/-/gi, ""); 
			paramCallCenterExcel.startDate = startDate.substr(0,4);
			paramCallCenterExcel.endDate = startDate.substr(0,4);
		}
		
		$("#ifraCallcenter").attr("src", "/popup/callcenterListExcel?startDate="+paramCallCenterExcel.startDate+"&endDate="+paramCallCenterExcel.endDate + "&empNm="+empNm + "&radioValue=" + paramCallCenterExcel.radioValue);
	});
});
</script>
<script>
$(document).ready(function() {
	$("#bt_startDate").datepicker({
		showMonthAfterYear : true,
		changeMonth : true,
		changeYear : true,
		dateFormat : "yy-mm-dd",
		dayNamesMin : ["일","월","화","수","목","금","토"],
		monthNamesShort : ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'],
		nextText:'다음 달',
        prevText:'이전 달'
	});

	$("#bt_endDate").datepicker({
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
<script id="tpl_row_callcenter" type="text/template">
	<tr class="tr03">
		<td scope="row" align ="center"><!= regDate !></td>
		<td scope="row"><!= genDirNo !></td>
		<td><!= totIbCount !></td>
		<td><!= totIbAgTransCount !></td>
		<td><!= totCbCount !></td>
		<td><!= totAbnCount !></td>
		<td><!= answer !></td>
		<td><!= totOutCount !></td>
		<td><!= totResCount !></td>
		<td><!= totExtCount !></td>
	</tr>
</script>
<script id="tpl_none_callcenter" type="text/template">
    <tr height ="380">
        <td colspan="10" class="none" align="center">데이터가 존재하지 않습니다.</td>
    </tr>
</script>
<script id="tpl_pages_callcenter" type="text/template">
    <! for(var i = 0; i < pages.length; i++) { !>
    <a href="#" class="page" onclick="fn_page();"><!= pages[i] !></a>
    <! } !>
</script>
<div class="head">
	<a href="#" class="close"><i class="icon-exit"></i></a>
	<table width="100%" border="0" align="center" cellpadding="0"
		cellspacing="0">
		<tr>
			<td class="poptitle"
				style="background-image: url(../resources/jui-master/img/theme/jennifer/pop.png);">
				콜센터 전체 통계
			</td>
		</tr>
	</table>
</div>
<div class="body" style="overflow-y:hidden">
	<table width="100%" border="0" align="center" cellpadding="0"
		cellspacing="0" style="margin-bottom: 2px;">
		<tr>
			<td width="60" class="td01">인입일자</td>
			<td align="left" class="td02">
				<input type="text" class="input mini" id="bt_startDate"  style="width: 82px" /> 
				<input type="text" class="input mini" id="bt_endDate"  style="width: 82px" />
			</td>
			<td width="290">
				<input type="radio" name="radio_callcenter" value = "1" id="radio_callcenterNoagg" checked> 시간대별 
				<input type="radio" name="radio_callcenter" value = "2" id="radio_callcenterDay"> 일별 
				<input type="radio" name="radio_callcenter" value = "3" id="radio_callcenterMonth"> 월별
				<input type="radio" name="radio_callcenter" value = "4" id="radio_callcenterYear"> 연도별
			</td>
         <td width="20%"></td>
        <td width="200" align="right" class="td01">
        	<a class="btn small focus" id="bt_callcenterList">조 회</a> 
        	<a class="btn small focus" id="bt_callcenterCSV">엑셀 다운로드</a>
        </td>
		</tr>
	</table>
	<table class="table special hover" id="tab_callcenterList" width="100%">
		<colgroup>
			<col width="110px">
			<col width="110px">
			<col width="110px">
			<col width="110px">
			<col width="110px">
			<col width="110px">
			<col width="110px">
			<col width="110px">
			<col width="110px">
			<col width="auto">
		</colgroup>
		<thead>
			<tr>
				<th rowspan="2" scope="col">일자</th>
				<th rowspan="2" scope="col">대표번호</th>
				<th colspan="5" scope="colgroup">인바운드</th>
				<th colspan="3" scope="colgroup">아웃바운드</th>
			</tr>
			<tr>
				<th scope="col">총인입</th>
				<th scope="col">상담원연결</th>
				<th scope="col">콜백</th>
				<th scope="col">포기호</th>
				<th scope="col">응대율</th>
				<th scope="col">건수</th>
				<th scope="col">예약</th>
				<th scope="col">내선통화</th>
			</tr>
		</thead>
		<tbody>
		</tbody>
	</table>
	<div id="paging_callCenter" class="paging" style="margin-top: 3px;">
	    <a href="#" class="prev" style="left:0" onclick="fn_page();">이전</a>
	    <div class="list"></div>
	    <a href="#" class="next" onclick="fn_page();">다음</a>
	</div>
	<iframe id="ifraCallcenter" name="ifraCallcenter" style="display:none;"></iframe>
</div>