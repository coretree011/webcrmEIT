<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>

<script>
var paramNoticeInsert = {
		bbsSbj : "",
		regEmpNo : "",
		regEmpNm : "",
		regDate : "",
		regHms : "",
		bbsNote : "",
/*		fileYN : "",
		commentYN : "",
		newYN : "",*/
		fileName : ""
		
};
jui.ready([ "grid.table"], function(table) {

	var data;
	var data_size;
	var page = 1;
	var result_data;

	/* 공지사항 저장 버튼*/
	$("#insertNotice").click(function() {
		var sbjNull = document.getElementById('txt_noticeSbj');
		var noteNull = document.getElementById('txt_noticeNote');
		var blank_pattern = /^\s+|\s+$/g;
		
		if (sbjNull.value == '' || sbjNull.value == null || sbjNull.value.replace( blank_pattern, '' ) == ""){
			msgboxActive('공지사항 등록', '\"제목\"을 입력해주세요.');
			//alert("제목을 입력해주세요.");
		}else if(noteNull.value == '' || noteNull.value == null || noteNull.value.replace( blank_pattern, '' ) == ""){
			msgboxActive('공지사항 등록', '\"내용\"을 입력해주세요.');	
			//alert("내용을 입력해주세요.");
		}else{
			var date = new Date();
		    var year  = date.getFullYear();
		    var month = date.getMonth() + 1; 
		    var day   = date.getDate();
		    var hours = date.getHours();
		    var minute = date.getMinutes();
		    var second = date.getSeconds();
		        
		    if (("" + month).length == 1) { month = "0" + month; }
		    if (("" + day).length   == 1) { day   = "0" + day;   }
		    
		    if (("" + hours).length == 1) { hours = "0" + hours; }
		    if (("" + minute).length   == 1) { minute   = "0" + minute;   }
		    if (("" + second).length   == 1) { second   = "0" + second;   }
		    
		    var today = year + month + day;
		    var time = hours +""+ minute +""+ second;
			
		    var sbj  =  $("#txt_noticeSbj").val().replace(/\n/g, "<br>");
		    sbj = replaceAll(replaceAll(sbj, "\"", "&quot;"), "\'", "\`");
		    
		    var note = $("#txt_noticeNote").val().replace(/\n/g, "<br>"); 
		    note = replaceAll(replaceAll(note, "\"", "&quot;"), "\'", "\`");
		    
		    paramNoticeInsert.bbsSbj =  sbj; 
		    paramNoticeInsert.regEmpNo =  $("#txt_noticeNo").val(); 
		    paramNoticeInsert.regEmpNm =   $("#txt_noticeNm").val(); 
		    paramNoticeInsert.regDate = today;
		    paramNoticeInsert.regHms = time;
		    
		    paramNoticeInsert.bbsNote = note; 
		    paramNoticeInsert.fileName = $("#noticefileRoot").val();
		    
		    //var root = $("#noticefileRoot").val(); 
		    
		    var temp = $("#txt_noticeNm").val();
		    
		    if(temp == 'null'){
		    	paramNoticeInsert.regEmpNm = "";
		    }
		    
	
			$.ajax({
				url : "/popup/noticeInsert",
				type : "post",
				contentType : 'application/json; charset=utf-8',
				data : JSON.stringify(paramNoticeInsert),
				success : function(result) {
					if(result == 1){
						msgboxActive('공지사항 등록', '게시글 \"저장\"이 완료되었습니다.');
						//alert("저장이 완료되었습니다");
						$("#win_15").hide();
					}else if(result == 0){
						msgboxActive('공지사항 등록', '게시글 \"저장\"이 완료되지 않았습니다. 다시 시도해주세요.');
						//alert("저장이 되지 않았습니다");
					}	
					$("#bt_noticeSelect").click();
				}
			
			});
			
			/* 파일업로드 */
			$.ajax({
		        url:"/popup/noticeFileUpload",
		        type: "POST",
		        data: new FormData($("#upload_file_notice")[0]),
		        enctype: 'multipart/form-data',
		        processData: false,
		        contentType: false,
		        cache: false,
		        success: function () {
		            //alert("File Upload Success");
		        },
		        error: function () {
		        	//alert("파일크기는 1048576 bytes 까지 가능합니다. \n 다시 시도해주세요.");
		        }
		    });
		}
	});
});

$(document).ready(function(){
	$("#noticeFileSelect").click(function() {
		$("#fileNotice").click();
		$("#fileNotice").change(function() {
			var tmpStr = $("#fileNotice").val();
		    var cnt = 0;
		    while(true){
		        cnt = tmpStr.indexOf("/");
		        if(cnt == -1) break;
		        tmpStr = tmpStr.substring(cnt+1);
		    }
		    while(true){
		        cnt = tmpStr.indexOf("\\");
		        if(cnt == -1) break;
		        tmpStr = tmpStr.substring(cnt+1);
		    }
		    
			$("#noticefileRoot").val(tmpStr);
			/* 확장자 비교 
 		    var thumbext = $("#noticefileRoot").val(); //파일을 추가한 input 박스의 값
			thumbext = thumbext.slice(thumbext.indexOf(".") + 1).toLowerCase(); //파일 확장자를 잘라내고, 비교를 위해 소문자로 만듭니다.
			if(thumbext != "xlsx"){ //확장자를 확인합니다.
				alert('엑셀파일(.xlsx)만 등록 가능합니다.'); 
			*/
		});
	});
});
</script>
<div class="head">
	<a href="#" class="close" onclick="$('#win_15').hide();"><i class="icon-exit"></i></a>
	<table width="100%" border="0" align="center" cellpadding="0" cellspacing="0">
		<tr>
			<td class="poptitle"
				style="background-image: url(../resources/jui-master/img/theme/jennifer/pop.png);">
				공지사항 등록
			</td>
		</tr>
	</table>
</div>
<div class="body">
<form id="upload_file_notice">
	<table style="width: 100%" border="0" cellpadding="0" cellspacing="0" class="table01">
		<tr>
		<td>
			<table style="width: 100%" border="0" cellpadding="0" cellspacing="0">
				<tr>
					<td width="60" class="td01">제목<sup style="color:red; font-weight: bold;">*</sup>&nbsp;&nbsp;</td>
					<td height="26" align="left">
						<input type="text" class="input mini" id="txt_noticeSbj" style="width: 830px" />
					</td>
					<td width="130" align="right" class="td01">
						<a class="btn small focus" id="insertNotice">저장</a> 
						<a class="btn small focus" onclick="$('#win_15').hide();">취소</a>
					</td>
				</tr>
				<tr>
					<td width="60" class="td01">내용<sup style="color:red; font-weight: bold;">*</sup>&nbsp;&nbsp;</td>
					<td height="100" colspan="2" align="left">
						<textarea name="textarea" class="input" id="txt_noticeNote"  style="height: 300px; width: 960px"></textarea>
					</td>
				</tr>
				<tr>
					<td width="60" class="td01">첨부파일&nbsp;&nbsp;</td>
					<td height="25" colspan="2" align="left">
						<input type="file" id="fileNotice" name="noticeUploadFile" style="display : none"/>
						<a class="btn small focus" id="noticeFileSelect">파일선택</a> 
						<input type="text" class="input mini" id="noticefileRoot"  style="width: 890px" />
						<%-- <input type="hidden" id="txt_noticeNo" value="<%= session.getAttribute("empNo") %>" /> --%>
						<%-- <input type="hidden" id="txt_noticeNm" value="<%= session.getAttribute("empNm") %>" /> --%>
					</td>
				</tr>
				<!-- <tr>
					<td width="60" class="td01">다운로드&nbsp;&nbsp;</td>
					<td height="0" align="left">
						<input type="text" class="input mini" style="width: 830px" value="선택된 파일명" />
					</td>
					<td width="130" align="right" class="td01">
						<a class="btn small focus">다운</a> <a class="btn small focus">삭제</a>
					</td>
				</tr> -->
			</table>
		</td>
		</tr>
	</table>
</form>
</div>