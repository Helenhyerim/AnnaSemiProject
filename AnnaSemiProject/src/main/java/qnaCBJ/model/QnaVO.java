package qnaCBJ.model;

public class QnaVO {

	private int qnaNo;
	private String fk_userId;
	private String questionTitle;
	private String questionContents;
	private String questionDate;
	private String answerTitle;
	private String answerContents;
	private String answerDate;
	private String questionImg;
	private String answerImg;
	
	public QnaVO() {}

	public QnaVO(int qnaNo, String fk_userId, String questionTitle, String questionContents, String questionDate,
			String answerTitle, String answerContents, String answerDate, String questionImg, String answerImg) {
		super();
		this.qnaNo = qnaNo;
		this.fk_userId = fk_userId;
		this.questionTitle = questionTitle;
		this.questionContents = questionContents;
		this.questionDate = questionDate;
		this.answerTitle = answerTitle;
		this.answerContents = answerContents;
		this.answerDate = answerDate;
		this.questionImg = questionImg;
		this.answerImg = answerImg;
	}

	public int getQnaNo() {
		return qnaNo;
	}

	public void setQnaNo(int qnaNo) {
		this.qnaNo = qnaNo;
	}

	public String getFk_userId() {
		return fk_userId;
	}

	public void setFk_userId(String fk_userId) {
		this.fk_userId = fk_userId;
	}

	public String getQuestionTitle() {
		return questionTitle;
	}

	public void setQuestionTitle(String questionTitle) {
		this.questionTitle = questionTitle;
	}

	public String getQuestionContents() {
		return questionContents;
	}

	public void setQuestionContents(String questionContents) {
		this.questionContents = questionContents;
	}

	public String getQuestionDate() {
		return questionDate;
	}

	public void setQuestionDate(String questionDate) {
		this.questionDate = questionDate;
	}

	public String getAnswerTitle() {
		return answerTitle;
	}

	public void setAnswerTitle(String answerTitle) {
		this.answerTitle = answerTitle;
	}

	public String getAnswerContents() {
		return answerContents;
	}

	public void setAnswerContents(String answerContents) {
		this.answerContents = answerContents;
	}

	public String getAnswerDate() {
		return answerDate;
	}

	public void setAnswerDate(String answerDate) {
		this.answerDate = answerDate;
	}

	public String getQuestionImg() {
		return questionImg;
	}

	public void setQuestionImg(String questionImg) {
		this.questionImg = questionImg;
	}

	public String getAnswerImg() {
		return answerImg;
	}

	public void setAnswerImg(String answerImg) {
		this.answerImg = answerImg;
	}
	
	

	
	
}
