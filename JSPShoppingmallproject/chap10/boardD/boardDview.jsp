﻿<%@ page language="java" import="java.sql.*" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<% request.setCharacterEncoding("utf-8"); %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML>
 <HEAD>
  <TITLE>파일 게시판 상세보기</TITLE>
 </HEAD>

<script language=javascript>
function submit_modify()
{
	document.frm1.action = "boardDmodify.jsp";
	document.frm1.submit();
}

function submit_delete()
{
	document.frm1.action = "boardDdelConfirm.jsp";
	document.frm1.submit();
}

function submit_list()
{
	document.frm1.action = "boardDlist.jsp";
	document.frm1.submit();
}

</script>

<%@ include file = "/chap10/include/dbinfo.inc" %>		

<%
PreparedStatement pstmt = null;
ResultSet rs = null;

try
{
	int num = Integer.parseInt(request.getParameter("pnum"));

	String strSQL = "SELECT num, title, contents, writer, CONVERT(CHAR(10), updatedtm, 120) writedt, readcnt, upfile1, upfile2 FROM boardD WHERE num = ?";
	pstmt = con.prepareStatement(strSQL);
	pstmt.setInt(1, num);
	rs = pstmt.executeQuery();

	if (rs.next() == false)
		out.print("등록된 게시글이 없습니다.");
	else
	{
		String writer		= rs.getString("writer");
		String title		= rs.getString("title");
		String contents = rs.getString("contents");
		String writedt  = rs.getString("writedt");
		int readcnt			= rs.getInt("readcnt");
		String upfile1  = rs.getString("upfile1");
		String upfile2  = rs.getString("upfile2");
		String ext1     = null;
		if (upfile1 != null) {
			ext1 =  upfile1.substring(upfile1.indexOf(".") + 1);
		}
		String ext2     = null;
		if (upfile2 != null) {
			ext2 =  upfile2.substring(upfile2.indexOf(".") + 1);
		}
		
		strSQL = "UPDATE boardD SET readcnt = readcnt + 1 WHERE num = ?";
		pstmt = con.prepareStatement(strSQL);
		pstmt.setInt(1, num);
		pstmt.executeUpdate();

%>
		<h3>파일 게시판</h3>
		<BODY>
		<TABLE WIDTH = "500" BORDER = "1" CellPadding = "0" CellSpacing = "0">
			<TR>
				<TD WIDTH = "40%" ALIGN = "left">작성자명</TD>
				<TD WIDTH = "60%" ALIGN = "left"><%= writer %></TD>
			</TR>
			<TR>
				<TD WIDTH = "40%" ALIGN = "left">제목</TD>
				<TD WIDTH = "60%" ALIGN = "left"><%= title %></TD>
			</TR>
			<TR>
				<TD WIDTH = "40%" ALIGN = "left">첨부</TD>
				<TD WIDTH = "60%" ALIGN = "left">
<%
				if (upfile1 != null) {
					ext1 = ext1.toLowerCase();
					if (ext1.equals("jpg") || ext1.equals("bmp") || ext1.equals("gif") || ext1.equals("png"))
						out.print ("<IMG SRC='/chap10/boardD/upfile/" + upfile1 +"' WIDETH = 100 HEIGHT = 100>");
					else
						out.print ("<A HREF='boardDfiledown.jsp?pnum=" + num +"&ftype=1'><IMG SRC='/chap10/boardD/icon_file.gif'> " + upfile1 + "</A>");
				}
				if (upfile2 != null) {
					ext2 = ext2.toLowerCase();
					if (ext2.equals("jpg") || ext2.equals("bmp") || ext2.equals("gif") || ext2.equals("png"))
						out.print ("<BR><IMG SRC='/chap10/boardD/upfile/" + upfile2 +"' WIDETH = 100 HEIGHT = 100>");
					else
						out.print ("<BR><A HREF='boardDfiledown.jsp?pnum=" + num +"&ftype=2'><IMG SRC='/chap10/boardD/icon_file.gif'> " + upfile2 + "</A>");
				}
%>
				</TD>
			</TR>
			<TR>
				<TD WIDTH = "40%" ALIGN = "left">내용</TD>
				<TD WIDTH = "60%" ALIGN = "left">
					<TEXTAREA NAME="contents" ROWS=5 COLS=50 disabled><%= contents %></TEXTAREA>
				</TD>
			</TR>
			<TR>
				<TD WIDTH = "100%" ALIGN = "center" COLSPAN = "2">
				<FORM NAME = "frm1" METHOD = "post">
				<INPUT TYPE = "hidden" NAME = pnum VALUE = <%= num %>>
				<TABLE>
					<TR>
						<TD WIDTH = "33%" ALIGN = "center">
							<INPUT TYPE = "button" VALUE = "수정하기" onclick = "submit_modify()">
						</TD>
						<TD WIDTH = "33%" ALIGN = "center">
							<INPUT TYPE = "button" VALUE = "삭제하기" onclick = "submit_delete()">
						</TD>
						<TD WIDTH = "*%" ALIGN = "center">
							<INPUT TYPE = "button" VALUE = "목록으로" onclick = "submit_list()">
						</TD>
					</TR>
				</TABLE>
				</FORM>
				</TD>
			</TR>
		</TABLE>
		</BODY>
<%
	} // if (rs.next() == false) else end

} //try end

catch(SQLException e1){
	out.println(e1.getMessage());
} // catch SQLException end

catch(Exception e2){
	e2.printStackTrace();
} // catch Exception end

finally{
	if (pstmt != null) pstmt.close();
	if (rs    != null) rs.close();
	if (con   != null) con.close();
} // finally end
%>
</HTML>