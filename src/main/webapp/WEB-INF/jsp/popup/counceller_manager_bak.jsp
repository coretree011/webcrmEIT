<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<script>
var param = {
};
var paramCounceller = {
		empNo : ""
};
var paramCouncellerInsert = {
		empNo : "",
		empNm : "",
		enterDate : "",
		extensionNo : "",
		authCd : "",
		mobilePhoneNo : "",
		emailId : "",
		note : ""
};


jui.ready([ "grid.xtable"], function(xtable) {
	var data;
	var data_size;
	var page = 1;
	var result_data;
	
	/*
	 * 상담원관리
	 * counceller_manager.jsp
	 */	
	tab_counceller = xtable("#tab_counceller", {
		resize : true,
		scrollHeight: 400,
		width : 945,
        scrollWidth: 930,
        buffer: "s-page",
        bufferCount: 2000,
 	    event: {
 	    	click: function(row, e) {
 	    		var id = "#" + row.index + "_counceller";
 	    		if($(id).hasClass("selected")) {
 	    			$(id).removeClass("selected");
 	    			$(id).find('input:checkbox[name="chk_counceller"]').prop('checked', false);
 	    			$("#councellerUpdate").val('0');
 	    		}else{
					$(id).addClass("selected");
					$(id).find('input:checkbox[name="chk_counceller"]').prop('checked', true);
 	    		}
				
				var cnt = $('input:checkbox[name="chk_counceller"]:checked').length;
			    if(cnt >= 2 || cnt == 0){
			    	bt_initializationCounceller();
			    }else if(cnt == 1){
			    	var empNo  = $('tr.selected').find('[name=empNo]').html();
			    	var empNm  = $('tr.selected').find('[name=empNm]').html();
			    	var extensionNo  = $('tr.selected').find('[name=extensionNo]').html();
			    	var authCd   = $('tr.selected').find('[name=authCd]').html();
			    	var mobilePhoneNo   = $('tr.selected').find('[name=mobilePhoneNo]').html();
			    	var emailId   = $('tr.selected').find('[name=emailId]').html();
			    	var note   = $('tr.selected').find('[name=note]').html();
			    	councellerData(empNo,empNm,extensionNo,authCd,mobilePhoneNo,emailId,note);
			    }
 	    	}
	    } 
	});
	
	$("#bt_councellerSelect").click(function() {
		
		$.ajax({
			url : "/popup/counceller",
			type : "post",
			contentType : 'application/json; charset=utf-8',
			data : JSON.stringify(param),
			success : function(result) {
				page=1;
				tab_counceller.update(result);
				tab_counceller.resize(); 
				
				bt_initializationCounceller();
			}
		
		});
	});
	
	/*삭제 버튼*/
	$("#bt_councellerDelete").click(function() {
		var cnt = $('input:checkbox[name="chk_counceller"]:checked').length;
	    if(cnt == 0){
	    	msgboxActive('상담원 관리', '\"삭제\"할 상담원을 선택해주세요.');
	        //alert('삭제할 상담원을 선택해주세요.');
	    }else{
			var chkLength = 0;
			var temp = "";
			chkLength = tab_counceller.size();
			for(var i = 0; i< chkLength; i++){
				 if($("#"+i+"_counceller input[name=chk_counceller]:checked").is(":checked")){
					if(temp == ""){
						temp = $("#"+i+"_counceller input[name=chk_counceller]").val();
					}else{
						temp += ","+$("#"+i+"_counceller input[name=chk_counceller]").val();
					}
				}  
			}
			
			paramCounceller.empNo = temp;
			
			$.ajax({
				url : "/popup/councellerDelete",
				type : "post",
				contentType : 'application/json; charset=utf-8',
				data : JSON.stringify(paramCounceller),
				success : function(result) {
					if(result>=1){
						msgboxActive('상담원 관리', '\"삭제\"가 완료되었습니다.');
						//alert("삭제가 완료되었습니다");
						$("#txt_empNo").val("");
						$("#txt_empNm").val("");	
						$("#txt_tel").val("");
						$("#txt_email").val("");
						$("#txt_note").val("");
						$("#select_councellerExtension").val("");
						$("#select_councellerAuthCd").val("");
						$("#bt_councellerSelect").click(); 
					}else {
						//alert("삭제가 되지 않았습니다. 다시 시도해주세요.");
						msgboxActive('상담원 관리', '\"삭제\"가 되지 않았습니다. 다시 시도해주세요.');
					}
				}
			
			});
	    }
	});
	
	/*비번초기화 버튼*/
	$("#bt_pwInitialization").click(function() {
		var cnt = $('input:checkbox[name="chk_counceller"]:checked').length;
	    if(cnt == 0){
	    	msgboxActive('상담원 관리', '\"비밀번호 초기화\"할 상담원을 선택해주세요.');
	        //alert('비밀번호 초기화할 상담원을 선택해주세요.');
	    }else{
			var chkLength = 0;
			var temp = "";
			chkLength = tab_counceller.size();
			for(var i = 0; i< chkLength; i++){
				 if($("#"+i+"_counceller input[name=chk_counceller]:checked").is(":checked")){
					if(temp == ""){
						temp = $("#"+i+"_counceller input[name=chk_counceller]").val();
					}else{
						temp += ","+$("#"+i+"_counceller input[name=chk_counceller]").val();
					}
				}  
			}
			
			paramCounceller.empNo = temp;
		
			$.ajax({
				url : "/popup/councellerUpdate",
				type : "post",
				contentType : 'application/json; charset=utf-8',
				data : JSON.stringify(paramCounceller),
				success : function(result) {
					if(result>=1){
						//alert("비밀번호가 초기화되었습니다.");
						msgboxActive('상담원 관리', '\"비밀번호 초기화\" 되었습니다.');
						$("#bt_councellerSelect").click();
					}else{
						msgboxActive('상담원 관리', '\"비밀번호 초기화\"가 완료되지 않았습니다. 다시 시도해주세요.');
						//alert("비밀번호가 초기화되지 않았습니다. 다시 시도해주세요.");
					}
				}
			
			});
	    }
	});
	
	/*저장 버튼*/
	$("#bt_councellerInsert").click(function() {
		var date = new Date();
		   
	    var year  = date.getFullYear();
	    var month = date.getMonth() + 1; 
	    var day   = date.getDate();
	
	    if (("" + month).length == 1) { month = "0" + month; }
	    if (("" + day).length   == 1) { day   = "0" + day;   }
	    
	    var today = year + month + day;
		paramCouncellerInsert.empNo = $("#txt_empNo").val();
		paramCouncellerInsert.empNm = $("#txt_empNm").val();
		paramCouncellerInsert.enterDate = today;
		paramCouncellerInsert.extensionNo = $("#select_councellerExtension").val();
		paramCouncellerInsert.authCd = $("#select_councellerAuthCd").val();		
		paramCouncellerInsert.mobilePhoneNo = $("#txt_tel").val();
		paramCouncellerInsert.emailId = $("#txt_email").val();
		paramCouncellerInsert.note = $("#txt_note").val();
		
		//같은 이름의 상담원이 존재할 경우 alert
/*  		var tempName = 0;
		$('.trCounceller').each(function(index){	
			var name = $('.trCounceller').find('#councellerNm').eq(index).html();
			if(paramCouncellerInsert.empNm == name){
				tempName = 1;
				return false;
			}else{
				tempName = 0;
			}
			
		}); 
		

		if(tempName == 1){
			msgboxActive3('상담원 관리', '\"같은 이름\"의 상담원이 존재합니다.');
			//alert("같은 이름의 상담원이 존재합니다.");
			tempName = 0;
			
			*/
		
		if(paramCouncellerInsert.empNo == ''){
			//alert("사번을 입력해주세요.");
			msgboxActive('상담원 관리', '\"사번\"을 입력해주세요.');
		}else if(paramCouncellerInsert.empNm == ''){
			//alert("이름을 입력해주세요.");
			msgboxActive('상담원 관리', '\"이름\"을 입력해주세요.');
		}else if(paramCouncellerInsert.authCd == ''){
			//alert("권한유형을 선택해주세요.");
			msgboxActive('상담원 관리', '\"권한 유형\"을 선택해주세요.');
		}else if($("#councellerUpdate").val() == '1'){
			$.ajax({
				url : "/popup/councellerNameChk",
				type : "post",
				contentType : 'application/json; charset=utf-8',
				data : JSON.stringify(paramCouncellerInsert),
				success : function(result) {
					if(result>=1){
						msgboxActive3('상담원 관리', '\"같은 이름\"의 상담원이 존재합니다.');
						$('#counceller_msgok').click(function() {
							$('#counceller_msgbox').css( "display", "none" );
							$.ajax({
								url : "/popup/councellerDataUpdate",
								type : "post",
								contentType : 'application/json; charset=utf-8',
								data : JSON.stringify(paramCouncellerInsert),
								success : function(result) {
									if(result>=1){
										msgboxActive('상담원 관리', '\"수정\"이 완료되었습니다.');
										//alert("수정이 완료되었습니다");
										document.getElementById("txt_empNo").disabled = false;
										$("#txt_empNo").val("");
										$("#txt_empNm").val("");	
										$("#txt_tel").val("");
										$("#txt_email").val("");
										$("#txt_note").val("");
										$("#select_councellerExtension").val("");
										$("#select_councellerAuthCd").val("");
										$("#bt_councellerSelect").click(); 
									}else{
										msgboxActive('상담원 관리', '\"수정\"이 완료되지 않았습니다. 다시 시도해주세요.');
										//alert("수정이 완료되지 않았습니다.");
									}
								}
							});
						});
					}else{
						$.ajax({
							url : "/popup/councellerDataUpdate",
							type : "post",
							contentType : 'application/json; charset=utf-8',
							data : JSON.stringify(paramCouncellerInsert),
							success : function(result) {
								if(result>=1){
									msgboxActive('상담원 관리', '\"수정\"이 완료되었습니다.');
									//alert("수정이 완료되었습니다");
									document.getElementById("txt_empNo").disabled = false;
									$("#txt_empNo").val("");
									$("#txt_empNm").val("");	
									$("#txt_tel").val("");
									$("#txt_email").val("");
									$("#txt_note").val("");
									$("#select_councellerExtension").val("");
									$("#select_councellerAuthCd").val("");
									$("#bt_councellerSelect").click(); 
								}else{
									msgboxActive('상담원 관리', '\"수정\"이 완료되지 않았습니다. 다시 시도해주세요.');
									//alert("수정이 완료되지 않았습니다.");
								}
							}
						});
					}
				}
			});
			$("#councellerUpdate").val('0');
		}else{
			$.ajax({
				url : "/popup/councellerNameChk",
				type : "post",
				contentType : 'application/json; charset=utf-8',
				data : JSON.stringify(paramCouncellerInsert),
				success : function(result) {
					if(result>=1){
						msgboxActive3('상담원 관리', '\"같은 이름\"의 상담원이 존재합니다.');
						$('#counceller_msgok').click(function() {
							$('#counceller_msgbox').css( "display", "none" );
							$.ajax({
								url : "/popup/councellerExtensionChk",
								type : "post",
								contentType : 'application/json; charset=utf-8',
								data : JSON.stringify(paramCouncellerInsert),
								success : function(result) {
									if(result >= 1){
										msgboxActive3('상담원 관리', '동일한 내선이 존재합니다. \n 저장하시겠습니까?');
										$('#counceller_msgok').click(function() {
											$('#counceller_msgbox').css( "display", "none" );
											$.ajax({
												url : "/popup/councellerInsert",
												type : "post",
												contentType : 'application/json; charset=utf-8',
												data : JSON.stringify(paramCouncellerInsert),
												success : function(result) {
													if(result>=1){
														msgboxActive('상담원 관리', '\"저장\"이 완료되었습니다.');
														//alert("저장이 완료되었습니다");
														$("#txt_empNo").val("");
														$("#txt_empNm").val("");	
														$("#txt_tel").val("");
														$("#txt_email").val("");
														$("#txt_note").val("");
														$("#select_councellerExtension").val("");
														$("#select_councellerAuthCd").val("");
														$("#bt_councellerSelect").click(); 
													}else{
														msgboxActive('상담원 관리', '일치하는 \"사번이 존재\"합니다. \n 사번을 다시 입력해주세요.');
														//alert("일치하는 사번이 존재합니다. 사번을 다시 입력해주세요.");
													}
												}
											});
										});
									}else{
										$.ajax({
											url : "/popup/councellerInsert",
											type : "post",
											contentType : 'application/json; charset=utf-8',
											data : JSON.stringify(paramCouncellerInsert),
											success : function(result) {
												if(result>=1){
													msgboxActive('상담원 관리', '\"저장\"이 완료되었습니다.');
													//alert("저장이 완료되었습니다");
													$("#txt_empNo").val("");
													$("#txt_empNm").val("");	
													$("#txt_tel").val("");
													$("#txt_email").val("");
													$("#txt_note").val("");
													$("#select_councellerExtension").val("");
													$("#select_councellerAuthCd").val("");
													$("#bt_councellerSelect").click(); 
												}else{
													msgboxActive('상담원 관리', '일치하는 \"사번이 존재\"합니다. \n 사번을 다시 입력해주세요.');
													//alert("일치하는 사번이 존재합니다. 사번을 다시 입력해주세요.");
												}
											}
										});
									}
									$("#councellerUpdate").val('0');
								}
							});
						});
					}
				}
			});
		}
	});
	
	/*
	 * 상담원관리  
	 * load 시 데이터 조회
	 * 내선 코드  / 권한유형
	 */	
	$("#bt_councellerPopup").click(function() {
		document.getElementById("txt_empNo").disabled = false;
		$("#txt_empNo").val("");
		$("#txt_empNm").val("");	
		$("#txt_tel").val("");
		$("#txt_email").val("");
		$("#txt_note").val("");
		$("#select_councellerExtension").val("");
		$("#select_councellerAuthCd").val("");
		
		$.ajax({
			url : "/popup/counceller",
			type : "post",
			contentType : 'application/json; charset=utf-8',
			data : JSON.stringify(param),
			success : function(result) {
				page=1;
				tab_counceller.update(result);
				tab_counceller.resize(); 
			}
		
		});
		
		paramCode.lcd = "1007";
		$.ajax({
			url : "/code/selecCodeList",
			type : "post",
			contentType : 'application/json; charset=utf-8',
			data : JSON.stringify(paramCode),
			success : function(result) {
				$('#select_councellerExtension').empty();
				$('#select_councellerExtension').append('<option value=' + '' + '></option>');
			    for ( var i = 0; i < result.length; i++) {
						$('#select_councellerExtension').append('<option value='+result[i].scd+'>' + result[i].scd + '</option>');
			    } 			
			}
		});
		paramCode.lcd = "1001";
		$.ajax({
			url : "/code/selecCodeList",
			type : "post",
			contentType : 'application/json; charset=utf-8',
			data : JSON.stringify(paramCode),
			success : function(result) {
				$('#select_councellerAuthCd').empty();
				$('#select_councellerAuthCd').append('<option value=' + '' + '></option>');
			    for ( var i = 0; i < result.length; i++) {
						$('#select_councellerAuthCd').append('<option value='+result[i].scd+'>' + result[i].scdNm + '</option>');
			    } 			
			}
		});
	});
	
});

$(document).ready(function(){
	$("#counceller_checkall").click(function(){
	      if($("#counceller_checkall").prop("checked")){
	          $("input[name=chk_counceller]").prop("checked",true);
	          $(".trCounceller").addClass("selected");
	      }else{
	          $("input[name=chk_counceller]").prop("checked",false);
	          $(".trCounceller.selected").removeClass("selected");
	      }
	});
});
function bt_initializationCounceller(){
	document.getElementById("txt_empNo").value = "";
	document.getElementById("txt_empNm").value = "";
	document.getElementById("txt_tel").value = "";
	document.getElementById("txt_email").value = "";
	document.getElementById("txt_note").value = "";
	document.getElementById("select_councellerExtension").value = "";
	document.getElementById("select_councellerAuthCd").value = "";
	document.getElementById("txt_empNo").disabled = false;
}
function councellerData(empNo, empNm, extensionNo, authCd, mobilePhoneNo, emailId, note){
	document.getElementById("txt_empNo").value = empNo;
	document.getElementById("txt_empNm").value = empNm;
	document.getElementById("select_councellerExtension").value = extensionNo;
	document.getElementById("select_councellerAuthCd").value = authCd;
	document.getElementById("txt_tel").value = mobilePhoneNo;
	document.getElementById("txt_email").value = emailId;
	document.getElementById("txt_note").value = note;
	document.getElementById("councellerUpdate").value = "1";
	document.getElementById("txt_empNo").disabled = true;
}
</script>
<script data-jui="#tab_counceller" data-tpl="row" type="text/template">
	<tr id="<!= row.index !>_counceller" class="trCounceller" onclick="councellerData('<!= empNo !>','<!= empNm !>','<!= extensionNo !>','<!= authCd !>','<!= mobilePhoneNo !>','<!= emailId !>','<!= note !>')">
		<td><input type="checkbox" name="chk_counceller" id="councellerChk" value="<!= empNo !>"/></td>
		<td name="empNo" align ="center"><!= empNo !></td>
		<td name="empNm" align ="center" id="councellerNm"><!= empNm !></td>
		<td name="extensionNo"><!= extensionNo !></td>
		<td name="mobilePhoneNo"><!= mobilePhoneNo !></td>
		<td name="emailId"><!= emailId !></td>
		<td name="note"><!= note !></td>
		<td name="authCd" style="display:none"><!= authCd !></td>
	</tr>
</script>
<script data-jui="#tab_counceller" data-tpl="none" type="text/template">
    <tr height ="390">
        <td colspan="7" class="none" align="center">데이터가 존재하지 않습니다.</td>
    </tr>
</script>
<style>
#counceller_top_tr td {
	padding-bottom: 5px;
}
</style>
<div class="head">
	<a href="#" class="close"><i class="icon-exit"></i></a>
	<table width="100%" border="0" align="center" cellpadding="0"
		cellspacing="0">
		<tr>
			<td class="poptitle"
				style="background-image: url(../resources/jui-master/img/theme/jennifer/pop.png);">
				상담원관리
			</td>
		</tr>
	</table>
</div>
<div class="body">
<form>
	<table width="100%" border="0" align="center" cellpadding="0" cellspacing="0" style="margin-bottom: 2px;">
		<tr id="counceller_top_tr">
			<td class="td01" width="30">사번<sup style="color:red; font-weight: bold;">*</sup></td>
			<td align="left" class="td02" width="70">
				<input type="text" class="input mini" id="txt_empNo" style="width: 90px" />
			</td>
			<td class="td01">상담원<sup style="color:red; font-weight: bold;">*</sup></td>
			<td align="left" class="td02">
				<input type="text" class="input mini" id="txt_empNm" style="width: 90px" />
			</td>
			<td class="td01">내선</td>			
			<td align="left" class="td02" width="80">
				<select id="select_councellerExtension" style="width:80px; height:22px;"> </select>
			</td>
			<td class="td01">권한유형<sup style="color:red; font-weight: bold;">*</sup></td>
			<td align="left">
				<select id="select_councellerAuthCd" style="height:22px;"></select>
			</td>
			<td class="td01" width="60">전화번호</td>
			<td align="left" class="td02">
				<input type="text" class="input mini" id="txt_tel" maxLength="14" style="width: 180px;float:left;" onfocus="OnCheckPhone(this)" onKeyup="OnCheckPhone(this)"/>
			</td>
		</tr>
	 	<tr id="counceller_top_tr">
			<td class="td01" width="40">E-Mail</td>
			<td align="left" class="td02" colspan="3">
				<input type="text" class="input mini" id="txt_email" style="width: 242px" />
			</td>
			<td class="td01">비고&nbsp;</td>
			<td align="left" class="td02" colspan="3">
				<input type="text" class="input mini" id="txt_note" style="width: 230px" /></td>
			<td align="right" colspan="2" style="padding-right:8px;">
				<a class="btn small focus" onclick="bt_initializationCounceller()">초기화</a> 
				<a class="btn small focus" id="bt_councellerInsert">저 장</a> 
				<input type="hidden" id="councellerEmpNo" />
				<input type="hidden" id="councellerUpdate" value="0" />
 				<a class="btn small focus" id="bt_councellerDelete">삭 제</a> 
				<a class="btn small focus" id="bt_pwInitialization"">비번초기화</a>
				<a class="btn small focus" id="bt_councellerSelect">조 회</a>
			</td>
		</tr> 
	</table>
	</form>
	<table class="table classic hover" id="tab_counceller" width="100%" style="padding-left:5px;">
		<thead>
			<tr>
				<th style="width:24px"><input type="checkbox" id="counceller_checkall"/></th>
				<th style="width:123px">사번</th>
				<th style="width:137px">상담원명</th>
				<th style="width:130px">내선</th>
				<th style="width:146px">전화번호</th>
				<th style="width:151px">eMail</th>
				<th style="width:auto">비고</th>
			</tr>
		</thead>
		<tbody>
		</tbody>
	</table>
</div>