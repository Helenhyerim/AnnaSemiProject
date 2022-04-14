package cart.model;

public class CartVO {
	private int cartno ; 			/* 장바구니번호 */
	private String fk_userid ; 		/* 회원아이디 */
	private int fk_productnum ; 	/* 제품번호 */
	private int orderqty ; 			/* 주문량 */
	private String registerday ; 	/* 입력일자 */
	private int fk_optionnum;		/* 옵션넘버 */
	private String optionname;		/* 옵션이름 */
	private int totalpricebyproduct;
	private int totalpointbyproduct;
	//////////////////////////////////////////////////////////////////
	public int getCartno() {
		return cartno;
	}
	public void setCartno(int cartno) {
		this.cartno = cartno;
	}
	public String getFk_userid() {
		return fk_userid;
	}
	public void setFk_userid(String fk_userid) {
		this.fk_userid = fk_userid;
	}
	public int getFk_productnum() {
		return fk_productnum;
	}
	public void setFk_productnum(int fk_productnum) {
		this.fk_productnum = fk_productnum;
	}
	public int getOrderqty() {
		return orderqty;
	}
	public void setOrderqty(int orderqty) {
		this.orderqty = orderqty;
	}
	public String getRegisterday() {
		return registerday;
	}
	public void setRegisterday(String registerday) {
		this.registerday = registerday;
	}
	public int getTotalpricebyproduct() {
		return totalpricebyproduct;
	}
	public void setTotalpricebyproduct(int totalpricebyproduct) {
		this.totalpricebyproduct = totalpricebyproduct;
	}
	public int getTotalpointbyproduct() {
		return totalpointbyproduct;
	}
	public void setTotalpointbyproduct(int totalpointbyproduct) {
		this.totalpointbyproduct = totalpointbyproduct;
	}
	public int getFk_optionnum() {
		return fk_optionnum;
	}
	public void setFk_optionnum(int fk_optionnum) {
		this.fk_optionnum = fk_optionnum;
	}
	public String getOptionname() {
		return optionname;
	}
	public void setOptionname(String optionname) {
		this.optionname = optionname;
	}
	
	/////////////////////////////////////////////////////////////
	
	public CartVO() {}
	
	public CartVO(int cartno, String fk_userid, int fk_productnum, int orderqty, String registerday) {
		super();
		this.cartno = cartno;
		this.fk_userid = fk_userid;
		this.fk_productnum = fk_productnum;
		this.orderqty = orderqty;
		this.registerday = registerday;
	}
	
	
	

}
