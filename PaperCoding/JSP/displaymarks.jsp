<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
   <%@ page import="java.sql.*" %>
      <%@ page import="java.util.*" %>
   <%@ page import="dbpackage.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Marks display</title>
<script type="text/javascript">
function getPath()
{
		var path1=prompt("Enter the File Path","d:\\");
		document.f.path.value=path1;	
		document.f.action="convertcsv.jsp";
		document.f.submit();	
}
</script>
</head>
<body bgcolor="lightgray">
<br><br>
<%

String table=null;
Cookie d[]=request.getCookies();
for(int j=0;j<d.length;j++)
{
	if(d[j].getName().equals("table"))
	  table=d[j].getValue();
}
Database db = new Database();
ResultSet rs=null;
try
{
rs = db.executeDBQuery("select StdNo,StdName,StdMarks from "+table);
ResultSetMetaData rsmd = rs.getMetaData();
int c=0;
%>
<table align="center" border="1" >
<caption> <b> Marks Report </b><br><br></caption>
<tr><th align="left">SL.No.</th><th align="left">Chest No.</th><th align="left">Trainee Name</th><th align="left">Marks Obtained</th></tr>
<%
for(int j=0;rs.next();j++)
{
  c=1;
 %>
    <tr>
    <th><%=j+1%></th>
   <td align="center"><%=rs.getString(1)%></td>
   <td align="center"><%=rs.getString(2)%></td>
   <td align="center"><%=rs.getString(3)%></td>
    </tr>	
 <%
}
%>
</table>
<%
 if(c==0)
 { 
	 out.println("<br><br><center> <b> No Marks in the Database </b></center><br>");
 }
 else
 {
	 response.addCookie(new Cookie("table",table));
 
	%>
	<br><br>
<form name="f">
<input type="hidden" name=path value="d:\"></input>
<input type="hidden" name="type" value="StdMarks"></input>
</form>
<center><input type="Button" name="Print" value="Print" onClick="window.print()" ></center><br><br>
<center><input type="button" value="Save Details to File" onclick="getPath()"></center><br><br>
<center><a href="../DisplayMarksPrompt.html" target="f3"> <b>Back</b></a></center>
</body>
</html>
	<%
 }
}
catch(Exception e)
{
	out.println("<br><br><center><b> No Marks details for this exam in Database.<br><br>Please Enter Marks first. </b></center><br>");
}
finally
{
db.closeConnections();
}

%>
