<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8" import="java.sql.*, java.util.*"%>
<%
	request.setCharacterEncoding("UTF-8");
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
<p align="center"><input  type="button" value="이전화면" onClick="window.location='main.jsp'" /></p>
<br />
<br />
<table align="center" border="1" cellpadding="1" cellspacing="0"
		width="85%">
		<tr bgcolor=f7e091>
			<td height="29">
				<p align="center">
					<b>책 이름</b></font>
				</p>
			</td>
			<td height="29">
				<p align="center">
					<b>작가</b></font>
				</p>
			</td>
			<td height="29">
				<p align="center">
					<b>장르</b></font>
				</p>
			</td>
		</tr>

<%
	String name = request.getParameter("name");

	Connection conn = null;
	PreparedStatement prmt = null;
	ResultSet rs = null;

	try {
		String jdbcURL = "jdbc:mysql://localhost:3306/basicjsp";
		String dbid = "jspid";
		String dbpwd = "jspass";

		Class.forName("com.mysql.jdbc.Driver");
		conn = DriverManager.getConnection(jdbcURL, dbid, dbpwd);
		String sql = "select * from book where name like '%" + name + "%'";
		prmt = conn.prepareStatement(sql);
		rs = prmt.executeQuery(sql);
		
		if(!rs.next()){
			%>
			<script>
			alert("해당 정보 없음");
			history.go(-1);
			</script>
			<%
		} else {
			rs.previous();
		}
		
		while(rs.next()){
			String namee =rs.getString("name");
			String writer =rs.getString("writer");
			String genre =rs.getString("genre"); %>
			<tr>
			<td width="167" height="38">
				<p align="center"><%=namee%></p>
			</td>
			<td width="167" height="38">
				<p align="center"><%=writer%></p>
			</td>
			<td width="167" height="38">
				<p align="center"><%=genre%></p>
			</td>
			</tr>
		
			
			 <%
		}
	} catch (SQLException E) {
		out.println("다음과 같은 오류가 발생하였습니다. " + "<p>");
		out.println(E.toString());
	}
%>



</body>
</html>