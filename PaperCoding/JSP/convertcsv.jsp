<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@page import="dbpackage.*"%>
    <%@page import="java.io.*"%>
    <%@page import="java.sql.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Convert to csv</title>
</head>
<body bgcolor="lightgrey">
<%
String tname=null,path=null,type=null;
path=request.getParameter("path");
type=request.getParameter("type");
Cookie c[]=request.getCookies();
for(int i=0;i<c.length;i++)
	if(c[i].getName().equals("table"))
	tname=c[i].getValue();
Database db=null;
FileWriter file=null;
try
{
db=new Database();
ResultSet rs=db.executeDBQuery("select StdNo,StdName,"+type+" from "+tname);
file=new FileWriter(path+tname+".csv");
BufferedWriter data=new BufferedWriter(file);
String temp="Cadet No.,Cadet Name,"+type;
data.write(temp);
data.newLine();
while(rs.next())
{
	temp=rs.getString(1)+","+rs.getString(2)+","+rs.getString(3);
	data.write(temp,0,temp.length());
	data.newLine();
}
data.close();
db.closeConnections();
out.println("<center> Student List saved to </center>"+path+tname+".csv");
}
catch(FileNotFoundException e)
{
	out.println("<center>File Path doesnot Exits Please Give Correct Path</center>");
}
catch(Exception e)
{
	out.println("<center>Unable to save the file</center>");
}
finally
{
	try{
if(db!=null)
	db.closeConnections();
	if(file!=null)file.close();}
	catch(Exception e)
	{
	}
}

	
%>
</body>
</html>