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
var tab4_Param = {
		lcd : "",
	};


$(document).ready(function() {
	var tab4_reserv = {
			resDate : "",
			resDate2 : "",
			empNo : "",
			counCd : "",
		};

	$("#tab4_resDate").datepicker({
		showMonthAfterYear : true,
		changeMonth : true,
		changeYear : true,
		dateFormat : "yy-mm-dd",
		dayNamesMin : ["일","월","화","수","목","금","토"],
		monthNamesShort : ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'],
		nextText:'다음 달',
        prevText:'이전 달'
	});

	$("#tab4_resDate2").datepicker({
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
		
		$("input[name=tab4_resDate]").val(setYesterday2(date.getFullYear() +'-'+ month +'-'+ day));
		$("input[name=tab4_resDate2]").val(date.getFullYear() +'-'+ month +'-'+ day);
		

		tab4_Param.lcd ="1012";

		$.ajax({
			url : "/code/selecCodeList",
			type : "post",
			data : JSON.stringify(tab4_Param),
			contentType : 'application/json; charset=utf-8',
			success : function(result) {
				$('#tab4_counResult').append('<option value=' + '' + '></option>');
			    for ( var i = 0; i < result.length; i++) {
						$('#tab4_counResult').append('<option value='+result[i].scd+'>' + result[i].scdNm + '</option>');
			    } 
			}
		});

		$.ajax({
			url : "/empList",
			type : "post",
			data : "",
			contentType : 'application/json; charset=utf-8',
			success : function(result) {
				$('#tab4_empNo').append('<option value=' + '' + '></option>');
			    for ( var i = 0; i < result.length; i++) {
				    if(<%=session.getAttribute("empNo") %> == result[i].empNo){
			    		$('#tab4_empNo').append('<option value='+result[i].empNo+' selected>' + result[i].empNm + '</option>');
				    }else{
			    		$('#tab4_empNo').append('<option value='+result[i].empNo+'>' + result[i].empNm + '</option>');
				    }
		  	  }
			}
		});

		jui.ready(["grid.xtable","ui.paging"], function(xtable, paging) {

			var data;
			var data_size;
			var page = 1;
			var result_data;
			
			tab_reservationList = xtable("#tab_reservationList", {
				/* scroll : true,  */
				resize : true,
				scrollHeight: 400,
				scrollWidth: 1095,
				width:1099,
		        fields: [ "고객번호", "고객명", "예약번호", "예약일시", "처리일시", "처리결과", "처리자", "메모" ],
		        sort : true,
		        buffer: "s-page",
		        bufferCount: 20,
		        tpl: {
		            row: $("#tpl_row_tab04").html(),
		            none: $("#tpl_none_tab04").html()
		        }
			});
			
			$("#bt_reservation").click(function() {
				tab4_reserv.resDate = $("input[name=tab4_resDate]").val().replace(/-/gi, "");
				tab4_reserv.resDate2 = $("input[name=tab4_resDate2]").val().replace(/-/gi, "");
				tab4_reserv.empNo = $("#tab4_empNo option:selected").val();
				tab4_reserv.counCd = $("#tab4_counResult option:selected").val();

				$.ajax({
					url : "/main/reservationList",
					type : "post",
					contentType : 'application/json; charset=utf-8',
					data : JSON.stringify(tab4_reserv),
					success : function(result) {
							page=1;
							tab_reservationList.update(result);
							tab_reservationList.resize();
							tab04_codeList();
							paging_4.reload(tab_reservationList.count());
							
						}
				});
			});

			paging_4 = paging("#paging_4", {
			      pageCount: 20,
			      event: {
			          page: function(pNo) {
			        	  tab_reservationList.page(pNo);
			        	  tab04_codeList();
			          }
			       },
			       tpl: {
			           pages: $("#tpl_pages_tab04").html()
			       }
			});
		});
});

function tab04_codeList(){
	var reservSize = tab_reservationList.size();
	tab4_Param.lcd ="1012";

	$.ajax({
		url : "/code/selecCodeList",
		type : "post",
		data : JSON.stringify(tab4_Param),
		contentType : 'application/json; charset=utf-8',
		success : function(result) {
			$('.tab4_counResult2').append('<option value=' + '' + '></option>');
		    for ( var i = 0; i < result.length; i++) {
					$('.tab4_counResult2').append('<option value='+result[i].scd+'>' + result[i].scdNm + '</option>');
		    } 
		    for ( var i = 0; i < reservSize; i++) {
				$("#tab4_"+i+" .tab4_counResult2").val($("#tab4_"+i+" input[name=tab4_counCd2]").val());
		    }
		}
	});
}
function customer(telNo){
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
				if(result.length > 1){
					//고객정보화면 팝업 
				}else{
					//1건 존재 고객정보관리화면 popup, 상담이력 sms 이력을 display
				}
			}else{
				//고객정보화면 clear 
			}
		}
	});
}
 function setResSeq(resSeq,empNo,counCd){
	 $("input[name=resSeq]").val(resSeq);
	 $("#tab4_empNo").val(empNo);
	 $("#tab4_counResult").val(counCd);
 }

 function reservChange(resSeq,counCd){
	 $("input[name=resSeq]").val(resSeq);
	 $("input[name=tab4_counCd]").val(counCd.value);
 }
 
 function reservationSave(){
		var resvation = {
				resSeq : "",
				empNo : "",
				empNm : "",
				counCd : "",
			};
		
		resvation.resSeq = $("input[name=resSeq]").val();
		resvation.empNo = $("input[name=tab4_empNoS]").val();
		resvation.empNm = $("input[name=tab4_empNmS]").val();
		resvation.counCd = $("input[name=tab4_counCd]").val();
		
		$.ajax({
			url : "/main/reservationSave",
			type : "post",
			contentType : 'application/json; charset=utf-8',
			data : JSON.stringify(resvation),
			success : function(result) {
				if(result == 1){
					alert("저장되었습니다.");
					$("#bt_reservation").click();
				}else{
					alert("실패했습니다.");
				}
			}
		});
 }
</script>

<script id="tpl_row_tab04" type="text/template">
	<tr id="tab4_<!=row.index !>" ondblclick="javascript:customer_one('<!= custNo !>');">
		<td align ="center"><!= num !></td>
		<td align ="center"><!= custNo !></td>
		<td align ="center"><!= custNm !></td>
		<td align ="center"><!= resTelNo !></td>
		<td align ="center"><!= resDate !> <!= resHms !></td>
		<td align ="center"><!= counDate !> <!= counHms !></td>
		<td align ="center"><input type="hidden" name="tab4_counCd2" value="<!= counCd !>"/><select class="tab4_counResult2" onchange="javascript:reservChange('<!= resSeq !>',this);"></select></td>
		<td align ="center"><!= empNm !></td>
		<td align ="center"><!= resNote !></td>
	</tr>
</script>
<script id="tpl_none_tab04" type="text/template">
    <tr height ="400">
        <td colspan="9" class="none" align="center">데이터가 존재하지 않습니다.</td>
    </tr>
</script>
<script id="tpl_pages_tab04" type="text/template">
    <! for(var i = 0; i < pages.length; i++) { !>
    <a href="#" class="page"><!= pages[i] !></a>
    <! } !>
</script>
</head>
<body class="jui">
	<table width="100%" border="0" align="center" cellpadding="0" cellspacing="0" style="margin-bottom: 7px;">
		<tr>
			<td><table width="100%" border="0" align="center" cellpadding="0" cellspacing="0" class="table01">
					<tr>
						<td><table width="100%" border="0" align="center" cellpadding="0" cellspacing="0">
								<tr>
									<td class="td01">예약일자</td>
									<td class="td02">
										<input type="text" class="input mini" id="tab4_resDate" name="tab4_resDate" style="width: 82px" /> 
										<input type="text" class="input mini" id="tab4_resDate2" name="tab4_resDate2" style="width: 82px" /> 
										<input type="hidden" class="input mini" name="resSeq" style="width: 82px" /> 
										<input type="hidden" name="tab4_counCd" class="input mini" style="width: 82px" /> 
										<input type="hidden" name="tab4_empNoS" class="input mini" value ="<%=session.getAttribute("empNo")%>" style="width: 82px" /> 
										<input type="hidden" name="tab4_empNmS" class="input mini" value ="<%=session.getAttribute("empNm")%>" style="width: 82px" />
									</td>
									<td class="td01">상담원</td>
									<td class="td02">
										<select id="tab4_empNo"></select>
									</td>
									<td class="td01">상담결과</td>
									<td class="td02">
										<select id="tab4_counResult"></select>
									</td>
									<td width="360">&nbsp;</td>
									<td width="140" align="right" class="td01">
										<a class="btn small focus" id="bt_reservation">조 회</a> 
										<a class="btn small focus" id="bt_reservationSave" href="javascript:reservationSave()">저 장</a></td>
								</tr>
							</table>
							<table width="100%" border="0" cellpadding="0" cellspacing="0">
								<tr>
									<td height="3"></td>
								</tr>
							</table>
							<table class="table classic hover"  id="tab_reservationList" width="100%">
								<thead>
									<tr>
										<th style="width: 25px;">SEQ</th>
										<th style="width: 90px;">고객번호</th>
										<th style="width: 80px;">고객명</th>
										<th style="width: 100px;">예약번호</th>
										<th style="width: 120px;">예약일시</th>
										<th style="width: 120px;">처리일시</th>
										<th style="width: 80px;">처리결과</th>
										<th style="width: 50px;">처리자</th>
										<th style="width: auto;">메모</th>
									</tr>
								</thead>
								<tbody>
								</tbody>
							</table>
							<br>
							<div id="paging_4" class="paging" style="margin-top: 3px;">
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