package com.sapum.aop;

import java.net.URLDecoder;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.LinkedList;
import java.util.Queue;

import javax.inject.Inject;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.aspectj.lang.ProceedingJoinPoint;
import org.aspectj.lang.annotation.Around;
import org.aspectj.lang.annotation.Aspect;
import org.springframework.http.codec.json.Jackson2JsonEncoder;
import org.springframework.stereotype.Component;
import org.springframework.ui.Model;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;
import org.springframework.web.servlet.ModelAndView;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.sapum.domain.work.WorkDTO;
import com.sapum.service.work.WorkService;

// 로그 수집 작업을 하려면 모든 메서드에 해야 함
// 로그 수집은 중요한 업무이지만 핵심적인 업무는 아니고 공통적인 업무에 해당 됨
// 공통적인 업무는 모든 class의 모든 method에 작성하지말고
// Advice에 모아서 작성하고 세부적인 코드에서는 핵심 업무에 집중하도록 처리

@Component // 스프링 beans로 등록되기 위한 설정
@Aspect    // AOP bean - 공통 업무를 지원하는 코드
public class WatchList {
    // 포인트컷 - 실행 시점,
    // Around ( 메서드 실행 전후 )
    // Before ( 메서드 실행 전 )
    // After ( 메서드 실행 후 )
	
	@Inject private WorkService wService;
	
	// @Around 메서드 실행 전후로 AOP를실행시키기 위함
	@Around("execution(* com.sapum.controller.work.WorkController.*(..))")
    public Object workAOP(ProceedingJoinPoint joinPoint) throws Throwable {
    	
		// joinPoint -> 핵심업무를 수행하는 메서드들의 정보가 담겨있음
		String method = joinPoint.getSignature().getName(); // 실행된 메서드의 이름을 찾음
		String type = joinPoint.getSignature().getDeclaringTypeName();
		System.out.println("++++++++++++ " + type + " 의 " + method + " 메서드가 실행되었습니다 " + "++++++++++++");
		
		//해당페이지에 접근하며 주고받는 request와 response 정보를 가져옴
		//AOP에서 request와 response의 정보를 가져오는 방법은 아래와 같다.
		HttpServletRequest request = ((ServletRequestAttributes) RequestContextHolder.currentRequestAttributes()).getRequest();
		HttpServletResponse response = ((ServletRequestAttributes) RequestContextHolder.currentRequestAttributes()).getResponse();
		
        Object result = joinPoint.proceed(); // 핵심업무 실행
        
        
        //작품 상세보기 페이지에 접근시
		if(method.equals("view")) { // 실행된 메서드의 이름이 view일때 해당 if문 실행 (어떠한 작품을 봤을 때)
			//쿠키 정보를 가져오기 위한 객체선언
			// request.getCookies -> 클라이언트가 물고다니는 모든 쿠키 목록을 가져옴(배열형태)
			// 특정쿠키를 가져오는 것이 불가능해서 배열로 통째로 가져옴
			Cookie[] cookieList = request.getCookies();
			// 출력되는 목록의 수를 제어하기위해서 변수선언
			Cookie tempCookie = null;
			ArrayList<Integer> watchList = new ArrayList<Integer>();
			//쿠키에 json타입으로 넣고 빼줄 jackson객체 선언
			//ObjectMapper -> json을 객체로 바꿔주거나, 객체를 json으로 바꿔줄 때 사용 함.
			ObjectMapper mapper = new ObjectMapper();
			// joinPoint.getArgs() -> 실행되는 메서드의 매개변수 목록
			Model model = (Model) joinPoint.getArgs()[1];
			// model.asMap().get("one") -> 모델 내의 데이터를 map형태로 불러와서 one이라는 이름으로 호출
			WorkDTO wDto = (WorkDTO) model.asMap().get("one");
			
			int wno = wDto.getWno();
			
			// 쿠키 목록중 watchlist 쿠키가 있는지 확인하고 있으면 tempCookie에 담음
			// watchlist에 들어갈 데이터를 10개로 제한하기 위함
			for (Cookie cookie : cookieList) {
				if(cookie.getName().equals("watchlist")) {
					tempCookie = cookie;
				}
			}
			// watchlist에 데이터가 있을 경우 해당 쿠키에 URL인코딩된 Json 데이터를 디코딩한 후
			// ArrayList 형태로 바꿔서 저장
			if(tempCookie!= null) {
				watchList = mapper.readValue(URLDecoder.decode(tempCookie.getValue(),"UTF-8"),ArrayList.class);
			}
			// 만약 watchlist에 있는 데이터가 이미 10개 인 경우 가장 앞에 있는 데이터를 제거
			if(watchList.size()==10) {
				watchList.remove(0);
			}
			// 만약 watchlist에 이미 현재 조회중인 게시물과 동일한 게시물의 조회 기록이 있을 경우 제거
			// 중간에 있는 중복 데이터는 제거하고 다시 뒷쪽으로 추가해주기 위함
			if(watchList.contains(wno)) {
				watchList.remove(watchList.indexOf(wno));
			}
			
			watchList.add(wno);

			// ArrayList 데이터를 다시 Json타입으로 변형
			String readJson = mapper.writeValueAsString(watchList);
			// Json타입의 영어, 숫자 외의 데이터는 담을 수 없으므로 URL인코딩후 쿠키 생성
			// setPath는 해당 쿠키가 적용되는 경로, setMaxAge는 쿠키의 수명
			Cookie cookie = new Cookie("watchlist", URLEncoder.encode(readJson,"UTF-8"));
			cookie.setPath("/sapum");
			cookie.setMaxAge(24*60*60*365);
			response.addCookie(cookie);
		}
        return result;
    }
}