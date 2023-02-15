<%@page import="dto.BbsDto"%>
<%@page import="dao.BbsDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>


<script type="text/javascript">
</script>

<%
	request.setCharacterEncoding("utf-8");	// db에 넣기 전에는 꼭 설정해줘야지 한글이 안 깨진다.

	String id = request.getParameter("id");
	String title = request.getParameter("title");
	String content = request.getParameter("content");

	// back-end
	BbsDao dao = BbsDao.getInstance();
	
	BbsDto dto = new BbsDto(id, title, content);

	boolean isSuccess = dao.addBbslist(dto);
	
	if(isSuccess){
		%>
		<script type="text/javascript">
			alert("글이 등록되었습니다!");
			location.href = "bbslist.jsp";
		</script>
		<%
	} else {
		%>
		<script type="text/javascript">
			alert("다시 작성해 주십시오.");
			location.href = "bbsWrite.jsp";
		</script>
		<% 
	}
%>