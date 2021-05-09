﻿<%@ page language="java" import="java.util.*" import="java.sql.*" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%@ page import="com.oreilly.servlet.MultipartRequest, com.oreilly.servlet.multipart.DefaultFileRenamePolicy" %>
<% request.setCharacterEncoding("utf-8"); %>
<%@ include file = "/chap10/include/dbinfo.inc" %>
<%
String realFolder = "";
String saveFolder = "/chap10/boardD/upfile";
String encType = "utf-8";

int sizeLimit = 10 * 1024 * 1024;
realFolder = application.getRealPath(saveFolder);
MultipartRequest multi	= new MultipartRequest(request, realFolder, sizeLimit, encType);

PreparedStatement pstmt = null;

try
{
	String writername	= multi.getParameter("writername");  
	String title		= multi.getParameter("title");
	String contents		= multi.getParameter("contents");

	String fileName1	= multi.getFilesystemName("file1");
	String fileName2	= multi.getFilesystemName("file2");

	String strSQL ="INSERT INTO boardD(title, contents, writer, writedtm, updatedtm, upfile1, upfile2) VALUES (?, ?, ?, ?, ?, ?, ?)";
	pstmt = con.prepareStatement(strSQL);

	Calendar dateIn = Calendar.getInstance();
	String indate = Integer.toString(dateIn.get(Calendar.YEAR))		+ "-";
	indate = indate + Integer.toString(dateIn.get(Calendar.MONTH)+1)	+ "-";
	indate = indate + Integer.toString(dateIn.get(Calendar.DATE))		+ " ";
	indate = indate + Integer.toString(dateIn.get(Calendar.HOUR_OF_DAY))	+ ":";
	indate = indate + Integer.toString(dateIn.get(Calendar.MINUTE))		+ ":";
	indate = indate + Integer.toString(dateIn.get(Calendar.SECOND));

	pstmt.setString(1, title);
	pstmt.setString(2, contents);
	pstmt.setString(3, writername);
	pstmt.setString(4, indate);
	pstmt.setString(5, indate);
	pstmt.setString(6, fileName1);
	pstmt.setString(7, fileName2);
	pstmt.executeUpdate();


} // try end

catch(SQLException e1){
	out.println(e1.getMessage());
} // catch SQLException end

catch(Exception e2){
	e2.printStackTrace();
} // catch Exception end

finally{
	if (pstmt != null) pstmt.close();
	if (con   != null) con.close();

	response.sendRedirect("boardDlist.jsp");
} // finally end
%>