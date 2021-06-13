<%@page import="java.sql.SQLException"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Admin | SIMS</title>
</head>
<body>
<%
	
	request.setCharacterEncoding("UTF-8");
	String user = request.getParameter("user");
	String password = request.getParameter("password");
	String sqlQuery = "SELECT * FROM dbsms.login WHERE user='"+user+"'AND password='"+password+"'";
	try{
		Class.forName("com.mysql.cj.jdbc.Driver");
		Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/dbsms","root","");
		Statement sql = con.createStatement();
		ResultSet rs = sql.executeQuery(sqlQuery);
		if(rs.next()){
			session.setAttribute("user", user);
			session.setAttribute("id", rs.getString(1));
			response.sendRedirect("frame.jsp");
		}else{
			out.print("<script language='JavaScript'>alert('Your Login Details are Wrong ! Please Re-enter or Register !');window.location.href='Login.html'</script>");
		}
		con.close();
	}catch(SQLException e){
		e.printStackTrace();
	}
%>
</body>
</html>