<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8" import="java.sql.*, java.util.*"%>
    <% request.setCharacterEncoding("UTF-8"); %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<body>
<center>
<br /><br /><br />
<h1>Welcome!!</h1>
<br /><br /><br />
<form action = "login.jsp" method="post" >
	ID <input type="text" name="id" /><br /><br />
	PW <input type="password" name="passwd" /><br /><br />
	<input type="submit" value="로그인"/>
	<input type="button" value="회원가입" onClick="window.location='signup.jsp'" />
	<input type="button" value="회원탈퇴" onClick="window.location='signdown.jsp'" />
	<input type="button" value="관리자모드" onClick="window.location='admin.jsp'" />
</form>
</center>
</body>
</html>