function setYesterday(date)
{
    var selectDate = date.split("-");
    var changeDate = new Date();
    changeDate.setFullYear(selectDate[0], selectDate[1]-1, selectDate[2]-2);
    
    var y = changeDate.getFullYear();
    var m = changeDate.getMonth() + 1;
    var d = changeDate.getDate();
    if(m < 10)    { m = "0" + m; }
    if(d < 10)    { d = "0" + d; }
    
    var resultDate = y + "-" + m + "-" + d;
    return resultDate;
}
function setYesterday2(date)
{
	var selectDate = date.split("-");
	var changeDate = new Date();
	changeDate.setFullYear(selectDate[0], selectDate[1]-1, selectDate[2]-1);
	
	var y = changeDate.getFullYear();
	var m = changeDate.getMonth() + 1;
	var d = changeDate.getDate();
	if(m < 10)    { m = "0" + m; }
	if(d < 10)    { d = "0" + d; }
	
	var resultDate = y + "-" + m + "-" + d;
	return resultDate;
}

function regularExpCheck(str,format){
	var expression;
	var value = "";

	if(format == "phoneNum"){		//전화번호 형식
		expression = /^[0-9]{2,3}-[0-9]{3,4}-[0-9]{4}$/;
	}else if(format == "email"){	//이메일형식
		expression =  /^([\w-]+(?:\.[\w-]+)*)@((?:[\w-]+\.)*\w[\w-]{0,66})\.([a-z]{2,6}(?:\.[a-z]{2})?)$/;
	}else if(format == "num"){		//숫자만
		expression =  /^[0-9]+$/;
	}else if(format == "korean"){		//한글만
		expression =  /^[가-힣]+$/;
	}else if(format == "phoneNum"){	//영문만
		expression = /^[a-zA-Z]+$/;
	}else if(format == "time"){ // 시간
		expression = /^[0-9]{2}:[0-9]{2}$/;
	}
	value = expression.test(str);
	return value;
}


function OnCheckPhone(oTa) { 
var oForm = oTa.form ; 
var sMsg = oTa.value ; 
var onlynum = "" ; 
var imsi=0; 
onlynum = RemoveDash2(sMsg);  //하이픈 입력시 자동으로 삭제함 
onlynum = checkDigit(onlynum);  // 숫자만 입력받게 함
    var retValue = ""; 

if(event.keyCode != 12 ) { 
if(onlynum.substring(0,2) == 02) {  // 서울전화번호일 경우  10자리까지만 나타나교 그 이상의 자리수는 자동삭제 
if (GetMsgLen(onlynum) <= 1) oTa.value = onlynum ; 
if (GetMsgLen(onlynum) == 2) oTa.value = onlynum + "-"; 
if (GetMsgLen(onlynum) == 4) oTa.value = onlynum.substring(0,2) + "-" + onlynum.substring(2,3) ; 
if (GetMsgLen(onlynum) == 4) oTa.value = onlynum.substring(0,2) + "-" + onlynum.substring(2,4) ; 
if (GetMsgLen(onlynum) == 5) oTa.value = onlynum.substring(0,2) + "-" + onlynum.substring(2,5) ; 
if (GetMsgLen(onlynum) == 6) oTa.value = onlynum.substring(0,2) + "-" + onlynum.substring(2,6) ; 
if (GetMsgLen(onlynum) == 7) oTa.value = onlynum.substring(0,2) + "-" + onlynum.substring(2,5) + "-" + onlynum.substring(5,7) ; ; 
if (GetMsgLen(onlynum) == 8) oTa.value = onlynum.substring(0,2) + "-" + onlynum.substring(2,6) + "-" + onlynum.substring(6,8) ; 
if (GetMsgLen(onlynum) == 9) oTa.value = onlynum.substring(0,2) + "-" + onlynum.substring(2,5) + "-" + onlynum.substring(5,9) ; 
if (GetMsgLen(onlynum) == 10) oTa.value = onlynum.substring(0,2) + "-" + onlynum.substring(2,6) + "-" + onlynum.substring(6,10) ; 
if (GetMsgLen(onlynum) == 11) oTa.value = onlynum.substring(0,2) + "-" + onlynum.substring(2,6) + "-" + onlynum.substring(6,10) ; 
if (GetMsgLen(onlynum) == 12) oTa.value = onlynum.substring(0,2) + "-" + onlynum.substring(2,6) + "-" + onlynum.substring(6,10) ; 
} 
if(onlynum.substring(0,2) == 05 ) {  // 05로 시작되는 번호 체크 
if(onlynum.substring(2,3) == 0 ) {  // 050으로 시작되는지 따지기 위한 조건문 
if (GetMsgLen(onlynum) <= 3) oTa.value = onlynum ; 
if (GetMsgLen(onlynum) == 4) oTa.value = onlynum + "-"; 
if (GetMsgLen(onlynum) == 5) oTa.value = onlynum.substring(0,4) + "-" + onlynum.substring(4,5) ; 
if (GetMsgLen(onlynum) == 6) oTa.value = onlynum.substring(0,4) + "-" + onlynum.substring(4,6) ; 
if (GetMsgLen(onlynum) == 7) oTa.value = onlynum.substring(0,4) + "-" + onlynum.substring(4,7) ; 
if (GetMsgLen(onlynum) == 8) oTa.value = onlynum.substring(0,4) + "-" + onlynum.substring(4,8) ; 
if (GetMsgLen(onlynum) == 9) oTa.value = onlynum.substring(0,4) + "-" + onlynum.substring(4,7) + "-" + onlynum.substring(7,9) ; ; 
if (GetMsgLen(onlynum) == 10) oTa.value = onlynum.substring(0,4) + "-" + onlynum.substring(4,8) + "-" + onlynum.substring(8,10) ; 
if (GetMsgLen(onlynum) == 11) oTa.value = onlynum.substring(0,4) + "-" + onlynum.substring(4,7) + "-" + onlynum.substring(7,11) ; 
if (GetMsgLen(onlynum) == 12) oTa.value = onlynum.substring(0,4) + "-" + onlynum.substring(4,8) + "-" + onlynum.substring(8,12) ; 
if (GetMsgLen(onlynum) == 13) oTa.value = onlynum.substring(0,4) + "-" + onlynum.substring(4,8) + "-" + onlynum.substring(8,12) ; 
          } else { 
if (GetMsgLen(onlynum) <= 2) oTa.value = onlynum ; 
if (GetMsgLen(onlynum) == 3) oTa.value = onlynum + "-"; 
if (GetMsgLen(onlynum) == 4) oTa.value = onlynum.substring(0,3) + "-" + onlynum.substring(3,4) ; 
if (GetMsgLen(onlynum) == 5) oTa.value = onlynum.substring(0,3) + "-" + onlynum.substring(3,5) ; 
if (GetMsgLen(onlynum) == 6) oTa.value = onlynum.substring(0,3) + "-" + onlynum.substring(3,6) ; 
if (GetMsgLen(onlynum) == 7) oTa.value = onlynum.substring(0,3) + "-" + onlynum.substring(3,7) ; 
if (GetMsgLen(onlynum) == 8) oTa.value = onlynum.substring(0,3) + "-" + onlynum.substring(3,6) + "-" + onlynum.substring(6,8) ; ; 
if (GetMsgLen(onlynum) == 9) oTa.value = onlynum.substring(0,3) + "-" + onlynum.substring(3,7) + "-" + onlynum.substring(7,9) ; 
if (GetMsgLen(onlynum) == 10) oTa.value = onlynum.substring(0,3) + "-" + onlynum.substring(3,6) + "-" + onlynum.substring(6,10) ; 
if (GetMsgLen(onlynum) == 11) oTa.value = onlynum.substring(0,3) + "-" + onlynum.substring(3,7) + "-" + onlynum.substring(7,11) ; 
if (GetMsgLen(onlynum) == 12) oTa.value = onlynum.substring(0,3) + "-" + onlynum.substring(3,7) + "-" + onlynum.substring(7,11) ; 
          } 
} 

if(onlynum.substring(0,2) == 03 || onlynum.substring(0,2) == 04  || onlynum.substring(0,2) == 06  || onlynum.substring(0,2) == 07  || onlynum.substring(0,2) == 08 ) {  // 서울전화번호가 아닌 번호일 경우(070,080포함 // 050번호가 문제군요) 
if (GetMsgLen(onlynum) <= 2) oTa.value = onlynum ; 
if (GetMsgLen(onlynum) == 3) oTa.value = onlynum + "-"; 
if (GetMsgLen(onlynum) == 4) oTa.value = onlynum.substring(0,3) + "-" + onlynum.substring(3,4) ; 
if (GetMsgLen(onlynum) == 5) oTa.value = onlynum.substring(0,3) + "-" + onlynum.substring(3,5) ; 
if (GetMsgLen(onlynum) == 6) oTa.value = onlynum.substring(0,3) + "-" + onlynum.substring(3,6) ; 
if (GetMsgLen(onlynum) == 7) oTa.value = onlynum.substring(0,3) + "-" + onlynum.substring(3,7) ; 
if (GetMsgLen(onlynum) == 8) oTa.value = onlynum.substring(0,3) + "-" + onlynum.substring(3,6) + "-" + onlynum.substring(6,8) ; ; 
if (GetMsgLen(onlynum) == 9) oTa.value = onlynum.substring(0,3) + "-" + onlynum.substring(3,7) + "-" + onlynum.substring(7,9) ; 
if (GetMsgLen(onlynum) == 10) oTa.value = onlynum.substring(0,3) + "-" + onlynum.substring(3,6) + "-" + onlynum.substring(6,10) ; 
if (GetMsgLen(onlynum) == 11) oTa.value = onlynum.substring(0,3) + "-" + onlynum.substring(3,7) + "-" + onlynum.substring(7,11) ; 
if (GetMsgLen(onlynum) == 12) oTa.value = onlynum.substring(0,3) + "-" + onlynum.substring(3,7) + "-" + onlynum.substring(7,11) ; 

} 
if(onlynum.substring(0,2) == 01) {  //휴대폰일 경우 
if (GetMsgLen(onlynum) <= 2) oTa.value = onlynum ; 
if (GetMsgLen(onlynum) == 3) oTa.value = onlynum + "-"; 
if (GetMsgLen(onlynum) == 4) oTa.value = onlynum.substring(0,3) + "-" + onlynum.substring(3,4) ; 
if (GetMsgLen(onlynum) == 5) oTa.value = onlynum.substring(0,3) + "-" + onlynum.substring(3,5) ; 
if (GetMsgLen(onlynum) == 6) oTa.value = onlynum.substring(0,3) + "-" + onlynum.substring(3,6) ; 
if (GetMsgLen(onlynum) == 7) oTa.value = onlynum.substring(0,3) + "-" + onlynum.substring(3,7) ; 
if (GetMsgLen(onlynum) == 8) oTa.value = onlynum.substring(0,3) + "-" + onlynum.substring(3,7) + "-" + onlynum.substring(7,8) ; 
if (GetMsgLen(onlynum) == 9) oTa.value = onlynum.substring(0,3) + "-" + onlynum.substring(3,7) + "-" + onlynum.substring(7,9) ; 
if (GetMsgLen(onlynum) == 10) oTa.value = onlynum.substring(0,3) + "-" + onlynum.substring(3,6) + "-" + onlynum.substring(6,10) ; 
if (GetMsgLen(onlynum) == 11) oTa.value = onlynum.substring(0,3) + "-" + onlynum.substring(3,7) + "-" + onlynum.substring(7,11) ; 
if (GetMsgLen(onlynum) == 12) oTa.value = onlynum.substring(0,3) + "-" + onlynum.substring(3,7) + "-" + onlynum.substring(7,11) ; 
} 

if(onlynum.substring(0,1) == 1) {  // 1588, 1688등의 번호일 경우 
if (GetMsgLen(onlynum) <= 3) oTa.value = onlynum ; 
if (GetMsgLen(onlynum) == 4) oTa.value = onlynum + "-"; 
if (GetMsgLen(onlynum) == 5) oTa.value = onlynum.substring(0,4) + "-" + onlynum.substring(4,5) ; 
if (GetMsgLen(onlynum) == 6) oTa.value = onlynum.substring(0,4) + "-" + onlynum.substring(4,6) ; 
if (GetMsgLen(onlynum) == 7) oTa.value = onlynum.substring(0,4) + "-" + onlynum.substring(4,7) ; 
if (GetMsgLen(onlynum) == 8) oTa.value = onlynum.substring(0,4) + "-" + onlynum.substring(4,8) ; 
if (GetMsgLen(onlynum) == 9) oTa.value = onlynum.substring(0,4) + "-" + onlynum.substring(4,8) ; 
if (GetMsgLen(onlynum) == 10) oTa.value = onlynum.substring(0,4) + "-" + onlynum.substring(4,8) ; 
if (GetMsgLen(onlynum) == 11) oTa.value = onlynum.substring(0,4) + "-" + onlynum.substring(4,8) ; 
if (GetMsgLen(onlynum) == 12) oTa.value = onlynum.substring(0,4) + "-" + onlynum.substring(4,8) ; 
} 
} 
} 

function RemoveDash2(sNo) { 
var reNo = "" 
for(var i=0; i<sNo.length; i++) { 
if ( sNo.charAt(i) != "-" ) { 
reNo += sNo.charAt(i) 
} 
} 
return reNo 
} 

function GetMsgLen(sMsg) { // 0-127 1byte, 128~ 2byte 
var count = 0 
for(var i=0; i<sMsg.length; i++) { 
if ( sMsg.charCodeAt(i) > 127 ) { 
count += 2 
} 
else { 
count++ 
} 
} 
return count 
} 

function checkDigit(num) { 
    var Digit = "1234567890"; 
    var string = num; 
    var len = string.length;
    var retVal = ""; 

    for (i = 0; i < len; i++) 
    { 
        if (Digit.indexOf(string.substring(i, i+1)) >= 0) 
        { 
            retVal = retVal + string.substring(i, i+1);
        } 
    } 
    return retVal; 
} 

/**
 * 문자열의 바이트수 리턴
 * @returns {Number}
 */
String.prototype.byteLength = function() {
    var l= 0;
     
    for(var idx=0; idx < this.length; idx++) {
        var c = escape(this.charAt(idx));
         
        if( c.length==1 ) l ++;
        else if( c.indexOf("%u")!=-1 ) l += 2;
        else if( c.indexOf("%")!=-1 ) l += c.length/3;
    }
     
    return l;
}; 

function byteCheck(commet,byteChk,byteChkWarn){
	document.getElementById(byteChk).innerHTML = commet.byteLength();
	
	if(commet.byteLength() > 90){
		document.getElementById(byteChkWarn).innerHTML = 'SMS 전송내용이 90byte가 넘었습니다.';
		document.getElementById(byteChkWarn).style.color = "red";
		document.getElementById(byteChk).style.fontWeight = "800";
	}else if(commet.byteLength() <= 90){
		document.getElementById(byteChkWarn).innerHTML = '&nbsp;';
		document.getElementById(byteChk).style.fontWeight = "100";
	}
}