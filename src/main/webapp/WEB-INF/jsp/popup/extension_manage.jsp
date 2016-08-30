<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<script>
var paramCode = {
		lcd : "",
};
var paramExtensionInsert = {
		scdNm : "",
		scd : ""
};
var paramExtension = {
		scd : ""
};

jui.ready([ "grid.xtable"], function(xtable) {

	tab_extension = xtable("#tab_extension", {
		resize : true,
		scrollHeight: 400,
		width : 945,
        scrollWidth: 930,
        buffer: "s-page",
        bufferCount: 2000,
        event: {
            click: function(row, e) {
            	var id = "#" + row.index + "_extension";
 	    		if($(id).hasClass("selected")) {
 	    			$(id).removeClass("selected");
 	    			$(id).find('input:checkbox[name="chk_extension"]').prop('checked', false);
 	    		}else{
					$(id).addClass("selected");
					$(id).find('input:checkbox[name="chk_extension"]').prop('checked', true);
 	    		}
				
				var cnt = $('input:checkbox[name="chk_extension"]:checked').length;
			    if(cnt >= 2 || cnt == 0){
			    	document.getElementById("txt_extensionNo").value = "";
					document.getElementById("txt_extensionContents").value = "";
					document.getElementById("txt_extensionNo").disabled = false;
			    }else if(cnt == 1){
			    	var scd = $('tr.selected').find('[name=scd]').html();
			    	var scdNm = $('tr.selected').find('[name=scdNm]').html();
			    	extensionData(scd,scdNm);
			    }
            }
        }
	});
	
	/*조회 버튼*/
	$("#bt_extensionSelect").click(function() {
		paramCode.lcd = "1007";
		
		$.ajax({
			url : "/code/selecCodeList",
			type : "post",
			contentType : 'application/json; charset=utf-8',
			data : JSON.stringify(paramCode),
			success : function(result) {
				page=1;
				tab_extension.update(result);
				tab_extension.resize(); 
				
				/* tab_extension.reset();
				tab_extension.append(result); */
			}
		});
	
	}); 
	
	/*최초 LOAD 시 조회 버튼*/
	$("#bt_extenstionPopup").click(function() {
		document.getElementById("txt_extensionNo").value = "";
		document.getElementById("txt_extensionContents").value = "";
		document.getElementById("txt_extensionNo").disabled = false;
		
		paramCode.lcd = "1007";
		
		$.ajax({
			url : "/code/selecCodeList",
			type : "post",
			contentType : 'application/json; charset=utf-8',
			data : JSON.stringify(paramCode),
			success : function(result) {
				page=1;
				tab_extension.update(result);
				tab_extension.resize(); 
				
				/* tab_extension.reset();
				tab_extension.append(result); */
			}
		});
	
	});
	
	/*저장 버튼*/
	$("#bt_extensionInsert").click(function() {
		paramExtensionInsert.scd = $("#txt_extensionNo").val();
		paramExtensionInsert.scdNm = $("#txt_extensionContents").val();
		
		if(paramExtensionInsert.scd == ''){
			//alert("내선번호를 입력해주세요. 내선번호는 4자리입니다.");
			msgboxActive('내선관리', '\"내선번호\"를 입력해주세요. 내선번호는 4자리입니다.');	
		}else if(document.getElementById("txt_extensionNo").value.length < 4){
			//alert("내선번호는 4자리 입니다. 다시 입력해주세요");
			msgboxActive('내선관리', '\"내선번호\"는 4자리 입니다. 다시 입력해주세요.');
		}else if($("#extensionUpdate").val() == '1'){
			if(regularCheck2()){
				$.ajax({
					url : "/code/updateExtension",
					type : "post",
					contentType : 'application/json; charset=utf-8',
					data : JSON.stringify(paramExtensionInsert),
					success : function(result) {
						if(result>=1){
							//alert("수정이 완료되었습니다");
							msgboxActive('내선관리', '\"수정\"이 완료되었습니다.');
							document.getElementById("txt_extensionNo").disabled = false;
							$("#txt_extensionNo").val("");
							$("#txt_extensionContents").val("");
							$("#bt_extensionSelect").click();
							document.getElementById("extensionUpdate").value = "0";
						}else{
							//alert("수정이 완료되지 않았습니다.");
							msgboxActive('내선관리', '\"수정\"이 완료되지 않았습니다. 다시 시도해주세요.');
						}
					}
				});
			}
		}else{
			if(regularCheck2()){
				$.ajax({
					url : "/code/insertExtensionCode",
					type : "post",
					contentType : 'application/json; charset=utf-8',
					data : JSON.stringify(paramExtensionInsert),
					success : function(result) {
						if(result>=1){
							//alert("저장이 완료되었습니다");
							msgboxActive('내선관리', '\"저장\"이 완료되었습니다.');
							$("#txt_extensionNo").val("");
							$("#txt_extensionContents").val("");
							$("#bt_extensionSelect").click();
							document.getElementById("extensionUpdate").value = "0";
						}else{
							//alert("내선번호가 존재합니다.");
							msgboxActive('내선관리', '\"내선번호\"가 존재합니다.');
						}	
					}
				});
			}
		}
		
	
	});
	
	/*삭제 버튼*/
	$("#bt_extensionDelete").click(function() {
		var cnt = $('input:checkbox[name="chk_extension"]:checked').length;
	    if(cnt == 0){
	         //alert('삭제할 내선을 선택해주세요.');
	         msgboxActive('내선관리', '\"삭제할 내선\"을 선택해주세요.');
	    }else{
			var chkLength = 0;
			var temp = "";
			chkLength = tab_extension.size();
			for(var i = 0; i< chkLength; i++){
				 if($("#"+i+"_extension input[name=chk_extension]:checked").is(":checked")){
					if(temp == ""){
						temp = $("#"+i+"_extension input[name=chk_extension]").val();
					}else{
						temp += ","+$("#"+i+"_extension input[name=chk_extension]").val();
					}
				}  
			}
			
			paramExtension.scd = temp;
			
			$.ajax({
				url : "/code/deleteExtensionCode",
				type : "post",
				contentType : 'application/json; charset=utf-8',
				data : JSON.stringify(paramExtension),
				success : function(result) {
					if(result>=1){
						//alert("삭제가 완료되었습니다");
						msgboxActive('내선관리', '\"삭제\"가 완료되었습니다.');
						$("#bt_extensionSelect").click();
					}else{
						//alert("삭제가 되지 않았습니다.");
						msgboxActive('내선관리', '\"삭제\"가 되지 않았습니다. 다시 시도해주세요.');
					}
				}
			});
	    }	
	});
	
});

$(document).ready(function(){
    $("#extension_checkall").click(function(){
        if($("#extension_checkall").prop("checked")){
            $("input[name=chk_extension]").prop("checked",true);
            $(".trExtension").addClass("selected");
        }else{
            $("input[name=chk_extension]").prop("checked",false);
            $(".trExtension.selected").removeClass("selected");
        }
    });
})
function bt_initialization(){
	document.getElementById("txt_extensionNo").value = "";
	document.getElementById("txt_extensionContents").value = "";
	document.getElementById("txt_extensionNo").disabled = false;
	document.getElementById("extensionUpdate").value = "0";
}
function extensionData(scd, scdNm){
	document.getElementById("txt_extensionNo").value = scd;
	document.getElementById("txt_extensionContents").value = scdNm;
	document.getElementById("extensionUpdate").value = "1";
	document.getElementById("txt_extensionNo").disabled = true;
}
function regularCheck2(){
	if(!regularExpCheck($("#txt_extensionNo").val(),"num")){
		//alert("숫자 형식이 아닙니다.");
		msgboxActive('내선관리', '\"숫자 형식\"이 아닙니다.');
		return false;
	}else{
		return true;
	}
} 
</script>
<script data-jui="#tab_extension" data-tpl="row" type="text/template">
	<tr id="<!= row.index !>_extension" class="trExtension" onclick = "javascript:extensionData('<!= scd !>','<!= scdNm !>')";>
		<td><input type="checkbox" name="chk_extension" value="<!= scd !>"/></td>
		<td name="scd" align ="center"><!= scd !></td>
		<td name="scdNm"><!= scdNm !></td>
	</tr>
</script>
<script data-jui="#tab_extension" data-tpl="none" type="text/template">
    <tr height ="390">
        <td colspan="3" class="none" align="center">데이터가 존재하지 않습니다.</td>
    </tr>
</script>
<style>
#extension_top_tr td {
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
				내선관리
			</td>
		</tr>
	</table>
</div>
<div class="body">
	<table width="100%" border="0" align="center" cellpadding="0" cellspacing="0" style="margin-bottom: 2px;">
		<tr id="extension_top_tr">
			<td width="60" class="td01">내선번호<sup style="color:red; font-weight: bold;">*</sup></td>
			<td align="left" class="td02">
				<input type="text" class="input mini" id="txt_extensionNo"  maxLength="4" style="width: 80px" />
			</td>
			<td width="50" class="td01">내용</td>
			<td colspan="2" align="left" class="td02" width="230">
				<input type="text" class="input mini" id="txt_extensionContents" style="width: 350px" />
			</td>
			<td width="260" align="right" class="td01" style="padding-right:9px;">
				<a class="btn small focus" onclick="bt_initialization()">초기화</a> 
				<a class="btn small focus" id="bt_extensionInsert">저 장</a> 
				<a class="btn small focus" id="bt_extensionDelete">삭 제</a>
				<a class="btn small focus" id="bt_extensionSelect">조 회</a>
				<input type="hidden" id="extensionUpdate" value="0" />
			</td>
		</tr>
	</table>
	<table class="table classic hover" id="tab_extension" width="100%" style="padding-left:5px;">
		<thead>
			<tr>
				<th style="width:20px"><input type="checkbox" id="extension_checkall"/></th>
				<th style="width:200px">내선번호</th>
				<th style="width:auto">내용</th>
			</tr>
		</thead>
		<tbody>
		</tbody>
	</table>
</div>