package product.model_lsh;

import member.model.MemberVO;

public class OrderVO {

	private String ordernum;		// 주문 번호
	private String userid;			// 사용자 ID
	private int ordertotalprice;	// 주문 가격
	private int ordertotalpoint;	// 주문 포인트
	private String orderdate;		// 주문 일자
	private int paymethod;			// 결제 수단
	private String name_receiver;	// 수신인 이름
	private String zipcode;			// 우편 번호
	private String address;			// 배송지
	private int orderstatus;		// 주문상태
	
	private OrderDetailVO odvo;
	private ProductVO pvo;
	private MemberVO mvo;
	
	
	public OrderVO() {}
	
	public OrderVO(String ordernum, String userid, int ordertotalprice, int ordertotalpoint, String orderdate,
			int paymethod, String name_receiver, String zipcode, String address, int orderstatus, OrderDetailVO odvo,
			ProductVO pvo, MemberVO mvo) {
		super();
		this.ordernum = ordernum;
		this.userid = userid;
		this.ordertotalprice = ordertotalprice;
		this.ordertotalpoint = ordertotalpoint;
		this.orderdate = orderdate;
		this.paymethod = paymethod;
		this.name_receiver = name_receiver;
		this.zipcode = zipcode;
		this.address = address;
		this.orderstatus = orderstatus;
		this.odvo = odvo;
		this.pvo = pvo;
		this.mvo = mvo;
	}


	public String getOrdernum() {
		return ordernum;
	}

	public void setOrdernum(String ordernum) {
		this.ordernum = ordernum;
	}

	public String getUserid() {
		return userid;
	}

	public void setUserid(String userid) {
		this.userid = userid;
	}

	public int getOrdertotalprice() {
		return ordertotalprice;
	}

	public void setOrdertotalprice(int ordertotalprice) {
		this.ordertotalprice = ordertotalprice;
	}

	public int getOrdertotalpoint() {
		return ordertotalpoint;
	}

	public void setOrdertotalpoint(int ordertotalpoint) {
		this.ordertotalpoint = ordertotalpoint;
	}

	public String getOrderdate() {
		return orderdate;
	}

	public void setOrderdate(String orderdate) {
		this.orderdate = orderdate;
	}

	public int getPaymethod() {
		return paymethod;
	}

	public void setPaymethod(int paymethod) {
		this.paymethod = paymethod;
	}

	public String getName_receiver() {
		return name_receiver;
	}

	public void setName_receiver(String name_receiver) {
		this.name_receiver = name_receiver;
	}

	public String getZipcode() {
		return zipcode;
	}

	public void setZipcode(String zipcode) {
		this.zipcode = zipcode;
	}

	public String getAddress() {
		return address;
	}

	public void setAddress(String address) {
		this.address = address;
	}

	public OrderDetailVO getOdvo() {
		return odvo;
	}

	public void setOdvo(OrderDetailVO odvo) {
		this.odvo = odvo;
	}

	public ProductVO getPvo() {
		return pvo;
	}

	public void setPvo(ProductVO pvo) {
		this.pvo = pvo;
	}

	public int getOrderstatus() {
		return orderstatus;
	}

	public void setOrderstatus(int orderstatus) {
		this.orderstatus = orderstatus;
	}

	public MemberVO getMvo() {
		return mvo;
	}

	public void setMvo(MemberVO mvo) {
		this.mvo = mvo;
	}
	
}