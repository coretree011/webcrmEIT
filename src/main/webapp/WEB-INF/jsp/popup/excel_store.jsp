<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<script>
var param2 = {
/* 		custNo : "", */
		custCd : "",
		custNm : "",
		tel1No : "",
		tel2No : "",
		tel3No : "",
		emailId : "",
		faxNo : "",
		addr : "",
		custNote : ""
		
};
var paramdata = {
		custCd : "",
		custNo : "",
		custNm : "",
		tel1No : "",
		tel2No : "",
		tel3No : ""
};
var param1 = {};
var arr = new Array();
var obj = new Object();

/* 엑셀 저장할 때  */
var arr2 = new Array();
var obj2 = new Object();

/* DB로 고개정보 저장할 때 */
var arr3 = new Array();
var obj3 = new Object();

jui.ready([ "grid.xtable"], function(xtable) { 
 	var data;
	var data_size;
	var page = 1;
	var result_data;
	
	var tableTr = "";
	var dataChk = '';
	tab_excelList = xtable("#tab_excelList", {
		//fields: [ "", "번호" ,"저장여부","저장확인","유형","고객번호","고객명","핸드폰","직장","자택","eMail","FAX","주소","비고"],
		resize : true,
		scrollHeight: 480,
		width : 2200,
		//1700
        scrollWidth: 1325,
        buffer: "s-page",
        bufferCount: 2000,
        event: {
 	    	click: function(row, e) {
 	    		var id = "#" + row.index + "_excel";
 	    		if($(id).hasClass("selected")) {
 	    			$(id).removeClass("selected");
 	    			$(id).find('input:checkbox[name="excel_chk"]').prop('checked', false);
 	    		}else{
					var bcheckbox = $(id).find("input:checkbox[name='excel_chk']").is(":disabled");
					if(bcheckbox == true){
					}else{
						$(id).addClass("selected");
						$(id).find('input:checkbox[name="excel_chk"]').prop('checked', true);
					}
 	    		}
 	    	}
	 }
	});
	
    /* 체크박스 전체선택/전체해제 */
    $("#excel_checkall").click(function(){
        if($("#excel_checkall").prop("checked")){
            $("input[name=excel_chk]").not(":disabled").prop("checked",true);
          
            $("input:checkbox[name='excel_chk']:checked").each(function(idx, row) {
				var record = $(row).parents("tr");
				$(record[0]).addClass("selected");
				//alert(record[0].innerText);
			});
        }else{
            $("input[name=excel_chk]").prop("checked",false);
            $(".trExcel.selected").removeClass("selected");
        }
        
    }); 
    
	/*
	 * 엑셀로 고객정보 저장
	 * excel_store.jsp
	 * Button Name : 엑셀선택
	 */	
	 $("#bt_selectExcel").click(function() {
		$("#bt_file").click();
	 });

	$("#bt_file").change(function() {
		var thumbext = $("#bt_file").val(); //파일을 추가한 input 박스의 값
		thumbext = thumbext.slice(thumbext.indexOf(".") + 1).toLowerCase(); //파일 확장자를 잘라내고, 비교를 위해 소문자로 만듭니다.
		if(thumbext == "xlsx"){ //확장자를 확인합니다.
			$.ajax({
		        url:"/popup/read_xlsx",
		        type: "POST",
		        data: new FormData($("#upload_file_frm")[0]),
		        enctype: 'multipart/form-data',
		        processData: false,
		        contentType: false,
		        cache: false,
		        success: function () {
		            //alert("File Upload Success");
		        },
		        error: function () {
		           // alert("File Upload Error");
		        }
		    });
			
			setTimeout(function (){
				$.ajax({
					url : "/popup/read_xlsx2",
					type : "post",
					contentType : 'application/json; charset=utf-8',
					data : JSON.stringify(param1),
					beforeSend : function(){
						document.getElementById('loadingData').innerHTML = "요청하신 데이터를 불러오는 중입니다.";
						document.getElementById("wrap-loading").classList.remove("display-none");
					},
					complete:function(){
						document.getElementById("wrap-loading").classList.add("display-none");
				    },
					success : function(result) {
						if(result != ""){
							page=1;
							tab_excelList.update(result);
							tab_excelList.resize(); 
							tableTr = tab_excelList.size();
							$("#bt_insertExcel").attr('disabled',true);
							$('#bt_insertExcel').click(function(){return false;});
							$("#bt_file").val('');
					 	}else{
							tab_excelList.resize(); 
						} 
					}
				}); 
			},2000);
		}else if(thumbext == null || thumbext == ''){
		}else{
			//alert('엑셀파일(.xlsx)만 등록 가능합니다.');
			msgboxActive('엑셀로 고객정보 저장', '\"엑셀파일(.xlsx)\"만 등록 가능합니다.');
		}
		
	});
	
	
	paging_excel = function(no) {
        page += no;
        page = (page < 1) ? 1 : page;
        tab_excelList.page(page);
	}

    /* 데이터검증 */ 
	$("#bt_excelData").click(function() {
		document.getElementById('loadingData').innerHTML = "데이터를 검증 중입니다.";
		document.getElementById("wrap-loading").classList.remove("display-none");
		$('[name=insertOX]').html('');
		
		var trExcel = $('.trExcel');
		for(var i = 0; i < trExcel.length; i++){
			obj = new Object();
			obj.custCd = document.querySelectorAll(".cust_cdNm")[i].innerHTML;
			//obj.custNo = document.querySelectorAll(".cust_no")[i].innerHTML;
			obj.coRegNo = document.querySelectorAll(".co_reg_no")[i].innerHTML;
			obj.custNm = document.querySelectorAll(".cust_nm")[i].innerHTML;
			obj.tel1No = document.querySelectorAll(".tel1_no")[i].innerHTML;
			obj.tel2No = document.querySelectorAll(".tel2_no")[i].innerHTML;
			obj.tel3No = document.querySelectorAll(".tel3_no")[i].innerHTML;
			//alert(paramdata.custCd + "," + paramdata.custNo + "," + paramdata.custNm + "," + paramdata.tel1No);

			//var t = document.querySelectorAll(".cust_no")[i].innerHTML;
			if(obj.custCd == "개인"){
				obj.custCd = '1001';
				//t = "";
			}else if(obj.custCd == "사업자"){
				obj.custCd = '1002';
			}
			arr.push(obj);
		}
	
		$.ajax({
			url : "/popup/excelData",
			type : "post",
			contentType : 'application/json; charset=utf-8',
			data : JSON.stringify(arr),
			success : function(result) {
				for(var i=0; i<result.length; i++){
					dataChk = result[i];
					//document.querySelectorAll(".excelData")[i].innerHTML = dataChk;
					if(dataChk == '1000'){
						document.querySelectorAll(".insertChk")[i].innerHTML = "가능";
						document.querySelectorAll(".insertChk")[i].style.color = "black";
						document.querySelectorAll(".insertChk")[i].style.fontWeight = "normal";
						//document.querySelectorAll(".cust_no")[i].innerHTML = "";
					}else if(dataChk == '1100'){
						document.querySelectorAll(".insertChk")[i].innerHTML = "선택필요(중복)";
						document.querySelectorAll(".insertChk")[i].style.color = "blue";
						document.querySelectorAll(".insertChk")[i].style.fontWeight = "bold";
						//document.querySelectorAll(".cust_no")[i].innerHTML = "";
					}else if(dataChk == '2000'){
						document.querySelectorAll(".insertChk")[i].innerHTML = "가능";
						document.querySelectorAll(".insertChk")[i].style.color = "black";
						document.querySelectorAll(".insertChk")[i].style.fontWeight = "normal";
					}else if(dataChk == '2100'){
						document.querySelectorAll(".insertChk")[i].innerHTML = "불가(중복)";
						document.querySelectorAll(".insertChk")[i].style.color = "red";
						document.querySelectorAll(".insertChk")[i].style.fontWeight = "bold";
						document.querySelectorAll(".excel_chk")[i].disabled = true;
					}else if(dataChk == '1001'){
						document.querySelectorAll(".insertChk")[i].innerHTML = "가능";
						document.querySelectorAll(".insertChk")[i].style.color = "black";
						document.querySelectorAll(".insertChk")[i].style.fontWeight = "normal";
						document.querySelectorAll(".cust_no")[i].innerHTML = "";
					}else if(dataChk == '1101'){
						document.querySelectorAll(".insertChk")[i].innerHTML = "선택필요(중복)";
						document.querySelectorAll(".insertChk")[i].style.color = "blue";
						document.querySelectorAll(".insertChk")[i].style.fontWeight = "bold";
						document.querySelectorAll(".cust_no")[i].innerHTML = "";
					}else if(dataChk == '4000'){
						document.querySelectorAll(".insertChk")[i].innerHTML = "불가(사업자번호)";
						document.querySelectorAll(".excel_chk")[i].disabled = true;
						document.querySelectorAll(".insertChk")[i].style.color = "red";
						document.querySelectorAll(".insertChk")[i].style.fontWeight = "bold";
					}else if(dataChk == '4100'){
						document.querySelectorAll(".insertChk")[i].innerHTML = "불가(사업자번호오류)";
						document.querySelectorAll(".excel_chk")[i].disabled = true;
						document.querySelectorAll(".insertChk")[i].style.color = "red";
						document.querySelectorAll(".insertChk")[i].style.fontWeight = "bold";
					}
				}
				$("#bt_insertExcel").attr('disabled',false);
				arr = [];
				document.getElementById("wrap-loading").classList.add("display-none");
			}
		});	
	});
	
	/*
	 * 엑셀로 고객정보 저장
	 * excel_store.jsp
	 * Button Name : 저장
	 */	

	$("#bt_insertExcel").click(function() {
		var cnt = $('input:checkbox[name="excel_chk"]:checked').length;
	    if(cnt == 0){
	    	msgboxActive('엑셀로 고객정보 저장', '\"저장\"할 데이터를 선택해주세요.');
	        //alert('저장할 데이터를 선택해주세요.');
	    }else{
	    /* 	document.getElementById('loadingData').innerHTML = "선택한 고객정보를 저장 중입니다.";
			document.getElementById("wrap-loading").classList.remove("display-none"); */
		 	var chkLength = 0;
			var chktemp = "";
			chkLength = tab_excelList.size();
			for(var i = 0; i< chkLength; i++){
				 if($("#"+i+"_excel input[name=excel_chk]:checked").is(":checked")){
					if(chktemp == ""){
						chktemp = $("#"+i+"_excel input[name=excel_chk]").val();
					}else{
						chktemp += ","+$("#"+i+"_excel input[name=excel_chk]").val();
					}
				}  
			} 
			var chkNumber = chktemp;
			var chkindex = new Array();
			chkindex = chkNumber.split(',');
			
			$('.trExcel').each(function(index){
				var num = index+1;	
				for(var i=0; i < tableTr; i++){
					if(chkindex[i] == num){
						obj3 = new Object();
						obj3.custCd = document.querySelectorAll(".cust_cdNm")[index].innerHTML;
						//obj3.custNo = document.querySelectorAll(".cust_no")[index].innerHTML; 
						obj3.custNm = document.querySelectorAll(".cust_nm")[index].innerHTML;
						obj3.coRegNo = document.querySelectorAll(".co_reg_no")[index].innerHTML;
						obj3.tel1No = document.querySelectorAll(".tel1_no")[index].innerHTML;
						obj3.tel2No = document.querySelectorAll(".tel2_no")[index].innerHTML;
						obj3.tel3No = document.querySelectorAll(".tel3_no")[index].innerHTML;
						obj3.emailId = document.querySelectorAll(".emailid")[index].innerHTML;
						obj3.faxNo = document.querySelectorAll(".fax_no")[index].innerHTML;
						obj3.addr = document.querySelectorAll(".addr")[index].innerHTML;
						obj3.sexCd = document.querySelectorAll(".sex_Cd")[index].innerHTML;
						obj3.birthDate = document.querySelectorAll(".birth_Date")[index].innerHTML;
						obj3.gradeCd = document.querySelectorAll(".grade_Cd")[index].innerHTML;
						obj3.custTypCd = document.querySelectorAll(".cust_Typ_Cd")[index].innerHTML;
						obj3.recogTypCd = document.querySelectorAll(".recog_Typ_Cd")[index].innerHTML;
						obj3.custNote = document.querySelectorAll(".cust_note")[index].innerHTML;
						
						if(obj3.custCd == "개인"){
							obj3.custCd = '1001';
						}else if(obj3.custCd == "사업자"){
							obj3.custCd = '1002';
						}
						arr3.push(obj3);
					}
				}
			});
			
			$.ajax({
				url : "/popup/insertCustomer",
				type : "post",
				contentType : 'application/json; charset=utf-8',
				data : JSON.stringify(arr3),
				beforeSend : function(){
					document.getElementById('loadingData').innerHTML = "선택한 고객정보를 저장 중입니다.";
					document.getElementById("wrap-loading").classList.remove("display-none");
				},
				complete:function(){
					document.getElementById("wrap-loading").classList.add("display-none");
			    },
				success : function(result) {
					$('.trExcel').each(function(index){
						var num = index+1;	
						for(var i=0; i < tableTr; i++){
							if(chkindex[i] == num){
								if(result[i].length > 0) {
									$('[name=custNo]').eq(num).html(result[i]);
									$('[name=insertOX]').eq(index).html('O');
								}else if(result[i] == "0"){
									$('[name=insertOX]').eq(index).html('X');
								}
							}
						}
					});
					arr3 = [];
					msgboxActive('엑셀로 고객정보 저장', '\"저장\"이 완료되었습니다.');
					$(".trExcel.selected").removeClass("selected");
					//alert("저장이 완료되었습니다.");
					
					$("#excel_checkall").prop("checked",false);
					$("input[name=excel_chk]").prop("checked",false);
					$("#bt_insertExcel").attr('disabled',true);
				},
				error: function () {
					$('.trExcel').each(function(index){
						var num = index+1;	
						for(var i=0; i < tableTr; i++){
							if(chkindex[i] == num){
								$('[name=insertOX]').eq(index).html('X');
							}
						}
					});
					msgboxActive('엑셀로 고객정보 저장', '\"저장\"이 완료되지 않았습니다.');
					//alert("실패하였습니다.");	
				}
			});
	    }
	});
});
    
$(document).ready(function(){
    $("#bt_excelPopup").click(function(){
    	tab_excelList.update();
    });
    
    $("#bt_excelExport").click(function() {
    	var trExcel = $('.trExcel');
		for(var i = 0; i < trExcel.length; i++){
			obj2 = new Object();
			obj2.custCdNm = document.querySelectorAll(".cust_cdNm")[i].innerHTML;
			obj2.insertChk = document.querySelectorAll(".insertChk")[i].innerHTML;
			//obj2.custNo = document.querySelectorAll(".cust_no")[i].innerHTML;
			obj2.custNm = document.querySelectorAll(".cust_nm")[i].innerHTML;
			obj2.coRegNo = document.querySelectorAll(".co_reg_no")[i].innerHTML;
			obj2.tel1No = document.querySelectorAll(".tel1_no")[i].innerHTML;
			obj2.tel2No = document.querySelectorAll(".tel2_no")[i].innerHTML;
			obj2.tel3No = document.querySelectorAll(".tel3_no")[i].innerHTML;
			obj2.emailId = document.querySelectorAll(".emailid")[i].innerHTML;
			obj2.faxNo = document.querySelectorAll(".fax_no")[i].innerHTML;
			obj2.addr = document.querySelectorAll(".addr")[i].innerHTML;
			
			obj2.sexCd = document.querySelectorAll(".sex_Cd")[i].innerHTML;
			obj2.birthDate = document.querySelectorAll(".birth_Date")[i].innerHTML;
			obj2.gradeCd = document.querySelectorAll(".grade_Cd")[i].innerHTML;
			obj2.custTypCd = document.querySelectorAll(".cust_Typ_Cd")[i].innerHTML;
			obj2.recogTypCd = document.querySelectorAll(".recog_Typ_Cd")[i].innerHTML;
			
			obj2.custNote = document.querySelectorAll(".cust_note")[i].innerHTML;
			
			arr2.push(obj2);
		}
		var jsonEncode = JSON.stringify(arr2);
		var empNm = $("input[name=empNm]").val();

		$("#ifraPopup").attr("src","/popup/excelListExport?jsonEncode=" + jsonEncode + "&empNm=" + empNm);
	});
    
});
/* 취소버튼 click Event */
function cancel(){
	$("#tbodyid").empty();
	$("#list").empty();
}
/* replaceAll 메소드 */
String.prototype.replaceAll = function(org, dest) {
    return this.split(org).join(dest);
}

</script>
<script data-jui="#tab_excelList" data-tpl="row" type="text/template">
	<tr id="<!= row.index !>_excel" class="trExcel">
		<td><input type="checkbox" name="excel_chk" class="excel_chk" value="<!= parseInt(row.index)+1 !>"/></td>
		<td name="excelNumber"><!= parseInt(row.index)+1 !></td>
		<td class="excelData" style="display:none;"></td>
		<td class="insertChk"></td>
		<td class="insertOX" name="insertOX" id="insertOX"></td>
		<td id="cust_cdNm" class="cust_cdNm" align ="center"><!= custCdNm !></td>
		<td id="cust_no" class="cust_no" align ="center" name="custNo"></td>
		<td id="cust_nm" class="cust_nm"><!= custNm !></td>
		<td class="co_reg_no"><!= coRegNo !></td>
		<td id="tel1_no" class="tel1_no"><!= tel1No !></td>
		<td id="tel2_no" class="tel2_no"><!= tel2No !></td>
		<td id="tel3_no" class="tel3_no"><!= tel3No !></td>
		<td id="emailid" class="emailid"><!= emailId !></td>
		<td id="fax_no" class="fax_no"><!= faxNo !></td>
		<td id="addr" class="addr"><!= addr !></td>
		<td class="sex_Cd"><!= sexCd !></td>
		<td class="birth_Date"><!= birthDate !></td>
		<td class="grade_Cd"><!= gradeCd !></td>
		<td class="cust_Typ_Cd"><!= custTypCd !></td>
		<td class="recog_Typ_Cd" ><!= recogTypCd !></td>
		<td id="cust_note" class="cust_note"><!= custNote !></td>
	</tr>
</script>
<script data-jui="#tab_excelList" data-tpl="none" type="text/template" >
    <tr height ="480">
        <td colspan="20" class="none" align="center">데이터가 존재하지 않습니다.</td>
    </tr>
</script>
<style>
.wrap-loading{ /*화면 전체를 어둡게 합니다.*/
    position: fixed;
    left:0;
    right:0;
    top:0;
    bottom:0; 
    background: rgba(0,0,0,0.2);  /*not in ie */
}
.wrap-loading div{ /*로딩 이미지*/
    position: fixed;
    top:50%;
    left:40%;
    margin-left: -21px;
    margin-top: -21px; 
}
.display-none{ /*감추기*/
    display:none;
}
</style>
<div class="head">
	<a href="#" class="close"><i class="icon-exit"></i></a>
	<table width="100%" border="0" align="center" cellpadding="0" cellspacing="0">
		<tr>
			<td class="poptitle"
				style="background-image: url(../resources/jui-master/img/theme/jennifer/pop.png);">
				고객정보를 엑셀로 여러 건 입력하기
			</td>
		</tr>
	</table>
</div>
<div class="body">
	 <form id="upload_file_frm" enctype="multipart/form-data">
		<table width="100%" border="0" cellpadding="0" cellspacing="0" style="margin-bottom: 2px;">
			<tr>
				<td width="100%" align="right" class="td01" style="padding-bottom: 5px;">
				<input type="file" id="bt_file" name="uploadFile" style="display:none;"/>
				<a class="btn small focus" id="bt_selectExcel">엑셀선택</a>
				<a class="btn small focus" id="bt_excelData">데이터검증</a>
				<a class="btn small focus" id="bt_insertExcel">저장</a>
				<a class="btn small focus" onclick="cancel()">취소</a>
				<a class="btn small focus" id="bt_excelExport">엑셀저장</a>
				</td>
			</tr>
		</table>
	</form>
	<table class="table classic hover" id="tab_excelList">
		<thead>
			<tr>
				<th style="width:25px;"><input type="checkbox" id="excel_checkall"/></th>
				<th style="width:36px;">번호</th>
				<!-- <th style="width:54px;">검증</th>  -->
				<th style="width:108px;">저장여부</th>
				<th style="width:82px;">저장확인</th>
				<th style="width:68px;">유형</th>
				<th style="width:90px;">고객번호</th>
				<th style="width:70px;">고객명</th>
				<th style="width:90px;">사업자번호</th>
				<th style="width:100px;">핸드폰</th>
				<th style="width:100px;">직장</th>
				<th style="width:100px;">자택</th>
				<th style="width:141px;">eMail</th>
				<th style="width:110px;">FAX</th>
				<th style="width:272px;">주소</th>
				<th style="width:40px;">성별</th>
				<th style="width:80px;">생년월일</th>
				<th style="width:80px;">고객등급</th>
				<th style="width:80px;">고객유형</th>
				<th style="width:80px;">인지경로</th>
				<th style="width:auto;">비고</th> 
			</tr>
		</thead>
		<tbody id="tbodyid">
		</tbody>
	</table>
	<iframe id="ifraPopup" name="ifraPopup" style="display:none;"></iframe>
<!--  	<div class="row" align="right" style="text-align: right; margin-top: 3px;">
	    <div class="group">
	        <button onclick="paging_excel(-1);" class="btn mini">Prev</button>
	        <button onclick="paging_excel(1);" class="btn mini">Next</button>
	    </div>
	</div> -->
</div>
<div class="wrap-loading display-none" id="wrap-loading">
 	<div style="background:white; border:1px solid #bd5949; border-radius: 15px; height:100px; width: 350px;">
 		<!-- <span class='icon icon-loading' style="font-size: 80px; color: #bd5949;"></span> -->
 		<img src="../resources/jui-master/img/icon/spin.gif" width="100" height="80" style="float:left; margin:10px;"/>
 		<p style="margin-top:20px;" >
 		<font style="color: #bd5949; font-weight: bold;">고객정보를 엑셀에서 여러 건 입력하기<br></font>
 		<p id="loadingData" style="margin-bottom:5px;">요청하신 데이터를 불러오는 중입니다.</p>
 		<b>잠시만 기다려주세요.</b>
 	</div>
</div>
