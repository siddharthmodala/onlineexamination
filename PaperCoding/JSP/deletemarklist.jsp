<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@page import="dbpackage.*"%>
        <%@page import="java.net.URLDecoder"%>
         <%@page import="java.io.*"%>
          <%@page import="java.util.*"%>
         <%@page import="java.sql.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Delete Marks List</title>
</head>
<body bgcolor="lightgrey">
<%
String table="",path=null,temp=null,value=null;
Cookie c[] =request.getCookies();
for(int i=0;i<c.length;i++)
{
	if(c[i].getName().equals("table"))
	 value=c[i].getValue();	
}
value=URLDecoder.decode(value,"UTF-8");
StringTokenizer stk=new StringTokenizer(value," ");
while(stk.hasMoreTokens())
	table+=stk.nextToken();

path=request.getParameter("filepath");
Database db=new Database();
FileWriter file=null;
String totalpath=path+table+".csv";
try{
if(path!="")
{
		ResultSet rs=db.executeDBQuery("select StdNo,StdName,StdMarks from "+table);
		file=new FileWriter(totalpath);
		BufferedWriter data=new BufferedWriter(file);
		temp="Cadet No.,Cadet Name,Cadet Marks";
		data.write(temp);
		data.newLine();
		while(rs.next())
		{
			temp=rs.getString(1)+","+rs.getString(2)+","+rs.getString(3);
			data.write(temp,0,temp.length());
			data.newLine();
		}
		data.close();
		out.println("<br><br><center><b>Student List saved to  "+ path+" "+table+".csv </b><br></center>");
		
		try{
			db.executeDBUpdate("drop table "+table);
			out.println("<center><b><br><br> Marks details Successfully deleted.<br><br><a href='../DeleteMarkList.html' target='f3'>Back</a></b></center>");
		}
		catch(Exception e)
		{
			out.println("<center><b><br><br>Unable to delete the table<br><br><a href='../DeleteMarkList.html' target='f3'>Back</a></b></center>");
		}
	}
else
{
		try{
			db.executeDBUpdate("drop table "+table);
			out.println("<center><b><br><br> Marks details Successfully deleted.<br><br><a href='../DeleteMarkList.html' target='f3'>Back</a></b></center>");
			}
		catch(Exception e)
		{
			out.println("<center><b><br><br>Marks details not found.<br><br>Please check the given details.<br><br><a href='../DeleteMarkList.html' target='f3'>Back</a></b></center>");
		}
}
}
catch(SQLException e)
{
	out.println("<center><b><br><br>The specified table details doesnot exist.<br><br>Unable to delete the Marks List.<br><br><a href='../DeleteMarkList.html' target='f3'>Back</a></b></center>");
}
catch(FileNotFoundException e)
{
	out.println("<center><b><br><br>The specified location doesnot exist please create it.<br><br>Unable to delete the Marks List.<br><br><a href='../DeleteMarkList.html' target='f3'>Back</a></b></center>");
}
catch(Exception e)
{
	out.println("<center><b><br><br>Unable to delete the Marks List.<br><br><a href='../DeleteMarkList.html' target='f3'>Back</a></b></center>");
}
finally
{
	db.closeConnections();
}

%>
</body>
</html>