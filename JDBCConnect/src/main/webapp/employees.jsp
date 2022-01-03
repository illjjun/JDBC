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
String sql="select c.department_id as 부서코드 ,c.department_name as 부서명 , nvl(b.emp_name,'-') as 매니저명 , nvl(a.department_name,'-') as 상위부서명 "+ 
			"from employees b, departments a, departments c "+
			"where a.department_id(+)=c.parent_id and b.employee_id(+)=c.manager_id "+
			"order by c.department_id";

%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Employees</title>
</head>

<body>
<style>

table {border-collapse:collapse; font-style: italic;}
td {border:1px solid black;}


</style>
<table>
<tr><th>부서아이디</th><th>부서명</th><th>매니저명(사번)</th><th>상위부서명</th></tr>
<%
try {
	Class.forName("oracle.jdbc.driver.OracleDriver"); //driver (ojdbc6.jar)
	conn=DriverManager.getConnection(url,userid,passcode); //null if connection failed
	stmt=conn.createStatement();
	rs=stmt.executeQuery(sql);

	while(rs.next()){
		out.print("<tr>");
		int did=rs.getInt("부서코드");
		String dname=rs.getString("부서명");
		String mname=rs.getString("매니저명");
		String ddname=rs.getString("상위부서명");

%>
		
		<tr><td><%=did %></td><td><%=dname %></td><td><%=mname %></td><td><%=ddname %></td></tr>
		<%
// 		out.println("<td>"+eid+"</td><td>"+ename+"</td><td>"+salary+"<td>"+mid+"</td>"+"</td>"+
// 				"<td>"+did+"</td>"+"<td>"+jobid+"</td></tr>");
		
		
	}
}catch(Exception e){
	e.printStackTrace();
}finally{
	if(rs != null)rs.close();
	if(stmt != null)stmt.close();
	if(conn != null)conn.close();
}
%>
</table>
</body>
</html>