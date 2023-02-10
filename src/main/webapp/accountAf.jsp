<%@page import="dto.MemberDto"%>
<%@page import="dao.MemberDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%
	request.setCharacterEncoding("utf-8");	// db에 넣기 전에는 꼭 설정해줘야지 한글이 안 깨진다.

	String id = request.getParameter("id");
	String pwd = request.getParameter("pwd");
	String name = request.getParameter("name");
	String email = request.getParameter("email");	
	
	// back-end
	MemberDao dao = MemberDao.getInstance();
	
	MemberDto dto = new MemberDto(id, pwd, name, email, 0);
	boolean isSuccess = dao.addMember(dto);
	
	if(isSuccess){	// 가입이 성공했으면
		%>
		<script type="text/javascript">
			alert("성공적으로 가입되었습니다!");
			location.href = "login.jsp";	// 로그인 창으로
		</script>
		<%
	} else {		// 가입이 실패했으면
		%>
		<script type="text/javascript">
			alert("다시 가입해 주십시오.");
			location.href = "account.jsp";	// 회원가입 창으로
		</script>
		<% 
	}
%>
