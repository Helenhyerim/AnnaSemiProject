package faqCBJ.model;

public class FaqCategoryVO {

	private int cnum;
	private String faqrequesttype;
	
	public FaqCategoryVO() {}

	public FaqCategoryVO(int cnum, String faqrequesttype) {
		super();
		this.cnum = cnum;
		this.faqrequesttype = faqrequesttype;
	}

	public int getCnum() {
		return cnum;
	}

	public void setCnum(int cnum) {
		this.cnum = cnum;
	}

	public String getFaqrequesttype() {
		return faqrequesttype;
	}

	public void setFaqrequesttype(String faqrequesttype) {
		this.faqrequesttype = faqrequesttype;
	}
	
	
	
}
