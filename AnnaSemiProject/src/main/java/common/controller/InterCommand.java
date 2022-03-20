package common.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public interface InterCommand {
	// 여기서 미완성 메소드를 만듦으로써 모든 controller 에서 execute 메소드를 재정의 하도록 강제한다.
	void execute(HttpServletRequest request, HttpServletResponse response) throws Exception;
}
