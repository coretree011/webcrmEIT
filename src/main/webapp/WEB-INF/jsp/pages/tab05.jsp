<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<!DOCTYPE HTML>
<html>
<head>
<title>[JUI Library] - CSS/Tab</title>

<!-- <link rel="stylesheet" href="../resources/jui-master/dist/ui.css" />
	<link rel="stylesheet" href="../resources/jui-master/dist/ui-jennifer.css" />
	<link rel="stylesheet" href="../resources/jui-master/dist/grid.css" />
	<link rel="stylesheet" href="../resources/jui-master/dist/grid-jennifer.css" /> -->

<%-- <%@ include file="../common/jui_common.jsp"%> --%>
<script type="text/javascript">
$(document).ready(function() {
	var tab5_param = {
			lcd : "",
		};

	$("#tab5_cStartDate").datepicker({
		showMonthAfterYear : true,
		changeMonth : true,
		changeYear : true,
		dateFormat : "yy-mm-dd",
		dayNamesMin : ["일","월","화","수","목","금","토"],
		monthNamesShort : ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'],
		nextText:'다음 달',
        prevText:'이전 달'
	});

	$("#tab5_cEndDate").datepicker({
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
	
	var v = new Date(Date.parse(date) - 14*1000*60*60*24);
	var month2 = v.getMonth() + 1;
	month2 = month2 < 10 ? '0' + month2 : month2;
	var day2 = v.getDate();
	day2 = day2 < 10 ? '0' + day2 : day2;

	$("input[name=tab5_cStartDate]").val(date.getFullYear() +'-'+ month2 +'-'+ day2);
	$("input[name=tab5_cEndDate]").val(date.getFullYear() +'-'+ month +'-'+ day);

	tab5_param.lcd ="1006";
	$.ajax({
		url : "/code/selecCodeList",
		type : "post",
		data : JSON.stringify(tab5_param),
		contentType : 'application/json; charset=utf-8',
		success : function(result) {
			$('#tab5_callTypCd').append('<option value=' + '' + '></option>');
		    for ( var i = 0; i < result.length; i++) {
					$('#tab5_callTypCd').append('<option value='+result[i].scd+'>' + result[i].scdNm + '</option>');
		    } 
		}
	});

	tab5_param.lcd ="1011";
	$.ajax({
		url : "/code/selecCodeList",
		type : "post",
		data : JSON.stringify(tab5_param),
		contentType : 'application/json; charset=utf-8',
		success : function(result) {
			$('#tab5_counResult').append('<option value=' + '' + '></option>');
		    for ( var i = 0; i < result.length; i++) {
					$('#tab5_counResult').append('<option value='+result[i].scd+'>' + result[i].scdNm + '</option>');
		    } 
		}
	});
	
	$.ajax({
		url : "/empList",
		type : "post",
		data : "",
		contentType : 'application/json; charset=utf-8',
		success : function(result) {
			$('#tab5_empNo').append('<option value=' + '' + '></option>');
		    for ( var i = 0; i < result.length; i++) {
					$('#tab5_empNo').append('<option value='+result[i].empNo+'>' + result[i].empNm + '</option>');
		    } 
		}
	});
	});

	jui.ready(["grid.xtable","ui.paging"], function(xtable, paging) {
	
		var data;
		var data_size;
		var page = 1;
		var result_data;
		
		tab_counselList = xtable("#tab_counselList", {
			 /* scroll : true,   */
			resize : true,
			scrollHeight: 400,
			scrollWidth: 1095,
			width:1099,
	        buffer: "s-page",
	        bufferCount: 20,
	        tpl: {
	            row: $("#tpl_row_tab05").html(),
	            none: $("#tpl_none_tab05").html()
	        }
		});
	
	$("#counSearch").click(function() {
		var counsel = {
				counStartDate : "",
				counEndDate : "",
				callTypCd : "",
				empNo : "",
				counCd : "",
				counNote : "",
				custNo : "",
			};
	
		counsel.counStartDate = $("input[name=tab5_cStartDate]").val().replace(/-/gi, ""); 
		counsel.counEndDate = $("input[name=tab5_cEndDate]").val().replace(/-/gi, "");
		counsel.callTypCd = $("#tab5_callTypCd option:selected").val();
		counsel.empNo = $("#tab5_empNo option:selected").val();
		counsel.counCd = $("#tab5_counResult option:selected").val();
		counsel.counNote = $("input[name=tab5_counNote]").val();
		counsel.custNo = $("input[name=tab5_custNo]").val();
		
			$.ajax({
				url : "/main/counselList",
				type : "post",
				contentType : 'application/json; charset=utf-8',
				data : JSON.stringify(counsel),
				success : function(result) {
					if(result!=""){
						page=1;
						tab_counselList.update(result);
						tab_counselList.resize();
						
						paging_5.reload(tab_counselList.count());
						/* var start = (page-1)*3
						var end = page*3
						for (var i = start; i < end; i++){
							tab_counselList.append(result[i]);
						} */
					}else{
						tab_counselList.reset();
						paging_5.reload(tab_counselList.count());
					}
				}
			});
	});
	
	paging_5 = paging("#paging_5", {
	      pageCount: 20,
	      event: {
	          page: function(pNo) {
	        	  tab_counselList.page(pNo);
	          }
	       },
	       tpl: {
	           pages: $("#tpl_pages_tab05").html()
	       }
	});
	
	
	//$("#counSearch").click();
	});

	function counselOne(counSeq){
		var counsel = {
				counStartDate : "",
				counEndDate : "",
				callTypCd : "",
				empNo : "",
				counCd : "",
				counNote : "",
				counSeq : "",
				custNo : "",
			};
		
		counsel.counSeq = counSeq;
		$.ajax({
			url : "/main/counselList",
			type : "post",
			contentType : 'application/json; charset=utf-8',
			data : JSON.stringify(counsel),
			success : function(result) {
				$("#callResult").val(result[0].counCd);
				$("input[name=counNote]").val(result[0].counNote);
				$("input[name=counSeq]").val(result[0].counSeq);
				
			}
	});
}
	
</script>

<script id="tpl_row_tab05" type="text/template">
	<tr ondblclick="javascript:counselOne(<!= counSeq !>);"">
		<td align ="center"><!= custNo !></td>
		<td align ="center"><!= custNm !></td>
		<td align ="center"><!= telNo !></td>
		<td align ="center"><!= callTypCdNm !></td>
		<td align ="center"><!= counStartDate !> <!= counStartHms !></td>
		<td align ="center"></td>
		<td align ="center"><!= counCdNm !></td>
		<td align ="center"><!= empNm !></td>
		<td align ="center"><!= counNote !></td>
	</tr>
</script>
<script id="tpl_none_tab05" type="text/template">
    <tr height ="100px">
        <td colspan="9" class="none" align="center">데이터가 존재하지 않습니다.</td>
    </tr>
</script>
<script id="tpl_pages_tab05" type="text/template">
    <! for(var i = 0; i < pages.length; i++) { !>
    <a href="#" class="page"><!= pages[i] !></a>
    <! } !>
</script>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<style type="text/css">
.ui-datepicker{ font-size: 12px; width: 50px; }
.ui-datepicker select.ui-datepicker-month{ width:30%; font-size: 11px; }
.ui-datepicker select.ui-datepicker-year{ width:40%; font-size: 11px; }
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
</head>
<body class="jui">
	<table width="100%" border="0" align="center" cellpadding="0"
		cellspacing="0">
		<tr>
			<td>
				<table width="100%" border="0" align="center" cellpadding="0"
					cellspacing="0" class="table01">
					<tr>
						<td><table width="100%" border="0" align="center" cellpadding="0" cellspacing="0">
								<tr>
									<td class="td01">통화일자</td>
									<td class="td02">
										<input type="text" id="tab5_cStartDate" name="tab5_cStartDate" class="input mini" value="" style="width: 82px" /> 
										<input type="text" id="tab5_cEndDate" name="tab5_cEndDate" class="input mini" value="" style="width: 82px" />
										<input type="hidden" name="tab5_custNo" class="input mini" value="" />
									</td>
									<td class="td01">콜유형</td>
									<td class="td02">
										<select id="tab5_callTypCd"></select>
									</td>
									<td class="td01">상담원</td>
									<td class="td02">
										<select id="tab5_empNo"></select>
									</td>
									<td class="td01">상담결과</td>
									<td class="td02">
										<select id="tab5_counResult"></select>
									</td>
									<td class="td01">메모</td>
									<td class="td02"><input type="text" name="tab5_counNote" class="input mini" style="width: 160px" /></td>
									<td width="50" align="right" class="td01"><a class="btn small focus" id="counSearch">조 회</a></td>
								</tr>
							</table>
							<table width="100%" border="0" cellpadding="0" cellspacing="0">
								<tr>
									<td height="3"></td>
								</tr>
							</table>
							<table class="table classic hover" id="tab_counselList" width="100%">
								<thead>
									<tr>
										<th class="th01" style="width:110px">고객번호</th>
										<th style="width:110px">고객명</th>
										<th style="width:110px">상담전화번호</th>
										<th style="width:110px">콜유형</th>
										<th style="width:110px">상담일시</th>
										<th style="width:110px">상담시간</th>
										<th style="width:110px">상담결과</th>
										<th style="width:110px">상담자</th>
										<th style="width:auto">메모</th>
									</tr>
								</thead>
								<tbody>
								</tbody>
							</table>
							<br>
							<div id="paging_5" class="paging" style="margin-top: 3px;">
							    <a href="#" class="prev" style="left:0">이전</a>
							    <div class="list"></div>
							    <a href="#" class="next">다음</a>
							</div>
						
						</td>
					</tr>
				</table>
	</table>
</body>
</html>