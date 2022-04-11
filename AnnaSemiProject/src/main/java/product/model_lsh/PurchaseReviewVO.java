package product.model_lsh;

public class PurchaseReviewVO {

	private int review_no;			// 리뷰 번호(시퀀스)
	private String userid;			// 사용자 ID
	private int productnum;			// 제품 번호
	private String reviewcontents;	// 리뷰 내용
	private String reviewdate;		// 리뷰 작성 일자
	private String reviewtitle;		// 리뷰 제목
	
	public PurchaseReviewVO() {}

	public PurchaseReviewVO(int review_no, String userid, int productnum, String reviewcontents,
							String reviewdate, String reviewtitle) {
		this.review_no = review_no;
		this.userid = userid;
		this.productnum = productnum;
		this.reviewcontents = reviewcontents;
		this.reviewdate = reviewdate;
		this.reviewtitle = reviewtitle;
	}

	public int getReview_no() {
		return review_no;
	}

	public void setReview_no(int review_no) {
		this.review_no = review_no;
	}

	public String getUserid() {
		return userid;
	}

	public void setUserid(String userid) {
		this.userid = userid;
	}

	public int getProductnum() {
		return productnum;
	}

	public void setProductnum(int productnum) {
		this.productnum = productnum;
	}

	public String getReviewcontents() {
		return reviewcontents;
	}

	public void setReviewcontents(String reviewcontents) {
		this.reviewcontents = reviewcontents;
	}

	public String getReviewdate() {
		return reviewdate;
	}

	public void setReviewdate(String reviewdate) {
		this.reviewdate = reviewdate;
	}

	public String getReviewtitle() {
		return reviewtitle;
	}

	public void setReviewtitle(String reviewtitle) {
		this.reviewtitle = reviewtitle;
	}
	
}
