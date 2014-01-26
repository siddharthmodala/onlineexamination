<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*" %>
<%@ page import="dbpackage.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Remove Student</title>
</head>
<body>
<%
String sno=request.getParameter("stpno");
Database db= new Database();
try
{	
ResultSet rs = db.executeDBQuery("select * from student where StdNo='"+sno+"'");
if(rs.next())
{
db.executeDBUpdate("delete from Student where StdNo='"+sno+"'");
out.println("<body bgcolor='yellowgreen'><br><br><center><b>Student Removed Successfully</b><br><a href='../StudentDetails.html'><b>Back</b></a></center></body> ");
}
else
{
out.println("<body  bgcolor='yellowgreen'><br><br><center><b>Student Number doesn't exist.<br><br>Please <a href='../RemoveStd.html'>Retry</a></b></center></body> ");
}
}
catch(Exception e)
{
	out.println("<body  bgcolor='yellowgreen'><br><br><center><b>Unable to Remove Student. (Stipend no. might not exist.)<br><br><br> Please <a href='../RemoveStd.html'> Retry </a> </b></center></body>");
}
finally
{
 db.closeConnections();
}
%>
</body>
</html>