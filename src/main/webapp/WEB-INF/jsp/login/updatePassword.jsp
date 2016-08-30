<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<script type="text/javascript">
var users = {
		username : "",
		empNo : "",
		password : "",
		newPwd : "",
	};

function updatePwd() {
			var empNo = $("input[name=pwdEmpNo]").val();
			var nowPwd = $("input[name=nowPwd]").val();
			var newPwd = $("input[name=newPwd]").val();
			var confirmPwd = $("input[name=confirmPwd]").val();
			
			if(empNo == ""){
				alert("아이디를 입력해주세요.");
			}else if(empNo == "superadmin"){
				alert("비밀번호를 변경할 수 없습니다.");
			}else if(nowPwd == ""){
				alert("현재 비밀번호를 입력해주세요.");
			}else if(newPwd == ""){
				alert("새 비밀번호를 입력해주세요.");
			}else if(confirmPwd == ""){
				alert("새 비밀번호 확인을 입력해주세요.");
			}else if(newPwd != confirmPwd){
				alert("새 비밀번호와 새 비밀번호 확인이 맞지 않습니다.");
			}else{
				if(newPwd == confirmPwd){
					users.empNo = empNo;
					users.password = nowPwd;
					users.newPwd = newPwd;
					var jsondata = JSON.stringify(users);
					$.ajax({
						url : "/login/updatePwd",
						type : "post",
						contentType : 'application/json; charset=utf-8',
						data : JSON.stringify(users),
						success : function(result) {
							if(result == 0){
								alert("현재 비밀번호를 확인하세요.");
							}else if(result == 1){
								alert("변경되었습니다.");
								bt_updatePwd();
								win_12_1.hide();
							}
						}
					});
				}
			}
		}
</script>
</head>
<body class="jui">
	<div class="head">
		<a href="#" class="close"><i class="icon-exit"></i></a>
		<table width="100%" border="0" align="center" cellpadding="0" cellspacing="0">
			<tr>
				<td class="poptitle"style="background-image: url(../resources/jui-master/img/theme/jennifer/pop.png);">비밀번호변경</td>
			</tr>
		</table>
	</div>
	<div class="body">
		<form name="frm" method="post">
			<table width="330" border="0" cellspacing="0" cellpadding="0">
						<tr>
							<td align="center">
								<input type="text" name= "pwdEmpNo" class="loginput mini" placeholder="아이디" value="<%= session.getAttribute("empNo") %>" style="width: 130px" /> 
								<input type="password" class="loginput mini" name="nowPwd" placeholder="현재 비밀번호" style="width: 130px" />
							</td>
						</tr>
						<tr>
							<td height="4"></td>
						</tr>
						<tr>
							<td align="center">
								<input type="password" name="newPwd" class="loginput mini"placeholder="새 비밀번호" style="width: 130px" />
								<input type="password" name="confirmPwd" class="loginput mini" placeholder="새 비밀번호 확인" style="width: 130px" />
							</td>
						</tr>
						<tr>
							<td height="4"></td>
						</tr>
						<tr>
							<td align="center">
								<a class="logbtn small focus" href="javascript:updatePwd();">확인</a>&nbsp;
								<a class="logbtn small focus" href="#" onclick="win_12_1.hide();">취소</a>&nbsp;
							</td>
						</tr>
					</table>
			</form>
		<div>
	</div>
	<br>
</div>
</body>
</html>