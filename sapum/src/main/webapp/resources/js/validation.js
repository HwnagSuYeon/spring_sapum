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
		
		// email 유효성 출력문
		success_email:{
			code: 0,
			desc: '사용 가능한 메일주소입니다'
		},
		invalid_email: {
			code: 3,
			desc: '올바른 이메일 주소를 입력해주세요'
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
		leng_phone:{
			code: 6,
			desc: '8~11자리의 올바른 번호를 입력해 주세요'
		},
	},
	
	// 실제 유효성 체크하는 기능
	checkId: function(memId) {
		var regEmpty = /\s/g; //공백문자 정규식
		var reg = /[^a-z0-9-_.]+/g; // 올바른 아이디 형식

		if(memId==""|| memId.length == 0){
			return this.resultCode.empty_val;
		} else if (memId.match(regEmpty)) {
			return this.resultCode.space_length_val;
		} else if (reg.test(memId)) {
			return this.resultCode.invalid_id;
		} else if (memId.length < 6 || memId.length > 50) {
			return this.resultCode.length_id;
		} else {
			return this.resultCode.success_id;
		}
	},
	checkEmail: function(memEmail) {
		var regEmpty = /\s/g; //공백문자 정규식
		var regEmail = /^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*.[a-zA-Z]{2,3}$/i; // 이메일이 적합한지 검사할 정규식

		if(memEmail==""|| memEmail.length == 0){
			return this.resultCode.empty_val;
		} else if (memEmail.match(regEmpty)) {
			return this.resultCode.space_length_val;
		} else if (!regEmail.test(memEmail)) {
			return this.resultCode.invalid_email;
		} else {
			return this.resultCode.success_email;
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
		var nameReg = /^[가-힣]+$/; // 한글문자 정규식
		
		if(name==""|| name.length == 0){
			return this.resultCode.empty_val;
		} else if (name.match(regEmpty)) {
			return this.resultCode.space_length_val;
		}  else if (!nameReg.test(name)) {
			return this.resultCode.invalid_name;
		} else if (name.length > 4 || name.length < 2) {
			return this.resultCode.length_name;
		} else {
			return this.resultCode.success_name;
		}
	},
	checkPhone: function(phone) {
		var regEmpty = /\s/g; //공백문자 정규식
		var regPhone = RegExp(/^[0-9]{8,11}$/);  //핸드폰번호  정규식
		
		if(phone ==""|| phone.length == 0){
			return this.resultCode.empty_val;
		} else if (phone.match(regEmpty)) {
			return this.resultCode.space_length_val;
		} else if ($.isNumeric(phone)==false) {
			return this.resultCode.number_phone;
		} else if(phone.indexOf("01") !=0) { 
			return this.resultCode.invalid_phone
		} else if (!(phone.length == 10 || phone.length == 11)) {
			return this.resultCode.length_phone
		} else if (!regPhone.test(phone)) {
			return this.resultCode.leng_phone
		} else {
			return this.resultCode.success_phone
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
		type: "POST",
		success: function(data){
			console.log(data);
			
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



