<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<link rel="shortcut icon" type="image/x-icon" href="../resources/jui-master/img/icon/favicon.ico" />
<title>Coretree - IP Contact Centre</title>
<!-- <script src="../resources/js/jquery-2.2.4.min.js"></script> -->

<%@ include file="./common/jui_common.jsp"%>
<script src="../resources/js/popup.js"></script>

<!-- 우측 사이드 바 기능 활용을 위한 파일 -->
<link rel="stylesheet" href="../resources/css/jquery-ui.css">
<script src="../resources/js/jquery-ui.js"></script>

<!-- Popup script components -->
<script src="../resources/js/tel.js"></script>

<style type="text/css">
body {
	overflow-y: hidden;
}
.navigation {
	display: block;
	position: absolute;
	float: left;
	top: 0;
	left: 0;
	width: 205px;
	height: 100%;
	background-color: #eaeaea;
	background-image:
		url(../resources/jui-master/img/theme/jennifer/left_back.jpg);
	margin-top: 8px;
}

.content-wrapper {
	display: block;
	position: absolute;
	float: left;
	left: 205px;
	top: 0;
	height: 100%;
	width: 1140px;
	/* width:885px; */
}

.top {
	margin-top: 8px;
	background-image:
		url(../resources/jui-master/img/theme/jennifer/top_back.jpg);
}

.right {
	display: block;
	position: absolute;
	float: right;
	top: 0;
	right: 0;
	left: 1345px;
	width: 20px;
	height: 100%;
}

.nav-right {
	display: none;
	position: absolute;
	float: right;
	top: 0;
	right: 0;
	width: 250px;
	height: 100%;
	background-color: lightgray;
}
</style>

<script>
	$(document).ready(function() {

		$(".submenu").slideUp();
		$(".submenu:first").slideDown();

		/* 좌측 메뉴 slide 기능 */
		$(".vmenu>a").click(function() {
			$(".vmenu>a").removeClass("active");
			$(this).addClass("active");
			$(".vmenu a i").removeClass("icon-arrow1");
			$(this).find("i").addClass("icon-arrow1");

			var submenu = $(this).next("ul");
			$(".submenu").slideUp();
			submenu.slideToggle();
		});

		$(".submenu>li").click(function() {
			$(".submenu>li").removeClass("active");
			$(this).addClass("active");

		});

		/* 우측 사이드바 기능 */
		$("#imgSidr").click(function() {
			$("#sidr").toggle("right");
			monitoringSearch();
		});
		
		/* ENTER키 눌렀을 때 이벤트  */
		$(document).keypress(function (e) {
		    if (e.which == 13 || e.which == 32) {
		    	$("#msgAlert_ok").click(); 
		    	$("#tab01_cancel").click();
		    }
		});
		
		/* 상단 탭 컨트롤 */
		/* $(".tab_up").ready(function() {
			$(".tab_content").hide();
			$(".tab_content:first").show();
			$("ul.tab_up li:first").addClass("checked");
			$("ul.tab_up li:first i").addClass("icon-arrow1");

			$("ul.tab_up li").click(function() {
				$("ul.tab_up li").removeClass("checked");
				$(this).addClass("checked");
				$("ul.tab_up li i").removeClass("icon-arrow1");
				$(this).find("i").addClass("icon-arrow1");

				$(".tab_content").hide();
				var activeTab = $(this).attr("rel");
				$("#" + activeTab).fadeIn("fast");
			});
		}); */

		/* 하단 탭 컨트롤 */
		/* $(".tab_down").ready(function() {
			$(".tab_content2").hide();
			$(".tab_content2:first").show();
			$("ul.tab_down li:first").addClass("checked");
			$("ul.tab_down li:first i").addClass("icon-arrow1");

			$("ul.tab_down li").click(function() {
				$("ul.tab_down li").removeClass("checked");
				$(this).addClass("checked");
				$("ul.tab_down li i").removeClass("icon-arrow1");
				$(this).find("i").addClass("icon-arrow1");

				$(".tab_content2").hide();
				var activeTab = $(this).attr("rel");
				$("#" + activeTab).fadeIn("fast");
			});
		}); */
		

	jui.ready([ "ui.tab" ], function(tab) {
		tab_1 = tab("#tab_1", {
			event : {
				change : function(data) {
					$("ul.tab_up li").removeClass("checked");
					$("ul.tab_up li i").removeClass("icon-arrow1");

					var a = data.index + 1;

					$("ul.tab_up li:nth-child(" + a + ")").addClass("checked");
					$("ul.tab_up li:nth-child(" + a + ") i").addClass("icon-arrow1");
				}
			},
			target : "#tab_contents_1",
			index : 0
		});

		tab_2 = tab("#tab_2", {
			event : {
				change : function(data) {
					$("ul.tab_down li").removeClass("checked");
					$("ul.tab_down li i").removeClass("icon-arrow1");

					var a = data.index + 1;

					$("ul.tab_down li:nth-child(" + a + ")")
							.addClass("checked");
					$("ul.tab_down li:nth-child(" + a + ") i").addClass(
							"icon-arrow1");
				}
			},
			target : "#tab_contents_2",
			index : 0
		});
	});
		
	//팝업 닫기할 때 달력 display : none 이벤트
	$(".icon-exit").click(function() {
		document.getElementById("ui-datepicker-div").style.display = "none";
	});
});
	
/* popup창 z-index 동적으로 할당 */
var num = 0;
var id;
function fn_index(popupId){
	id = "#"+popupId;
	num++;
	$(id).css("z-index",  num);

	$(id).on("click",function(){
	  $(this).css("z-index", num);
	});
}

function fn_page(){
	$(id).css("z-index", num);
}

function fn_msg(){
	$('#msgAlert').css( "display", "none" );
	$('#tab01_msgbox').css( "display", "none" );
	$('#counceller_msgbox').css( "display", "none" );
}
function msgboxActive(pageName, note){
	var text = note.replaceAll("\n", "<BR>") 
	$('#msgBody1').html(pageName);
	$('#msgBody2').html(text);
	$('#msgAlert').css( "display", "block" );
}
function msgboxActive2(pageName, note){
	var text = note.replaceAll("\n", "<BR>") 
	$('#tab01_msgbody1').html(pageName);
	$('#tab01_msgbody2').html(text);
	$('#tab01_msgbox').css( "display", "block" );
}
function msgboxActive3(pageName, note){
	var text = note.replaceAll("\n", "<BR>") 
	$('#counceller_msgbody1').html(pageName);
	$('#counceller_msgbody2').html(text);
	$('#counceller_msgbox').css( "display", "block" );
}
</script>

</head>

<body class="jui">
	<div class="navigation">
		<%@ include file="./pages/menu.jsp"%>
	</div>

	<!-- CONTENTS -->
	<div class="content-wrapper">
		<!-- 버튼 부분 -->
		<div class="top" style="height: 65px">
			<%@ include file="./pages/softphone.jsp"%>
		</div>
		<div>
			<div style="height: 40%">
				<table width="98%" border="0" align="center" cellpadding="0" cellspacing="0">
					<tr>
						<td>
							<ul id="tab_1" class="tab top tab_up">
								<li class="checked" id="click_tab1"><a href="#tab01" style="padding-bottom: 9px;">고객상세<i class="icon-arrow1"></i></a></li>
								<li id="click_tab2"><a href="#tab02" style="padding-bottom: 9px;">고객리스트<i></i></a></li>
								<li><a href="#tab03" style="padding-bottom: 9px;">콜백<i></i></a></li>
								<li><a href="#tab04" style="padding-bottom: 9px;">상담예약<i></i></a></li>
							</ul>

							<div id="tab_contents_1">
								<div id="tab01"><jsp:include page= "./pages/tab01.jsp" /></div>
								<div id="tab02"><jsp:include page= "./pages/tab02.jsp" /></div>
								<div id="tab03"><jsp:include page= "./pages/tab03.jsp" /></div>
								<div id="tab04"><jsp:include page= "./pages/tab04.jsp" /></div>
							</div>
						</td>
					</tr>
				</table>
			</div>
		</div>
	</div>

	<div class="right">
		<span class='icon icon-chevron-left' id="imgSidr"
			style="line-height: 550px; font-size: 20px;"></span>
	</div>

	<!-- 우측 사이드바 -->
	<div class="nav-right" id="sidr">
		<jsp:include page= "./pages/right.jsp" />
	</div>


	<!-- 좌측 메뉴 팝업 -->
	<div id="win_1" class="msgboxpop danger" style="display:none">
		<jsp:include page= "./popup/excel_store.jsp" />
	</div>

	<div id="win_2" class="msgboxpop danger" style="display:none">
		<jsp:include page= "./popup/record_present.jsp" />
	</div>

	<div id="win_3" class="msgboxpop danger" style="display:none">
		<jsp:include page= "./popup/ivr_present.jsp" />
	</div>

	<div id="win_4" class="msgboxpop danger" style="display:none">
		<jsp:include page= "./popup/callcenter_all_present.jsp" />
	</div>

	<div id="win_5" class="msgboxpop danger" style="display:none">
		<jsp:include page= "./popup/counceller_present.jsp" />
	</div>

	<div id="win_6" class="msgboxpop danger" style="display:none">
		<jsp:include page= "./popup/notice_ask.jsp" />
	</div>

	<%-- <div id="win_7" class="msgboxpop danger" style="display:none">
		<%@ include file="./popup/notice_reg_modify.jsp"%>
	</div>

	<div id="win_8" class="msgboxpop danger" style="display:none">
		<%@ include file="./popup/notice_comment_mgr.jsp"%>
	</div> --%>

	<div id="win_9" class="msgboxpop danger" style="display:none">
		<jsp:include page= "./popup/counceller_manager.jsp" />
	</div>

	<div id="win_10" class="msgboxpop danger" style="display:none">
		<jsp:include page= "./popup/sms_transport.jsp" />
	</div>

	<div id="win_11" class="msgboxpop danger" style="display:none">
		<jsp:include page= "./popup/extension_manage.jsp" />
	</div>

	<div id="win_12_1" class="msgboxpop danger" style="display:none">
		<jsp:include page= "./login/updatePassword.jsp" />
	</div>

	<div id="win_13" class="msgboxpop danger" style="display:none">
		<jsp:include page= "./popup/callback_reserve.jsp" />
	</div>

	<div id="win_14" class="msgboxpop danger" style="display:none">
		<jsp:include page= "./popup/sms_transport_reg.jsp" />
	</div>

	<div id="win_14_1" class="msgboxpop danger" style="display:none">
		<jsp:include page= "./popup/sms_grpTransport_reg.jsp" />
	</div>
	
	<div id="win_18" class="msgboxpop danger" style="display:none">
		<jsp:include page= "./popup/code_manager.jsp" />
	</div>
	
	<div id="msgAlert" style="position: relative; height: 150px; display: none; z-index:9999;">
		<div class="msgbox" style="left:550px; top:100%; width:300px;">
			<div class="head" id="msgHead" style="height:20px; font-size:13px; padding-left:2px; border: 0px">
					<img src="../resources/jui-master/img/theme/jennifer/popMsg.png"/>
					<span style="float:right; padding-right:115px; padding-top: 4px;">알림창</span>
		    </div>
			<div class="body" style="padding:0px;">
				<p id="msgBody1" style="margin:0px; font-weight:bold; background-color:#525252; color:white; height: 20px; padding-left:10px; padding-top: 10px;">페이지이름</p> <br/>
				<p id="msgBody2" style="margin:0px; padding-left: 10px;">메세지 내용</p><br/>
				<div style="text-align: center; margin-top: 20px; margin-bottom: 20px;">
					<a href="#" class="btn focus small" onclick="fn_msg()" id="msgAlert_ok">확인</a>
				</div>
			</div>
		</div>
	</div>
	<div id="tab01_msgbox" style="position: relative; height: 150px; display: none; z-index:9999;">
		<div class="msgbox" style="left:550px; top:100%; width:300px;">
			<div class="head" id="msgHead" style="height:20px; font-size:13px; padding-left:2px; border: 0px">
					<img src="../resources/jui-master/img/theme/jennifer/popMsg.png"/>
					<span style="float:right; padding-right:115px; padding-top: 4px;">알림창</span>
		    </div>
			<div class="body" style="padding:0px;">
				<p id="tab01_msgbody1" style="margin:0px; font-weight:bold; background-color:#525252; color:white; height: 20px; padding-left:10px; padding-top: 10px;">페이지이름</p> <br/>
				<p id="tab01_msgbody2" style="margin:0px; padding-left: 10px;">메세지 내용</p><br/>
				<div style="text-align: center; margin-top: 20px; margin-bottom: 20px;">
					<a href="#" class="btn focus small" id="tab01_msgok">확인</a>
					<a href="#" class="btn focus small" onclick="fn_msg()" id="tab01_cancel">취소</a>
				</div>
			</div>
		</div>
	</div>
	<div id="counceller_msgbox" style="position: relative; height: 150px; display: none; z-index:9999;">
		<div class="msgbox" style="left:550px; top:100%; width:300px;">
			<div class="head" id="msgHead" style="height:20px; font-size:13px; padding-left:2px; border: 0px">
					<img src="../resources/jui-master/img/theme/jennifer/popMsg.png"/>
					<span style="float:right; padding-right:115px; padding-top: 4px;">알림창</span>
		    </div>
			<div class="body" style="padding:0px;">
				<p id="counceller_msgbody1" style="margin:0px; font-weight:bold; background-color:#525252; color:white; height: 20px; padding-left:10px; padding-top: 10px;">페이지이름</p> <br/>
				<p id="counceller_msgbody2" style="margin:0px; padding-left: 10px;">메세지 내용</p><br/>
				<div style="text-align: center; margin-top: 20px; margin-bottom: 20px;">
					<a href="#" class="btn focus small" id="counceller_msgok">확인</a>
					<a href="#" class="btn focus small" onclick="fn_msg()" id="tab01_cancel">취소</a>
				</div>
			</div>
		</div>
	</div>
</body>
</html>