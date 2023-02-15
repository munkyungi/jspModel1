<%@page import="dto.BbsDto"%>
<%@page import="dao.BbsDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%
request.setCharacterEncoding("utf-8");

int seq = Integer.parseInt(request.getParameter("seq"));

String id = request.getParameter("id");
String title = request.getParameter("title");
String content = request.getParameter("content");

BbsDao dao = BbsDao.getInstance();

boolean isS = dao.answer(seq, new BbsDto(id, title, content));
if(isS){
	%>
	<script type="text/javascript">
		alert("답글이 입력되었습니다!");
		location.href = "bbslist.jsp";
	</script>
	<%
} else {
	 %>
	 <script type="text/javascript">
	 	alert("답글입력에 실패하였습니다.");
		location.href = "bbslist.jsp";
	 </script>
	 <%
}
%>

