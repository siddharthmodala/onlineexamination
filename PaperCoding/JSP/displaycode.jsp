<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>
<%@ page import="java.net.*" %>
<%@ page import="dbpackage.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Code Display</title>
<script type="text/javascript">
function getPath()
{
		var path1=prompt("Enter the File Path","d:\\");
		//var reg=RegExp("^[a-zA-Z]{1}\:\\[a-zA-Z0-9 \]*\\$");
		/*if(path1.match(reg))
		{*/
		document.f.path.value=path1;
		document.f.action="convertcsv.jsp";
		document.f.submit();
		/*}
		else
			alert("the path is not valid(should end with \\");*/
}
</script>
</head>
<body bgcolor="lightgray">
<%
String table="",value=null;
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

Database db=new Database();
try
{
ResultSet rs=db.executeDBQuery("select StdNo,StdCode from "+table);
ResultSetMetaData rsmd=rs.getMetaData();
%>
<table align="center" border="1">
<caption><b><br>Code Details<br><br></b></caption>
<tr><th>SL No.</th><th>Chest Number</th><th>Paper Code</th></tr>
<%
for(int j=0;rs.next();j++)
{
	%>
    <tr>
    <th><%=j+1%></th>
 	<td align="center"><%=rs.getString(1)%></td>
 	<td align="center"><%=rs.getInt(2)%></td>
 	  </tr>
 <%
 }
 %>
</table>
<form name="f">
<input type="hidden" name=path value="d:\"></input>
<input type="hidden" name="type" value="StdCode"></input>
</form>
<center><input type="Button" name="Print" value="Print" onClick="window.print()" ></center><br><br>
<center><input type="button" value="Save Details to File" onclick="getPath()"></center><br><br>
<center><a href="../DisplayCode.html" target="f3"> <b>Back</b></a></center>
<%
}
catch(Exception e)
{
	out.println("<br><br><center>Code Table doesnot exist. Please Create it first.<br><br><a href='../Show.html' target='f3'><b>Back</b></a></center>");
}
%>
</body>
</html>