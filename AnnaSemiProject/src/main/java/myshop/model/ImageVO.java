package myshop.model;

//DTO(Data Transfer Object) == VO(Value Object)
public class ImageVO {

	private int imgno;          
	private String imgfilename;
	
	public int getImgno() {
		return imgno;
	}
	
	public void setImgno(int imgno) {
		this.imgno = imgno;
	}
	
	public String getImgfilename() {
		return imgfilename;
	}
	
	public void setImgfilename(String imgfilename) {
		this.imgfilename = imgfilename;
	}     
	
}
