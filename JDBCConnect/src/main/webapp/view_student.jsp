<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.sql.Statement" %>
<%@ page import="java.sql.Connection" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%!
Connection conn=null;
Statement stmt=null;
ResultSet rs=null;

String url="jdbc:oracle:thin:@localhost:1521:orcl";
String userid="ora_user";
String passcode="human123";
String sql="select * from student";

%>
<!DOCTYPE html>
<html>
<head>
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link
   href="https://fonts.googleapis.com/css2?family=Gowun+Batang&display=swap"
   rel="stylesheet">
<meta charset="UTF-8">
<title>view student</title>
</head>
<body>
<style>
   table{
      border-collapse:collapse;      
   }
   td{
      border:2px solid black;
   }
   *{
      font-family: 'Gowun Batang', serif;
   }
</style>
<table>
<tr>
   <th>이름</th>
   <th>수학</th>
   <th>국어</th>
   
</tr>
<%
try{
   Class.forName("oracle.jdbc.driver.OracleDriver");   //driver(ojdbc6.jar)
   conn=DriverManager.getConnection(url,userid,passcode); // db접속 실패하면 null뜸
   stmt=conn.createStatement(); //SQL문을 넣을 곳을 만들어라
   rs=stmt.executeQuery(sql);   // SQL문 실행 결과를 rs에 담아라
   while(rs.next()){      
      String name=rs.getString("student_name");
      int math=rs.getInt("math");
      int korean=rs.getInt("korean");
%>
      <tr>
         <td><%=name %></td>
         <td><%=math%></td>
         <td><%=korean %></td>
         
      </tr>
<%   }
} catch(Exception e){
   e.printStackTrace();
} finally{
   if(rs!=null) rs.close();
   if(stmt!=null) stmt.close();
   if(conn!=null) conn.close();
}
%>
</table>
</body>
</html>