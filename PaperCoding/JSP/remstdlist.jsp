<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
 <%@ page import="dbpackage.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Remove Student list</title>
</head>
<body>
<%
Database db= new Database();
try
{
db.executeDBUpdate("delete from Student");
out.println("<body bgcolor='yellowgreen'><br><br><center><b>Student List Removed Successfully</b><br><a href='../StudentDetails.html'><b>Back</b></a></center></body> ");
}
catch(Exception e)
{
	out.println("<body  bgcolor='yellowgreen'><br><br><center><b>Unable to Remove Student List.<br><br><br> Please <a href='../RemoveStdList.html'> Retry </a> </b></center></body>");
}
finally
{
db.closeConnections();
}
%>
</body>
</html>