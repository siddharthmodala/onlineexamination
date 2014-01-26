<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@ page import="java.sql.*" %>
    <%@ page import="java.util.*" %>
    <%@ page import="dbpackage.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Automatic code</title>	
</head>
<body>
<form name="f">
<%
String name=request.getParameter("subname");
String date=request.getParameter("doe")+request.getParameter("moe")+request.getParameter("yoe");
String code=request.getParameter("ccode");
String value=code+name+date;
String table="";
int low=Integer.parseInt(request.getParameter("low"));
int high=Integer.parseInt(request.getParameter("high"));
Database db=new Database();
StringTokenizer stk=new StringTokenizer(value," ");
while(stk.hasMoreTokens())
	table+=stk.nextToken();
try
{
	ResultSet rs=db.executeDBQuery("select count(*) from Student");
	rs.next();
	String s=rs.getString(1);
	if(s.equals("0"))
	{
	out.println("<body bgcolor='Thistle'><br><br><center><b> There are No Students in the Database.<br><br> Please enter Student details first.<br><br><a href='../Show.html'>Back</a></b></center></body>");
	}
	else
	{
       int range=Integer.parseInt(s);
       if((high-low)<range)
       {
    	   out.println("<body bgcolor='Thistle'><br><br><center><b> There Range is less than no. of Students.<br><br> Please <br><br><a href='../AutomaticPrompt.html'>Retry</a></b></center></body>");
       }
       else
       {
    	   try
    	   {
    	  	rs=db.executeDBQuery("select * from " +table);
    	  	if(rs.next())
    	  	{
    	  		out.println("<body bgcolor='Thistle'><br><br><center><b> Code Table already generated for this exam.Please view the codes.</b><br><br><a href='../Show.html' target='f3'><b>Back</b></a></center></body>");    	  		
    	  	}
    	  	else
    	  	{
    	  	 response.addCookie(new Cookie("table",table));
       	     response.addCookie(new Cookie("lowr",low+""));
       	     response.addCookie(new Cookie("highr",high+""));
       	     response.sendRedirect("./createauto.jsp");  		
    	  	 }
    	   }
    	   catch(Exception e)
    	   {     		  
    	     response.addCookie(new Cookie("table",table));
    	     response.addCookie(new Cookie("lowr",low+""));
    	     response.addCookie(new Cookie("highr",high+""));
    	     response.sendRedirect("./createauto.jsp");
    	   }
       }
	}
}
catch(Exception e)
{
	out.println("<body bgcolor='Thistle'><center><b>No table. <br><br> Please <a href='../AutomaticPrompt.html'>Retry</a></b></center></body>");
}
%>
</form>
</body>
</html>