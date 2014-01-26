<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*" %>
<%@ page import="dbpackage.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Code entry</title>
</head>
<body bgcolor="Thistle">
<%
ResultSet rs=null;
String sno=request.getParameter("sno");
String scode=request.getParameter("scode");
String table=null;
int code=Integer.parseInt(scode);
Cookie c[] =request.getCookies();
for(int i=0;i<c.length;i++)
{
 if(c[i].getName().equals("table"))
 table=c[i].getValue();
}
if(table==null)
{
	response.sendRedirect("../ManualPrompt.html");
}
Database db=new Database();
try
{
rs=db.executeDBQuery("select * from student where StdNo='"+sno+"'");
if(rs.next())
{
	try
	{
		String str="insert into "+table+" values ('"+sno+"','"+rs.getString(2)+"',"+code+",null)";
		db.executeDBUpdate(str);
		out.println("<center><br><br><b> Cadet Code Inserted Successfully </b><br><br><a href='../EnterCode.html' target='f3'><b>Back</b></a></center>");
		db.closeConnections();
	}
	catch(Exception e)
	{
		out.println("<center><b><br><br> Cadet Code may not be UNIQUE <br>or<br> Cadet code already entered. <br><br>Please <a href='../EnterCode.html' target='f3'>Retry</a></b></center>");
	}
}
else
{
	out.println("<center><b><br><br> Cadet Number doesn't exist. Please check details & <a href='../EnterCode.html' target='f3'>Retry</a></b></center>");
}
}
catch(Exception e)
{
	out.println("<center><b><br><br> Cadet code table details not found. Please <a href='../ManualPrompt.html' target='f3'>Retry</a></b></center>");
}

%>
</body>
</html>