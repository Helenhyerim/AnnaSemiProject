package product.model_lsh;

public class OrderDetailVO {

	private int orderseqnum;	// 주문번호
	private int productnum;		// 상품번호
	private String ordernum;	// 주문코드
	private int orderqty;		// 주문수량
	private int orderprice;		// 주문가격
	private int deliverstatus;	// 배송상태
	private String deliverdate;	// 배송일자
	
	public OrderDetailVO() {}
	
	public OrderDetailVO(int orderseqnum, int productnum, String ordernum, int orderqty, int orderprice,
			int deliverstatus, String deliverdate) {
		super();
		this.orderseqnum = orderseqnum;
		this.productnum = productnum;
		this.ordernum = ordernum;
		this.orderqty = orderqty;
		this.orderprice = orderprice;
		this.deliverstatus = deliverstatus;
		this.deliverdate = deliverdate;
	}

	public int getOrderseqnum() {
		return orderseqnum;
	}

	public void setOrderseqnum(int orderseqnum) {
		this.orderseqnum = orderseqnum;
	}

	public int getProductnum() {
		return productnum;
	}

	public void setProductnum(int productnum) {
		this.productnum = productnum;
	}

	public String getOrdernum() {
		return ordernum;
	}

	public void setOrdernum(String ordernum) {
		this.ordernum = ordernum;
	}

	public int getOrderqty() {
		return orderqty;
	}

	public void setOrderqty(int orderqty) {
		this.orderqty = orderqty;
	}

	public int getOrderprice() {
		return orderprice;
	}

	public void setOrderprice(int orderprice) {
		this.orderprice = orderprice;
	}

	public int getDeliverstatus() {
		return deliverstatus;
	}

	public void setDeliverstatus(int deliverstatus) {
		this.deliverstatus = deliverstatus;
	}

	public String getDeliverdate() {
		return deliverdate;
	}

	public void setDeliverdate(String deliverdate) {
		this.deliverdate = deliverdate;
	}
	
}
