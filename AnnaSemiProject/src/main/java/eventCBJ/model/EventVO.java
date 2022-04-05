package eventCBJ.model;

public class EventVO {

	private int eventNo;
	private String userId;
	private String registDate;
	private String eventTitle;
	private String eventStartdate;
	private String eventEnddate;
	private String eventImg1;
	private String eventImg2;
	private String thumbNail;
	
	public EventVO() {}

	public EventVO(int eventNo, String userId, String registDate, String eventTitle, String eventStartdate,
			String eventEnddate, String eventImg1, String eventImg2, String thumbNail) {
		super();
		this.eventNo = eventNo;
		this.userId = userId;
		this.registDate = registDate;
		this.eventTitle = eventTitle;
		this.eventStartdate = eventStartdate;
		this.eventEnddate = eventEnddate;
		this.eventImg1 = eventImg1;
		this.eventImg2 = eventImg2;
		this.thumbNail = thumbNail;
	}

	public int getEventNo() {
		return eventNo;
	}

	public void setEventNo(int eventNo) {
		this.eventNo = eventNo;
	}

	public String getUserId() {
		return userId;
	}

	public void setUserId(String userId) {
		this.userId = userId;
	}

	public String getRegistDate() {
		return registDate;
	}

	public void setRegistDate(String registDate) {
		this.registDate = registDate;
	}

	public String getEventTitle() {
		return eventTitle;
	}

	public void setEventTitle(String eventTitle) {
		this.eventTitle = eventTitle;
	}

	public String getEventStartdate() {
		return eventStartdate;
	}

	public void setEventStartdate(String eventStartdate) {
		this.eventStartdate = eventStartdate;
	}

	public String getEventEnddate() {
		return eventEnddate;
	}

	public void setEventEnddate(String eventEnddate) {
		this.eventEnddate = eventEnddate;
	}

	public String getEventImg1() {
		return eventImg1;
	}

	public void setEventImg1(String eventImg1) {
		this.eventImg1 = eventImg1;
	}

	public String getEventImg2() {
		return eventImg2;
	}

	public void setEventImg2(String eventImg2) {
		this.eventImg2 = eventImg2;
	}

	public String getThumbNail() {
		return thumbNail;
	}

	public void setThumbNail(String thumbNail) {
		this.thumbNail = thumbNail;
	}
	
	
}
