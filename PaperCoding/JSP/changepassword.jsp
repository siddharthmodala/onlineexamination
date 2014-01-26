<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
 <%@ page import="java.sql.*" %>  
 <%@ page import="dbpackage.*" %> 
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Change Password</title>
</head>
<body>
<%
Database db= new Database();
ResultSet rs=null;
String userid=request.getParameter("loginid");
String opswd=request.getParameter("oldpswd");
String npswd=request.getParameter("newpswd");
try{
	rs= db.executeDBQuery("select Password from Login where LoginID='"+userid+"'");
	rs.next();
	if ((rs.getString(1)).equals(opswd))
	{
		try {
		db.executeDBUpdate("update Login set Password='"+npswd+"' where LoginID='"+userid+"'");
		out.println("<body bgcolor='CornflowerBlue'><br><br><center><b>Password Successfully Changed</b><br><a href='../Show.html'><b>Back</b></a></center></body> ");
		}
		catch(Exception e)
		{
			out.println(" <body bgcolor='CornflowerBlue'><br><br><h4 align='center'>Unable to change the password <br><br>Please <a href='../ChangePassword.html'><b>Retry</b></a></h4></body>");
		}
	}
	else
	{
		out.println("<body bgcolor='CornflowerBlue'><br><br><h4 align='center'> Old Password doesn't match. Please validate yourself.<br><br>Please <a href='../ChangePassword.html'><b>Retry</b></a></h4></body>");
	}	
  }
catch(Exception e)
{
	out.println(" <body bgcolor='CornflowerBlue'><br><br><h4 align='center'>User ID doesn't exist. Please enter values correctly. <br><br>Please <a href='../ChangePassword.html'><b>Retry</b></a></h4></body>");
}
finally
{
	db.closeConnections();
}
%>
</body>
</html>