<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="dbpackage.*" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Automatic Code Generation</title>
</head>
<body bgcolor="Thistle">
<%
Database db=new Database();
Database db1=null;
ResultSet rs=null,rs1=null;
ResultSetMetaData rsmd=null;
Cookie c[]=request.getCookies();
String table=null,str=null;
int low=0,high=0,n=0,j=0;
for(int i=0;i<c.length;i++)
{
	if(c[i].getName().equals("table"))
	 table=c[i].getValue();
	if(c[i].getName().equals("lowr"))
		 low=Integer.parseInt(c[i].getValue());
	if(c[i].getName().equals("highr"))
		 high=Integer.parseInt(c[i].getValue());
}
try
{
	db1=new Database();
	db1.setDBAutoCommit(false);
	db1.executeDBUpdate("create table "+table+" (StdNo Text NOT NULL, StdName Text ,StdCode Number UNIQUE NOT NULL, StdMarks Number,primary key(StdNo))");
	rs=db.executeDBQuery("select * from Student");
	rsmd=rs.getMetaData();	
	int seed=high-low,code=0;
	Random r=new Random();
	int list[]=new int[2000],i=0;
	int flag=0;
	while(rs.next())
	{
	flag=0;
	while(flag==0)
		{
			code = low+ r.nextInt(seed);
			Arrays.sort(list);
			if(Arrays.binarySearch(list,code)<0)
			{
				list[i]=code;
				flag=1;
			}
		}
			str=" insert into "+table+" values ('"+rs.getString(1)+"','"+rs.getString(2)+"',"+code+",null)";
			db1.executeDBUpdate(str);
			i++;	    
		}
    db1.DBCommit();
    response.addCookie( new Cookie("table",table));
    out.println("<br><br><center><b>Table Success fully created</b><br><br><br><a href='./displaycode.jsp' target='f3'><b> Click to View Codes </b></a></center>");

}
catch( Exception e)
{
	System.out.println(e);
	db1.DBRollback();
			out.println("<body><center><br><br><b> Unable to create the table.<br><br> Please <a href='../AutomaticPrompt.html' target='f3'>Retry</a>.<br><br></b></center></body>");
}
finally{
	db1.setDBAutoCommit(true);
    db.closeConnections();
    db1.closeConnections();
}
%>
</body>
</html>