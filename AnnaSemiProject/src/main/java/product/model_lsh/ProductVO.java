package product.model_lsh;

import cart.model.CartVO;

public class ProductVO {
	private int productnum;				// 제품번호
	private int categorynum;			// 카테고리대분류번호
	private String productname;			// 제품명
	private String productcompany;		// 제조회사명
	private String productimage1;		// 대표제품이미지1
	private String productimage2;		// 대표제품이미지2
	private int productqty;				// 제품재고량 (디폴트 0)
	private int productprice;			// 제품정가(디폴트 0)
	private int saleprice;				// 제품판매가(회원할인율 컬럼으로 변경하고 고정 퍼센트지 부여하는 것은 어떤지 물어보기)
	private int fk_specnum;				// 스펙번호
	private String productcontent;		// 제품설명(배열?)
	private int point;					// 적립금(디폴트 0)
	private String productinputdate;	// 제품입고일자(디폴트 현재일자)
	
	private CartVO cvo;
	/////////////////////////////////////////////////////////////
	
	
	public ProductVO() {}

	public ProductVO(int productnum) {
		this.productnum = productnum;
	}
	
	public ProductVO(int productnum, int categorynum, String productname, String productcompany, String productimage1,
					 String productimage2, int productqty, int productprice, int saleprice, int fk_specnum,
					 String productcontent, int point, String productinputdate) {
		this.productnum = productnum;
		this.categorynum = categorynum;
		this.productname = productname;
		this.productcompany = productcompany;
		this.productimage1 = productimage1;
		this.productimage2 = productimage2;
		this.productqty = productqty;
		this.productprice = productprice;
		this.saleprice = saleprice;
		this.fk_specnum = fk_specnum;
		this.productcontent = productcontent;
		this.point = point;
		this.productinputdate = productinputdate;
	}


	// Getters and Setters
	public int getProductnum() {
		return productnum;
	}

	public void setProductnum(int productnum) {
		this.productnum = productnum;
	}

	public int getCategorynum() {
		return categorynum;
	}

	public void setCategorynum(int categorynum) {
		this.categorynum = categorynum;
	}

	public String getProductname() {
		return productname;
	}

	public void setProductname(String productname) {
		this.productname = productname;
	}

	public String getProductcompany() {
		return productcompany;
	}

	public void setProductcompany(String productcompany) {
		this.productcompany = productcompany;
	}

	public String getProductimage1() {
		return productimage1;
	}

	public void setProductimage1(String productimage1) {
		this.productimage1 = productimage1;
	}

	public String getProductimage2() {
		return productimage2;
	}

	public void setProductimage2(String productimage2) {
		this.productimage2 = productimage2;
	}

	public int getProductqty() {
		return productqty;
	}

	public void setProductqty(int productqty) {
		this.productqty = productqty;
	}

	public int getProductprice() {
		return productprice;
	}

	public void setProductprice(int productprice) {
		this.productprice = productprice;
	}

	public int getSaleprice() {
		return saleprice;
	}

	public void setSaleprice(int saleprice) {
		this.saleprice = saleprice;
	}

	public int getFk_specnum() {
		return fk_specnum;
	}

	public void setFk_specnum(int fk_specnum) {
		this.fk_specnum = fk_specnum;
	}

	public String getProductcontent() {
		return productcontent;
	}

	public void setProductcontent(String productcontent) {
		this.productcontent = productcontent;
	}

	public int getPoint() {
		return point;
	}

	public void setPoint(int point) {
		this.point = point;
	}

	public String getProductinputdate() {
		return productinputdate;
	}

	public void setProductinputdate(String productinputdate) {
		this.productinputdate = productinputdate;
	}

	public CartVO getCvo() {
		return cvo;
	}

	public void setCvo(CartVO cvo) {
		this.cvo = cvo;
	}
	
}
