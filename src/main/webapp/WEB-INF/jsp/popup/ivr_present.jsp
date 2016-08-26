<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<script>
var paramIvr = {
		startDate : "",
		endDate : "",
		telNo : "",
};
jui.ready(["grid.xtable","ui.paging"], function(xtable, paging) {
	tab_ivrList = xtable("#tab_ivrList", {
		resize : true,
		scrollHeight: 400,
		width : 1105,
        scrollWidth: 1100,
        buffer: "s-page",
        bufferCount: 100,
        tpl: {
            row: $("#tpl_row_ivr").html(),
            none: $("#tpl_none_ivr").html()
        }
	});
	
	paging_ivr = paging("#paging_ivr", {
	      pageCount: 100,
	      event: {
	          page: function(pNo) {
	        	  tab_ivrList.page(pNo);
	          }
	       },
	       tpl: {
	    	     pages: $("#tpl_pages_ivr").html()
	       }
	});
	
	$("#bt_ivrPopup").click(function() {
		var date = new Date();
		var month = date.getMonth() + 1;
		month = month < 10 ? '0' + month : month;
		var day = date.getDate();
		day = day < 10 ? '0' + day : day;

		$("#txt_ivrStartDate").val(setYesterday(date.getFullYear() +'-'+ month +'-'+ day));
		$("#txt_ivrEndDate").val(date.getFullYear() +'-'+ month +'-'+ day);
		
		tab_ivrList.update();
	});
	
	$("#bt_ivrSelect").click(function() {
		paramIvr.startDate  = $("#txt_ivrStartDate").val().replace(/-/gi, ""); 
		paramIvr.endDate = $("#txt_ivrEndDate").val().replace(/-/gi, ""); 
		paramIvr.telNo = $("#txt_ivrTel").val();
		
		$.ajax({
			url : "/popup/ivrSelect",
			type : "post",
			contentType : 'application/json; charset=utf-8',
			data : JSON.stringify(paramIvr),
			success : function(result) {
				if(result != ""){
					page=1;
					tab_ivrList.update(result);
					tab_ivrList.resize(); 
					
					paging_ivr.reload(tab_ivrList.count());
				}else{
					tab_ivrList.resize(); 
					paging_ivr.reload(tab_ivrList.count());
				}
			}
		});
	
	});
	
	/* 엑셀 다운로드 */
	$("#bt_ivrCSV").click(function() {
		var empNm = $("input[name=empNm]").val();
		paramIvr.startDate  = $("#txt_ivrStartDate").val().replace(/-/gi, ""); 
		paramIvr.endDate = $("#txt_ivrEndDate").val().replace(/-/gi, ""); 
		paramIvr.telNo = $("#txt_ivrTel").val();
		
		$("#ifraIvr").attr("src", "/popup/ivrListExcel?startDate="+paramIvr.startDate+"&endDate="+paramIvr.endDate+"&telNo="+paramIvr.telNo +"&empNm="+empNm);
	});
	
});
</script>
<script id="tpl_row_ivr" type="text/template">
	<tr class="tr03">
		<td align ="center"><!= regDate !></td>
		<td><!= regHms !></td>
		<td><!= genDirNo !></td>
		<td><!= telNo !></td>
		<td><!= extensionNo !></td>
		
	</tr>
</script>
<script id="tpl_none_ivr" type="text/template">
    <tr height ="390">
        <td colspan="5" class="none" align="center">데이터가 존재하지 않습니다.</td>
    </tr>
</script>
<script id="tpl_pages_ivr" type="text/template">
    <! for(var i = 0; i < pages.length; i++) { !>
    <a href="#" class="page" onclick="fn_page();"><!= pages[i] !></a>
    <! } !>
</script>
<script>
$(document).ready(function() {
	$("#txt_ivrStartDate").datepicker({
		showMonthAfterYear : true,
		changeMonth : true,
		changeYear : true,
		dateFormat : "yy-mm-dd",
		dayNamesMin : ["일","월","화","수","목","금","토"],
		monthNamesShort : ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'],
		nextText:'다음 달',
        prevText:'이전 달'
	});

	$("#txt_ivrEndDate").datepicker({
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
	<table width="100%" border="0" align="center" cellpadding="0" cellspacing="0">
		<tr>
			<td class="poptitle"
				style="background-image: url(../resources/jui-master/img/theme/jennifer/pop.png);">
				IVR 통계
			</td>
		</tr>
	</table>
</div>
<div class="body">
	<table width="100%" border="0" align="center" cellpadding="0" cellspacing="0" style="margin-bottom: 2px;">
		<tr>
			<td class="td01">인입일자</td>
			<td class="td02">
				<input type="text" class="input mini" id="txt_ivrStartDate"  style="width: 82px" /> 
				<input type="text" class="input mini" id="txt_ivrEndDate"  style="width: 82px" />
			</td>
			<td class="td01">인입번호</td>
			<td>
				<span class="td02"> 
					<input type="text" class="input mini" id="txt_ivrTel" maxLength="14"  style="width: 105px;float:left;" onfocus="OnCheckPhone(this)" onKeyup="OnCheckPhone(this)"/>
				</span>
			</td>
			<td width="290">
				<span class="td02"> 
					<input type="radio" name="radio" id="radio" value="radio"> 시간대별 
					<label for="radio"></label> 
					<input name="radio" type="radio" id="radio2" value="radio" checked> 일별 
					<input type="radio" name="radio" id="radio3" value="radio"> 월별
				</span> 
				<span class="td02"> 
					<input type="radio" name="radio" id="radio4" value="radio"> 연도별
				</span>
			</td>
			<td width="20%"></td>
			<td width="150" align="right" class="td01">
				<a class="btn small focus" id="bt_ivrSelect">조 회</a> 
				<a class="btn small focus" id="bt_ivrCSV">엑셀 다운로드</a>
			</td>
		</tr>
	</table>
	<table class="table classic hover" id="tab_ivrList" width="100%">
		<thead>
			<tr>
				<th style="width:210px">인입일자</th>
				<th style="width:210px">인입시간</th>
				<th style="width:210px">대표번호</th>
				<th style="width:210px">전화번호</th>
				<th style="width:auto">내선번호</th>
			</tr>
		</thead>
		<tbody>
		</tbody>
	</table>
	<div id="paging_ivr" class="paging" style="margin-top: 3px;">
	    <a href="#" class="prev" style="left:0" onclick="fn_page();">이전</a>
	    <div class="list"></div>
	    <a href="#" class="next" onclick="fn_page();">다음</a>
	</div>
	<iframe id="ifraIvr" name="ifraIvr" style="display:none;"></iframe>
</div>