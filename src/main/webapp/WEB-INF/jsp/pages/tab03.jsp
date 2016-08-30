<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>  
<!DOCTYPE HTML>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>[JUI Library] - CSS/Tab</title>
<%-- <%@ include file="../common/jui_common.jsp"%> --%>
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

	var tab3_param = {
			lcd : "",
		};

	var tab3_callback = {
			resDate : "",
			resDate2 : "",
			empNo : "",
			counCd : "",
		};

	jui.ready(["grid.xtable","ui.paging"], function(xtable, paging) {

		var data;
		var data_size;
		var page = 1;
		var result_data;
		
		tab_callbackList = xtable("#tab_callbackList", {
			/* scroll : true,  */
			resize : true,
			scrollHeight: 400,
		 	scrollWidth: 1095,
			width:1099, 
	        buffer: "s-page",
	        bufferCount: 500,
	        event: {
	 	    	dblclick: function(row, e) {
	 	    		this.select(row.index);
	 	    	}
		 	},
	        tpl: {
	            row: $("#tpl_row_tab03").html(),
	            none: $("#tpl_none_tab03").html()
	        }
		});
		
		$("#bt_callback").click(function() {
			tab3_callback.resDate = $("input[name=tab3_resDate]").val().replace(/-/gi, "");
			tab3_callback.resDate2 = $("input[name=tab3_resDate2]").val().replace(/-/gi, "");
			tab3_callback.empNo = $("#tab3_empNo option:selected").val();
			tab3_callback.counCd = $("#tab3_counResult option:selected").val();
			
			$.ajax({
				url : "/main/callbackList",
				type : "post",
				contentType : 'application/json; charset=utf-8',
				data : JSON.stringify(tab3_callback),
				success : function(result) {
						page=1;
						tab_callbackList.update(result);
						tab_callbackList.resize();

			        	 tab03_codeList();
						paging_3.reload(tab_callbackList.count());
						
					}
				});

		});

		paging_3 = paging("#paging_3", {
		      pageCount: 500,
		      event: {
		          page: function(pNo) {
		        	  tab_callbackList.page(pNo);
		        	  tab03_codeList();
		          }
		       },
		       tpl: {
		           pages: $("#tpl_pages_tab03").html()
		       }
		});
		
/* 		paging_3 = function(no) {
	        page += no;
	        page = (page < 1) ? 1 : page;
	        tab_callbackList.page(page);
	    } */
		$("#bt_callback").click();
	});

	$(document).ready(function() {
		$("#tab3_resDate").datepicker({
			showMonthAfterYear : true,
			changeMonth : true,
			changeYear : true,
			dateFormat : "yy-mm-dd",
			dayNamesMin : ["일","월","화","수","목","금","토"],
			monthNamesShort : ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'],
			nextText:'다음 달',
	        prevText:'이전 달'
		});
		$("#tab3_resDate2").datepicker({
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
		
		$("input[name=tab3_resDate]").val(setYesterday2(date.getFullYear() +'-'+ month +'-'+ day));
		$("input[name=tab3_resDate2]").val(date.getFullYear() +'-'+ month +'-'+ day);

		tab3_param.lcd ="1011";
		$.ajax({
			url : "/code/selecCodeList",
			type : "post",
			data : JSON.stringify(tab3_param),
			contentType : 'application/json; charset=utf-8',
			success : function(result) {
				$('#tab3_counResult').append('<option value=' + '' + '></option>');
			    for ( var i = 0; i < result.length; i++) {
						$('#tab3_counResult').append('<option value='+result[i].scd+'>' + result[i].scdNm + '</option>');
			    } 
			    $('#tab3_counResult').css("width","100px");
			}
		});

		$.ajax({
			url : "/empList",
			type : "post",
			data : "",
			contentType : 'application/json; charset=utf-8',
			success : function(result) {
				$('#tab3_empNo').append('<option value=' + '' + '></option>');
			    for ( var i = 0; i < result.length; i++) {
					   <%--  if(<%=session.getAttribute("empNo") %>==result[i].empNo){
				    		$('#tab3_empNo').append('<option value='+result[i].empNo+' selected>' + result[i].empNm + '</option>');
					    }else{ }--%>
				    		$('#tab3_empNo').append('<option value='+result[i].empNo+'>' + result[i].empNm + '</option>');
			    }
			}
		});
		
});
function tab03_codeList(){
	var callbackSize = tab_callbackList.size();
  
	tab3_param.lcd ="1011";
	$.ajax({
		url : "/code/selecCodeList",
		type : "post",
		data : JSON.stringify(tab3_param),
		contentType : 'application/json; charset=utf-8',
		success : function(result) {
				$(".tab3_counResult2").append('<option value=' + '' + '></option>');
			    for ( var j = 0; j < result.length; j++) {
			    	$(".tab3_counResult2").append('<option value='+result[j].scd+'>' + result[j].scdNm + '</option>');
			    }
			    for ( var i = 0; i < callbackSize; i++) {
					$("#tab3_"+i+" .tab3_counResult2").val($("#tab3_"+i+" input[name=tab3_counCd2]").val());
			    }
	    }
	}); 
}
function customer_one2(telNo){
	var customer = {
			telNo : "",
			custNm : "",
			custNo : "",
		};
	customer.telNo = telNo;
	$.ajax({
		url : "/main/customerList",
		type : "post",
		contentType : 'application/json; charset=utf-8',
		data : JSON.stringify(customer),
		success : function(result) {
			if(result != ""){
				$("input[name=custNo]").val(result[0].custNo);
				$("input[name=custNm]").val(result[0].custNm);
				$("#custCd").val(result[0].custCd);
				$("input[name=addr]").val(result[0].addr);
				$("input[name=tel1No]").val(result[0].tel1No);
				$("input[name=tel2No]").val(result[0].tel2No);
				$("input[name=tel3No]").val(result[0].tel3No);
				$("input[name=faxNo]").val(result[0].faxNo);
				$("input[name=emailId]").val(result[0].emailId);
				$("input[name=custNote]").val(result[0].custNote);
				if(result.length == 1){
					$("input[name=tab5_custNo]").val(result[0].custNo);
					$("input[name=tab6_custNo]").val(result[0].custNo);
					$("input[name=pop_sendTelNo]").val(result[0].tel1No);
					//$("input[name=tab5_cStartDate]").val(date.getFullYear()-1 +'-'+ month +'-'+ day);
					//$("input[name=tab5_cEndDate]").val("");
					$("#counSearch").click();
					$("#smsSearch").click();
					$("#click_tab1").click();
					//고객정보화면 팝업 
				}else if(result.length > 1){
					win_13.show();					
					$("input[name=tab2_telNo]").val(telNo);
					popCustomerList();
					//$("#click_tab2").click();
					//$("#bt_customer").click();
					//1건 존재 고객정보관리화면 popup, 상담이력 sms 이력을 display
				}
			}else{
				$("input[name=tab5_custNo]").val("9999999");
				$("input[name=tab6_custNo]").val("9999999");
				$("#counSearch").click();
				$("#smsSearch").click();
				$("#click_tab1").click();
				$("#bt_reset").click();
				counReset();
				$("input[name=tel1No]").val(telNo);
				$("input[name=tab1_resTelNo]").val(telNo);
				//고객정보화면 clear 
			}
		}
	});
}
 function setCbSeq(cbSeq,counCd){
	 $("input[name=tab3_cbSeq]").val(cbSeq);
	 $("#tab3_counResult").val(counCd);
 }
 
 function counChange(cbSeq,counCd){
	 $("input[name=tab3_cbSeq]").val(cbSeq);
	 $("input[name=tab3_counCd]").val(counCd.value);
 }
 
 function callbackSave(){
		var callback = {
				cbSeq : "",
				empNo : "",
				empNm : "",
				counCd : "",
			};
		
		callback.cbSeq = $("input[name=tab3_cbSeq]").val();
		callback.empNo = $("input[name=tab3_empNoS]").val();
		callback.empNm = $("input[name=tab3_empNmS]").val();
		callback.counCd = $("input[name=tab3_counCd]").val();
		
		$.ajax({
			url : "/main/callbackSave",
			type : "post",
			contentType : 'application/json; charset=utf-8',
			data : JSON.stringify(callback),
			success : function(result) {
				if(result == 1){
					msgboxActive('콜백', '콜백 \"저장\"이 완료되었습니다.');
					$("#tab3_counResult").val("");
					$("#tab3_empNo").val("");
					$("#bt_callback").click();
				}else{
					msgboxActive('콜백', '콜백 \"저장\"이 완료되지 않았습니다. 다시 시도해주세요.');
				}
			}
		});
	 
 }
</script>

<script id="tpl_row_tab03" type="text/template">
	<tr id="tab3_<!= row.index !>">
		<td align ="center"><!= num !></td>
		<td align ="center"><!= cbSeq !></td>
		<td align ="center" ondblclick="javascript:customer_one2('<!= resTelNo !>');"><!= resTelNo !></td>
		<td align ="center"><!= resDate !> <!= resHms !></td>
		<td align ="center"><!= counDate !> <!= counHms !></td>
		<td align ="center"><input type="hidden" name="tab3_counCd2" value="<!= counCd !>"/><select class="tab3_counResult2" onchange="javascript:counChange('<!= cbSeq !>',this);"></select></td>
		<td align ="center"><!= empNm !></td>
		<td align ="center"><!= genDirNo !></td>
		<td align ="center"></td>
	</tr>
</script>

<script id="tpl_none_tab03" type="text/template">
    <tr height ="400">
        <td colspan="9" class="none" align="center">데이터가 존재하지 않습니다.</td>
    </tr>
</script>
<script id="tpl_pages_tab03" type="text/template">
    <! for(var i = 0; i < pages.length; i++) { !>
    <a href="#" class="page"><!= pages[i] !></a>
    <! } !>
</script>
</head>
<body class="jui">
	<table width="100%" border="0" align="center" cellpadding="0" cellspacing="0" style="margin-bottom: 7px;">
		<tr>
			<td>
				<table width="100%" border="0" align="center"cellpadding="0" cellspacing="0" class="table01">
					<tr>
						<td>
							<table width="100%" border="0" align="center" cellpadding="0" cellspacing="0">
								<tr>
									<td class="td01">요청일자</td>
									<td class="td02">
										<input type="text" id="tab3_resDate" name="tab3_resDate" class="input mini" style="width: 82px" /> 
										<input type="text" id="tab3_resDate2" name="tab3_resDate2" class="input mini" style="width: 82px" /> 
										<input type="hidden" name="tab3_cbSeq" class="input mini" style="width: 82px" /> 
										<input type="hidden" name="tab3_counCd" class="input mini" style="width: 82px" /> 
										<input type="hidden" name="tab3_empNoS" class="input mini" value ="<%=session.getAttribute("empNo")%>" style="width: 82px" /> 
										<input type="hidden" name="tab3_empNmS" class="input mini" value ="<%=session.getAttribute("empNm")%>" style="width: 82px" /> 
									</td>
									<td class="td01">상담원</td>
									<td class="td02">
										<select id="tab3_empNo"></select>
									</td>
									<td class="td01">처리결과</td>
									<td class="td02">
										<select id="tab3_counResult"></select>
									</td>
									<td width="360">&nbsp;</td>
									<td width="140" align="right" class="td01">
										<a class="btn small focus" id="bt_callback">조 회</a> 
										<a class="btn small focus" id="bt_callbackSave" href="javascript:callbackSave()">저 장</a></td>
								</tr>
							</table>
							<table width="100%" border="0" cellpadding="0" cellspacing="0">
								<tr>
									<td height="3"></td>
								</tr>
							</table>
							<table class="table classic hover" id="tab_callbackList" width="100%">
								<thead>
									<tr>
										<th style="width: 30px;">SEQ</th>
										<th style="width: 100px;">콜백번호</th>
										<th style="width: 100px;">예약번호</th>
										<th style="width: 120px;">예약일시</th>
										<th style="width: 120px;">처리일시</th>
										<th style="width: 100px;">처리결과</th>
										<th style="width: 80px;">처리자</th>
										<th style="width: 100px">대표번호</th>
										<th style="width: auto">비고</th>
									</tr>
								</thead>
								<tbody>
								</tbody>
							</table>
							<br>
							<div id="paging_3" class="paging" style="margin-top: 3px;">
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