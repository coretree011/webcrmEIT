<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<script>
var noticeModifyUpdate = {
	bbsSeq : "",
	bbsSbj : "",
	regEmpNm : "",
	regEmpNm : "",
	regDate : "",
	regHms : "",
	bbsNote : ""
};
var noticeModifyFile = {
	bbsSeq : "",
	fileName : ""
};

$(document).ready(function() {
	/* 공지사항 수정페이지의 저장 버튼 */
	$("#bt_noticeModify").click(function() {
		var sbjModifyNull = document.getElementById('txt_noticeModifySbj');
		var noteModifyNull = document.getElementById('txt_noticeModifyNote');
		var blank_pattern = /^\s+|\s+$/g;
		
		if (sbjModifyNull.value == '' || sbjModifyNull.value == null || sbjModifyNull.value.replace( blank_pattern, '' ) == ""){
				//alert("제목을 입력해주세요.");
				msgboxActive('공지사항 수정', '\"제목\"을 입력해주세요.');
		}else if(noteModifyNull.value == '' || noteModifyNull.value == null || noteModifyNull.value.replace( blank_pattern, '' ) == ""){
				//alert("내용을 입력해주세요.");
				msgboxActive('공지사항 수정', '\"내용\"을 입력해주세요.');
		}else{
			var fname = $("#noticeModifyfileName").val();
			if (fname.length > 0){
				/* 데이터베이스에서 기존 파일 데이터 삭제 */
				var fileModifyDelete = {
						bbsSeq : $("#bbsmodifySEQ").val(),
						fileName : $("input[name=bbsModifyFileDownload]").val()
				};
				
				$.ajax({
					url : "/popup/noticeFileDelete",
					type : "post",
					contentType : 'application/json; charset=utf-8',
					data : JSON.stringify(fileModifyDelete),
					success : function(result) {
						$("input[name=bbsModifyFileDownload]").val("");
					}
				}); 
				
				/* 파일업로드 */
				$.ajax({
			        url:"/popup/noticeFileUpload2",
			        type: "POST",
			        data: new FormData($("#upload_file_noticeModify")[0]),
			        enctype: 'multipart/form-data',
			        processData: false,
			        contentType: false,
			        cache: false,
			        success: function () {
			        },
			        error : function(){
			        	
			        }
			    });
				
				noticeModifyFile.bbsSeq = $("#bbsmodifySEQ").val();
				noticeModifyFile.fileName = fname;
				
				/* BBS_FILE 테이블에 insert */
				$.ajax({
			        url:"/popup/noticeModifyFileInsert",
			        type : "post",
					contentType : 'application/json; charset=utf-8',
					data : JSON.stringify(noticeModifyFile),
					success : function(result) {
			        }
			    });
				
			}
			
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
			
			var sbj = $("#txt_noticeModifySbj").val().replace(/\n/g, "<br>");
			sbj = replaceAll(replaceAll(sbj, "\"", "&quot;"), "\'", "\`");
			   
			var note = $("#txt_noticeModifyNote").val().replace(/\n/g, "<br>");
			note = replaceAll(replaceAll(note, "\"", "&quot;"), "\'", "\`");
			
			noticeModifyUpdate.bbsSeq  = $("#bbsmodifySEQ").val(); 
			noticeModifyUpdate.bbsSbj = sbj; 
			noticeModifyUpdate.regEmpNo = $("#bbsModifyEmpNo").val();
			noticeModifyUpdate.regEmpNm = $("#bbsModifyEmpNm").val();
			noticeModifyUpdate.regDate = today;
			noticeModifyUpdate.regHms = time;
			noticeModifyUpdate.bbsNote = note;
			
			$.ajax({
				url : "/popup/noticeModify",
				type : "post",
				contentType : 'application/json; charset=utf-8',
				data : JSON.stringify(noticeModifyUpdate),
				success : function(result) {
					if(result == 1){
						msgboxActive('공지사항 수정', '게시글 \"수정\"이 완료되었습니다.');
						//alert("수정이 완료되었습니다."); 
						$("#win_16").hide();
						$("#bt_noticeSelect").click();
					}else{
						msgboxActive('공지사항 수정', '게시글 \"수정\"이 완료되지 않았습니다. 다시 시도해주세요.');
						//alert("수정 실패하였습니다.");
					}
				}
			});
		}
		
	});
	
	$("#bt_noticeModifyFileDown").click(function() {
		//파일명
		var fName = $("input[name=bbsModifyFileDownload]").val();
		var fileName = fName.substring(0, fName.lastIndexOf("."));
		//확장자 구하기
		var fileExtension = fName.slice(fName.lastIndexOf(".")+1).toLowerCase();
		$.ajax({
			url : "/popup/noticeFileDownload/" + fileName + "/" + fileExtension,
			type : "post",
			contentType: "application/octet-stream; charset=utf-8",
			data : fileName,
			success : function() {
				window.location.href = "/popup/noticeFileDownload/" + fileName + "/" + fileExtension;
			}
		});
	}); 
	
	/* 파일선택 버튼 */
	$("#bt_noticeModifyFileUp").click(function() {
		$("#noticeFileUp_hide").click(); 
		$("#noticeFileUp_hide").change(function() {
			var tmpStr = $("#noticeFileUp_hide").val();
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
		    
			$("#noticeModifyfileName").val(tmpStr);
		});
	}); 
	
	/* 삭제버튼 */
	$("#bt_fileModifyDelete").click(function() {
		paramNoticeDelete.bbsSeq = $("#bbsmodifySEQ").val();
		
		$.ajax({
			url : "/popup/noticeDelete",
			type : "post",
			contentType : 'application/json; charset=utf-8',
			data : JSON.stringify(paramNoticeDelete),
			success : function(result) {
				if(result>=1){
					msgboxActive('공지사항 수정', '게시글 \"삭제\"가 완료되었습니다.');
					//alert("삭제가 완료되었습니다");
					$("#win_16").hide();
					$("#bt_noticeSelect").click();
				}else {
					msgboxActive('공지사항 수정', '게시글 \"삭제\"가 완료되지 않았습니다. 다시 시도해주세요.');
					//alert("삭제가 완료되지 않았습니다. 다시 시도해주세요.");
				}
			}
		});
		
		$.ajax({
			url : "/popup/noticeCommentDelete",
			type : "post",
			contentType : 'application/json; charset=utf-8',
			data : JSON.stringify(paramNoticeDelete),
			success : function(result) {
				
			}
		});
		
		var fileModifyDelete = {
				bbsSeq : $("#bbsmodifySEQ").val(),
				fileName : $("input[name=bbsModifyFileDownload]").val()
		};
		
		$.ajax({
			url : "/popup/noticeFileDelete",
			type : "post",
			contentType : 'application/json; charset=utf-8',
			data : JSON.stringify(fileModifyDelete),
			success : function(result) {
				$("input[name=bbsModifyFileDownload]").val("");
			}
		}); 
		
	}); 
});
</script>
<div class="head">
<input type="hidden" id="bbsmodifySEQ" />
<input type="hidden" id="bbsModifyEmpNo" value ="<%=session.getAttribute("empNo")%>"/> 
<input type="hidden" id="bbsModifyEmpNm" value ="<%=session.getAttribute("empNm")%>" />
										
	<a href="#" class="close" onclick="$('#win_16').hide();"><i class="icon-exit"></i></a>
	<table width="100%" border="0" align="center" cellpadding="0"
		cellspacing="0">
		<tr>
			<td class="poptitle"
				style="background-image: url(../resources/jui-master/img/theme/jennifer/pop.png);">
				공지사항 수정
			</td>
		</tr>
	</table>
</div>
<div class="body">
<form id="upload_file_noticeModify">
	<table style="width: 100%" border="0" cellpadding="0" cellspacing="0" class="table01" >
		<tr>
		<td>
			<table style="width: 100%" border="0" cellpadding="0" cellspacing="0">
				<tr>
					<td width="60" class="td01">제목<sup style="color:red; font-weight: bold;">*</sup>&nbsp;&nbsp;</td>
					<td height="26" align="left">
						<input type="text" class="input mini" id="txt_noticeModifySbj" style="width: 800px"/>
					</td>
					<td width="150" align="right" class="td01">
						<a class="btn small focus" id="bt_noticeModify">저장</a> 
						<a class="btn small focus" id="bt_fileModifyDelete">삭제</a>
						<a class="btn small focus" onclick="$('#win_16').hide();">취소</a>
					</td>
				</tr>
				<tr>
					<td width="60" class="td01">내용<sup style="color:red; font-weight: bold;">*</sup>&nbsp;&nbsp;</td>
					<td height="300" colspan="2" align="left">
						<textarea name="textarea" class="input" id="txt_noticeModifyNote" style="height: 300px; width: 960px" ></textarea>
					</td>
				</tr>
				<tr>
					<td width="60" class="td01">첨부파일&nbsp;&nbsp;</td>
					<td height="25" colspan="2" align="left">
						<input type="file" id="noticeFileUp_hide" name="noticeModifyFileUpload" style="display : none"/>
						<a class="btn small focus" id="bt_noticeModifyFileUp">파일선택</a> 
						<input type="text" class="input mini" id="noticeModifyfileName"  style="width: 890px"/>
					</td>
				</tr>
				<tr>
					<td width="60" class="td01">다운로드&nbsp;&nbsp;</td>
					<td height="0" align="left">
						<input type="text" class="input mini" name="bbsModifyFileDownload" style="width: 830px"/>
					</td>
					<td width="130" align="right" class="td01">
						<a class="btn small focus" id="bt_noticeModifyFileDown">다운</a> 
					</td>
				</tr>
			</table>
		</td>
		</tr>
	</table>
</form>
</div>
