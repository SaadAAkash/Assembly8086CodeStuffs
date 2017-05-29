import java.awt.image.BufferedImage;
import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.IOException;
import javax.imageio.ImageIO;

/*
 * @author mkyong
 *
 */
public class ImageTest {

   public static void main(String [] args){
		
   try{
			
	BufferedImage originalImage = 
                              ImageIO.read(new File("e:\\games\\imgprocess\\akash.png"));
			
	ByteArrayOutputStream baos = new ByteArrayOutputStream();
	ImageIO.write( originalImage, "png", baos );
	baos.flush();
	byte[] imageInByte = baos.toByteArray();
	baos.close();
			
	}catch(IOException e){
		System.out.println(e.getMessage());
	}		
   }	
}