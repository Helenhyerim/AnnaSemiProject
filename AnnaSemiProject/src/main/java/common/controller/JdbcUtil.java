package common.controller;

import java.sql.Connection;
import java.sql.SQLException;

import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

public class JdbcUtil {
	private static JdbcUtil instance = new JdbcUtil();
	
	private static DataSource ds;
	
	static {
		try {
			Class.forName("oracle.jdbc.OracleDriver");
			System.out.println("드라이버 로딩 성공!");
			try {
				InitialContext ctx = new InitialContext();
				ds = (DataSource)ctx.lookup("java:comp/env/jdbc/mymvc_oracle");
				System.out.println("Connection Pool 생성!");
				
			} catch (NamingException e) {
				
				e.printStackTrace();
			}
			
		}catch(ClassNotFoundException e) {
			e.printStackTrace();
		}
	}
	
	private JdbcUtil() {}
	
	public static JdbcUtil getInstance() {
		return instance;
		
	}

	public Connection getConnection() throws SQLException {
		return ds.getConnection(); // 풀에서 커넥션 반환
		
	}
}

