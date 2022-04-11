package product.model_lsh;

public class ProductImageVO {

	private int imagefilenum;
	private int fk_productnum;
	private String imagefilename;
	
	
	public int getImagefilenum() {
		return imagefilenum;
	}
	public void setImagefilenum(int imagefilenum) {
		this.imagefilenum = imagefilenum;
	}
	public int getFk_productnum() {
		return fk_productnum;
	}
	public void setFk_productnum(int fk_productnum) {
		this.fk_productnum = fk_productnum;
	}
	public String getImagefilename() {
		return imagefilename;
	}
	public void setImagefilename(String imagefilename) {
		this.imagefilename = imagefilename;
	}	
}
