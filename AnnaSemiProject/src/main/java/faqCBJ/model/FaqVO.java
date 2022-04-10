package faqCBJ.model;

public class FaqVO {

	private int faqNo;
	private String fk_userId;
	private String faqRequestType;
	private String faqTitle;
	private String faqImg;
	private int fk_cnum;
	
	private FaqCategoryVO faqcategvo;
	
	public FaqVO() {}

	public FaqVO(int faqNo, String fk_userId, String faqRequestType, String faqTitle, String faqImg, int fk_cnum) {
		super();
		this.faqNo = faqNo;
		this.fk_userId = fk_userId;
		this.faqRequestType = faqRequestType;
		this.faqTitle = faqTitle;
		this.faqImg = faqImg;
		this.fk_cnum = fk_cnum;
	}

	public int getFaqNo() {
		return faqNo;
	}

	public void setFaqNo(int faqNo) {
		this.faqNo = faqNo;
	}

	public String getFk_userId() {
		return fk_userId;
	}

	public void setFk_userId(String fk_userId) {
		this.fk_userId = fk_userId;
	}

	public String getFaqRequestType() {
		return faqRequestType;
	}

	public void setFaqRequestType(String faqRequestType) {
		this.faqRequestType = faqRequestType;
	}

	public String getFaqTitle() {
		return faqTitle;
	}

	public void setFaqTitle(String faqTitle) {
		this.faqTitle = faqTitle;
	}

	public String getFaqImg() {
		return faqImg;
	}

	public void setFaqImg(String faqImg) {
		this.faqImg = faqImg;
	}

	public int getFk_cnum() {
		return fk_cnum;
	}

	public void setFk_cnum(int fk_cnum) {
		this.fk_cnum = fk_cnum;
	}

	public FaqCategoryVO getFaqcategvo() {
		return faqcategvo;
	}

	public void setFaqcategvo(FaqCategoryVO faqcategvo) {
		this.faqcategvo = faqcategvo;
	}

	
	
}
