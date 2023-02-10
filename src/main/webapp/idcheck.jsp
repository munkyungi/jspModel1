<%@page import="dao.MemberDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
	String id = request.getParameter("id");
	System.out.println("id: " + id);

	MemberDao dao = MemberDao.getInstance();	// 싱글톤 MemberDao 생성
	
	boolean b = dao.getId(id);
	
	if(b == true){	// id data가 이미 있으면
		out.println("NO");
	} else {		// id가 없음
		out.println("YES");
	}
%>