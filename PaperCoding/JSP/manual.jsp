<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
 <%@ page import="java.sql.*" %>
 <%@ page import="dbpackage.*" %>
 <%@ page import="java.util.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Manual Code</title>
</head>
<body bgcolor="Thistle">
<%
String name=request.getParameter("subname");
String date=request.getParameter("doe")+request.getParameter("moe")+request.getParameter("yoe");
String code=request.getParameter("ccode");
String value=code+name+date;
String table="";

StringTokenizer stk=new StringTokenizer(value," ");
while(stk.hasMoreTokens())
	table+=stk.nextToken();

Database db=new Database();
ResultSet rs=null;
ResultSetMetaData rsmd=null;
try
{
	rs=db.executeDBQuery("select * from "+table);
	response.addCookie(new Cookie("table",table));
    response.sendRedirect("../CodeEntryOptions.html");
}
catch(Exception e)
{
	db.executeDBUpdate("create table "+table+" (StdNo Text NOT NULL, StdName Text ,StdCode Number UNIQUE NOT NULL, StdMarks Number,primary key(StdNo))");
	response.addCookie(new Cookie("table",table));
    response.sendRedirect("../CodeEntryOptions.html");
}
%>
</body>
</html>