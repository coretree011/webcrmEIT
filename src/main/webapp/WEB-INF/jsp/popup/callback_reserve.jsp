<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>

<script type="text/javascript">
var popup_Customer = {
		telNo : "",
		custNm : "",
		custNo : "",
	};

	$(document).ready(function() {
		
		jui.ready([ "grid.xtable","ui.paging"], function(xtable, paging) {

			var data;
			var data_size;
			var page = 1;
			var result_data;
			
			tab_customerListPopup = xtable("#tab_customerListPopup", {
				 //scroll : true,  
				resize : true,
				scrollHeight: 400,
				scrollWidth: 1095,
				width:1900,
		        buffer: "s-page",
		        bufferCount: 500,
			});

			paging_customerListPop = paging("#paging_customerListPop", {
			      pageCount: 500,
			      event: {
			          page: function(pNo) {
			        	  tab_customerListPopup.page(pNo);
			          }
			       },
			       tpl: {
			           pages: $("#paging_customerListPop").html()
			       }
			});

			});
		});
	
	function popCustomerList(){
		popup_Customer.telNo = $("input[name=tab2_telNo]").val();
		popup_Customer.custNm = $("input[name=tab2_custNm]").val();
		popup_Customer.custNo = "";
		popup_Customer.regDate = "";
		
		$.ajax({
			url : "/main/customerList",
			type : "post", 
			contentType : 'application/json; charset=utf-8',
			data : JSON.stringify(popup_Customer),
			success : function(result) {
					page=1;
					tab_customerListPopup.update(result);
					tab_customerListPopup.resize();

					paging_customerListPop.reload(tab_customerListPopup.count());
			}
		});
	}
	
	function popCustomer_one(custNo){
		popup_Customer.custNo = custNo;
		$.ajax({
			url : "/main/customerOne",
			type : "post",
			contentType : 'application/json; charset=utf-8',
			data : JSON.stringify(popup_Customer),
			success : function(result) {
				if(result != ""){
					$("input[name=custNo]").val(result.custNo);
					$("input[name=tab5_custNo]").val(result.custNo);
					$("input[name=tab6_custNo]").val(result.custNo);
					$("input[name=custNm]").val(result.custNm);
					$("#custCd").val(result.custCd);
					$("input[name=addr]").val(result.addr);
					$("input[name=tel1No]").val(result.tel1No);
					$("input[name=tab1_resTelNo]").val(result.tel1No);
					$("input[name=tel2No]").val(result.tel2No);
					$("input[name=tel3No]").val(result.tel3No);
					$("input[name=faxNo]").val(result.faxNo);
					$("input[name=emailId]").val(result.emailId);
					$("input[name=custNote]").val(result.custNote);
				}
				$("#counSearch").click();
				$("#smsSearch").click();
				counReset();
				reservReset();
				$("#click_tab1").click();
				$("#win_13").hide();
			}
		});		
	}
</script>

<script data-jui="#tab_customerListPopup" data-tpl="row" type="text/template">
	<tr ondblclick="javascript:popCustomer_one(<!= custNo !>);">
		<td align ="center"><!= num !></td>
		<td align ="center"><!= custNo !></td>
		<td align ="center"><!= custNm !></td>
		<td align ="center"><!= tel1No !></td>
		<td align ="center"><!= tel2No !></td>
		<td align ="center"><!= tel3No !></td>
		<td align ="left"><!= emailId !></td>
		<td align ="left"><!= addr !></td>
		<td align ="center"><!= coRegNo !></td>
		<td align ="center"><!= lastCounDate !></td>
		<td align ="center"><!= gradeNm !></td>
		<td align ="center"><!= custTypNm !></td>
		<td align ="center"><!= recogTypNm !></td>
		<td align ="center"><!= sexNm !></td>
		<td align ="center"><!= birthDate !></td>
		<td align ="center"><!= regDate !></td>
		<td align ="left"><!= custNote !></td>
	</tr>
</script>

<script data-jui="#tab_customerListPopup" data-tpl="none" type="text/template">
    <tr height ="400">
        <td colspan="19" class="none" align="center">데이터가 존재하지 않습니다.</td>
    </tr>
</script>

<script id="paging_customerListPop" type="text/template">
    <! for(var i = 0; i < pages.length; i++) { !>
    <a href="#" class="page"><!= pages[i] !></a>
    <! } !>
</script>

<div class="head">
	<a href="#" class="close"><i class="icon-exit"></i></a>
	<table width="100%" border="0" align="center" cellpadding="0" cellspacing="0">
		<tr>
			<td class="poptitle" style="background-image: url(../resources/jui-master/img/theme/jennifer/pop.png);">
				고객정보선택
			</td>
		</tr>
	</table>
</div>
<div class="body">
	<table class="table classic hover" id="tab_customerListPopup" width="100%">
		<thead>
			<tr>
				<th style="width: 30px;">SEQ</th>
				<th style="width: 70px;">고객번호</th>
				<th style="width: 100px;">고객명</th>
				<th style="width: 88px;">핸드폰</th>
				<th style="width: 88px;">직장</th>
				<th style="width: 88px;">자택</th>
				<th style="width: 120px;">eMail</th>
				<th style="width: 190px;">주소</th>
				<th style="width: 80px;">사업자번호</th>
				<th style="width: 75px;">최종상담일</th>
				<th style="width: 80px;">고객등급</th>
				<th style="width: 80px;">고객유형</th>
				<th style="width: 80px;">인지경로</th>
				<th style="width: 25px;">성별</th>
				<th style="width: 75px;">생년월일</th>
				<th style="width: 75px;">등록일</th>
				<th style="width: auto;">비고</th>
			</tr>
		</thead>
		<tbody>
		</tbody>
	</table>
	<br>
	<div id="paging_customerListPop" class="paging" style="margin-top: 3px;">
	    <a href="#" class="prev" style="left:0">이전</a>
	    <div class="list"></div>
	    <a href="#" class="next">다음</a>
	</div>
</div>