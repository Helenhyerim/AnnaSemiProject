<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
    String ctxPath = request.getContextPath();
    //    /MyMVC
%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    
<jsp:include page="../common/header_login.jsp"/>

<style type="text/css">

.titleArea h2 {
    font-size: 18px;
    color: #444;
    font-weight: 600;
    letter-spacing: 1px;
    font-family: 'Roboto','Noto Sans KR',sans-serif;
}
#contents {
    width: 100%;
    float: none;
    padding: 200px 20px 0;
    box-sizing: border-box;  
} 
input[type=text], input[type=password], input[type=number] {
	display: inline-block;
	width: 100%; 
    height: 38px;
    box-sizing: border-box;
    padding: 2px 4px;
    border: 1px solid #d5d5d5;
    color: #353535;
    font-size: 12px;
}
button[type=button]{
	border-radius: 0;
    width: 100%;
    min-width: auto;
    height: 45px;
    line-height: 44px;
    font-size: 12px;
    padding: 0
}
select {
	border: 1px solid #d5d5d5;
}
#postcode {
	width: 100px;
}

#address, #detailAddress {
    width: 280px;
    margin: 5px 0 0;
}    
#p1, #p2, #p3, #hp1, #hp2, #hp3 {
	width: 30.7%;
}


.memberjoin {
	width: 420px;
    margin: 0 auto;
    font-size: 12px;
}
.btnNormal
{
    height: 38px;
    line-height: 38px;
    display: inline-block;
}
a#zipcodeSearch {
	
    min-width: 68px;
    padding: 0 10px;
    box-sizing: border-box;
    text-align: center;
    border: 1px solid #ddd;
    border-radius: 0;
    background: #fff;
    font-size: 11px;
    color: #000;
    font-family: inherit;
    transition: all 0.5s;
}
table#tblMemberRegister {
          width: 93%;
          
          /* 선을 숨기는 것 */
          border: hidden;
          
          margin: 10px;
   }  
   
   table#tblMemberRegister th, td {
        display: block;
    	padding: 5px 0;
    	color: #555;
    	font-weight: 300;
   	 	border: 0;
    	background-color: #fff;
   }
   
   table#tblMemberRegister td {
         /* border: solid 1px gray;  */
        /* line-height: 30px;*/
        /* padding-top: 8px;*/
         padding-bottom: 8px;
   }
 .checkbox_group h3 {
 	margin: 20px 0 10px 0;
 	font-size:12px;
 	color: #999;
 }  
 label[for="agree"], label[for="agreeCheck"] {
 	color: #999;
 }
 button:button{
 	border:solid 1px gray;
 }

</style>


<script type="text/javascript" src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script type="text/javascript">



$(document).ready(function(){
	
	$("span.error").hide();

	if(${sessionScope.loginuser.email_status == 1}){
		$("input:radio[id='emailAgree']").prop('checked',true);
	}
	else{
		$("input:radio[id='emailDisagree']").prop('checked',true);
	}	
 	
	if(${sessionScope.loginuser.sms_status == 1}){
		$("input:radio[id='smsAgree']").prop('checked',true);
	}
	else{
		$("input:radio[id='smsDisagree']").prop('checked',true);
	}	
	
	// 아이디가 pwd인 것이 포커스를 잃어버렸을 경우(blur) 이벤트를 처리해주는 것이다. 
	$("input#pwd").blur( ()=>{
	    const $target = $(event.target);
		
	    const regExp = new RegExp(/^.*(?=^.{8,15}$)(?=.*\d)(?=.*[a-zA-Z])(?=.*[^a-zA-Z0-9]).*$/g);
	    // 숫자/문자/특수문자/ 포함 형태의 8~15자리 이내의 암호 정규표현식 객체 생성
		
	    const bool = regExp.test($target.val());
	    
		const pwd = $target.val().trim();
		
		if(!bool) {
			// 암호가 정규표현식에 위배된 경우  			
			$target.parent().find(".error").show();

		
		}
		else {
			// 암호가 정규표현식에 맞는 경우  
				$target.parent().find(".error").hide();
		}
	}); 
	
	
	// 아이디가 pwdcheck인 것이 포커스를 잃어버렸을 경우(blur) 이벤트를 처리해주는 것이다. 
	$("input#pwdcheck").blur( ()=>{
		const $target = $(event.target);
		
		const pwd = $("input#pwd").val();
		const pwdcheck = $target.val();
		
		
		if(pwd != pwdcheck) {
			// 암호와 암호확인값이 틀린 경우   
			
			$target.parent().find(".error").show();

			
		}
		else {
			// // 암호와 암호확인값이 같은 경우    
			
				$target.parent().find(".error").hide();
		}
	});
	

	
	// 아이디가 email인 것이 포커스를 잃어버렸을 경우(blur) 이벤트를 처리해주는 것이다. 
	$("input#email").blur( ()=>{
		const $target = $(event.target);
		
	    // const regExp = /^[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*\.[a-zA-Z]{2,3}$/i;
    	// 또는
      	const regExp = new RegExp(/^[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*\.[a-zA-Z]{2,3}$/i); 
      	// 이메일 정규표현식 객체 생성
	   
	    const bool = regExp.test($target.val());
	    
		if(!bool) {
			// 이메일이 정규표현식에 위배된 경우  
	
		//	$target.next().show();
		// 	또는
			$target.parent().find(".error").show();

		}
		else {
			// 이메일이 정규표현식에 맞는 경우  
			
			//	$target.next().hide();
			// 	또는
				$target.parent().find(".error").hide();
		}
	}); 
	
	
	
	//주소 입력하기 
	$("a#zipcodeSearch").click(function(){
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
                    addr += extraAddr;
                
                } else {
                    addr += extraAddr;
                }

                // 우편번호와 주소 정보를 해당 필드에 넣는다.
                document.getElementById('postcode').value = data.zonecode;
                document.getElementById("address").value = addr;
                // 커서를 상세주소 필드로 이동한다.
                document.getElementById("detailAddress").focus();
            }
        }).open();
	});
	

	
	// 휴대전화 입력하기 
	// 아이디가 hp2인 것이 포커스를 잃어버렸을 경우(blur) 이벤트를 처리해주는 것이다. 
	$("input#hp2").blur( ()=>{
		const $target = $(event.target);
		
	    // const regExp = /^[1-9][0-9]{3}$/g;
    	// 또는
      	const regExp = new RegExp(/^[1-9][0-9]{3}$/g); 
      	// 숫자 4자리만 들어오도록 검사해주는 정규표현식 객체 생성(첫글자는 숫자 1-9까지만 가능함)
	   
	    const bool = regExp.test($target.val());
	    
		if(!bool) {
			
			$target.parent().find(".error").show();

			
		}
		else {
			// 국번이 정규표현식에 맞는 경우  
			
			//	$target.next().hide();
			// 	또는
				$target.parent().find(".error").hide();
		}
	}); 
	
	
	
	// 아이디가 hp3인 것이 포커스를 잃어버렸을 경우(blur) 이벤트를 처리해주는 것이다. 
	$("input#hp3").blur( ()=>{
		const $target = $(event.target);
		
	    // const regExp = /^\d{4}$/g;
	    // 또는 (/^[0-9]{4}$/g); 
    	// 또는
      	const regExp = new RegExp(/^\d{4}$/g); 
      	// 숫자 4자리만 들어오도록 검사해주는 정규표현식 객체 생성(첫글자는 숫자 1-9까지만 가능함)
	   
	    const bool = regExp.test($target.val());
	    
		if(!bool) {
			// 마지막 전화번호 네자리가 정규표현식에 위배된 경우  
			
		//	$target.next().show();
		// 	또는
			$target.parent().find(".error").show();

		}
		else {
			// 마지막 전화번호 네자리가 정규표현식에 맞는 경우  
			
			//	$target.next().hide();
			// 	또는
				$target.parent().find(".error").hide();
		}
	}); 
	
	

	

	
	
	// 약관 체크박스 동의 처리하기  
	// 체크박스 전체 선택
	$(".checkbox_group").on("click", "#agree_all", function () {
	    $(this).parents(".checkbox_group").find('input').prop("checked", $(this).is(":checked"));
	});
	
	// 체크박스 개별 선택
	$(".checkbox_group").on("click", ".normal", function() {
	    var is_checked = true;
	
	    $(".checkbox_group .normal").each(function(){
	        is_checked = is_checked && $(this).is(":checked");
	    });
	
	    $("#agree_all").prop("checked", is_checked);
	});
	
	

	$("input#email").blur( ()=>{
		
		if("${sessionScope.loginuser.email}" != $("input#email").val()){
			
			$.ajax({
	     	   url: "<%= ctxPath%>/member/emailDuplicateCheck.an",
	     	   data: {"email":$("input#email").val()}, 
	     	   type: "post",
	     	   async: true, 
	     	   success: function(text){
	     		   
	     		   const json = JSON.parse(text);
	 
	     			if(json.isExist){
	     				// 입력한 $("input#email").val() 값이 이미 사용중인 경우 
	     				$("span#emailCheckResult").html($("input#email").val()+" 은 중복된 이메일이므로 사용불가합니다.").css("color","red");
	     			}
	     			else{
	     				// 입력한 $("input#email").val() 값이 DB tbl_member 테이블에 존재하지 않는 경우 
	     				$("span#emailCheckResult").html($("input#email").val()+"은 사용가능합니다.").css("color","green");
	     				b_flagOnlyEmailCheck = true;
	     			}
	     	   }, 
	     	   error:function(request, status, error){
	     		   alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
	     	   }
	
	        });
		}
		else{
			$("span#emailCheckResult").html("");
		}
		
	});

});	
	

	
	
// Function Declaration	

// 회원탈퇴하기
function goLeave(){
	
}
// 취소하기
function goCancel(){
	location.href = "<%= ctxPath%>/index.an";	
}

// 회원정보 수정하기
function goModify() {
		// *** 필수입력 사항에 모두 입력이 되었는지 검사한다. ***// 
		let b_FlagRequiredInfo = false;
		
		$("input.requiredInfo").each(function(index, item){
			const data = $(item).val().trim();
			if(data == "") {
				alert("*표시된 필수입력사항은 모두 입력하셔야 합니다.");
				b_FlagRequiredInfo = true;
				return false; // for문에서 break;와 같은 기능이다. 
			}
		});
		
		if(b_FlagRequiredInfo) {
			return; // 종료 
		}
	
		if($("input:radio[id='emailAgree']").is(":checked")){
			$("input:radio[name='email_status']").val("1");
		}

		else{
			$("input:radio[name='email_status']").val("0");
		}	
	 	
		if($("input:radio[id='smsAgree']").is(":checked")){
			$("input:radio[name='sms_status']").val("1");
		}

		else{
			$("input:radio[name='sms_status']").val("0");
		}	
	 	
	  
	
		
	 	// *** 넘겨주기 **// 
		const frm = document.modifyFrm;
		frm.action = "<%= request.getContextPath()%>/member/memberEditEnd.an";
		frm.method = "post";
		frm.submit();
	}

/// === 이메일 중복 검사하기 == ////


	

</script>


<div class="contents mx-5" style="margin-top:230px;">
	<div class="titleArea">
	    <h2 class="w3-left-align mb-5">Modify</h2>
	</div>
   <form name="modifyFrm">
   <div class="memberjoin">
	   <p class="required " style="color:#353535; text-align:right;"><span class="require" title="필수">*</span>필수입력사항</p>
	   
	   <table id="tblMemberRegister">
		  <colgroup>
				<col style="width:150px;">
				<col style="width:auto;">
		  </colgroup>
		  
	      <tbody>
	      	<tr>
	          <td style="width: 20%;">아이디*</td>
	          <td style="width: 100%; text-align: left;">
	             <input type="text" name="userid" id="userid" class="requiredInfo" value = "${sessionScope.loginuser.userid}"readonly />
	             
	             <!-- 아이디중복체크 -->
	             <span class="error">아이디는 필수입력 사항입니다.</span>
	             <span id="idcheckResult"></span>
	         </td> 
	      </tr>
	      
	
	      
	      <tr>
	         <td style="width: 20%;">비밀번호*</td>
	         <td style="width: 100%; text-align: left;"><input type="password" name="pwd" id="pwd" class="requiredInfo" placeholder="(영문 대소문자/숫자/특수문자 중 2가지 이상 조합, 8자~16자)"/>
	            <span class="error">암호는 영문자,숫자,특수기호가 혼합된 8~15 글자로 입력하세요.</span>
	         </td>
	      </tr>
	      <tr>
	         <td style="width: 30%;">비밀번호확인*</td>
	         <td style="width: 100%; text-align: left;"><input type="password" id="pwdcheck" class="requiredInfo" /> 
	         <span class="error">비밀번호와 비밀번호확인이 다릅니다.</span>
	         </td>
	      </tr>
	      
	      <tr>
	         <td style="width: 20%;">이름*</td>
	         <td style="width: 100%; text-align: left;">
	             <input type="text" name="name" id="name" class="requiredInfo" value = "${sessionScope.loginuser.name}" readonly /> 
	            <span class="error">이름은 필수입력 사항입니다.</span>
	         </td>
	      </tr>
	      
	      <tr>
	         <td style="width: 20%;">이메일*</td>
	         <td style="width: 100%; text-align: left;"><input type="text" name="email" id="email" class="requiredInfo" placeholder="abc@def.com" value = "${sessionScope.loginuser.email}"/> 
	             <span class="error">이메일 형식에 맞지 않습니다.</span>
	             <span id="emailCheckResult"></span>
	         </td>
	      </tr>
	      <tr>
	         <td>
	      	    <label for="sms_status" style="margin-right: 10px;">이메일 수신을 동의하십니까?</label>&nbsp;&nbsp;
				   <input type="radio" name="email_status" id = "emailAgree" class="normal"/>&nbsp;&nbsp;
				<label for="sms_status">동의함</label>&nbsp;&nbsp;
					<input type="radio" name="email_status" id = "emailDisagree"class="normal"/>&nbsp;&nbsp;
				<label for="sms_status">동의안함</label>
	      	 </td>
		  </tr>
		  
		  <c:set var="mobileNo" value="${sessionScope.loginuser.mobile}"/>
	      <tr>
	         <td style="width: 20% important!;">휴대전화*</td>
	         <td style="text-align: left;">
	             <input type="text" id="hp1" name="hp1" size="6" maxlength="3" value="010" readonly />&nbsp;-&nbsp;
	             <input type="text" id="hp2" name="hp2" size="6" maxlength="4" value="${fn:substring(mobileNo,3,7)}"/>&nbsp;-&nbsp;
	             <input type="text" id="hp3" name="hp3" size="6" maxlength="4" value="${fn:substring(mobileNo,7,12)}"/>
	             <span class="error">휴대폰 형식이 아닙니다.</span>
	             
	         </td>
	      </tr>
	      <tr>
	         <td>
	      	    <label for="sms_status" style="margin-right: 10px;">SMS 수신을 동의하십니까?</label>&nbsp;&nbsp;
				   <input type="radio" name="sms_status" id="smsAgree" class="normal"/>&nbsp;&nbsp;
				<label for="sms_status">동의함</label>&nbsp;&nbsp;
					<input type="radio" name="sms_status" id="smsDisagree"class="normal"/>&nbsp;&nbsp;
				<label for="sms_status">동의안함</label>
	      	 </td>
		  </tr>         
	      <tr>
	         <td style="width: 20% important!;">주소</td>
	         <td style="width: 100%; text-align: left;">
				<input type="text" id="postcode" name="postcode" size="6" maxlength="5" value = "${sessionScope.loginuser.postcode}"/>
	            <%-- 우편번호 찾기 --%>
	            <%--<img id="zipcodeSearch" src="../images/b_zipcode.gif" style="vertical-align: middle;" /> --%>
	            <a  id="zipcodeSearch" class="btnNormal">우편번호</a>
	            <span class="error">우편번호 형식이 아닙니다.</span>
	            <input type="text" id="address" name="address" size="40" value = "${sessionScope.loginuser.address}" />&nbsp;기본주소<br/>
	            <input type="text" id="detailAddress" name="detailAddress" size="40" value = "${sessionScope.loginuser.detailaddress}" />&nbsp;상세주소
	            <span class="error">주소를 입력하세요</span>
	         </td>
	      </tr>
	      
	      
	      





			<c:set var="birthdate" value="${sessionScope.loginuser.birthday}"/>
	      <tr>
	         <td style="width: 20%;">생년월일</td>
	         <td style="text-align: left;">
	            <input type="text" id="birthyyyy" name="birthyyyy" style="width: 60px;" value = "${fn:substring(birthdate,0,4) }" required readonly/>&nbsp;년&nbsp;
	            
	            <input type="text" id="birthmm" name="birthmm" style="margin-left: 2%; height:38px; width: 60px; padding: 8px;" value = "${fn:substring(birthdate,4,6)}"readonly/>
	           
	            &nbsp;월&nbsp;
	            
	            <input type="text" id="birthdd" name="birthdd" style="margin-left: 2%; height:38px; width: 60px; padding: 8px;" value = "${fn:substring(birthdate,6,8) }"readonly/>
	              
	            &nbsp;일
	           </td>
	      </tr>
	      </tbody>
	      </table>
	      
	      
		      
	      
	      <div style="line-height: 50px; margin: 10px auto; width:96%">
	          <button type="button" id="btnModify" class="btn btn-dark btn-lg text-center" onClick="goModify();">회원정보 수정</button> 
	      </div>
	      <div style="line-height: 50px; margin: 10px auto; width:96%">
	          <button type="button" id="btncancel" class="btn btn-light btn-lg text-center" onClick="goCancel();">취소</button> 
	      </div>
	      <div style="line-height: 50px; margin: 10px auto; width:96%">
	          <button type="button" id="btnWithdrawal" class="btn btn-light btn-lg text-center" onClick="goLeave();">회원탈퇴</button> 
	      </div>
	  
	   </div>
   </form>
 </div>



<jsp:include page="../common/footer.jsp"/>