package common.controller;

import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.lang.reflect.Constructor;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.Map;
import java.util.Properties;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebInitParam;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet(
			description = "사용자가 웹에서 *.an 을 했을 경우 이 서블릿이 응답해준다.", 
			urlPatterns = { "*.an" },
			initParams = { 
					@WebInitParam(name = "propertyConfig", value = "C:/Users/sist/git/AnnaSemiProject/AnnaSemiProject/WebContent/WEB-INF/Command.properties", description = "*.an 에 대한 클래스의 매핑파일")
			})
public class FrontController extends HttpServlet {
	
	private static final long serialVersionUID = 1L;
       
	Map<String, Object> cmdMap = new HashMap<>(); // 어떤 클래스라도 받아야해서 value 를 Object로 한다.

	
	// 이 init 메소드는 was 구동 후 처음에 딱 한번 읽어온다.
		public void init(ServletConfig config) throws ServletException {
			/*
			        웹브라우저 주소창에서  *.an 을 하면 FrontController 서블릿이 응대를 해오는데 
			        맨 처음에 자동적으로 실행되어지는 메소드가 init(ServletConfig config) 이다.
			        여기서 중요한 것은 init(ServletConfig config) 메소드는 WAS(톰캣)가 구동되어진 후
			        딱 1번만 init(ServletConfig config) 메소드가 실행되어지고, 그 이후에는 실행이 되지 않는다. 
			        그러므로 init(ServletConfig config) 메소드에는 FrontController 서블릿이 동작해야할 환경설정을 잡아주는데 사용된다.
		  */
			
			// Command.properties 파일에 가서 내용물을 읽어와야 한다.
			
			FileInputStream fis = null; // 특정 파일에 있는 내용을 읽어오기 위한 용도로 쓰이는 객체
			
			String props = config.getInitParameter("propertyConfig");
			// System.out.println("~~~ 확인용 props => " + props);
			// ~~~ 확인용 props => C:/NCS/workspace(jsp)/AnnaDiaPrj/WebContent/WEB-INF/Command.properties
			
			try {
				fis = new FileInputStream(props); // 빨대에 properties 주소로 객체를 하나 만든다.
				// fis 는 C:/NCS/workspace(jsp)/AnnaDiaPrj/WebContent/WEB-INF/Command.properties 파일의 내용을 읽어오기 위한 용도로 쓰이는 객체이다.
				
				
				Properties pr = new Properties();
				// Properties 는 Collection 중 HashMap 계열중의  하나로써
				// "key","value"으로 이루어져 있는것이다.
				// 그런데 중요한 것은 Properties 는 key도 String 타입이고, value도 String 타입만 가능하다는 것이다.
				// key는 중복을 허락하지 않는다. value 값을 얻어오기 위해서는 key값만 알면 된다.
				
				pr.load(fis);
				// InputStream 은 인터페이스이다. 여기에 InputStream 계열, 즉 FileInputStream 이 들어올 수 있다.
				// 이제 properties 의 key 와 value 가 pr 에 로드된다.
				/*
		         	pr.load(fis); 은  fis 객체를 사용하여 C:/NCS/workspace(jsp)/MyMVC/WebContent/WEB-INF/Command.properties 파일의 내용을 읽어다가 
		         	Properties 클래스의 객체인 pr 에 로드시킨다.
		         	그러면 pr 은 읽어온 파일(Command.properties)의 내용에서 
		         	= 을 기준으로 왼쪽은 key로 보고, 오른쪽은 value 로 인식한다. 띄어쓰기 하지 않도록 주의한다.
				 */
				
				Enumeration<Object> en = pr.keys();
				/*
		          pr.keys(); 은
		          C:/NCS/workspace(jsp)/MyMVC/WebContent/WEB-INF/Command.properties 파일의 내용물에서 
		          = 을 기준으로 왼쪽에 있는 모든 key 들만 가져오는 것이다.    
		       */
				
				while(en.hasMoreElements()) {
					
					String key = (String)en.nextElement(); // 원래 리턴타입은 Object 이지만, pr의 key가 String타입이어서 캐스팅함
					// System.out.println("~~~ 확인용 key 값들 =>" + key);
					/*
						~~~ 확인용 key 값들 =>/main.up
						~~~ 확인용 key 값들 =>/index.up
					*/
					
					// System.out.println("~~~ 확인용 value 값들 => " + pr.getProperty(key));
					/*
					 	~~~ 확인용 value 값들 => common.controller.MainController
						~~~ 확인용 value 값들 => common.controller.IndexController
					*/
					
					String className = pr.getProperty(key); // 이건 property 글자만 가져온 것. 가져온 property 를 클래스화 해서 그 안의 메소드를 돌리고 싶다.
					
					if(className != null) {
						className = className.trim();
						
						// 클래스를 객체화(인스턴스화) 하겠다. (설계도면)
						Class<?> cls = Class.forName(className); 
						// <?> 은 generic 인데 어떤 클래스 타입인지는 모르지만 하여튼 클래스 타입이 들어온다는 뜻이다.
		                // String 타입으로 되어진 className 을 클래스화 시켜주는 것이다.
		                // 주의할 점은 실제로 String 으로 되어져 있는 문자열이 클래스로 존재해야만 한다는 것이다.
						
						// Constructor<Object> constrt = cls.getDeclaredConstructor(); // 파라미터에 뭐 안넣었으므로 일단 기본생성자
						// Type mismatch: cannot convert from Constructor<capture#2-of ?> to Constructor<Object>
						Constructor<?> constrt = cls.getDeclaredConstructor(); // 파라미터에 뭐 안넣었으므로 일단 기본생성자
						// 생성자 만들기
						
						Object obj = constrt.newInstance();
						// 생성자로 실제 객체(인스턴스)생성
						
						// System.out.println("[확인용] : "+obj.toString());
						/*
						    [확인용] : >>> 확인용 MainController 클래스의 인스턴스 메소드인 toString() 호출함 <<< 
							[확인용] : == 확인용 IndexController 클래스의 인스턴스 메소드인 toString() 호출함 == 
						*/
						
						cmdMap.put(key, obj); // 예를들어, ("/main.up", key 에 해당하는 인스턴스) 이다.
						// 이렇게 객체를 생성한 후 저장해 두었다가, 필요할 때마다 사용하도록 일괄적으로 관리하기 위함이다.
						// cmdMap 에서 키값으로 Command.properties 파일에 저장되어진 url 을 주면 
			            // cmdMap 에서 해당 클래스에 대한 객체(인스턴스)를 얻어오도록 만든 것이다.
					}// end of if(className != null) -------------
					
				}// end of while(en.hasMoreElements())------------------
				
				
			} catch (FileNotFoundException e) {
				// properties 파일이 없을 수 있으니까
				System.out.println(">>>C:/NCS/workspace(jsp)/MyMVC/WebContent/WEB-INF/Command.properties 파일을 찾을 수 없습니다. <<<");
				e.printStackTrace();
			} catch (IOException e) {
				e.printStackTrace();
			} catch (ClassNotFoundException e) {
				// 이름만 존재하고 클래스가 없을 수 있으니까
				System.out.println(">>> 문자열로 명명된 클래스가 존재하지 않습니다. <<<");
				e.printStackTrace();
			} catch (Exception e) {
				// TODO: handle exception
			}
			
			
		}// end of public void init(ServletConfig config) --------------------


	
		protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
			// 웹브라우저 주소 입력창에서 
			// http://localhost:9090/MyMVC/member/idDuplicateCheck.up?userid=leess 라고 입력되었다면
			/*
				String url = request.getRequestURL().toString();
				System.out.println("~~ 확인용 url => " + url);
				// ~~ 확인용 url => http://localhost:9090/MyMVC/member/idDuplicateCheck.up
			*/
			String uri = request.getRequestURI();
			// System.out.println("== 확인용 uri => " + uri);
			// == 확인용 uri => /MyMVC/member/idDuplicateCheck.up
			
			String ctxPath = request.getContextPath();
			//		/MyMVC
			
			String key = uri.substring(ctxPath.length());
			// /member/idDuplicateCheck.up
			
			AbstractController action = (AbstractController)cmdMap.get(key); // map 에 저장된 인스턴스를 불러온다. 
			 // 클래스의 부모클래스가 똑같으니까 부모클래스로 받아온다.
			// key 에 맞는 각각의 인스턴스이다.
			
			if(action == null) {// 클래스가 없는 key property 를 url 에서 호출하거나, 없는 key property 를 호출시
				System.out.println(">>> "+key+" 는 URI 패턴에 매핑된 클래스가 없습니다. <<<");
			}
			else {// 매핑된 클래스가 있는 url 을 호출시
				
				try {
					action.execute(request, response);
					
					boolean bool = action.isRedirect(); 	// false 또는 true 
					String viewPage = action.getViewPage(); // .jsp 또는 .up
					
					if(!bool) {// .jsp 로 forward
						// viewPage 에 명기된 view단 페이지로 forward(dispatcher)를 하겠다는 말이다.
		                // forward 되어지면 웹브라우저의 URL주소 변경되지 않고 그대로 이면서 화면에 보여지는 내용은 forward 되어지는 jsp 파일이다.
		                // 또한 forward 방식은 forward 되어지는 페이지로 데이터를 전달할 수 있다는 것이다.
						
						if(viewPage != null) {
							RequestDispatcher dispatcher = request.getRequestDispatcher(viewPage);
							dispatcher.forward(request, response);
						}
					}
					else {// .up 로 sendRedirect
						// viewPage 에 명기된 주소로 sendRedirect(웹브라우저의 URL주소 변경됨)를 하겠다는 말이다.
			            // 즉, 단순히 페이지이동을 하겠다는 말이다. 
			            // 암기할 내용은 sendRedirect 방식은 sendRedirect 되어지는 페이지로 데이터를 전달할 수가 없다는 것이다.
						
						if(viewPage != null) {
							response.sendRedirect(viewPage);
						}
					}
					
				} catch (Exception e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}
			

		}

	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}