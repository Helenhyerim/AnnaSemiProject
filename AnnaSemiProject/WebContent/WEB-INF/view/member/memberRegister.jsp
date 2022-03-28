<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
    String ctxPath = request.getContextPath();
%>
    
<style type = "text/css">
<%-- 아이디, 비밀번호, 등 표시해주는 글씨 색과 크기 조정해주는곳 --%>
.item , #tblMemberRegister > thead > tr > th{
	color:#888;
	font-size: x-small;
	font-weight: bold;
}
<%-- 필수 입력칸이 비어있을 때, 경고메시지를 위한 자리를 만들기위해 높이조절을 해주는 곳--%>
#tblMemberRegister > tbody > tr > td.data{
	
	height: 50px;

}
<%-- input칸의 넓이 설정해주는 곳 --%>
#tblMemberRegister > tbody > tr > td.data > input {
	height: 30px;
	width: 100%;
}
span.error{
	padding-left: 0;
}


</style>    

    
<jsp:include page="../common/header_login.jsp"></jsp:include>
<%-- 헤더시작 --%>
<script type="text/javascript" src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script type="text/javascript">

let b_flag_IsIdDuplicatCheck = false;
let b_flag_IsEmailDuplicatCheck = false;

$(document).ready(function(){
	
	$("span.error").hide();

	// 아이디 입력관련 시작 ***********************************************************************
	
	// 아이디가 userid 인 것은 포커스를 잃어버렸을 경우(blur) 이벤트를 처리해주는 것이다.   중복검사까지  
	$("input#userid").blur( ()=>{
	  
		const $target = $(event.target);
		  
	    const userid = $target.val().trim();
	    
		if(userid == "") {
			// 입력하지 않거나 공백만 입력했을 경우 필수입력이라고 알려준다.
			$target.parent().find(".error").show();
		}
		else {
		 	// 공백이 아닌 글자를 입력했을 경우 에러란을 다시 숨겨준뒤 자동으로 아이디가 중복되었는지 확인하러간다.
			   $target.parent().find(".error").hide();
		 	
			   $.ajax({
	     	      url:"<%= ctxPath%>/member/idDuplicateCheck.an",
	     	      data:{"userid":$("input#userid").val()}, 
	     	      type:"post",  // type 은 생략하면 "get" 이다.
	     	  //  async:false,  // 동기처리(지도는 동기처리로 해야 한다)
	     	      async:true,   // 비동기처리(기본값임)
	     	      success:function(text){
	     	    
	   	    	  const json = JSON.parse(text);
	   	    	 
	   	    	  if(json.isExist) {
	   	    		  // 입력한 $("input#userid").val() 값이 이미 사용중이라면 
	   	    		  $("span#idcheckResult").html($("input#userid").val()+" 은 이미 사용중인 아이디입니다.").css("color","red");
	   	    		  b_flag_IsIdDuplicatCheck = true;
	   	    	  }
	   	    	  else{
	   	    		b_flag_IsIdDuplicatCheck = false;
	   	    	  }
	   	      },
	   	      error:function(request, status, error){
	   	    	  alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
	   	      }
	       });
		}
		  
	  }); // end of $("input#userid").blur( ()=>{});+++++++++++++++++++++++++++++++++++++++++ 아이디 중복검사와 아이디 입력확인 해주는 함수 끝
  
  
	  // 아이디를입력칸으로 다시 올라가면 중복되었다는 경고와 필수입력 이라는 것을 숨겨준다
	  $("input#userid").focus( ()=>{
		  const $target = $(event.target);
		 
		  $target.parent().find(".error").hide();
		  $("span#idcheckResult").html("");
	  });
	  // 아이디 입력관련 끝 ***********************************************************************
      
	  // 이메일 입력관련 시작 ***********************************************************************
	  
	  // 아이디가 email 인 것은 포커스를 잃어버렸을 경우(blur) 이벤트를 처리해주는 것이다.   중복검사까지  
	  $("input#email").blur( ()=>{
	  
		  const $target = $(event.target);
		  
		  const regExp = new RegExp(/^[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*\.[a-zA-Z]{2,3}$/i); 
		  // 이메일 정규표현식 객체 생성
		
		  const bool = regExp.test($target.val());   
	    
		  if(!bool) {
			  // 입력하지 않거나 공백만 입력했을 경우 필수입력이라고 알려준다.
			  $target.parent().find(".error").show();
		  }
		  else {
		 	   // 공백이 아닌 글자를 입력했을 경우 에러란을 다시 숨겨준뒤 자동으로 아이디가 중복되었는지 확인하러간다.
			   $target.parent().find(".error").hide();
		 	
			   $.ajax({
	     	      url:"<%= ctxPath%>/member/emailDuplicateCheck.an",
	     	      data:{"email":$("input#email").val()},   
	     	      type:"post",  // type 은 생략하면 "get" 이다.
	     	  //  async:false,  // 동기처리(지도는 동기처리로 해야 한다)
	     	      async:true,   // 비동기처리(기본값임)
	     	      success:function(text){
	     	    
	   	    	  const json = JSON.parse(text);
	   	    	 
	   	    	  if(json.isExist) {
	   	    		  // 입력한 $("input#userid").val() 값이 이미 사용중이라면 
	   	    		  $("span#emailcheckResult").html($("input#email").val()+" 은 이미 가입된 이메일 입니다.").css("color","red");
	   	    		b_flag_IsEmailDuplicatCheck = true;
	   	    	  }
	   	    	  else{
	   	    		b_flag_IsEmailDuplicatCheck = false;
	   	    	  }
	   	      },
	   	      error:function(request, status, error){
	   	    	  alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
	   	      }
	       });
		 }
	  });
	
	  // email입력칸으로 다시 올라가면 중복되었다는 경고와 필수입력 이라는 것을 숨겨준다
	  $("input#email").focus( ()=>{
		  const $target = $(event.target);
		 
		  $target.parent().find(".error").hide();
		  $("span#emailcheckResult").html("");
	  });
	
	  // 이메일 입력관련 끝 ***********************************************************************
	
	  
	  // 비밀번호 입력하는 곳 시작 *******************************************************************
	  // 아이디가 pwd인 것은 포커스를 잃어버렸을 경우(blur) 이벤트를 처리해주는 것이다. 
	$("input#pwd").blur( ()=>{
		  
		  const $target = $(event.target);

		  const regExp = new RegExp(/^.*(?=^.{8,15}$)(?=.*\d)(?=.*[a-zA-Z])(?=.*[^a-zA-Z0-9]).*$/g);
	   // 숫자/문자/특수문자/ 포함 형태의 8~15자리 이내의 암호 정규표현식 객체 생성
		
		  const bool = regExp.test($target.val());   
		  
		  if(!bool) {
			  // 암호가 정규표현식에 위배된 경우 
		      $target.parent().find(".error").show();
		  }
		  else {
			  // 암호가 정규표현식에 맞는 경우
			  $target.parent().find(".error").hide();
		  }
		  
	 });
	
	 // 비밀번호 입력하는 곳 끝 *******************************************************************
	
	 // 비밀번호 확인 입력하는 곳 시작 *******************************************************************
	 
	// 아이디가 pwdcheck 인 것은 포커스를 잃어버렸을 경우(blur) 이벤트를 처리해주는 것이다. 
	  $("input#pwdcheck").blur( ()=>{
		  
		  const $target = $(event.target);
		  
		  const pwd = $("input#pwd").val();
		  const pwdcheck = $target.val();
		  
		  if(pwd != pwdcheck) {
			  // 암호와 암호확인값이 틀린 경우 
		      $target.parent().find(".error").show();
			  
		  }
		  else {
			  // 암호와 암호확인값이 같은 경우 
			  $target.parent().find(".error").hide();
		  }
		  
	  });
	
	
	  // 비밀번호 확인 입력하는 곳 끝 *******************************************************************
	
	
	 // 이름 입력하는 곳 시작 *******************************************************************
	
	  // 아이디가 name 인 것은 포커스를 잃어버렸을 경우(blur) 이벤트를 처리해주는 것이다. 
	  $("input#name").blur( ()=>{
		  
		  const $target = $(event.target);
		  
		  const name = $target.val().trim();
		  if(name == "") {
			  // 입력하지 않거나 공백만 입력했을 경우
		      $target.parent().find(".error").show();
		
		  }
		  else {
			  // 공백이 아닌 글자를 입력했을 경우 
			   $target.parent().find(".error").hide();
		  }
		  
	  }); 
	
	  // 이름 입력하는 곳 끝 *******************************************************************
	  
	  
	  // 전화번호 입력하는 곳 시작 **************************************************************************
	  
	  
	  
	  
	  $("input#hp1").blur( ()=>{
		  
		  const $target = $(event.target);   
		
	 	  const regExp = new RegExp(/^\d{3}$/g); 
		
		  const bool = regExp.test($target.val());   
		  
		  if(!bool) {
			 
			 
		      $target.parent().parent().find(".error").show();
			
		  }
		  else {
			  // 국번이 정규표현식에 맞는 경우 
			  $target.parent().parent().find(".error").hide();
		  }
		  
	  });
	    $("input#hp2").blur( ()=>{
		  
		  const $target = $(event.target);   
		
	 	  const regExp = new RegExp(/^[1-9][0-9]{3}$/g); 
		
		  const bool = regExp.test($target.val());   
		  
		  if(!bool) {
			  // 국번이 정규표현식에 위배된 경우 
			 
		      $target.parent().parent().find(".error").show();
			
		  }
		  else {
			  // 국번이 정규표현식에 맞는 경우 
			  $target.parent().parent().find(".error").hide();
		  }
		  
	  });
	  
	    $("input#hp3").blur( ()=>{
			  
			  const $target = $(event.target);   
			
		 	  const regExp = new RegExp(/^\d{4}$/g); 
			
			  const bool = regExp.test($target.val());   
			  
			  if(!bool) {
				  // 국번이 정규표현식에 위배된 경우 
				 
			      $target.parent().parent().find(".error").show();
				
			  }
			  else {
				  // 국번이 정규표현식에 맞는 경우 
				  $target.parent().parent().find(".error").hide();
			  }
			  
		  });
	  
	  // 전화번호 입력하는 곳 끝 **************************************************************************
	  
	  // 주소 관련 입력하는 곳 시작 ***********************************************************************
	  
	  $("img#zipcodeSearch").click(function(){
		  new daum.Postcode({
	            oncomplete: function(data) {
	                // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

	                // 각 주소의 노출 규칙에 따라 주소를 조합한다.
	                // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
	                let addr = ''; // 주소 변수
	                let extraAddr = ''; // 참고항목 변수

	                //사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
	                if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
	                    addr = data.roadAddress;
	                } else { // 사용자가 지번 주소를 선택했을 경우(J)
	                    addr = data.jibunAddress;
	                }

	                // 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
	                if(data.userSelectedType === 'R'){
	                    // 법정동명이 있을 경우 추가한다. (법정리는 제외)
	                    // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
	                    if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
	                        extraAddr += data.bname;
	                    }
	                    // 건물명이 있고, 공동주택일 경우 추가한다.
	                    if(data.buildingName !== '' && data.apartment === 'Y'){
	                        extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
	                    }
	                    // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
	                    if(extraAddr !== ''){
	                        extraAddr = ' (' + extraAddr + ')';
	                    }
	                    // 조합된 참고항목을 해당 필드에 넣는다.
	                    document.getElementById("extraAddress").value = extraAddr;
	                
	                } else {
	                    document.getElementById("extraAddress").value = '';
	                }

	                // 우편번호와 주소 정보를 해당 필드에 넣는다.
	                document.getElementById('postcode').value = data.zonecode;
	                document.getElementById("address").value = addr;
	                // 커서를 상세주소 필드로 이동한다.
	                document.getElementById("detailAddress").focus();
	            }
	        }).open();
	  });
	  
	  
	  
	  // 주소 관련 입력하는 곳 끝 ***********************************************************************
	  
	  // 생년월일을 입력하는 곳 시작 *********************************************************************
	  
	 
	  
	  // 생년월일을 입력하는 곳 끝 *********************************************************************
	  
	  
	
	
});//end of document.ready(function(){})+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++


//  체크박스 전체선택 전체 해제 관리 해주는 곳  시작 ************************************************************************

// == 체크박스 전체선택 / 전체해제 == //
function allCheck(bool) {
	
	   const agree_checkBox_List = document.getElementsByClassName("agree");
	   
	   for(let agree_checkBox of agree_checkBox_List) {
		   agree_checkBox.checked = bool;
	   }// end of for----------------------- 
	   
}// end of function allCheck()-----------------------------------------


function agreeCheck() {
	   
	   const agree_checkBox_List = document.getElementsByClassName("agree");
	   
	   let bFlag = false;
	   for(let agree_checkBox of agree_checkBox_List) {
		   
		   if(!agree_checkBox.checked) {
			  
			   bFlag = true;
			   break;
		   }
		   
	   }// end of for-----------------------
	   
	   if(bFlag) {
		// 하위 체크박스에 체크가 1개라도 체크가 해제되었더라면
		   document.getElementById("allAgree").checked = false;
	   }
	   else {
		// 하위 체크박스에 체크가 모두 체크가 되었더라면  
		  document.getElementById("allAgree").checked = true;
	   }
	   
}// end of function agreeCheck(){}----------------------------------


//체크박스 전체선택 전체 해제 관리 해주는 곳 끝 ************************************************************************

 //회원가입버튼을 눌렀을 때 최종 검사 및 회원가입 시작 =========================================================================
      function goRegister() {
	  
	  // *** 필수입력 사항에 모두 입력이 되었는지 검사한다. *** //
	  let b_FlagRequiredInfo = false;
	  
	  $("input.requiredInfo").each(function(index, item){
		  const data = $(item).val().trim();
		  if(data == "") {
			  alert("*표시된 필수입력사항은 모두 입력하셔야 합니다.");
			  b_FlagRequiredInfo = true;
			  return false;  // for 문에서 break; 와 같은 기능이다.
		  }
	  });
	  
	  if(b_FlagRequiredInfo) {
		  return; // 종료 
	  } 
	  
	 
	  
	  // *** 이용약관에 동의했는지 검사한다. *** //
	  const agreeCheckedLength = $("input:checkbox[name='agree']:checked").length;
	  
	  if(agreeCheckedLength == 0) {
		  alert("이용약관에 동의하셔야 합니다.");
		  return; // 종료
	  }
	  
	  
	  // *** 아이디 중복확인을 클릭했는지 검사한다. *** //
	  if(b_flag_IsIdDuplicatCheck) {
		  // 아이디가 중복인 경우 
		  
		  alert("이미 사용중인 아이디 입니다. 아이디를 변경하여 주세요.");
		  return; // 종료
	  }
	  
	  
	  // *** 이메일 중복확인을 클릭했는지 검사한다. *** //
	  if(b_flag_IsEmailDuplicatCheck) {
		  // "이메일중복확인" 을 클릭했는지 클릭안했는지를 알아보기위한 용도임.
		  alert("이미 가입된 이메일 입니다. 이메일을 확인해 주세요.");
		  return; // 종료
	  }
	  

	  
 	  
 	  
 	  
	  const sms_agree_length = $("input:checkbox[id='smsAgree']:checked").length;
	  
		
	  if(sms_agree_length == 0){
	      $("input:checkbox[id='smsAgree']").val("0");
	  }
	  else{
		  $("input:checkbox[id='smsAgree']").val("1");
	  }
	  
	  
	  
	  
	  const email_agree_length = $("input:checkbox[id='emailAgree']:checked").length;
	 
	  if(email_agree_length == 0){
	      $("input:checkbox[id='emailAgree']").val("0");
	  }
	  else{
		  $("input:checkbox[id='emailAgree']").val("1");
	  }
	  
	 
	  const frm = document.registerFrm;
	  frm.action = "memberRegister.an";
	  frm.method = "post";
	  frm.submit();
	  
  }// end of function goRegister() {}------------------------------------
		  
	  //회원가입버튼을 눌렀을 때 최종 검사 및 회원가입 끝 =========================================================================

</script>

<%-- 회원가입을 시켜줄 from 생성 시작 --%>

<div class="container" " >
	<div class = "mt-1 ml-0 mb-5"style="width: 80%; margin: 80% auto; ">
		<!-- div 태그의 margin 80% 을 0 으로 바꾸고, 여기에 원하는 내용을 작성하세요! -->
		<span class = "h3" style = "color:#888">JOIN</span>
	</div>
	
	
	<div class = "my-5 text-center"style="width: 100%; margin: 80% auto;">
	
		<div class = "row" id = "divRegisterFrm" style = "justify-content: center;">
			<div class = "col-md-8" align = "center" >
				<form name = "registerFrm">
					<table id = "tblMemberRegister" style = "margin: auto; width: 60%;">
						<thead>
							<tr>
								<th class = "text-right pb-3" >(*)는 필수입력 사항입니다.</th>
							</tr>
						</thead>
						<tbody>
							<tr><%-- 아이디 입력하는 칸 시작--%>
								<td class = "text-left item">아이디 *</td>
							</tr>
							<tr>
								<td class = "data">
									<input type = "text" name = "userid" id = "userid" class = "requiredInfo" placeholder = "영문소문자/숫자,4~16자"/>
									<span class = "error">아이디는 필수입력 사항입니다.</span>
									<span id="idcheckResult"></span>
								</td>
							</tr><%-- 아이디 입력하는 칸 끝 --%>
							
							<tr><%-- 비밀번호 입력하는 칸 시작--%>
								<td class = "text-left item">비밀번호 *</td>
							</tr>
							<tr>
								<td class = "data">
									<input type = "password" name = "pwd" id = "pwd" class = "requiredInfo" placeholder ="(영문 대소문자/숫자/특수문자 중 2가지 이상 조합, 8자~16자)"/>
									<span class = "error">비밀번호는 영문 대소문자/숫자/특수문자 중 2가지 이상 조합, 8자~16자 이어야합니다.</span>
								</td>
							</tr><%-- 비밀번호 입력하는 칸 끝 --%>
							
							<tr><%-- 비밀번호 확인하는 칸 시작--%>
								<td class = "text-left item">비밀번호 확인*</td>
							</tr>
							<tr>
								<td class = "data">
									<input type = "password" name = "pwdcheck" id = "pwdcheck" class = "requiredInfo"/>
									<span class = "error">비밀번호가 일치하지 않습니다.</span>
								</td>
							</tr><%-- 비밀번호 확인하는 칸 끝 --%>
							
							<tr><%-- 이름 입력하는 칸 시작--%>
								<td class = "text-left item">이름 *</td>
							</tr>
							<tr>
								<td class = "data">
									<input type = "text" name = "name" id = "name" class = "requiredInfo"/>
									<span class = "error">이름은 필수입력 사항입니다.</span>
								</td>
							</tr><%-- 이름 입력하는 칸 끝 --%>
							
							<tr><%-- 주소입력하는 칸 시작 --%>
								<td class = "text-left item">우편번호*</td>
							</tr>
							<tr>
								<td class = "data"><%-- 우편번호 --%>
									<div style="display:inline-block; width: 50%;">
										<input type = "text" name = "postcode" id = "postcode" style = "width:60%; height:30px;" class = "requiredInfo" />
										<img id="zipcodeSearch" src="<%=ctxPath %>/images/b_zipcode.gif" style="vertical-align: middle;width: 33%; height:30px;" />
									</div>
								</td>
							</tr>
							<tr><%-- 주소입력 --%>
								<td class = "data">
									<input type = "text" name = "address" id = "address" class = "requiredInfo" style = "width:80%;"/>
									<span class = "item" style = "width:20%;">주소*</span>
								</td>
							</tr>
							<tr><%-- 상세주소입력 --%>
								<td class = "data">
									<input type = "text" name = "detailAddress" id = "detailAddress" class = "requiredInfo" style = "width:80%;"/>
									<span class = "item" style = "width:20%;">상세주소</span> <input type="hidden" id="extraAddress" name="extraAddress" size="40"  />
								</td>
							</tr><%-- 주소입력하는 칸 끝 --%>
							
							<tr><%-- 휴대전화 입력하는 칸 시작 --%>
								<td class = "text-left item">휴대전화*</td>
							</tr>
							<tr>
								<td class = "data">
									<div style = "display:flex; justify-content: space-between; height:30px;">
										<input type = "text" name = "hp1" id = "hp1" class= "w-25 requiredInfo" maxlength = "3"/>
										&mdash;
										<input type = "text" name = "hp2" id = "hp2" class= "w-25 requiredInfo" maxlength = "4"/>
										&mdash;
										<input type = "text" name = "hp3" id = "hp3" class= "w-25 requiredInfo" maxlength = "4"/>
										
									</div>
									<span class = "error">전화번호를 올바르게 입력해주세요</span>
								</td>
							</tr><%-- 휴대전화 입력하는 칸 끝 --%>
							
							<tr><%-- 이메일 입력하는 칸 시작--%>
								<td class = "text-left item">이메일 *</td>
							</tr>
							<tr>
								<td class = "data">
									<input type = "text" name = "email" id = "email" class = "requiredInfo"/>
									<span class = "error">이메일 형식에 맞게 작성해주세요</span>
									<span id="emailcheckResult"></span>
								</td>
							</tr><%-- 이메일 입력하는 칸 끝 --%>
							
							
							<tr><%-- 생년월일 입력하는 칸 시작 --%>
								<td class = "text-left item">생년월일*</td>
							</tr>
							<tr>
								<td class = "data"  style = "padding-bottom: 50px;">
									<div style = "display:flex; justify-content: space-between; height:30px;">
										<input type = "text" name = "birthyyyy" id = "birthyyyy" class= "w-25 requiredInfo" placeholder="YYYY"/>
										<span>년</span>
										<input type = "text" name = "birthmm" id = "birthmm" class= "w-25 requiredInfo" placeholder="MM"/>
										<span>월</span>
										<input type = "text" name = "birthdd" id = "birthdd" class= "w-25 requiredInfo" placeholder="DD"/>
										<span>일</span>
									</div>
								</td>
							</tr><%-- 생년월일 입력하는 칸 끝 --%>
							<tr>
								<td ><!-- 천체동의 받는 체크박스 -->
									<input class = "agree" type="checkbox" id="allAgree" onclick="allCheck(this.checked);" />&nbsp;<label for="allAgree" class = "item">이용약관 및 개인정보 수집 및 이용 쇼핑정보 수신(선택)에 모두 동의합니다.</label>
								</td>
							</tr>
							<tr><!-- 첫번째 약관동의 시작 -->
		                    	<td class = "text-left item ">[필수]이용약관 동의</td>
		                    </tr>
							<tr>
								<td style="text-align: center; vertical-align: middle;">
									<iframe src="/AnnaSemiProject/iframeAgree/agree1.html" width="100%" height="150px" class="box" ></iframe>
								</td>
							</tr>
							<tr>
								<td class = "data" style = "padding-bottom: 50px;">
									<label for="termsOfUseAgree" class = "item">이용약관에 동의하십니까? &nbsp;<input class = "agree" type="checkbox" id="termsOfUseAgree" name = "agree" onclick = "agreeCheck()" class = "requiredInfo">&nbsp;동의함</label>
								</td>
							</tr><!-- 첫번째 약관동의 끝 -->
							
							
							<tr><!-- 두번째 약관동의 시작 -->
		                    	<td class = "text-left item">[필수]개인정보 수집 및 이용 동의</td>
		                    </tr>
							<tr>
								<td style="text-align: center; vertical-align: middle; ">
									<iframe src="/AnnaSemiProject/iframeAgree/agree2.html" width="100%" height="150px" class="box" ></iframe>
								</td>
							</tr>
							<tr>
								<td class = "data" style = "padding-bottom: 50px;">
									<label for="privateInfoAgree" class = "item">개인정보 수집 및 이용에 동의하십니까? &nbsp;<input class = "agree" type="checkbox" id="privateInfoAgree" name = "agree" onclick = "agreeCheck()" class = "requiredInfo">&nbsp;동의함</label>
								</td>
							</tr><!-- 두번째 약관동의 끝 -->
							
							
							<tr><!-- 세번째 약관동의 시작 -->
		                    	<td class = "text-left item">[선택]쇼핑정보 수신동의</td>
		                    </tr>
							<tr>
								<td style="text-align: center; vertical-align: middle;">
									<iframe src="/AnnaSemiProject/iframeAgree/agree3.html" width="100%" height="150px" class="box" ></iframe>
								</td>
							</tr>
							<tr>
								<td class = "data" style = "padding-bottom: 50px;">
									<label for="smsAgree" class = "item">sms수신을 동의하십니까? &nbsp; &nbsp; &nbsp;<input class = "agree" type="checkbox" id="smsAgree" name = "smsAgree" onclick = "agreeCheck()" value = "1">&nbsp;동의함</label><br/>
									<label for="emailAgree" class = "item">이메일수신을 동의하십니까? &nbsp;<input class = "agree" type="checkbox" id="emailAgree" name = "emailAgree" onclick = "agreeCheck()" value = "1">&nbsp;동의함</label>
								</td>
							</tr><!-- 세번째 약관동의 끝 -->
							<tr>
								<td class = data>
									<button class = "w-100" type = "button" id = "btnJoin" style = "background-color: #999; border:0; outline:0; height:30px;" onclick = "goRegister()">JOIN</button>
								</td>
							</tr>

						</tbody>
					</table>
				</form>
			</div>
		</div>
	</div>
</div>

<jsp:include page="../common/footer.jsp"></jsp:include>