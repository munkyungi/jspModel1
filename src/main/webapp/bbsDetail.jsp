<%@page import="dto.MemberDto"%>
<%@page import="dto.BbsDto"%>
<%@page import="dao.BbsDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<% 
MemberDto login = (MemberDto)session.getAttribute("login");
if(login == null){	// 세션이 만료되거나 로그인이 안 된 상태로 접속했을 때
	%>
		<script type="text/javascript">
			alert("로그인 해주십시오.");
			location.href = "login.jsp";
		</script>
	<%
}

int seq = Integer.parseInt(request.getParameter("seq"));

BbsDao dao = BbsDao.getInstance();

// readcount 설정
if(!dao.getBbsRead(login.getId(), seq)){ // 현재 계정으로 조회한 적이 없으면
	dao.updateReadCount(seq);			 // readcount 증가 + 기록저장
}

BbsDto dto = dao.getBbs(seq);

%>

<!DOCTYPE html>
<html>

<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<style type="text/css">
.center{
	margin: auto;
	width: 50%;
	border: 3px solid tomato;
	padding: 10px;
}
</style>

</head>

<body>

<h1>상세 글보기</h1>

<div class="center">

	<table border="1" align="center">
		<col width="100">
		<col width="500">
		<tr>
			<th>제목</th>
			<td><%=dto.getTitle() %></td>
		</tr>
		<tr>
			<th>작성자</th>
			<td><%=dto.getId() %></td>
		</tr>
		<tr>
			<th>작성일</th>
			<td><%=dto.getWdate() %></td>
		</tr>
		<tr>
			<th>조회수</th>
			<td><%=dto.getReadcount() %></td>
		</tr>
		<tr>
			<th>답글정보</th>
			<td><%=dto.getRef() %>-<%=dto.getStep() %>-<%=dto.getDepth() %></td>
		</tr>
		<tr>
			<th>내용</th>
			<td><%=dto.getContent() %></td>
		</tr>
	</table>
	<br><br>
	
	<% 
	if(login.getId().equals(dto.getId())) {
		%>
		<button type="button" onclick="updateBbs(<%=seq %>)">수정</button>
		<button type="button" onclick="deleteBbs(<%=seq %>)">삭제</button>
		<%
	}
	%>
	<button type="button" onclick="answerBbs(<%=seq %>)">답글</button>
	<button type="button" onclick="location.href='bbslist.jsp'">글목록</button>
</div>


<script type="text/javascript">
function answerBbs( seq ) {
	location.href = "answer.jsp?seq=" + seq;
}
function updateBbs( seq ) {
	location.href = "updateBbs.jsp?seq=" + seq;
}
function deleteBbs( seq ) {
	if (confirm("정말 삭제하시겠습니까?") == true){
		location.href = "deleteBbsAf.jsp?seq=" + seq;
	 }
}


</script>


</body>

</html>