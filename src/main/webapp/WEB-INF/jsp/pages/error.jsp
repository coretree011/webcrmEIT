<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
	<title>Insert title here</title>
	<link rel="stylesheet" href="../resources/jui-master/dist/ui.css" />
	<link rel="stylesheet" href="../resources/jui-master/dist/ui-jennifer.css" />
	<link rel="stylesheet" href="../resources/jui-master/dist/ui.min.css" />
	<link rel="stylesheet" href="../resources/jui-master/dist/grid.css" />
	<link rel="stylesheet" href="../resources/jui-master/dist/grid.min.css" />
	<link rel="stylesheet" href="../resources/jui-master/dist/grid-jennifer.css" />
	<link rel="stylesheet" href="../resources/jui-master/dist/grid-jennifer.min.css" />
</head>

<body class="jui">
<table style="width:100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
      <td><table  width="100%"  border="0" cellpadding="0" cellspacing="0">
        <tr>
          <td><div class="msgboxpop danger">
            <div class="head">
            <a href="#" class="close"><i class="icon-exit"></i></a>
              <table style="width:100%" border="0" align="center" cellpadding="0" cellspacing="0">
                <tr>
                  <td class="poptitle" style="background-image: url(../resource/jui-master/img/theme/jennifer/pop.png);" >ERROR</td>
                </tr>
              </table>
            </div>
            <div class="body">
            <table class="table01" border="0" cellpadding="0" cellspacing="0" width="100%">
                <tr>
                  <td><table width="450" border="0" cellspacing="0" cellpadding="0">
                    <tr>
                      <td width="190" height="180" align="center">
                      	<img src="<c:url value="../resources/jui-master/img/theme/jennifer/error.png" />" width="156" height="156">
                      </td>
                      <td width="260" height="180"><table border="0" cellspacing="0" cellpadding="0">
                        <tr>
                          <td height="35" class="error_title01">요청하신 페이지를 찾을 수 없습니다.<br></td>
                        </tr>
                        <tr>
                          <td align="center">서비스 이용에 불편을 드려 죄송합니다.</td>
                        </tr>
                        <tr>
                          <td height="40" align="center" valign="bottom"><a class="btn small focus">이전 페이지</a></td>
                        </tr>
                      </table></td>
                    </tr>
                  </table></td>
              </tr>
          </table></td>
        </tr>
            </table></td>
        </tr>
      </table>
</body>
</html>