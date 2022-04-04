package board;

import java.util.Date;

public class BoardVo {
	private int qnano;
	private String fk_userid;
	private String questiontitle;
	private String questioncontents;
	private Date questiondate;
	private String answertitle;
	private String answercontents;
	private Date answerdate;
	
	
	
	
	public int getQnano() {
		return qnano;
	}

	public void setQnano(int qnano) {
		this.qnano = qnano;
	}

	public String getFk_userid() {
		return fk_userid;
	}

	public void setFk_userid(String fk_userid) {
		this.fk_userid = fk_userid;
	}

	public String getQuestiontitle() {
		return questiontitle;
	}

	public void setQuestiontitle(String questiontitle) {
		this.questiontitle = questiontitle;
	}

	public String getQuestioncontents() {
		return questioncontents;
	}

	public void setQuestioncontents(String questioncontents) {
		this.questioncontents = questioncontents;
	}

	public Date getQuestiondate() {
		return questiondate;
	}

	public void setQuestiondate(Date questiondate) {
		this.questiondate = questiondate;
	}

	public String getAnswertitle() {
		return answertitle;
	}

	public void setAnswertitle(String answertitle) {
		this.answertitle = answertitle;
	}

	public String getAnswercontents() {
		return answercontents;
	}

	public void setAnswercontents(String answercontents) {
		this.answercontents = answercontents;
	}

	public Date getAnswerdate() {
		return answerdate;
	}

	public void setAnswerdate(Date answerdate) {
		this.answerdate = answerdate;
	}
	
	
	public BoardVo() {}
	
	public BoardVo(int qnano, String fk_userid, String questiontitle, String questioncontents, Date questiondate,
			String answertitle, String answercontents, Date answerdate) {
		super();
		this.qnano = qnano;
		this.fk_userid = fk_userid;
		this.questiontitle = questiontitle;
		this.questioncontents = questioncontents;
		this.questiondate = questiondate;
		this.answertitle = answertitle;
		this.answercontents = answercontents;
		this.answerdate = answerdate;
	}

	@Override
	public String toString() {
		return "BoardVo [qnano=" + qnano + ", fk_userid=" + fk_userid + ", questiontitle=" + questiontitle
				+ ", questioncontents=" + questioncontents + ", questiondate=" + questiondate + ", answertitle="
				+ answertitle + ", answercontents=" + answercontents + ", answerdate=" + answerdate + "]";
	}

	
	
	
	
	

}












