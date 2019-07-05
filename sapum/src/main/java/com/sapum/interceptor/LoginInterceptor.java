package com.sapum.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.servlet.FlashMap;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;
import org.springframework.web.servlet.support.RequestContextUtils;

import lombok.extern.slf4j.Slf4j;
@Slf4j
public class LoginInterceptor extends HandlerInterceptorAdapter{
	
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		// session 체크, 값이 있으면 통과
		// 없으면 돌려보냄 -> 원래페이지로 돌려보내서 모달창 ON, 에러메세지 출력
		HttpSession session = request.getSession();
		if (session.getAttribute("userid") == null) {
			// 로그인이 안된상태
			log.info("session값 없음-> 로그인필요");
			// ajax가 아니므로 돌아갈 페이지를 정해줌
			// referer의 역할-> getHeader가 전페이지의 정보를 갖고있음. 아래의 코드는 샌드리다이렉트 방법으로 전페이지로 돌려보내는 역할.
			String referer = request.getHeader("referer");
			String uri = request.getRequestURI();
			int index = referer.lastIndexOf("/"); // String 값이 아닌 int. /board/create중 두번째 슬러시의 뒤를 뜻함 = 6
			int length = referer.length(); // 글자의 전체 길이를 구함 = 12
			String url = referer.substring(index, length); // 자르는 역할 index~length까지 자르라는 뜻
			// 원래 uri는 뒤에 붙은 쿼리스트링 못읽는데,answer 를 탔을 때 뒤에있는 bno를 읽기위한 코드임
			String query = request.getQueryString();
			// getQueryString -> 이것도 ?는 붙여주지 않아. 그래서 else에 ?를 더해준것.
			if(query == null || query.equals("null")) {
				query = "";
			} else {
				query = "?" + query;
			}
			
			// board/create 전체부분에서 board만 가져옴. referer.substring(index, length); ==>의 반대가 되는 부분 -> 0,index
			String replaceURL = referer.substring(0,index);
			if (replaceURL.contains("board")) { // contains => ()안의 문자가 포함되어있냐 되어있지 않나를 true, false로 반환
				// 위의 조건이 true일 경우 -> bloard/list로 보내줌
				referer = replaceURL+"/list";
			} else if (replaceURL.contains("work")) {
				referer = replaceURL+"/list";
			} else if (replaceURL.contains("member")) {
				referer = request.getContextPath();
			}
			
			
			
			
			log.info("수정된 URL" + url);
			
			
			// login 페이지로 이동
			// 로그인 안된상태로 게시글 등록버튼 누름 -> 모달창이뜨면서 로그인하라고함
			// 로그인 한 후 다시 게시글 등록버튼 누름 -> 전에는 쿼리스트링으로 로그인 안한 정보를 보내줘서 로그인 해도 nologin이라고 떠서 모달창이 계속 뜸.
			FlashMap flashMap = RequestContextUtils.getOutputFlashMap(request);
			flashMap.put("message", "nologin");
			// board/answer를 탔을 때 bno를 받기위함
			flashMap.put("uri", (uri+query));
			log.info(">>>URI" + uri);
			
			RequestContextUtils.saveOutputFlashMap(referer, request, response);
			// 어디로 가라고 정해줌
			response.sendRedirect(referer);
			
			return false;
		} else {
			log.info("sesson값 있음-> Action단 이동");
			return true;
		}
	
		// return에 들어올 수 있는 값은 두가지.
		// true -> 메인액션 실행
		// false -> 메인액션 실행 못함. 돌아가게만듦.
	}
}
