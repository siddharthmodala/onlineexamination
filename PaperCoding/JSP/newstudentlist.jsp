<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
   <%@ page import="java.io.*"  %>
      <%@ page import="java.sql.*"  %>
      <%@ page import="dbpackage.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<%@page import="java.util.StringTokenizer"%><html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>New Student List</title>
</head>
<body bgcolor="yellowgreen">
<%
	//to get the content type information from JSP Request Header
	String contentType = request.getContentType();
	//here we are checking the content type is not equal to Null and as well as the passed data from mulitpart/form-data is greater than or equal to 0
	if ((contentType != null) && (contentType.indexOf("multipart/form-data") >= 0)) {
 		DataInputStream in = new DataInputStream(request.getInputStream());
		//we are taking the length of Content type data
		int formDataLength = request.getContentLength();
		byte dataBytes[] = new byte[formDataLength];
		int byteRead = 0;
		int totalBytesRead = 0;
		//this loop converting the uploaded file into byte code
		while (totalBytesRead < formDataLength) {
			byteRead = in.read(dataBytes, totalBytesRead, formDataLength);
			totalBytesRead += byteRead;
			}

		String file = new String(dataBytes);
		//for saving the file name
		String saveFile = file.substring(file.indexOf("filename=\"") + 10);
		saveFile = saveFile.substring(0, saveFile.indexOf("\n"));
		saveFile = saveFile.substring(saveFile.lastIndexOf("\\") + 1,saveFile.indexOf("\""));
		int lastIndex = contentType.lastIndexOf("=");
		String boundary = contentType.substring(lastIndex + 1,contentType.length());
		int pos;
		//extracting the start index of file
		pos = file.indexOf("filename=\"");
		
		pos = file.indexOf("\n", pos) + 1;
		
		pos = file.indexOf("\n", pos) + 1;
		
		pos = file.indexOf("\n", pos) + 1;
		
		int boundaryLocation = file.indexOf(boundary, pos) - 4;
		int startPos = ((file.substring(0, pos)).getBytes()).length;
		int endPos = ((file.substring(0, boundaryLocation)).getBytes()).length;

		String info=file.substring(startPos,endPos);
		Database db=null;
		try{
			db=new Database();
		db.setDBAutoCommit(false);
			db.addDBBatch("delete from student");
			//db.addDBBatch("create table student(stdno number primary key not null,stdfname text not null)");
			StringTokenizer read=new StringTokenizer(info,"\n",false);
			while(read.hasMoreTokens())
			{
				StringTokenizer token=new StringTokenizer(read.nextToken(),",");
				if(token.countTokens()==2)
				db.addDBBatch("insert into student values('"+token.nextToken()+"','"+token.nextToken()+"')");
				else
					throw new Exception("Invalid number of values in row in the file");
			}
			db.executeDBBatch();
			db.DBCommit();
			%><h4 style="text-align:center"><br/><br/>You have successfully upload the file
			<br/><br/><br/>To view the new List of students <a href="displaystddtls.jsp">Click Here</a></h4> 
			<%
		}
		catch(SQLException e)
		{
			db.DBRollback();
			out.println("<br/><br/><h4 style='text-align:center'>Unable to upload the file<BR><br/><br/>Error in Data in the File</h4>");
			out.println("<center><u><a href='javascript:history.go(-1)'>Back</a></u></center>");
		}
		catch(Exception e)
		{
			db.DBRollback();
			out.println("<br/><br/><h4 style='text-align:center'>Unable to upload the file<br/><br/><BR>please check the format of the file</h4>");
			out.println("<center><u><a href='javascript:history.go(-1)'>Back</a></u></center>");
		}
		finally{
			db.setDBAutoCommit(true);
			db.closeConnections();
		}

		}
%>

</body>
</html>