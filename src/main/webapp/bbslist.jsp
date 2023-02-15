<%@page import="java.util.List"%>
<%@page import="dao.BbsDao"%>
<%@page import="dto.BbsDto"%>
<%@page import="dto.MemberDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%!
// 답글용 화살표 추가 함수
public String  arrow(int depth){
	String img = "<img src='./img/arrow.png' width='15px' height='15px' />";
	String nbsp= "&nbsp;&nbsp;&nbsp;&nbsp;";
	
	String ts = "";
	
	for(int i=0; i<depth; i++){
		ts += nbsp;
	}
	
	return depth==0? "" : ts + img;
}
%>

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
%>

<!DOCTYPE html>
<html>

<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>

<body>

<%

String choice = request.getParameter("choice");
String search = request.getParameter("search");

if(choice == null){
	choice = "";
}
if(search == null){
	search = "";
}

BbsDao dao = BbsDao.getInstance();

// 현재 페이지 설정
String sPageNumber = request.getParameter("pageNumber");
int pageNumber = 0;
if(sPageNumber != null && !sPageNumber.equals("")){
	pageNumber = Integer.parseInt(sPageNumber);
}

// db에서 글목록 가져오기
//List<BbsDto> list = dao.getBbslist();	// 검색 없을 때
//List<BbsDto> list = dao.getBbsSearchlist(choice, search);	
List<BbsDto> list = dao.getBbsPageList(choice, search, pageNumber);	

// 글의 총 개수
int count = dao.getAllBbs(choice, search);

// 페이지의 총수
int pageBbs = count / 10;	// 10개씩 페이지를 나눠 보여줌
if((count % 10) > 0){		// 10개로 나눴을 때 페이지가 딱 떨어지지 않으면 페이지 수 +1
	pageBbs = pageBbs + 1;
}

%>

<h1>List</h1>

<div align="center">
	<table>
		<colgroup>
			<col width="70">
			<col width="600">
			<col width="100">
			<col width="150">
		</colgroup>
		
		<thead>
			<tr>
				<th>번호</th>
				<th>제목</th>
				<th>조회수</th>
				<th>작성자</th>
			</tr>
		</thead>
		
		<tbody>
			<%
			if(list == null || list.size() == 0){
			%>
				<tr>
					<td colspan="4">작성된 글이 없습니다.</td>
				</tr>
			<%
			} else {
				for(int i=0; i<list.size(); i++)
				{
					BbsDto dto = list.get(i);
					%>
					<tr>
						<th><%=i + 1 %></th>
						<td>
							<%=arrow(dto.getDepth()) %>
							
							<% if(dto.getDel() == 0) { %>
								<a href="bbsDetail.jsp?seq=<%=dto.getSeq() %>">
								<%=dto.getTitle() %>
								</a>
							<%} else if(dto.getDel() == 1) {%>
								삭제된 게시글 입니다.
							<%} %>
						</td>
						<td><%=dto.getReadcount() %></td>
						<td><%=dto.getId() %></td>
					</tr>
					<%
				}
			}
			%>
		</tbody>
	</table>
	<br>
	
	<%
	for(int i=0; i<pageBbs; i++){
		if(pageNumber == i){	// 현재 페이지일 때
			%>
			<span style="font-size: 15pt; color: #0000ff; font-weight: bold;">
				<%=i+1 %>
			</span>
			<%
		} else {
			%>
			<a href="#none" title="<%=i+1%>페이지" onclick="goPage(<%=i %>)" style="font-size: 15pt; color: #000; font-weight: bold; text-decoration: none;">
				[<%=i+1 %>]
			</a>
			<%
		}
	}
	%>
	<br><br>
	
	<select id="choice">
		<option value="">검색</option>
		<option value="title">제목</option>
		<option value="content">내용</option>
		<option value="writer">작성자</option>
	</select>
	
	<input type="text" id="search" value="<%=search %>">
	
	<button type="button" onclick="searchBtn()">검색</button>
	<br><br>
	
	<a href="bbsWrite.jsp">글쓰기</a>
</div>

<script type="text/javascript">

let search = "<%=search %>";

// 검색어가 있을 시, 처리
if(search != ""){
	let obj = document.getElementById("choice");
	obj.value = "<%=choice %>";
	obj.setAttribute("selected", "selected");

	// 한줄로 요약 가능
	// document.getElementById("choice").value = "<%=choice %>";
}

function searchBtn() {
	let choice = document.getElementById('choice').value;
	let search = document.getElementById('search').value;
	
	/*
	if(choice == ""){
		alert("카테고리를 선택해 주십시오.");
		return;
	}
	if(search.trim() == ""){
		alert("검색어를 입력해 주십시오.");
		return;
	}
	*/
	
	location.href = "bbslist.jsp?choice=" + choice + "&search=" + search;
}

function goPage(pageNumber) {
	let choice = document.getElementById('choice').value;
	let search = document.getElementById('search').value;

	location.href = "bbslist.jsp?choice=" + choice + "&search=" + search + "&pageNumber=" + pageNumber;
}
</script>

</body>

</html>