package member.model;

public class MemberVO {

	private String userid; // 회원아이디
	private String pwd;  // 회원비밀번호 (SHA-256 암호화 대상)
	private String name;  // 회원명
	private String email;  // 이메일 (AES-256 암호화/복호화 대상)
	private String mobile; // 연락처 (AES-256 암호화/복호화 대상) 
	private String postcode; // 우편번호
	private String address;  //주소
	private String detailaddress;  // 상세주소
	private String gender;  // 성별   남자:1  / 여자:2
	private String birthday;  // 생년월일   
	private int point; // 포인트 
	private String registerday;  // 가입일자 
	private String lastpwdchangedate;  // 마지막으로 암호를 변경한 날짜  
	private int register_status;  // 회원탈퇴유무   1: 사용가능(가입중) / 0:사용불능(탈퇴) 
	private int inactive_status; // 휴면유무     0 : 활동중  /  1 : 휴면중 
						// 마지막으로 로그인한 날짜 시간이 현재 시각으로부터 1년이 초과되는 경우 휴면으로 지정.
	private int sms_status; // sms 수신동의 여부
	private int email_status; // 이메일 수신동의 여부 
	/////////////////////////////////////////////////////////////////////
	
	private boolean requirePwdChange = false;
	// 마지막으로 암호를 변경한 날짜가 현재시각으로 부터 3개월이 지났으면 true
	// 마지막으로 암호를 변경한 날짜가 현재시각으로 부터 3개월이 지나지 않았으면 false
	
	/////////////////////////////////////////////////////////////////////

	public MemberVO() {}

	public MemberVO(String userid, String pwd, String name, String email, String mobile, String postcode,	String address, String detailaddress, String birthday, int sms_status, int email_status) {

		this.userid = userid;
		this.pwd = pwd;
		this.name = name;
		this.email = email;
		this.mobile = mobile;
		this.postcode = postcode;
		this.address = address;
		this.detailaddress = detailaddress;
		this.birthday = birthday;
		this.sms_status = sms_status;
		this.email_status = email_status;
	}

	public String getUserid() {
		return userid;
	}

	public void setUserid(String userid) {
		this.userid = userid;
	}

	public String getPwd() {
		return pwd;
	}

	public void setPwd(String pwd) {
		this.pwd = pwd;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getMobile() {
		return mobile;
	}

	public void setMobile(String mobile) {
		this.mobile = mobile;
	}

	public String getPostcode() {
		return postcode;
	}

	public void setPostcode(String postcode) {
		this.postcode = postcode;
	}

	public String getAddress() {
		return address;
	}

	public void setAddress(String address) {
		this.address = address;
	}

	public String getDetailaddress() {
		return detailaddress;
	}

	public void setDetailaddress(String detailaddress) {
		this.detailaddress = detailaddress;
	}

	public String getGender() {
		return gender;
	}

	public void setGender(String gender) {
		this.gender = gender;
	}

	public String getBirthday() {
		return birthday;
	}

	public void setBirthday(String birthday) {
		this.birthday = birthday;
	}

	public int getPoint() {
		return point;
	}

	public void setPoint(int point) {
		this.point = point;
	}

	public String getRegisterday() {
		return registerday;
	}

	public void setRegisterday(String registerday) {
		this.registerday = registerday;
	}

	public String getLastpwdchangedate() {
		return lastpwdchangedate;
	}

	public void setLastpwdchangedate(String lastpwdchangedate) {
		this.lastpwdchangedate = lastpwdchangedate;
	}

	public int getRegister_status() {
		return register_status;
	}

	public void setRegister_status(int register_status) {
		this.register_status = register_status;
	}

	public int getInactive_status() {
		return inactive_status;
	}

	public void setInactive_status(int inactive_status) {
		this.inactive_status = inactive_status;
	}

	public int getSms_status() {
		return sms_status;
	}

	public void setSms_status(int sms_status) {
		this.sms_status = sms_status;
	}

	public int getEmail_status() {
		return email_status;
	}

	public void setEmail_status(int email_status) {
		this.email_status = email_status;
	}

	public boolean isRequirePwdChange() {
		return requirePwdChange;
	}

	public void setRequirePwdChange(boolean requirePwdChange) {
		this.requirePwdChange = requirePwdChange;
	}

}
	
	



