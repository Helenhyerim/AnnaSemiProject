<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
    String ctxPath = request.getContextPath();
%>
    
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

</style>


<script type="text/javascript" src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script type="text/javascript">

	let b_flagOnlyIdCheck = false;
	// 가입하기 버튼 클릭시 "아이디중복"이 확인되었는지 알아보기 위한 용도

	let b_flagOnlyEmailCheck = false;
	// 가입하기 버튼 클릭시 "이메일중복"이 확인되었는지 알아보기 위한 용도 


$(document).ready(function(){
	
	$("span.error").hide();

	$("input#userid").blur( ()=>{
		const $target = $(event.target);
		
		const userid = $target.val().trim();
		if(userid == "") {
			// 입력하지 않거나 공백만 입력했을 경우 
			$target.next().show();
			
			$target.focus();
		}

		else {
			// 공백이 아닌 글자를 입력했을 경우 
			$target.next().hide();
		}
	}); 
	
	
	
	
	// 아이디가 pwd인 것이 포커스를 잃어버렸을 경우(blur) 이벤트를 처리해주는 것이다. 
	$("input#pwd").blur( ()=>{
	//	const $target = $(event.target);
		
	    const regExp = new RegExp(/^.*(?=^.{8,15}$)(?=.*\d)(?=.*[a-zA-Z])(?=.*[^a-zA-Z0-9]).*$/g);
	    // 숫자/문자/특수문자/ 포함 형태의 8~15자리 이내의 암호 정규표현식 객체 생성
		
	    const bool = regExp.test($target.val());
	    
		const pwd = $target.val().trim();
		
		if(!bool) {
			// 암호가 정규표현식에 위배된 경우  			
			$target.parent().find(".error").show();

			$target.focus();
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
			$("table#tblMemberRegister :input").prop("disabled", true);
			$target.prop("disabled", false);
			$("input#pwd").prop("disabled", false);
			
		//	$target.next().show();
		// 	또는
			$target.parent().find(".error").show();

			$("input#pwd").focus();
		}
		else {
			// // 암호와 암호확인값이 같은 경우    
			$("table#tblMemberRegister :input").prop("disabled", false);
			
			//	$target.next().hide();
			// 	또는
				$target.parent().find(".error").hide();
		}
	});
	
	
	// 아이디가 name인 것이 포커스를 잃어버렸을 경우(blur) 이벤트를 처리해주는 것이다. 
	$("input#name").blur( ()=>{
		const $target = $(event.target);
		
		const name = $target.val().trim();
		if(name == "") {
			// 입력하지 않거나 공백만 입력했을 경우 
			$("table#tblMemberRegister :input").prop("disabled", true);
			$target.prop("disabled", false);
			
		//	$target.next().show();
		// 	또는
			$target.parent().find(".error").show();

			$target.focus();
		}
		else {
			// 공백이 아닌 글자를 입력했을 경우 
			$("table#tblMemberRegister :input").prop("disabled", false);
//			$target.next().hide();
			// 	또는
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

			$target.focus();
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
			// 국번이 정규표현식에 위배된 경우  
			$("table#tblMemberRegister :input").prop("disabled", true);
			$target.prop("disabled", false);
			
		//	$target.next().show();
		// 	또는
			$target.parent().find(".error").show();

			$target.focus();
		}
		else {
			// 국번이 정규표현식에 맞는 경우  
			$("table#tblMemberRegister :input").prop("disabled", false);
			
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
			$("table#tblMemberRegister :input").prop("disabled", true);
			$target.prop("disabled", false);
			
		//	$target.next().show();
		// 	또는
			$target.parent().find(".error").show();

			$target.focus();
		}
		else {
			// 마지막 전화번호 네자리가 정규표현식에 맞는 경우  
			$("table#tblMemberRegister :input").prop("disabled", false);
			
			//	$target.next().hide();
			// 	또는
				$target.parent().find(".error").hide();
		}
	}); 
	
	

	
	// 생년월일 입력하기
	let mm_html = "";
	for(let i=1; i<=12; i++){
		if(i<10) {
			mm_html += "<option value='0"+i+"'>0"+i+"</option>";
		}
		else {
			mm_html += "<option value='"+i+"'>"+i+"</option>";
		}
	}
	
	$("select#birthmm").html(mm_html);	


	let dd_html = "";
	for(let i=1; i<=31; i++){
		if(i<10) {
			dd_html += "<option value='0"+i+"'>0"+i+"</option>";
		}
		else {
			dd_html += "<option value='"+i+"'>"+i+"</option>";
		}
	}
	
	$("select#birthdd").html(dd_html);
	
	
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
	
	
	/////////////////////////////////////////////////////////////////////
	

	/// === 아이디 중복 검사하기 == ////
	$("input#userid").bind("change", ()=>{
			//입력하고자 하는 아이디가 데이터베이스 테이블에 존재하는지 알아오기
               $.ajax({
            	   url: "<%= ctxPath%>/member/idDuplicateCheck.an",
            	   data: {"userid":$("input#userid").val()}, 
            	   type: "post",
            	   async: true, 
            	   success: function(text){
            		   
            		   const json = JSON.parse(text);
        
            			if(json.isExist){
            				// 입력한 $("input#userid").val() 값이 이미 사용중인 경우 
            				$("span#idcheckResult").html($("input#userid").val()+" 은 중복된 ID이므로 사용불가합니다.").css("color","red");
            			}
            			else{
            				// 입력한 $("input#userid").val() 값이 DB tbl_member 테이블에 존재하지 않는 경우 
            				$("span#idcheckResult").html($("input#userid").val()+"은 사용가능합니다.").css("color","green");
            				b_flagOnlyIdCheck = true;
            			}
            	   }, 
            	   error:function(request, status, error){
            		   alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
            	   }
 
               });
		
	}) ;
	
	
	/// === 이메일 중복 검사하기 == ////
	$("input#email").bind("change", ()=>{
		//입력하고자 하는 아이디가 데이터베이스 테이블에 존재하는지 알아오기
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
	
		});
	
}); // end of $(document).ready(function(){

	
	
// Function Declaration	
//가입하기
function goRegister() {
		
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
		
		
		// *** 이용약관에 동의했는지 검사한다. ***// 
		const agreeCheckedLength = $("input:checkbox[id='agree']:checked").length;
	  
	 	if(agreeCheckedLength == 0) {
		  	alert("이용약관에 동의하셔야 합니다.");
		  	return; // 종료
		}
		

	   // *** 정보 이용약관에 동의했는지 검사한다. ***// 
		const privacyAgreeCheckedLength = $("input:checkbox[id='privacyAgree']:checked").length;
	  
	 	if(privacyAgreeCheckedLength == 0) {
		  	alert("개인정보 수집 및 이용약관에 동의하셔야 합니다.");
		  	return; // 종료
		}
	 	
	 	
	 	// ***아이디가 중복되지 않고 사용가능한 아이디인지 확인한다. ***// 
		if(!b_flagOnlyIdCheck) {
			alert("이미 사용중인 아이디이므로 아이디를 변경해주세요.");
			return;
		}
	 
		// ***이메일이 중복되지 않고 사용가능한 아이디인지 확인한다. ***// 
		if(!b_flagOnlyEmailCheck) {
			alert("이미 사용중인 이메일이므로 이메일을 변경해주세요.");
			return;
		}
		
	 	// *** 넘겨주기 **// 
		const frm = document.registerFrm;
		frm.action = "memberRegister.an";
		frm.method = "post";
		frm.submit();
	}


	

</script>


<div class="contents mx-5" style="margin-top:230px;">
	<div class="titleArea">
	    <h2 class="w3-left-align mb-5">JOIN</h2>
	</div>
   <form name="registerFrm">
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
	             <input type="text" name="userid" id="userid" class="requiredInfo" />
	             
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
	         <span class="error">암호가 일치하지 않습니다.</span>
	         </td>
	      </tr>
	      
	      <tr>
	         <td style="width: 20%;">이름*</td>
	         <td style="width: 100%; text-align: left;">
	             <input type="text" name="name" id="name" class="requiredInfo" /> 
	            <span class="error">이름은 필수입력 사항입니다.</span>
	         </td>
	      </tr>
	      
	      <tr>
	         <td style="width: 20%;">이메일*</td>
	         <td style="width: 100%; text-align: left;"><input type="text" name="email" id="email" class="requiredInfo" placeholder="abc@def.com" /> 
	             <span class="error">이메일 형식에 맞지 않습니다.</span>
	             <span id="emailCheckResult"></span>
	         </td>
	      </tr>
	      
	      <tr>
	         <td style="width: 20% important!;">휴대전화*</td>
	         <td style="text-align: left;">
	             <input type="text" id="hp1" name="hp1" size="6" maxlength="3" value="010" readonly />&nbsp;-&nbsp;
	             <input type="text" id="hp2" name="hp2" size="6" maxlength="4" />&nbsp;-&nbsp;
	             <input type="text" id="hp3" name="hp3" size="6" maxlength="4" />
	             <span class="error">휴대폰 형식이 아닙니다.</span>
	         </td>
	      </tr>
	      
	      <tr>
	         <td style="width: 20% important!;">주소</td>
	         <td style="width: 100%; text-align: left;">
				<input type="text" id="postcode" name="postcode" size="6" maxlength="5" />
	            <%-- 우편번호 찾기 --%>
	            <%--<img id="zipcodeSearch" src="../images/b_zipcode.gif" style="vertical-align: middle;" /> --%>
	            <a  id="zipcodeSearch" class="btnNormal">우편번호</a>
	            <span class="error">우편번호 형식이 아닙니다.</span>
	            <input type="text" id="address" name="address" size="40" placeholder="" />&nbsp;기본주소<br/>
	            <input type="text" id="detailAddress" name="detailAddress" size="40" placeholder="" />&nbsp;상세주소
	            <span class="error">주소를 입력하세요</span>
	         </td>
	      </tr>
	      
	      
	      

	      
	      <tr>
	         <td style="width: 20%;">생년월일</td>
	         <td style="text-align: left;">
	            <input type="number" id="birthyyyy" name="birthyyyy" min="1950" max="2050" step="1" value="1995" style="width: 60px;" required />&nbsp;년&nbsp;
	            
	            <select id="birthmm" name="birthmm" style="margin-left: 2%; height:38px; width: 60px; padding: 8px;">
	               <%-- 
	               <option value ="01">01</option>
	               <option value ="02">02</option>
	               <option value ="03">03</option>
	               <option value ="04">04</option>
	               <option value ="05">05</option>
	               <option value ="06">06</option>
	               <option value ="07">07</option>
	               <option value ="08">08</option>
	               <option value ="09">09</option>
	               <option value ="10">10</option>
	               <option value ="11">11</option>
	               <option value ="12">12</option>
	               --%>
	            </select> &nbsp;월&nbsp;
	            
	            <select id="birthdd" name="birthdd" style="margin-left: 2%; height:38px; width: 60px; padding: 8px;">
	               <%-- 
	               <option value ="01">01</option>
	               <option value ="02">02</option>
	               <option value ="03">03</option>
	               <option value ="04">04</option>
	               <option value ="05">05</option>
	               <option value ="06">06</option>
	               <option value ="07">07</option>
	               <option value ="08">08</option>
	               <option value ="09">09</option>
	               <option value ="10">10</option>
	               <option value ="11">11</option>
	               <option value ="12">12</option>
	               <option value ="13">13</option>
	               <option value ="14">14</option>
	               <option value ="15">15</option>
	               <option value ="16">16</option>
	               <option value ="17">17</option>
	               <option value ="18">18</option>
	               <option value ="19">19</option>
	               <option value ="20">20</option>
	               <option value ="21">21</option>
	               <option value ="22">22</option>
	               <option value ="23">23</option>
	               <option value ="24">24</option>
	               <option value ="25">25</option>
	               <option value ="26">26</option>
	               <option value ="27">27</option>
	               <option value ="28">28</option>
	               <option value ="29">29</option>
	               <option value ="30">30</option>
	               <option value ="31">31</option>
	               --%>
	            </select> &nbsp;일
	         </td>
	      </tr>
	      </tbody>
	      </table>
	      
	      
	       <div class="checkbox_group" style="width:95%; margin:auto;">
	       
		         <label for="agree">이용약관 및 개인정보수집 및 이용, 쇼핑정보 수신(선택)에 모두 동의합니다.</label>
		         &nbsp;&nbsp;<input type="checkbox" id="agree_all"/>
		      
		      
		      	  <h3>[필수]이용약관 동의</h3>
		          <div class="agreeArea" style="text-align: center; vertical-align: middle;">
		              <iframe src="../iframeAgree/agree.html" style="width:100%; height=110px; padding=20px; border: 1px solid #d5d5d5;" class="box" ></iframe>
		          </div>
		          <label for="agree" style="margin-right: 10px;">이용약관에 동의하십니까?</label>&nbsp;&nbsp;
		           <input type="checkbox" id="agree" class="normal"/>&nbsp;&nbsp;
		           <label for="agreeCheck">동의함</label>
		     
		      	  <h3>[필수]개인정보 수집 및 이용 동의</h3>
		          <div class="agreeArea" style="text-align: center; vertical-align: middle;">
		            <iframe src="../iframeAgree/privacyAgree.html" style="width:100%; height=110px; padding=20px; border: 1px solid #d5d5d5;" class="box" ></iframe>
		       	   </div>
		           <label for="agree" style="margin-right: 10px;">개인정보 수집 및 이용 동의에 동의하십니까?</label>&nbsp;&nbsp;
		           <input type="checkbox" id="privacyAgree" class="normal" />&nbsp;&nbsp;
		           <label for="agreeCheck">동의함</label>

		 
		      	  <h3>[선택]쇼핑정보 수신 동의</h3>
		          <div class="agreeArea" style="text-align: center; vertical-align: middle;">
		           <iframe src="../iframeAgree/shoppingAgree.html" style="width:100%; height=110px; padding=20px; border: 1px solid #d5d5d5;" class="box" ></iframe>
		          </div>
		           <label for="agree" style="margin-right: 10px;">SMS 수신을 동의하십니까?</label>&nbsp;&nbsp;
		           <input type="checkbox" id="sms_status" name="sms_status" class="normal" value="1" />&nbsp;&nbsp;
		           <label for="agreeCheck">동의함</label>
		           <br/>
		           <label for="agree" style="margin-right: 10px;">이메일 수신을 동의하십니까?</label>&nbsp;&nbsp;
		           <input type="checkbox" id="email_status" name="email_status" class="normal" value="1" />&nbsp;&nbsp;
		            <label for="agreeCheck">동의함</label>
		      
	      </div> 
	      
	      
	      <div style="line-height: 90px; margin: 10px auto; width:96%">
	          <button type="button" id="btnRegister" class="btn btn-dark btn-lg text-center" onClick="goRegister();">JOIN US</button> 
	      </div>
	  
	   </div>
   </form>
 </div>



<jsp:include page="../common/footer.jsp"/>