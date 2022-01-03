<%@page import="java.sql.PreparedStatement"%>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.sql.Statement" %>
<%@ page import="java.sql.Connection" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%!
Connection conn=null;
PreparedStatement pstmt=null;


String url="jdbc:oracle:thin:@localhost:1521:orcl";
String userid="ora_user";
String passcode="human123";
String sql="insert into student values('Steve Rogers',98,88)";
%>    


<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert Student</title>
</head>

<body>
<style>

table {border-collapse:collapse; font-style: italic;}
td {border:1px solid black;}


</style>

<%
try {
	Class.forName("oracle.jdbc.driver.OracleDriver"); //driver (ojdbc6.jar)
	conn=DriverManager.getConnection(url,userid,passcode); //null if connection failed
	pstmt=conn.prepareStatement(sql);
	pstmt.executeUpdate();
		
	
}catch(Exception e){
	e.printStackTrace();
}finally{
	if(pstmt != null)pstmt.close();
	if(conn != null)conn.close();
	request.getRequestDispatcher("view_student.jsp").forward(request,response);
}
%>

</body>
</html>