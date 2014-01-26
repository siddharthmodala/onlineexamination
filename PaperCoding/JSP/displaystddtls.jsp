<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
 <%@ page import="java.sql.*" %>
 <%@ page import="dbpackage.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Display Student Details</title>
</head>
<body bgcolor="yellowgreen">
<br><br>
<%
Database db= new Database();
try
{
ResultSet rs = db.executeDBQuery("select * from student");
ResultSetMetaData rsmd = rs.getMetaData();
int c=0;
%>
<table align="center" border="1" >
<caption> <u style=" font-size:25px; color: blue">Trainee Details</u><br/><br/><br/></caption>
<tr><th align="left">Chest No.</th><th align="left">Trainee Name</th></tr>
<%
for(int j=0;rs.next();j++)
{
  c=1;
 %>
    <tr>
 <%
    for(int i=1;i<=rsmd.getColumnCount();i++)
    {
 %>
   <td><%=rs.getString(i)%></td>
 <% 
     }
 %>
    </tr>	
 <%
}
%>
</table>
<%
 if(c==0)
 { 
	 out.println("<br><br><center> <b> No Trainees in the Database </b></center><br>");
 }
out.println("<br><h4 style='text-align:center'><a href='javascript:history.go(-1)'>Back</a></h4>");
}
catch( Exception e)
{
	out.println(e);
}
finally
{
	db.closeResultSet();
}
%>
</body>
</html>