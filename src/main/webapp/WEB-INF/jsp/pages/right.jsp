<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE HTML>
<html>
<head>
	<title>[JUI Library] - CSS/Tab</title>
<!-- 
	<link rel="stylesheet" href="../resources/jui-master/dist/ui.css">
	<link rel="stylesheet" href="../resources/jui-master/dist/ui-jennifer.css">
	<link rel="stylesheet" href="../resources/jui-master/dist/grid.css">
	<link rel="stylesheet" href="../resources/jui-master/dist/grid-jennifer.css" />	 -->
	
	<%@ include file = "../common/jui_common.jsp" %>
	
	<script src="../resources/js/jquery-2.2.4.min.js"></script>
	
	<!-- 우측 사이드 바 기능 활용을 위한 파일 -->
  	<link rel="stylesheet" href="../resources/css/jquery-ui.css" />
	<!-- <script src="../resources/js/jquery-1.10.2.js"></script> -->
  	<script src="../resources/js/jquery-ui.js"></script>
  	
    <script type="text/javascript">
    jui.ready([ "ui.combo" ], function(combo) {
    combo_1 = combo("#combo_1", {
        index: 2,
        event: {
            change: function(data) {
                alert("text(" + data.text + "), value(" + data.value + ")");
            	}
	        }
	    });
	});   
    </script>
    <script>
	var right_param = {
			empNo : "",
			empNm : "",
		};
    $(document).ready(function(){
		/* 우측 사이드바 기능 */
		$( "#rightSidr" ).click(function() {
			  $( "#sidr" ).toggle( "right" );
		});
		monitoringSearch();
    });

	jui.ready([ "grid.xtable"], function(xtable) {

		var data;
		var result_data;
		
		empState = xtable("#empState", {
			resize : true,
	        scrollHeight: 200,
	        event: {
	            colmenu: function(column, e) {
	                this.toggleColumnMenu(e.pageX - 25);
	            },
	        }
		});
		
			$.ajax({
				url : "/main/usersState",
				type : "post", 
				contentType : 'application/json; charset=utf-8',
				data : "",
				success : function(result) {
					if(result!=""){
						result_data = result;
						var jsonData = JSON.stringify(result);
						data = JSON.parse(jsonData);
						empState.update(result);
						empState.resize();
					}else{
						empState.reset();
					}
				}
			});
	});
	
	function monitoringSearch(){
		right_param.empNm = $("input[name=empNm]").val();
		$.ajax({
			url : "/main/monitoringList",
			type : "post",
			contentType : 'application/json; charset=utf-8',
			data : JSON.stringify(right_param),
			success : function(result) {
				if(result != ""){
					$("input[name=totIbCnt]").val(result.totIbCnt);
					$("input[name=totAgtConnCnt]").val(result.totAgtConnCnt);
					$("input[name=totAbanCnt]").val(result.totAbanCnt);
					$("input[name=totAgtIbCnt]").val(result.totAgtIbCnt);
					$("input[name=totAgtObCnt]").val(result.totAgtObCnt);
					$("input[name=agtIbCnt]").val(result.agtIbCnt);
					$("input[name=agtObCnt]").val(result.agtObCnt);
					$("input[name=totCbCnt]").val(result.totCbCnt);
					$("input[name=agtCbCnt]").val(result.agtCbCnt);
					$("input[name=totRevCnt]").val(result.totRevCnt);
					$("input[name=agtRevCnt]").val(result.agtRevCnt);
					$("input[name=totBbsCnt]").val(result.totBbsCnt);
				}
			}
		});	
	}
	
	function goTelnum(extNo){
		$("input[name=sp_telNo]").val(extNo);
	}
	</script>
<script data-jui="#empState" data-tpl="row" type="text/template">
	<tr ondblclick="javascript:goTelnum('<!= extensionNo !>');">
		<td align ="center"><!= extensionNo !></td>
		<td align ="center"><!= empNm !></td>
		<td align ="center" id="ext_<!= extensionNo !>_state"></td>
	</tr>
</script>
<script data-jui="#empState" data-tpl="none" type="text/template">
    <tr>
        <td colspan="3" class="none" align="center">데이터가 존재하지 않습니다.</td>
    </tr>
</script>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
</head>
<body class="jui">

<table width="250" border="0" cellpadding="0" cellspacing="0">
  <tr>
    <td width="20"><span class='icon icon-chevron-right' id="rightSidr" style="line-height:550px;font-size:20px;"></span></td>
    <div id="sidr">
    <td width="230"><table width="100%" border="0" cellpadding="0" cellspacing="0" class="table02">
      <tr>
        <td align="center" valign="top" ><table width="100%" border="0" align="center" cellpadding="0" cellspacing="0">
          <tr>
            <td><div class="body fit">
              <div class="panel">
                <div class="head"> <i class="icon-left"></i> <strong>인바운드 서비스상태</strong></div>
                <div class="body fit">
                  <table width="100%" border="0" cellspacing="0" cellpadding="0">
                    <tr>
                      <td height="2"></td>
                    </tr>
                  </table>
                  <table width="94%" border="0" align="center" cellpadding="0" cellspacing="0">
                    <tr>
                      <td width="23%" class="right_txt01">대기고객</td>
                      <td width="23%" class="right_txt01">총인입</td>
                      <td width="23%" class="right_txt01">상담원연결</td>
                      <td width="23%" class="right_txt01">포기</td>
                    </tr>
                    <tr>
                      <td class="rightinput mini"><input type="text" name="waitCnt" class="rightinput mini" value="0" style="width:45px" disabled="disabled"/></td>
                      <td class="right_td01"><input type="text" name="totIbCnt" class="rightinput mini" value="" style="width:45px" disabled="disabled"/></td>
                      <td class="right_td01"><input type="text" name="totAgtConnCnt" class="rightinput mini" value="" style="width:45px" disabled="disabled"/></td>
                      <td class="right_td01"><input type="text" name="totAbanCnt" class="rightinput mini" value="" style="width:45px" disabled="disabled"/></td>
                    </tr>
                    <tr>
                      <td height="7" colspan="4"></td>
                    </tr>
                  </table>
                </div>
              </div>
            </div>
              </div></td>
          </tr>
        </table>
          <table width="100%" border="0" cellspacing="0" cellpadding="0">
            <tr>
              <td height="4"></td>
            </tr>
          </table>
          <table width="100%" border="0" align="center" cellpadding="0" cellspacing="0">
            <tr>
              <td><div class="body fit">
                <div class="panel">
                <div class="head"> <i class="icon-left"></i> <strong>상담원 상태</strong></div>
                <div class="body fit">
                <table width="100%" border="0" cellspacing="0" cellpadding="0">
                  <tr>
                    <td height="4"></td>
                  </tr>
                </table>
                <table width="96%" border="0" align="center" cellpadding="0" cellspacing="0">
                  <tr>
                    <td class="right_txt" >전체</td>
                    <td class="right_td01"><input type="text" name="totEmp" class="rightinput mini" value="0" size="1" disabled="disabled" /></td>
                    <td class="right_txt">로그인</td>
                    <td class="right_td01"><input type="text" name="totLogin" class="rightinput mini" value="0" size="1" disabled="disabled" /></td>
                    <td class="right_txt">로그아웃</td>
                    <td class="right_td01"><input type="text" name="totLogout" class="rightinput mini" value="0" size="1" disabled="disabled" /></td>
                  </tr>
                  <tr>
                    <td class="right_txt">대기</td>
                    <td class="right_td01"><input type="text" name="totReady" class="rightinput mini" value="0" size="1" disabled="disabled" /></td>
                    <td class="right_txt">이석</td>
                    <td class="right_td01"><input type="text" name="totNotready" class="rightinput mini" value="0" size="1" disabled="disabled" /></td>
                    <td class="right_txt">통화중</td>
                    <td class="right_td01"><input type="text" name="totEstablish" class="rightinput mini" value="0" size="1" disabled="disabled" /></td>
                  </tr>
                  <tr>
                  <tr>
                    <td height="7" colspan="6"></td>
                  </tr>
                </table>
                <table width="100%" align="center" class="table classic hover" id="empState">
                  <thead>
                    <tr>
                      <th width="50px">내선번호</th>
                      <th width="50px">상담원</th>
                      <th width="auto">상태</th>
                    </tr>
                  </thead>
                  <tbody>
                  </tbody>
                </table>
				<br>
                </td>
            </tr>
          </table>
          <table width="100%" border="0" cellspacing="0" cellpadding="0">
            <tr>
              <td height="4"></td>
            </tr>
          </table>
          <table width="100%" border="0" align="center" cellpadding="0" cellspacing="0">
            <tr>
              <td><div class="body fit">
                <div class="panel">
                  <div class="head"> <i class="icon-left"></i> <strong>당일실적</strong></div>
                  <div class="body fit">
                    <table width="96%" border="0" align="center" cellpadding="0" cellspacing="0">
                      <tr>
                        <td width="18%" class="right_txt02">&nbsp;</td>
                        <td width="25%" class="right_txt02">인바운드</td>
                        <td width="25%" class="right_txt02">아웃바운드</td>
                        <td width="25%" class="right_txt02">콜백<br>
                          상담예약</td>
                      </tr>
                      <tr>
                        <td width="18%" class="right_txt"><%=session.getAttribute("empNm") %></td>
                        <td width="25%" class="right_td01"><input type="text" name="agtIbCnt" class="rightinput mini" value="" style="width:55px" disabled="disabled" /></td>
                        <td width="25%" class="right_td01"><input type="text" name="agtObCnt" class="rightinput mini" value="" style="width:55px" disabled="disabled" /></td>
                        <td width="25%" class="right_td01"><input type="text" name="agtCbCnt" class="rightinput mini" value="" style="width:55px" disabled="disabled" /></td>
                      </tr>
                      <tr>
                        <td width="18%" class="right_txt">전체</td>
                        <td width="25%" class="right_td01"><input type="text" name="totAgtIbCnt" class="rightinput mini" value="" style="width:55px" disabled="disabled" /></td>
                        <td width="25%" class="right_td01"><input type="text" name="totAgtObCnt" class="rightinput mini" value="" style="width:55px" disabled="disabled" /></td>
                        <td width="25%" class="right_td01"><input type="text" name="totCbCnt" class="rightinput mini" value="" style="width:55px" disabled="disabled" /></td>
                      </tr>
                      <tr>
                        <td width="18%" class="right_txt">공지</td>
                        <td width="25%" class="right_td01"><input type="text" name="totBbsCnt" class="rightinput mini" value="" style="width:55px" disabled="disabled" /></td>
                      </tr>
                      <tr>
                        <td height="4" colspan="4"></td>
                      </tr>
                    </table>
                  </div>
                </div>
              </div></td>
            </tr>
          </table>
          </span></td>
      </tr>
    </table></td>
  </tr>
</table>
</div>
</body>
</html>