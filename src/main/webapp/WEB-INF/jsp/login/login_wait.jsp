<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>Insert title here</title>

<%@ include file="../common/jui_common.jsp"%>
<!-- <script src="../resources/js/popup.js"></script> -->
<script type="text/javascript">
	jui.ready([ "ui.window" ], function(win) {
		win_12 = win("#win_12", {
			width : 362,
			height : 288,
			left : "8%",
			top : 50,
			resize : false,
			move : true,
			modal : true
		});
		
		win_12.show();
	});
</script>

</head>
<body class="jui">
	<div id="win_12" class="window">
	<%@ include file="../login/login.jsp"%>
</div>
</body>
</html>