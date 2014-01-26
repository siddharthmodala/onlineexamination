<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="dbpackage.*" %>
<%@ page import="java.sql.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Marks Entry</title>
</head>
<body bgcolor="lightgray">
<%
String table=null;
ResultSet rs=null;
int code=Integer.parseInt(request.getParameter("pcode"));
Double marks=Double.parseDouble(request.getParameter("marks"));
Cookie c[]=request.getCookies();
for(int i=0;i<c.length;i++)
{
	if(c[i].getName().equals("table"))
	  table=c[i].getValue();
}

Database db=new Database();
try
{
rs=db.executeDBQuery("select * from "+table);
if(rs.next())
{
	try
	{
		String str="update "+table+" set StdMarks ="+marks+" where StdCode="+code;
		int row=db.executeDBUpdate(str);
		if(row==0)
	    	out.println("<center><br><br> <b>Cadet Marks cannot be inserted. Code doesnt exist. </b><br><br><a href='../EnterMarks.html' target='f3'><b>Retry</b></a></center>");
		else
			out.println("<center><br><br> <b>Cadet Marks Inserted Successfully</b> <br><br><a href='../EnterMarks.html' target='f3'><b>Back</b></a></center>");
	}
	catch(Exception e)
	{
		out.println("<center><b><br><br> Cadet marks not updated <br><br>Please <a href='../EnterMarks.html' target='f3'>Retry</a></b></center>");
	}
}
else
{
	out.println("<center><b><br><br> CODE Number doesn't exist. Please check code details & <a href='../EnterMarks.html' target='f3'>Retry</a></b></center>");
}
}
catch(Exception e)
{
	out.println("<center><b><br><br> Code table details not found. Please <a href='../MarksSubPrompt.html' target='f3'>Retry</a></b></center>");
}
%>
</body>
</html>