<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
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
	var tab2_param = {
			telNo : "",
			custNm : "",
			custNo : "",
			coRegNo : "",
			sexCd : "",
			regDate : "",
			regDate2 : "",
			lastCounDate : "",
			lastCounDate2 : "",
			gradeCd : "",
			custTypCd : "",
			recogTypCd : "",
		};
	
	jui.ready([ "grid.xtable","ui.paging"], function(xtable, paging) {

		var data;
		var data_size;
		var page = 1;
		var result_data;
		
		tab_customerList = xtable("#tab_customerList", {
			 //scroll : true,  
			resize : true,
			scrollHeight: 400,
			scrollWidth: 1095,
			width:1950,
	        buffer: "s-page",
	        bufferCount: 500,
	        event: {
	 	    	click: function(row, e) {
	 	    		var id = "#" + row.index;
	 	    		if($(id).hasClass("selected")) {
	 	    			$(id).removeClass("selected");
	 	    			$(id).find('input:checkbox[name="tab2_chk"]').prop('checked', false);
	 	    		}else{
						$(id).addClass("selected");
						$(id).find('input:checkbox[name="tab2_chk"]').prop('checked', true);
	 	    		}
	 	    		
	 	    		var cnt = $('input:checkbox[name="tab2_chk"]:checked').length;
	 	    		var cust = document.querySelectorAll(".custNo")[row.index].innerHTML;
				    if(cnt >= 2){
				    	$(id).removeAttr("ondblclick");
				    }else if(cnt == 1 || cnt == 0){
				    	 $(id).dblclick(function() {
				    		customer_one(cust);
				    	}); 
				    } 
	 	    		
	 	    	}
		 	},
	        tpl: {
	            row: $("#tpl_row_tab02").html(),
	            none: $("#tpl_none_tab02").html()
	        }
		});
		
		$("#bt_customer").click(function() {
			tab2_param.telNo = $("input[name=tab2_telNo]").val();
			tab2_param.custNm = $("input[name=tab2_custNm]").val();
			tab2_param.coRegNo = $("input[name=tab2_coRegNo]").val();
			tab2_param.sexCd = $("#tab2_tsexCd option:selected").val();
			tab2_param.regDate = $("input[name=tab2_regDate]").val().replace(/-/gi, "");
			tab2_param.regDate2 = $("input[name=tab2_regDate2]").val().replace(/-/gi, "");
			tab2_param.lastCounDate = $("input[name=tab2_lastCounDate]").val().replace(/-/gi, "");
			tab2_param.lastCounDate2 = $("input[name=tab2_lastCounDate2]").val().replace(/-/gi, "");
			tab2_param.gradeCd = $("#tab2_gradeCd option:selected").val();
			tab2_param.custTypCd = $("#tab2_custTypCd option:selected").val();
			tab2_param.recogTypCd = $("#tab2_recogTypCd option:selected").val();

			$.ajax({
				url : "/main/customerList",
				type : "post", 
				contentType : 'application/json; charset=utf-8',
				data : JSON.stringify(tab2_param),
				success : function(result) {
						page=1;
						tab_customerList.update(result);
						tab_customerList.resize();

						paging_2.reload(tab_customerList.count());
				}
			});
		});

		paging_2 = paging("#paging_2", {
		      pageCount: 500,
		      event: {
		          page: function(pNo) {
		        	  tab_customerList.page(pNo);
		          }
		       },
		       tpl: {
		           pages: $("#tpl_pages_tab02").html()
		       }
		});
		 $("#bt_customer").click();
	});

	$(document).ready(function() {
		var tab2_codeParam = {
			lcd : ""	
		};

		$("#tab2_regDate").datepicker({
			showMonthAfterYear : true,
			changeMonth : true,
			changeYear : true,
			dateFormat : "yy-mm-dd",
			dayNamesMin : ["일","월","화","수","목","금","토"],
			monthNamesShort : ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'],
			nextText:'다음 달',
	        prevText:'이전 달'
		});

		$("#tab2_regDate2").datepicker({
			showMonthAfterYear : true,
			changeMonth : true,
			changeYear : true,
			dateFormat : "yy-mm-dd",
			dayNamesMin : ["일","월","화","수","목","금","토"],
			monthNamesShort : ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'],
			nextText:'다음 달',
	        prevText:'이전 달'
		});
		
		$("#tab2_lastCounDate").datepicker({
			showMonthAfterYear : true,
			changeMonth : true,
			changeYear : true,
			dateFormat : "yy-mm-dd",
			dayNamesMin : ["일","월","화","수","목","금","토"],
			monthNamesShort : ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'],
			nextText:'다음 달',
	        prevText:'이전 달'
		});
		
		$("#tab2_lastCounDate2").datepicker({
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
		var month2 = (date.getMonth() + 1)-1;
		month2 = month2 < 10 ? '0' + month2 : month2;
		var day = date.getDate();
		day = day < 10 ? '0' + day : day;
		var hour = date.getHours() + 1;
		hour = hour < 10 ? '0' + hour : hour;
		var min = date.getMinutes();
		min = min < 10 ? '0' + min : min;
		
		$("input[name=tab2_regDate]").val(date.getFullYear() +'-'+ month2 +'-'+ day);
		$("input[name=tab2_lastCounDate]").val(date.getFullYear() +'-'+ month2 +'-'+ day);
		$("input[name=tab2_regDate2]").val(date.getFullYear() +'-'+ month +'-'+ day);
		$("input[name=tab2_lastCounDate2]").val(date.getFullYear() +'-'+ month +'-'+ day);
		
		$("#bt_customerdel").click(function() {
			var chkLength = 0;
			var result = "";
			chkLength = tab_customerList.size();
			for(var i = 0; i< chkLength; i++){
				if($("#"+i+" input[name=tab2_chk]:checked").is(":checked")){
					if(result == ""){
						result = $("#"+i+" input[name=tab2_chk]").val();
					}else{
						result += ","+$("#"+i+" input[name=tab2_chk]").val()
					}
				}
			}
			tab2_param.custNo = result;
			 $.ajax({
				url : "/main/deleteCustomer",
				type : "post", 
				contentType : 'application/json; charset=utf-8',
				data : JSON.stringify(tab2_param),
				success : function(result) {
					if(result>0){
						msgboxActive('고객리스트', '선택하신 고객 \"삭제\"가 완료되었습니다.');
						$("#bt_customer").click();
					}else{
						msgboxActive('고객리스트', '고객 \"삭제\"가 완료되지 않았습니다. 다시 시도해주세요.');
					}
				}
			}); 
		});

		$("#bt_customerExcel").click(function() {
			var empNm = $("input[name=empNm]").val();
			tab2_param.telNo = $("input[name=tab2_telNo]").val();
			tab2_param.custNm = $("input[name=tab2_custNm]").val();
			tab2_param.coRegNo = $("input[name=tab2_coRegNo]").val();
			tab2_param.sexCd = $("#tab2_tsexCd option:selected").val();
			tab2_param.regDate = $("input[name=tab2_regDate]").val().replace(/-/gi, "");
			tab2_param.regDate2 = $("input[name=tab2_regDate2]").val().replace(/-/gi, "");
			tab2_param.lastCounDate = $("input[name=tab2_lastCounDate]").val().replace(/-/gi, "");
			tab2_param.lastCounDate2 = $("input[name=tab2_lastCounDate2]").val().replace(/-/gi, "");
			tab2_param.gradeCd = $("#tab2_gradeCd option:selected").val();
			tab2_param.custTypCd = $("#tab2_custTypCd option:selected").val();
			tab2_param.recogTypCd = $("#tab2_recogTypCd option:selected").val();

			$("#ifra").attr("src", "/main/customerListExcel?telNo="+tab2_param.telNo+"&custNm="+tab2_param.custNm+"&custNo="+tab2_param.custNo+"&empNm="+empNm
								+"&coRegNo="+tab2_param.coRegNo+"&sexCd="+tab2_param.sexCd+"&regDate="+tab2_param.regDate+"&regDate2="+tab2_param.regDate2
								+"&lastCounDate="+tab2_param.lastCounDate+"&lastCounDate2="+tab2_param.lastCounDate2+"&gradeCd="+tab2_param.gradeCd+"&custTypCd="+tab2_param.custTypCd
								+"&recogTypCd="+tab2_param.recogTypCd);
		});

		$("#bt_smsGrpSend").click(function() {
			var allLength = 0;
			var result = "";
			var chkTelNum = "";
			var chkTelArr = new Array();
			allLength = tab_customerList.size();
			for(var i = 0; i< allLength; i++){
				if($("#"+i+" input[name=tab2_chk]:checked").is(":checked")){
					if(result == ""){
						result = $("#"+i+" input[name=tab2_chk]").val();
						chkTelNum = $("#"+i+"_tab2_tel1No").text();
					}else{
						result += ","+$("#"+i+" input[name=tab2_chk]").val();
						chkTelNum += ","+$("#"+i+"_tab2_tel1No").text();
					}
				}
			}
			if(result != ""){
				chkTelArr = chkTelNum.split(',');
				for(var i = 0; i <chkTelArr.length; i++){
					var tmp = chkTelArr[i];
					for(var j = i+1; j <chkTelArr.length; j++){
						if(tmp == chkTelArr[j]){
							msgboxActive('SMS 단체전송', '중복된 핸드폰번호가 있습니다. \n 확인해주세요.');
							return;
						}
					}
				}
				$("input[name=pop_grpTransCustNo]").val(result);
				$("#bt_smsGrpList").click();
				win_14_1.show();
			}else{
				msgboxActive('SMS 단체전송', '고객을 선택해주세요.');
			}
		});
		tab2_codeParam.lcd = "1013";
		$.ajax({
			url : "/code/selecCodeList",
			type : "post",
			data : JSON.stringify(tab2_codeParam),
			contentType : 'application/json; charset=utf-8',
			success : function(result) {
				$('#tab2_gradeCd').append('<option value=' + '' + '></option>');
			    for ( var i = 0; i < result.length; i++) {
						$('#tab2_gradeCd').append('<option value='+result[i].scd+'>' + result[i].scdNm + '</option>');
			    } 
			    $('#tab2_gradeCd').css("width","80px");
			}
		});

		tab2_codeParam.lcd = "1014";
		$.ajax({
			url : "/code/selecCodeList",
			type : "post",
			data : JSON.stringify(tab2_codeParam),
			contentType : 'application/json; charset=utf-8',
			success : function(result) {
				$('#tab2_custTypCd').append('<option value=' + '' + '></option>');
			    for ( var i = 0; i < result.length; i++) {
						$('#tab2_custTypCd').append('<option value='+result[i].scd+'>' + result[i].scdNm + '</option>');
			    } 
			   //$('#tab2_custTypCd').css("width","100px");
			}
		});

		tab2_codeParam.lcd = "1015";
		$.ajax({
			url : "/code/selecCodeList",
			type : "post",
			data : JSON.stringify(tab2_codeParam),
			contentType : 'application/json; charset=utf-8',
			success : function(result) {
				$('#tab2_recogTypCd').append('<option value=' + '' + '></option>');
			    for ( var i = 0; i < result.length; i++) {
						$('#tab2_recogTypCd').append('<option value='+result[i].scd+'>' + result[i].scdNm + '</option>');
			    } 
			    //$('#tab2_recogTypCd').css("width","130px");
			}
		});
		
		$("#click_tab2").click(function() {
			   $("input[name=tab2_chk]").prop("checked",false);
	           $(".tab02_tr.selected").removeClass("selected");
		});
	});
	
	function customer_one(custNo){
		tab2_param.custNo = custNo;
		var test =document.getElementsByName("tsexCd");
		$.ajax({
			url : "/main/customerOne",
			type : "post",
			contentType : 'application/json; charset=utf-8',
			data : JSON.stringify(tab2_param),
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
					$("input[name=pop_sendTelNo]").val(result.tel1No);
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
				}else{
					$("input[name=tab5_custNo]").val("");
					$("input[name=tab6_custNo]").val("");
					$("#bt_reset").click();
				}
				$("#counSearch").click();
				$("#smsSearch").click();
				counReset();
				reservReset();
				$("#click_tab1").click();
			}
		});		
	}
	function tab2_chkAll(){
        if($("#tab2_chkAll").prop("checked")){
            $("input[name=tab2_chk]").prop("checked",true);
            $(".tab02_tr").addClass("selected");
        }else{
            $("input[name=tab2_chk]").prop("checked",false);
            $(".tab02_tr.selected").removeClass("selected");
        }
	}
</script>

<script id="tpl_row_tab02" type="text/template">
	<tr class="tab02_tr" id="<!= row.index !>" >
		<td align ="center"><input type="checkbox" name="tab2_chk" value="<!= custNo !>"/></td>
		<td align ="center"><!= num !></td>
		<td align ="center"><!= custCdNm !></td>
		<td align ="center" class="custNo"><!= custNo !></td>
		<td><!= custNm !></td>
		<td id="<!= row.index !>_tab2_tel1No"><!= tel1No !></td>
		<td><!= tel2No !></td>
		<td><!= tel3No !></td>
		<td><!= emailId !></td>
		<td><!= faxNo !></td>
		<td><!= addr !></td>
		<td align ="center"><!= coRegNo !></td>
		<td align ="center"><!= lastCounDate !></td>
		<td align ="center"><!= gradeNm !></td>
		<td align ="center"><!= custTypNm !></td>
		<td align ="center"><!= recogTypNm !></td>
		<td align ="center"><!= sexNm !></td>
		<td align ="center"><!= birthDate !></td>
		<td align ="center"><!= regDate !></td>
		<td><!= custNote !></td>
	</tr>
</script>

<script id="tpl_none_tab02" type="text/template">
    <tr height ="400">
        <td colspan="20" class="none" align="center">데이터가 존재하지 않습니다.</td>
    </tr>
</script>
<script id="tpl_pages_tab02" type="text/template">
    <! for(var i = 0; i < pages.length; i++) { !>
    <a href="#" class="page"><!= pages[i] !></a>
    <! } !>
</script>

</head>
<body class="jui">
	<table width="100%" border="0" align="center" cellpadding="0" cellspacing="0" style="margin-bottom: 7px; height: 100%">
		<tr>
			<td>
				<table width="100%" border="0" align="center" cellpadding="0" cellspacing="0" class="table01">
					<tr>
						<td>
							<table width="100%" border="0" cellpadding="0" cellspacing="0">
								<tr>
									<td class="td01" width="65">전화번호</td>
									<td class="td02" width="130">
										<input type="text" name="tab2_telNo" class="input mini" style="width: 105px" />
									</td>
									<td class="td01" width="45"><span class="td01">고객명</span></td>
									<td class="td02">
										<input type="text" name="tab2_custNm" class="input mini" style="width: 98px" />
									</td>
									<td class="td01" width="65"><span class="td01">사업자번호</span></td>
									<td class="td02">
										<input type="text" name="tab2_coRegNo" class="input mini" style="width: 110px" />
									</td>
									<td width="60" class="td01">성별</td>
									<td class="td02">
										<select id="tab2_tsexCd" style="width: 80px;">
											<option value=""></option>
											<option value="1001">남</option>
											<option value="1002">여</option>
										</select>
									</td>
									<td colspan="4" align="right" class="td01">
										<a class="btn small focus" id="bt_customer">조 회</a>
										<a class="btn small focus" id="bt_customerdel">삭제</a>
										<a class="btn small focus" id="bt_smsGrpSend">SMS 단체전송</a>
										<a class="btn small focus" id="bt_customerExcel">엑셀저장</a>
									</td>
								</tr>
								<tr>
									<td class="td01">등록일</td>
									<td class="td02" colspan="2">
										<input type="text" id="tab2_regDate" name="tab2_regDate" class="input mini" value="" style="width: 82px" /> ~
										<input type="text" id="tab2_regDate2" name="tab2_regDate2" class="input mini" value="" style="width: 82px" />
									</td>
									<td class="td01">최종상담일</td>
									<td class="td02" colspan="2">
										<input type="text" id="tab2_lastCounDate" name="tab2_lastCounDate" class="input mini" value="" style="width: 82px" /> ~
										<input type="text" id="tab2_lastCounDate2" name="tab2_lastCounDate2" class="input mini" value="" style="width: 82px" />
									</td>
									<td width="45" class="td01">고객등급</td>
									<td class="td02">
										<select id="tab2_gradeCd"></select>
									</td>
									<td width="55" class="td01">고객구분</td>
									<td class="td02">
										<select id="tab2_custTypCd"></select>
									</td>
									<td width="60" class="td01">인지경로</td>
									<td class="td02" width="130">
										<select id="tab2_recogTypCd"></select>
									</td>
								</tr>
							</table>
						<table border="0" cellpadding="0" cellspacing="0">
							<tr>
								<td height="3"></td>
							</tr>
						</table>
						<table class="table classic hover" id="tab_customerList" width="100%">
							<thead>
								<tr>
									<th style="width: 15px;"><input type="checkbox" id="tab2_chkAll" onclick="javascript:tab2_chkAll();"/></th>
									<th style="width: 30px;">SEQ</th>
									<th style="width: 32px;">유형</th>
									<th style="width: 90px;">고객번호</th>
									<th style="width: 50px;">고객명</th>
									<th style="width: 95px;">핸드폰</th>
									<th style="width: 95px;">직장</th>
									<th style="width: 95px;">자택</th>
									<th style="width: 150px;">eMail</th>
									<th style="width: 95px;">FAX</th>
									<th style="width: 190px;">주소</th>
									<th style="width: 80px;">사업자번호</th>
									<th style="width: 95px;">최종상담일</th>
									<th style="width: 80px;">고객등급</th>
									<th style="width: 80px;">고객유형</th>
									<th style="width: 80px;">인지경로</th>
									<th style="width: 25px;">성별</th>
									<th style="width: 80px;">생년월일</th>
									<th style="width: 80px;">등록일</th>
									<th style="width: auto;">비고</th>
								</tr>
							</thead>
							 <tbody>
							</tbody> 
						</table>
						<br>
						<div id="paging_2" class="paging" style="margin-top: 3px;">
						    <a href="#" class="prev" style="left:0">이전</a>
						    <div class="list"></div>
						    <a href="#" class="next">다음</a>
						</div>
					</td>
				</tr>
			</table>
	</table>
<iframe id="ifra" name="ifra" style="display:none;"></iframe>
</body>
</html>