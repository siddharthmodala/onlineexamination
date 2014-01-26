<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>
<%@ page import="dbpackage.*" %>    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Enter Marks Prompt</title>
</head>
<body bgcolor="lightgray">
<%
String value=request.getParameter("ccode")+request.getParameter("subname")+request.getParameter("doe")+request.getParameter("moe")+request.getParameter("yoe");
String table="";
StringTokenizer stk=new StringTokenizer(value," ");
while(stk.hasMoreTokens())
	table+=stk.nextToken();
response.addCookie(new Cookie("table",table));

Database db=new Database();
try
{
	db.executeDBQuery("select * from "+table);
	response.addCookie( new Cookie("table",table));
	response.sendRedirect("../EnterMarks.html");
}
catch(Exception e)
{
	out.println("<body><br><br><center><b>Code Table Doesn't exist. Please enter Codes first.<br><br><a href='../MarksSubPrompt.html' target='f3'>Back</a></center></body>");
}
%>
</body>
</html>