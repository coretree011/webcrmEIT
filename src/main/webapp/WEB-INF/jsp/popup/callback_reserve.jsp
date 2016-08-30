<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>

<script type="text/javascript">
var popup_Customer = {
		telNo : "",
		custNm : "",
		custNo : "",
	};

	$(document).ready(function() {
		
		jui.ready([ "grid.xtable"], function(xtable) {

			var data;
			var data_size;
			var page = 1;
			var result_data;
			
			tab_customerListPopup = xtable("#tab_customerListPopup", {
				 //scroll : true,  
				resize : true,
				scrollHeight: 400,
		        buffer: "s-page",
		        bufferCount: 20,
			});
			
			paging_1 = function(no) {
		        page += no;
		        page = (page < 1) ? 1 : page;
		        tab_customerListPopup.page(page);
		    }

			});
		});
	
	function popCustomerList(){
		popup_Customer.telNo = $("input[name=tab2_telNo]").val();
		popup_Customer.custNm = $("input[name=tab2_custNm]").val();
		popup_Customer.custNo = "";
		
		$.ajax({
			url : "/main/customerList",
			type : "post", 
			contentType : 'application/json; charset=utf-8',
			data : JSON.stringify(popup_Customer),
			success : function(result) {
					page=1;
					tab_customerListPopup.update(result);
					tab_customerListPopup.resize();
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
		<td align ="center"><!= parseInt(row.index)+1 !></td>
		<td align ="center"><!= custNo !></td>
		<td><!= custNm !></td>
		<td><!= tel1No !></td>
		<td><!= tel2No !></td>
		<td><!= tel3No !></td>
		<td><!= emailId !></td>
		<td><!= addr !></td>
		<td><!= custNote !></td>
	</tr>
</script>

<script data-jui="#tab_customerListPopup" data-tpl="none" type="text/template">
    <tr height ="400">
        <td colspan="9" class="none" align="center">데이터가 존재하지 않습니다.</td>
    </tr>
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
				<th>SEQ</th>
				<th>고객번호</th>
				<th>고객명</th>
				<th>핸드폰</th>
				<th>직장</th>
				<th>자택</th>
				<th>eMail</th>
				<th>주소</th>
				<th>비고</th>
			</tr>
		</thead>
		<tbody>
		</tbody>
	</table>
	<br>
	<div class="row" align="right" style="text-align: right; margin-top: 3px;">
	    <div class="group">
	        <button onclick="paging_1(-1);" class="btn mini">이전</button>
	        <button onclick="paging_1(1);" class="btn mini">다음</button>
	    </div>
	</div>
</div>