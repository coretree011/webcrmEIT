<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<script>
var param = {
};
var paramSms = {
		cateCd : "",
		cateNm : "",
		cateComment : ""
};
var paramSmsDelete = {
		cateCd : ""	
};

jui.ready(["grid.xtable"], function(xtable) {

	var data;
	var data_size;
	var page = 1;
	var result_data;
	
	/*
	 * SMS 전송유형
	 * sms_transport.jsp
	 * Button Name : 조회
	 */	
	tab_smsTransport = xtable("#tab_smsTransport", {
		resize : true,
		scrollHeight: 400,
		width : 945,
        scrollWidth: 930,
        buffer: "s-page",
        bufferCount: 2000,
        event: {
 	    	click: function(row, e) {
 	    		var id = "#" + row.index + "_sms";
 	    		if($(id).hasClass("selected")) {
 	    			$(id).removeClass("selected");
 	    			$(id).find('input:checkbox[name="sms_chk"]').prop('checked', false);
 	    			document.getElementById("byte_chk").innerHTML = '0'; //byte check
 	    		}else{
					$(id).addClass("selected");
					$(id).find('input:checkbox[name="sms_chk"]').prop('checked', true);
 	    		}
				
				var cnt = $('input:checkbox[name="sms_chk"]:checked').length;
			    if(cnt >= 2 || cnt == 0){
			    	document.getElementById("cate_Nm").value = "";
			    	document.getElementById("cate_Comment").value = "";
			    	document.getElementById("cate_Cd").value = "";
			    	document.getElementById("cate_Cd").disabled = false;
			    	document.getElementById("byte_chk").innerHTML = '0'; //byte check
			    }else if(cnt == 1){
			    	var cateCd = $('tr.selected').find('[name=cateCd]').html();
			    	var cateNm = $('tr.selected').find('[name=cateNm]').html();
			    	var cateComment = $('tr.selected').find('[name=cateComment]').html();
			    	smsData(cateCd,cateNm,cateComment);
			    }
 	    	}
	    } 
	});
	
	$("#bt_smsSelect").click(function() {
		$.ajax({
			url : "/popup/smsList",
			type : "post",
			contentType : 'application/json; charset=utf-8',
			data : JSON.stringify(param),
			success : function(result) {
				page=1;
				tab_smsTransport.update(result);
				tab_smsTransport.resize(); 
			}
		});
	
	});  
	
	/*SMS 전송유형 최초 load 시 조회*/
	$("#bt_smsPopup").click(function() {
		document.getElementById("cate_Cd").disabled = false;
		document.getElementById("cate_Cd").value= "";
		document.getElementById("cate_Nm").value = "";
		document.getElementById("cate_Comment").value = "";
		
		$.ajax({
			url : "/popup/smsList",
			type : "post",
			contentType : 'application/json; charset=utf-8',
			data : JSON.stringify(param),
			success : function(result) {
				page=1;
				tab_smsTransport.update(result);
				tab_smsTransport.resize(); 
			}
		});
	
	}); 
	
	
	/*삭제 기능*/
	$("#bt_smsDelete").click(function() {
		var cnt = $('input:checkbox[name="sms_chk"]:checked').length;
	    if(cnt == 0){
	         //alert('삭제할 유형을 선택해주세요.');
			msgboxActive('SMS 전송유형', '\"삭제\"할 유형을 선택해주세요.');	         
	    }else{
			var chkLength = 0;
			var temp = "";
			chkLength = tab_smsTransport.size();
			for(var i = 0; i< chkLength; i++){
				 if($("#"+i+"_sms input[name=sms_chk]:checked").is(":checked")){
					if(temp == ""){
						temp = $("#"+i+"_sms input[name=sms_chk]").val();
					}else{
						temp += ","+$("#"+i+"_sms input[name=sms_chk]").val();
					}
				}  
			}
			paramSmsDelete.cateCd = temp;
			
			$.ajax({
				url : "/popup/smsDelete",
				type : "post",
				contentType : 'application/json; charset=utf-8',
				data : JSON.stringify(paramSmsDelete),
				success : function(result) {
					if(result>=1){
						//alert("삭제가 완료되었습니다");
						msgboxActive('SMS 전송유형', '\"삭제\"가 완료되었습니다.');	
						$("#smsInitialization").click();
						$("#bt_smsSelect").click();
					}else {
						//alert("삭제가 완료되지 않았습니다. 다시 시도해주세요.");
						msgboxActive('SMS 전송유형', '\"삭제\"가 완료되지 않았습니다. 다시 시도해주세요.');	
					}
				}
			});
	    }
	});
	
	/*
	 * SMS 전송유형
	 * sms_transport.jsp
	 * Button Name : 저장
	 */	
	
	
	$("#bt_smsInsert").click(function() {
		paramSms.cateCd = $("#cate_Cd").val();
		paramSms.cateNm = $("#cate_Nm").val();
		paramSms.cateComment = $("#cate_Comment").val();
	
		if(paramSms.cateCd == ''){
			//alert("유형코드를 입력해주세요.");
			msgboxActive('SMS 전송유형', '\"유형코드\"를 입력해주세요.');	
		}else if(paramSms.cateNm == ''){
			//alert("유형명을 입력해주세요.");
			msgboxActive('SMS 전송유형', '\"유형명\"을 입력해주세요.');	
		}else if($("#tempUpdate").val() == '1'){
			$.ajax({
				url : "/popup/updateSms",
				type : "post",
				contentType : 'application/json; charset=utf-8',
				data : JSON.stringify(paramSms),
				success : function(result) {
					if(result>=1){
						//alert("수정이 완료되었습니다.");
						msgboxActive('SMS 전송유형', '\"수정\"이 완료되었습니다.');	
						document.getElementById("cate_Cd").disabled = false;
						$("#cate_Cd").val("");
						$("#cate_Nm").val("");
						$("#cate_Comment").val("");
						$("#bt_smsSelect").click();
					}else{
						//alert("수정이 완료되지 않았습니다.");
						msgboxActive('SMS 전송유형', '\"수정\"이 완료되지 않았습니다. 다시 시도해주세요.');	
					}
				}
			});
			$("#tempUpdate").val('0');
		}else{
			$.ajax({
				url : "/popup/saveSms",
				type : "post",
				contentType : 'application/json; charset=utf-8',
				data : JSON.stringify(paramSms),
				success : function(result) {
					if(result>=1){
						//alert("저장이 완료되었습니다");
						msgboxActive('SMS 전송유형', '\"저장\"이 완료되었습니다.');	
						$("#cate_Cd").val("");
						$("#cate_Nm").val("");
						$("#cate_Comment").val("");
						$("#bt_smsSelect").click();
					}else{
						//alert("이미 존재하고 있는 유형코드입니다.");
						msgboxActive('SMS 전송유형', '이미 존재하고 있는 \"유형코드\"입니다.');	
					}
				}
			});
		}
	});
});
$(document).ready(function(){
    $("#sms_checkall").click(function(){
        if($("#sms_checkall").prop("checked")){
            $("input[name=sms_chk]").prop("checked",true);
            $(".trSms").addClass("selected");
        }else{
            $("input[name=sms_chk]").prop("checked",false);
            $(".trSms.selected").removeClass("selected");
        }
    }); 
    
    /* 초기화 버튼 */
    $("#smsInitialization").click(function(){
    	document.getElementById("cate_Nm").value = "";
    	document.getElementById("cate_Comment").value = "";
    	document.getElementById("cate_Cd").disabled = false;
    	document.getElementById("byte_chk").innerHTML = '0'; //byte check
		$.ajax({
			url : "/popup/smsInitialization",
			type : "post",
			contentType : 'application/json; charset=utf-8',
			data : JSON.stringify(param),
			success : function(result) {
				document.getElementById("cate_Cd").value = parseInt(result.cateCd)+1;
			}
		});
    });
    
})

function smsData(cateCd, cateNm, cateComment){
	document.getElementById("cate_Cd").value= cateCd;
	document.getElementById("cate_Nm").value = cateNm;
	document.getElementById("cate_Comment").value = cateComment;
	document.getElementById("tempUpdate").value = '1'; 
	document.getElementById("cate_Cd").disabled = true;
	
	byteCheck();
}

/**
 * 문자열의 바이트수 리턴
 * @returns {Number}
 */
String.prototype.byteLength = function() {
    var l= 0;
     
    for(var idx=0; idx < this.length; idx++) {
        var c = escape(this.charAt(idx));
         
        if( c.length==1 ) l ++;
        else if( c.indexOf("%u")!=-1 ) l += 2;
        else if( c.indexOf("%")!=-1 ) l += c.length/3;
    }
     
    return l;
}; 

function byteCheck(){
	var text = document.getElementById("cate_Comment").value;
	document.getElementById("byte_chk").innerHTML = text.byteLength();
	
	if(text.byteLength() > 90){
		document.getElementById("byte_chk_warn").innerHTML = 'SMS 전송내용이 90byte가 넘었습니다.';
		document.getElementById("byte_chk_warn").style.color = "red";
		document.getElementById("byte_chk").style.fontWeight = "800";
	}else if(text.byteLength() <= 90){
		document.getElementById("byte_chk_warn").innerHTML = '&nbsp;';
		document.getElementById("byte_chk").style.fontWeight = "100";
	}
}
</script>
<script data-jui="#tab_smsTransport" data-tpl="row" type="text/template">
	<tr id="<!= row.index !>_sms"  class="trSms" onclick="smsData('<!= cateCd !>','<!= cateNm !>','<!= cateComment !>');">
		<td><input type="checkbox" name="sms_chk" value="<!= cateCd !>"/></td>
		<td name="cateCd" align ="center"><!= cateCd !></td>
		<td name="cateNm"><!= cateNm !></td>
		<td name="cateComment" align = "left"><!= cateComment !></td>
	</tr>
</script>
<script data-jui="#tab_smsTransport" data-tpl="none" type="text/template">
    <tr height ="390">
        <td colspan="4" class="none" align="center">데이터가 존재하지 않습니다.</td>
    </tr>
</script>
<style>
#sms_top_tr td {
	padding-bottom: 5px;
}
#sms_top_tr2 td {
	padding-bottom: 10px;
}
</style>
<div class="head">
	<a href="#" class="close"><i class="icon-exit"></i></a>
	<table width="100%" border="0" align="center" cellpadding="0"
		cellspacing="0">
		<tr>
			<td class="poptitle"
				style="background-image: url(../resources/jui-master/img/theme/jennifer/pop.png);">
				SMS 전송유형
			</td>
		</tr>
	</table>
</div>
<div class="body">
	<table width="100%" border="0" align="center" cellpadding="0" cellspacing="0" style="margin-bottom: 2px;">
		<tr id="sms_top_tr">
			<td width="60" class="td01">유형코드<sup style="color:red; font-weight: bold;">*</sup></td>
			<td align="left" class="td02" width="90">
				<input type="text" class="input mini" id="cate_Cd" style="width: 80px" />
			</td>
			<td width="50" class="td01">유형명<sup style="color:red; font-weight: bold;">*</sup></td>
			<td align="left" class="td02" width="150">
				<input type="text" class="input mini" id="cate_Nm" style="width: 148px" />
			</td>
			<td></td>
			<td width="220" align="right" class="td01" style="padding-right:9px;">
				<a class="btn small focus" id ="smsInitialization">초기화</a> 
				<a class="btn small focus" id="bt_smsInsert">저 장</a> 
				<a class="btn small focus" id="bt_smsDelete">삭 제</a> 
				<input type="hidden" id="tempUpdate" value="0" />
				<a class="btn small focus" id="bt_smsSelect">조 회</a>
			</td>
		</tr>
		<tr id="sms_top_tr2">
			<td width="50" class="td01">내용<sup style="color:red; font-weight: bold;">*</sup></td>
			<td colspan="3" align="left" class="td02" width="150">
				<textarea id="cate_Comment" class="input mini" style="width: 300px; height:60px!important; resize: none;" onkeyup="byteCheck()" onkeypress="byteCheck()"></textarea>
			</td>
			<td align="left" style="font-size: 12">
				<span id="byte_chk">0</span>byte/90byte <br>
				90Byte 초과 시, 장문으로 전환됩니다. <br>
				<span id="byte_chk_warn">&nbsp;</span>
				<!-- <input type="text" class="input mini" id="cate_Comment" style="width: 300px; height:60px!important" /> -->
			</td>
		</tr>
	</table>
	<table class="table classic hover" id="tab_smsTransport" width="100%" style="padding-left:5px;">
		<thead>
			<tr>
				<th style="width:20px;"><input type="checkbox" id="sms_checkall"/></th>
				<th style="width:150px;">유형코드</th>
				<th style="width:150px;">유형명</th>
				<th style="width:auto;">내용</th>
			</tr>
		</thead>
		<tbody>
		</tbody>
	</table>
</div>