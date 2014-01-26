<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
   <%@ page import="java.sql.*" %>
   <%@ page import="dbpackage.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Add Student</title>
</head>
<body>
<%
String sname=request.getParameter("sname");
String sno=request.getParameter("stpno");
try 
{
Database db =new Database();
try
{	
db.executeDBUpdate("insert into Student values ('"+sno+"','"+sname+"')");
out.println("<body  bgcolor='yellowgreen'><br><br><center><b>Student Added Successfully</b><br><a href='../StudentDetails.html'><b>Back</b></a></center></body> ");
db.closeConnections();
//response.sendRedirect("../AddStd.html");
}
catch(Exception e)
{
	out.println("<body  bgcolor='yellowgreen'><br><br><center><b>Unable to add Student. (Stipend no. might already exist.)<br><br><br> Please <a href='../AddStd.html'> Retry </a> </b></center></body>");
}
}
catch(Exception e)
{
	out.println("<center>Unable to connect to Database.</center>");
}
%>
</body>
</html>