<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<script>
var param = {
};
var code = {
	lcd : ""
}
var codeInsert = {
	lcd : "",
	scd : "",
	scdNm : "",
	useYn : ""
}
var codeModify = {
	lcd : "",
	scd : "",
	scdNm : "",
	useYn : ""
}
var temp;
jui.ready([ "grid.xtable"], function(xtable) {
	var page = 1;
	table_codeLarge = xtable("#table_codeLarge", {
		resize : true,
	    buffer: "s-page",
	    bufferCount: 2000,
	    scrollHeight: 350,
		event: {
		    dblclick: function(row, e){
		    		this.select(row.index);
		    		
		    		document.getElementById("txt_code").value = "";
		    		document.getElementById("txt_code").disabled = false;
		    		document.getElementById("txt_codeNm").value = "";
		    		document.getElementById("codeYn1").checked = false;
		    		document.getElementById("codeYn2").checked = false;
		    		temp = 0;
		    		
		    		code.lcd = document.querySelectorAll(".lcd")[row.index].innerHTML;
		    		document.getElementById("codeLarge_Lcd").value = code.lcd;
		    		
		    		$.ajax({
		    			url : "/popup/codeSmallList",
		    			type : "post",
		    			contentType : 'application/json; charset=utf-8',
		    			data : JSON.stringify(code),
		    			success : function(result) {
		    				page=1;
		    				table_codeSmall.update(result);
		    				table_codeSmall.resize(); 
		    			}
		    		});
		    		
		    }
		}
	}); 
	
	table_codeSmall = xtable("#table_codeSmall", {
		resize : true,
	    buffer: "s-page",
	    bufferCount: 2000,
	    scrollHeight: 350,
		event: {
		    click: function(row, e){
		    	this.select(row.index);
		    }
		}
	}); 
	
	/* 페이지 로드될 때 */
	$("#bt_codePopup").click(function(){
		document.getElementById("txt_code").value = "";
		document.getElementById("txt_code").disabled = false;
		document.getElementById("txt_codeNm").value = "";
		document.getElementById("codeYn1").checked = false;
		document.getElementById("codeYn2").checked = false;
		
		$.ajax({
			url : "/popup/codeLargeList",
			type : "post",
			contentType : 'application/json; charset=utf-8',
			data : JSON.stringify(param),
			success : function(result) {
				page=1;
				table_codeLarge.update(result);
				table_codeLarge.resize(); 
			}
		});
		
		table_codeSmall.update();
	});
	
	/* 초기화 버튼 */
	$("#code_initialization").click(function(){
		temp = 0;
		document.getElementById("txt_codeNm").value = "";
		document.getElementById("txt_code").disabled = false;
		document.getElementById("codeYn1").checked = false;
		document.getElementById("codeYn2").checked = false;
		
		code.lcd = document.getElementById("codeLarge_Lcd").value;
		
		if(code.lcd == "" || code.lcd == null){
			document.getElementById("txt_code").value = "";
		}else{
			$.ajax({
				url : "/popup/codeSmallMax",
				type : "post",
				contentType : 'application/json; charset=utf-8',
				data : JSON.stringify(code),
				success : function(result) {
					document.getElementById("txt_code").value = parseInt(result.scd)+1;
				}
			});
		}
	});
	
	/* 저장 버튼 */
	$("#codeSmall_Save").click(function(){
		if(temp == 1){
			codeModify.lcd = document.getElementById("codeLarge_Lcd").value;
			codeModify.scd = document.getElementById("txt_code").value;
			codeModify.scdNm = document.getElementById("txt_codeNm").value;
			if(document.getElementById("codeYn1").checked == true){
				codeModify.useYn = 'Y';	
			}else{
				codeModify.useYn = 'N';
			}
			
			$.ajax({
    			url : "/popup/codeSmallModify",
    			type : "post",
    			contentType : 'application/json; charset=utf-8',
    			data : JSON.stringify(codeModify),
    			success : function(result) {
    				if(result == 1){
						msgboxActive('기타 코드관리', '\"수정\"이 완료되었습니다.');	
						
						$.ajax({
			    			url : "/popup/codeSmallList",
			    			type : "post",
			    			contentType : 'application/json; charset=utf-8',
			    			data : JSON.stringify(code),
			    			success : function(result) {
			    				page=1;
			    				table_codeSmall.update(result);
			    				table_codeSmall.resize(); 
			    			}
			    		});
					}else{
						msgboxActive('기타 코드관리', '\"수정\"이 완료되지 않았습니다. 다시 시도해주세요.');	
					}
    			}
    		});
		}else {
			temp = 0;
			if(document.getElementById("codeLarge_Lcd").value == "" || document.getElementById("codeLarge_Lcd").value == null){
				msgboxActive('기타 코드관리', '저장할 \"코드명\"을 선택해주세요.');
			}else if(document.getElementById("txt_code").value == "" || document.getElementById("txt_code").value == null){
				msgboxActive('기타 코드관리', '\"코드\"를 입력해주세요.');
			}else if(document.getElementById("txt_codeNm").value == "" || document.getElementById("txt_codeNm").value == null){
				msgboxActive('기타 코드관리', '\"코드명\"를 입력해주세요.');
			}else if(document.getElementById("codeYn1").checked == false && document.getElementById("codeYn2").checked == false){
				msgboxActive('기타 코드관리', '\"사용여부\"를 선택해주세요.');
			}else{
				codeInsert.lcd = document.getElementById("codeLarge_Lcd").value;
				codeInsert.scd = document.getElementById("txt_code").value;
				codeInsert.scdNm = document.getElementById("txt_codeNm").value;
				if(document.getElementById("codeYn1").checked == true){
					codeInsert.useYn = 'Y';	
				}else{
					codeInsert.useYn = 'N';
				}
				 
				$.ajax({
					url : "/popup/codeSmallInsert",
					type : "post",
					contentType : 'application/json; charset=utf-8',
					data : JSON.stringify(codeInsert),
					success : function(result) {
						if(result == 1){
							msgboxActive('기타 코드관리', '\"저장\"이 완료되었습니다.');	
							
							$.ajax({
				    			url : "/popup/codeSmallList",
				    			type : "post",
				    			contentType : 'application/json; charset=utf-8',
				    			data : JSON.stringify(code),
				    			success : function(result) {
				    				page=1;
				    				table_codeSmall.update(result);
				    				table_codeSmall.resize(); 
				    			}
				    		});
						}else{
							msgboxActive('기타 코드관리', '\"소분류코드\"가 존재합니다. 다시 입력해주세요.');	
						}
						
					}
				});
			}
		}
		
	});
	
});

/* 화면 레이아웃(단 나누기) */
jui.ready([ "ui.layout" ], function(layout) {
    layout_1 = layout("#layout_1", {
        width: 950,
        height: 510,
        barSize : 0,
        left: {
            size: 300,
            min: 100,
            max: 300,
        },
        right: {
            size: 200,
            min: 100,
            max: 300,
        }
    });
});

function codeSmall(scd,scdNm,useYn){
	temp = 1;
	document.getElementById("txt_code").value = scd;
	document.getElementById("txt_code").disabled = true;
	
	document.getElementById("txt_codeNm").value = scdNm;
	if(useYn == 'Y'){
		document.getElementById("codeYn1").checked = true;
	}else{
		document.getElementById("codeYn2").checked = true;
	}
	
}
</script>
<script data-jui="#table_codeLarge" data-tpl="row" type="text/template">
	<tr id="<!= row.index !>_codeLarge">
		<td class="lcd"><!= lcd !></td>
		<td><!= lcdNm !></td>
	</tr>
</script>
<script data-jui="#table_codeSmall" data-tpl="row" type="text/template">
	<tr onclick="codeSmall('<!= scd !>','<!= scdNm !>','<!= useYn !>');">
		<td><!= scd !></td>
		<td><!= scdNm !></td>
		<td><!= useYn !></td>
	</tr>
</script>
<script data-jui="#table_codeSmall" data-tpl="none" type="text/template" >
    <tr height ="150">
        <td colspan="3" class="none" align="center">코드명을 선택해주세요.</td>
    </tr>
</script>
<div class="head">
	<input type="hidden" id="codeLarge_Lcd" />
	<a href="#" class="close"><i class="icon-exit"></i></a>
	<table width="100%" border="0" align="center" cellpadding="0" cellspacing="0">
		<tr>
			<td class="poptitle"
				style="background-image: url(../resources/jui-master/img/theme/jennifer/pop.png);">
				기타 코드관리
			</td>
		</tr>
	</table>
</div>
<div class="body" id="layout_1" style="overflow-y:hidden; overflow-x:hidden;">
	<div  class="left" style="padding:10px; overflow-y:hidden">
		<b>기타코드</b>
		<div style="padding:10px;">
			<table class="table classic hover" id="table_codeLarge" width="100%">
				<thead>
					<tr>
						<th style="width:60px;">기타코드</th>
						<th style="width:auto;">코드명</th>
					</tr>
				</thead>
				<tbody>
				</tbody>
			</table>
		</div>
	</div>
	<div  class="center" style="padding:10px; overflow-y:hidden">
		<b>중분류코드관리</b>
		<div style="padding:10px;">
			<table width="100%">
				<tr>
					<td>코드</td>
					<td><input type="text" id="txt_code" /></td>
					<td align="center">
						사용여부 <br>
					</td>
				</tr>
				<tr>
					<td>코드명</td>
					<td><input type="text" id="txt_codeNm"/></td>
					<td align="center">
						<input type="radio" name="codeRadio" id="codeYn1"/>사용&nbsp;&nbsp;
						<input type="radio" name="codeRadio" id="codeYn2"/>미사용
					</td>
				</tr>
			</table>
			<p></p>
			<div style="padding:10px;">
				<table class="table classic hover" id="table_codeSmall" width="100%">
					<thead>
						<tr>
							<th style="width:60px;">소분류코드</th>
							<th style="width:100px;">소분류코드명</th>
							<th style="width:auto;">사용여부</th>
						</tr>
					</thead>
					<tbody>
					</tbody>
				</table>
			</div>
		</div>
	</div>
	<div class="right" style="padding:10px;">
		<a class="btn small focus" id="code_initialization">초기화</a>
		<a class="btn small focus" id="codeSmall_Save">저장</a>
	</div>
</div>