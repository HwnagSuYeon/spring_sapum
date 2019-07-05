<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!-- jstl 라이브러리를 사용하기 위한 선언문 -->
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<!-- font awsome -->
<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.8.1/css/all.css" integrity="sha384-50oBUHEmvpQ+1lW4y57PTFmhCaXp0ML5d60M1M7uH2+nqUivzIebhndOJK28anvf" crossorigin="anonymous">
<!-- jQuery -->
<script src="http://code.jquery.com/jquery-1.11.1.min.js" type="text/javascript"></script>
<!-- jstl, el태그로 컨택스트경로 -->
<c:set var="path" value="${pageContext.request.contextPath}"/>
<!-- favicon:파비콘은 모든 페이지에 들어가니까 -->
<link rel="icon" type="image/jpg" href="${path}/resources/img/pavi.png">