/**
 * 
 */
jui.ready([ "ui.window"], function(win) {
	/*엑셀로 고객정보 저장*/
	win_1 = win("#win_1", {
		width : 1340,
		height : 610,
		//left : "1%",
		top : 10,
		resize : false,
		move : true
	});

	/*녹취 현황*/
	win_2 = win("#win_2", {
		width : 1117,
		height : 548,
		left : "8%",
		top : 50,
		resize : false,
		move : true
	});

	/*IVR 현황*/
	win_3 = win("#win_3", {
		width : 1117,
		height : 548,
		left : "8%",
		top : 50,
		resize : false,
		move : true
	});

	/*전체 통계현황*/
	win_4 = win("#win_4", {
		width : 1117,
		height : 548,
		left : "8%",
		top : 50,
		resize : false,
		move : true
	});

	/*상담원 통계 현황*/
	win_5 = win("#win_5", {
		width : 1117,
		height : 548,
		left : "8%",
		top : 50,
		resize : false,
		move : true
	});

	/*공지사항 조회*/
	win_6 = win("#win_6", {
		width : 1117,
		height : 548,
		left : "8%",
		top : 50,
		resize : false,
		move : true
	});

	/*공지사항 등록/수정*/
/*	win_7 = win("#win_7", {
		width : 1080,
		height : 243,
		left : "8%",
		top : 50,
		resize : false,
		move : true
	});*/
	
	

/*	공지사항 댓글관리
	win_8 = win("#win_8", {
		width : 1117,
		height : 555,
		left : "8%",
		top : 50,
		resize : false,
		move : true
	});
	*/


	/*상담원관리*/
	win_9 = win("#win_9", {
		width : 950,
		height : 548,
		left : "15%",
		top : 40,
		resize : false,
		move : true,
	});

	/*SMS 전송유형*/
	win_10 = win("#win_10", {
		width : 950,
		height : 548,
		left : "15%",
		top : 40,
		resize : false,
		move : true,
	});

	/*내선관리*/
	win_11 = win("#win_11", {
		width : 950,
		height : 548,
		left : "15%",
		top : 40,
		resize : false,
		move : true,

	});

	/*로그인*/
/*	win_12 = win("#win_12", {
		width : 337,
		height : 288,
		left : "8%",
		top : 50,
		resize : false,
		move : true
	});
*/
	/*고객정보선택*/
	win_13 = win("#win_13", {
		width : 1117,
		height : 548,
		left : "8%",
		top : 50,
		resize : false,
		move : true
	});

	/*SMS 전송 등록*/
	win_14 = win("#win_14", {
		width : 560,
		height : 245,
		left : "8%",
		top : 50,
		resize : false,
		move : true
	});
	
	/*SMS 전송 등록*/
	win_14_1 = win("#win_14_1", {
		width : 560,
		height : 450,
		left : "8%",
		top : 50,
		resize : false,
		move : true
	});

	/*공지사항 페이지에서 등록*/
/*	win_15 = win("#win_15", {
		width : 1080,
		height : 443,
		left : "8%",
		top : 50,
		resize : false,
		move : true,
		modal : true
	});*/
	
	/*공지사항 페이지에서 수정*/
	/*win_16 = win("#win_16", {
		width : 1080,
		height : 243,
		left : "8%",
		top : 50,
		resize : false,
		move : true, 
		modal : true
	});*/
	/*공지사항 조회 페이지에서 댓글관리*/
	win_17 = win("#win_17", {
		width : 1117,
		height : 555,
		left : "8%",
		top : 50,
		resize : false,
		move : true
	});
	
	/*비밀번호 변경*/
	win_12_1 = win("#win_12_1", {
		width : 337,
		height : 170,
		left : "40%",
		top : 140,
		resize : false,
		move : true
	});
	
	/*기타코드*/
	win_18 = win("#win_18", {
		width : 950,
		height : 548,
		left : "15%",
		top : 40,
		resize : false,
		move : true,
	});

});

jui.ready([ "ui.modal" ], function(modal) {
    win_15 = modal("#win_15", {
    	target : "#notice",
    	opacity: 0,
    	color: "black"
    });
    
    win_16 = modal("#win_16", {
    	target : "#notice",
    	opacity: 0,
    	color: "black"
    });
    
});
