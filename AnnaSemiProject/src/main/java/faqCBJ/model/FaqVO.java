package faqCBJ.model;

public class FaqVO {

	private int faqNo;
	private String fk_userId;
	private String faqRequestType;
	private String faqTitle;
	private String faqContents;
	
	public FaqVO() {}

	public FaqVO(int faqNo, String fk_userId, String faqRequestType, String faqTitle, String faqContents) {
		super();
		this.faqNo = faqNo;
		this.fk_userId = fk_userId;
		this.faqRequestType = faqRequestType;
		this.faqTitle = faqTitle;
		this.faqContents = faqContents;
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

	public String getFaqContents() {
		return faqContents;
	}

	public void setFaqContents(String faqContents) {
		this.faqContents = faqContents;
	}
	
	
	
}
