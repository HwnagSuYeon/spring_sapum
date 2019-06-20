var joinValidate = {
	//결과 메시지 출력시 사용하는 text
	resultCode: {
		
		//모든 유효성 검사에 들어가는 공통 출력문
		//desc->디스크립션 약자. 상세설명문이라 생각하면 된다.
		empty_val : {
			code: 1,
			desc : '필수입력 정보입니다'
		},
		space_length_val: {
			code: 2,
			desc : '공백 없이 입력해 주세요'
		},
		
		// 아이디 유효성 출력문
		success_id:{
			code: 0,
			desc: '멋진 ID에요!'
		},
		invalid_id: {
			code: 3,
			desc: '올바른 ID를 입력해주세요'
		},
		length_id: {
			code: 4,
			desc: '아이디는 6자~50자 이내로 입력해주세요'
		},
		overlap_id: {
			code: 5,
			desc: '이미 사용중인 ID 입니다'
		},
		
		// 패스워드 유효성 출력문
		success_pw: {
			code: 0,
			desc: '사용가능한 비밀번호입니다'
		},
		invalid_pw: {
			code: 3,
			desc: '올바른 비밀번호(4자~12자)를 입력해주세요'
		},
		other_pw: {
			code: 4,
			desc: '입력하신 비밀번호가 일치하지 않습니다'
		},
		
		
		// 이름 유효성 출력문
		success_name:{
			code: 0,
			desc: '멋진 이름이에요!'
		},
		invalid_name: {
			code: 3,
			desc: '이름은 표준 한글만 입력가능합니다'
		},
		length_name: {
			code: 4,
			desc: '이름은 2자 이상~ 4자 이하로 써주세요'
		},
		
		
		// 핸드폰 번호 유효성 출력문
		success_phone: {
			code: 0,
			desc: '사용가능한 번호입니다'
		},
		invalid_phone: {
			code: 3,
			desc: '휴대폰 번호가 유효하지 않습니다'
		},
		number_phone: {
			code: 4,
			desc: '숫자만 입력해주세요'
		},
		length_phone:{
			code: 5,
			desc: '(-)없이 10~11자로 입력해주세요'
		},
		
	},
	
	// 실제 유효성 체크하는 기능
	checkId: function(memId) {
		var regEmpty = /\s/g; //공백문자 정규식
		var regEmail = /^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*.[a-zA-Z]{2,3}$/i; // 이메일이 적합한지 검사할 정규식
		//id => 1.null 2.정규식 3.중복체크
		
		// 4. join.jsp에서 전달한 매개변수 memId로 유효성체크 시작
		// Null값 체크					if
		// 값 사이의 공백값 체크 			else if
		// 유효한 값인지 체크(정규식) 		else if
		// 6자~50자 이내 길이 체크 			else if
		// 성공: 유효한 값 				else -> 중복유무체크 X
		if(memId==""|| memId.length == 0){
			return this.resultCode.empty_val;
		} else if (memId.match(regEmpty)) {
			return this.resultCode.space_length_val;
		} else if (!regEmail.test(memId)) {
			return this.resultCode.invalid_id;
		} else if (memId.length < 6 || memId.length > 50) {
			return this.resultCode.length_id;
		} else {
			// 5. 입력받은 값이 위의 유효성체크 네 단계를 통과(유효한 값이나, DB로부터 중복되었는지 확인X)
			// 6. return 결과값으로 success_id(code,desc)를 호출한 곳으로 전송!(전송하는 데이터->code:0, desc:'멋진아이디네요!')
			return this.resultCode.success_id;
		}
	},
	checkPw: function(memPw, memRpw) {
		var regEmpty = /\s/g; //공백문자 정규식
		var pwReg = RegExp(/^[a-zA-Z0-9]{4,12}$/); //비밀번호 정규식
		
		if(memPw==""|| memPw.length == 0){
			return this.resultCode.empty_val;
		} else if (memPw.match(regEmpty)) {
			return this.resultCode.space_length_val;
		}  else if (!pwReg.test(memPw)) {
			return this.resultCode.invalid_pw;
		} else {
			return this.resultCode.success_pw;
		}
	},
	checkRpw: function(mempw, memRpw) {
		var regEmpty = /\s/g; //공백문자 정규식
		var pwReg = RegExp(/^[a-zA-Z0-9]{4,12}$/); //비밀번호 정규식
		
		if(memRpw==""|| memRpw.length == 0){
			return this.resultCode.empty_val;
		} else if (memRpw.match(regEmpty)) {
			return this.resultCode.space_length_val;
		}  else if (!pwReg.test(memRpw)) {
			return this.resultCode.invalid_pw;
		} else {
			return this.resultCode.success_pw;
		}
	},
	checkName: function(name) {
		var regEmpty = /\s/g; //공백문자 정규식
		var nameReg = /[^가-힣]/; // 한글문자 정규식
		
		if(memRpw==""|| memRpw.length == 0){
			return this.resultCode.empty_val;
		} else if (name.match(regEmpty)) {
			return this.resultCode.space_length_val;
		}  else if (!pwReg.test(name)) {
			return this.resultCode.invalid_name;
		} else if (name.length > 4 || name.length < 2) {
			return this.resultCode.length_name;
		} else {
			return this.resultCode.success_name;
		}
		
	}
}




// ID중복체크 Ajax
function ajaxCheck(memId){
	//10. ajax시작!
	//	  목적지: idCheck.one
	//	  전달데이터: memId 데이터를 id변수에 담아 전달
	//	  데이터 포장방법: json
	//	  데이터 전달방법: POST방식
	//	  결론: web.xml로 이동!
	$.ajax({
		url: "idCheck?memId="+memId,
		// 아이디가 중복된 아이디인지 아닌지 판단하는 역할(Action)
		type: "POST",
		// 포장한 데이터를 어떤 운송수단(어떻게 보낼지)으로 태워 보낼지 정하는 것이 타입.
		// 데이터는 id라는 이름을 붙여서 보냄. 쿼리스트링처럼 보내는 것을 나눠서 적은 것과 같다.
		success: function(data){
			console.log(data);
			// 29. Action단에서 전송한 message, id를 data매개변수로 받음
			// 30. data.message의 값이 -1이면 -> 중복메시지 출력
			// 	   data.message의 값이 1 이면 -> 사용가능 메시지 출력
			// url에서 성공시 매개변수로 data를 받아와서 검사해주는 기능
			if(data == 1){
				$(".err_msg").eq(0).text("이미 사용중인 아이디 입니다.")
									.css("display","block")
									.css("color","tomato")
									.css("text-align","right");
				return "-1";
			} else {
				$(".err_msg").eq(0).text("멋진 아이디네요!")
							 .css("display","block")
				 			 .css("color","dodgerblue")
				 			 .css("text-align","right");
				return "1";
			}
		},
		error: function(){
			alert("System Error!");
		}
	});
}



function ajaxPwCheck(nowId, nowPw) {
	var return_val = false;
	$.ajax({
		url: 'pwcheck?id='+nowId+'&pw='+nowPw,
		type: 'POST',
		dataType: 'text',
		async: false,
		success: function (data) {
			console.log(data);
			if(data == "1") {
				$("#pwAjax").text("유저 정보와 비밀번호가 일치합니다")
							   .css("display","block")
				 			   .css("color","dodgerblue")
				 			   .css("text-align","right");
				return_val = true;
			} else {
				$("#pwAjax").text("유저 정보와 비밀번호가 일치하지 않습니다")
				   .css("display","block")
	 			   .css("color","tomato")
	 			   .css("text-align","right");
				return_val = false;
			}
		},
		error: function () {
			alert("validation >>> system error!");
		}
	});
	return return_val;
}



