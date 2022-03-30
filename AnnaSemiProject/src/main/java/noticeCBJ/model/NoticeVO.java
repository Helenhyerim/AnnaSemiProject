package noticeCBJ.model;

public class NoticeVO {

	private int noticeNo;
	private String fk_userId;
	private String noticeDate;
	private String noticeTitle;
	private String noticeContents;
	private int cnt;
	
	public NoticeVO() {}

	public NoticeVO(int noticeNo, String fk_userId, String noticeDate, String noticeTitle, String noticeContents, int cnt) {
		super();
		this.noticeNo = noticeNo;
		this.fk_userId = fk_userId;
		this.noticeDate = noticeDate;
		this.noticeTitle = noticeTitle;
		this.noticeContents = noticeContents;
		this.cnt = cnt;
	}

	public int getNoticeNo() {
		return noticeNo;
	}

	public void setNoticeNo(int noticeNo) {
		this.noticeNo = noticeNo;
	}

	public String getFk_userId() {
		return fk_userId;
	}

	public void setFk_userId(String fk_userId) {
		this.fk_userId = fk_userId;
	}

	public String getNoticeDate() {
		return noticeDate;
	}

	public void setNoticeDate(String noticeDate) {
		this.noticeDate = noticeDate;
	}

	public String getNoticeTitle() {
		return noticeTitle;
	}

	public void setNoticeTitle(String noticeTitle) {
		this.noticeTitle = noticeTitle;
	}

	public String getNoticeContents() {
		return noticeContents;
	}

	public void setNoticeContents(String noticeContents) {
		this.noticeContents = noticeContents;
	}

	public int getCnt() {
		return cnt;
	}

	public void setCnt(int cnt) {
		this.cnt = cnt;
	}
	
	
	
}
