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
		<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
		<!-- Bootstrap CSS -->
		<link rel="stylesheet" href="https://cdn.bootcss.com/bootstrap/4.0.0/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
		<!-- Optional JavaScript -->
		<!-- jQuery first, then Popper.js, then Bootstrap JS -->
		<script src="https://cdn.bootcss.com/jquery/3.2.1/jquery.slim.min.js" integrity="sha384-KJ3o2DKtIkvYIK3UENzmM7KCkRr/rE9/Qpg6aAZGJwFDMVNA/GpGFF93hXpG5KkN" crossorigin="anonymous"></script>
		<script src="https://cdn.bootcss.com/popper.js/1.12.9/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
		<script src="https://cdn.bootcss.com/bootstrap/4.0.0/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>
		<script type="text/javascript">
			function del() {
				if(!confirm("Are you sure you want to delete?")) {
					window.event.returnValue = false;
				}
			}
		</script>
		<title>School Information Management System</title>
		<style type="text/css">
			body {
				/*background-color: #eee;*/
			}
			
			form h1 {
				display: inline-block;
				width: 820px;
			}
			
			.check {
				padding: 30px 30px;
			}
			
			form {
				display: inline;
			}
			
			.contain {
				width: 1000px;
				border-radius: 10px;
				border: 1px #bbb solid;
				background-color: #eee;
				padding-top: 20px;
			}
			
			button {
				margin-left: 10px;
			}
			
			.search {
				display: inline-block;
				margin-left: 500px;
			}
			
			.add {
				float: right;
				margin-right: 50px;
			}
			.pageNav{
				margin-left: 200px;
			}
		</style>
	</head>

	<body>
		<%
		request.setCharacterEncoding("UTF-8");
		String pages = request.getParameter("pages");//获取当前页数
		int pagesNo = Integer.parseInt(pages);//把当前页数从字符串转为整型
		int startLine = (Integer.parseInt(pages)-1)*10;//指定数据库从哪一行开始读取
		%>
		<div class="contain pull-left">
			<form action="DaoSearch.jsp" class="form-inline ">
				<h2>Student List Management</h2>
				<div class="form-group search">
					<input type="text" name="check" class="form-control" placeholder="
Please enter the Name or student ID" />
					<input type="submit" name="submit" class="btn" value="Search" />

				</div>
			</form>
			<a href="AddStudent.jsp" target="_self"><button class="btn btn-primary add">Add Student</button></a>
			<div class="pull-left">
				<table class="table table-hover">
					<thead>
						<tr>
							<th>Student ID</th>
							<th>Name</th>
							<th>Gender</th>
							<th>Date of Birth</th>
							<th>Date of Admission</th>
							<th>Section</th>
							<th>Grade</th>
							<th>Action</th>
						</tr>
					</thead>
					<tbody>
<%
	int pageSize = 10;
	String sqlQuery = "SELECT * FROM dbsms.studentinfo limit "+startLine+","+pageSize;
	String sqlAll = "SELECT * FROM dbsms.studentinfo";
	int pagesCount = 0;
	int lastRow = 0;
	try{
		Class.forName("com.mysql.cj.jdbc.Driver");
		Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/dbsms","root","");
		Statement sql = con.createStatement();
		Statement stat = con.createStatement();
		ResultSet rs = sql.executeQuery(sqlQuery);
		ResultSet rsAll = stat.executeQuery(sqlAll);
		rsAll.last();
		lastRow = rsAll.getRow();
		while(rs.next()){
			out.print("<tr>");
			out.print("<td>"+rs.getString(1)+"</td>");
			out.print("<td>"+rs.getString(2)+"</td>");
			out.print("<td>"+rs.getString(3)+"</td>");
			out.print("<td>"+rs.getString(4)+"</td>");
			out.print("<td>"+rs.getString(5)+"</td>");
			out.print("<td>"+rs.getString(6)+"</td>");
			out.print("<td>"+rs.getString(7)+"</td>");
			out.print("<td><a href='AlertStudent.jsp?id="+rs.getString(1)+"'><button class='btn btn-primary'>Modify</button></a><a href='DaoDelete.jsp?id="+rs.getString(1)+"' onclick='javascript:return del();'><button class='btn btn-danger'>Delete</button></a></td>");
			out.print("</tr>");
		}
		con.close();
	}catch(SQLException e){
		e.printStackTrace();
	}
%>

					</tbody>
				</table>
				<div class="pageNav">
					<ul class="pagination">
					<%
						int prePage;
						if(pagesNo == 1){
							prePage = 1;
						}else{
							prePage = pagesNo - 1;
						}
					%>
					<li class="page-item"><a class="page-link" href="Contain.jsp?pages=<%=prePage%>">Previous Page</a></li>
					<%
						pagesCount = (lastRow % pageSize == 0) ? (lastRow / pageSize) : (lastRow / pageSize +1);
						int minpages = (pagesNo - 3 >0) ? (pagesNo - 3) : 1;
						int maxpages = (pagesNo + 3 >= pagesCount) ? (pagesCount) : (pagesNo+3);
						for(int i = minpages;i <=maxpages ;i++){
							if(i == pagesNo){
								out.print("<li class='page-item active'>");
								out.print("<a class='page-link' href='Contain.jsp?pages="+i+"'>"+i+"</a>");
								out.print("</li>");
							}else{
								out.print("<li class='page-item'>");
								out.print("<a class='page-link' href='Contain.jsp?pages="+i+"'>"+i+"</a>");
								out.print("</li>");
							}
							
						}
							//out.print("<li class='page-item'>");
							//out.print("<a class='page-link' href='#>...</a>");
							//out.print("</li>");
						
					%>
					<%
						int nextPage;
						if(pagesNo == pagesCount){
							nextPage = pagesCount;
						}else{
							nextPage = pagesNo + 1;
						}
					%>
					<li class="page-item"><a class="page-link" href="Contain.jsp?pages=<%=nextPage%>">Next Page</a></li>
					</ul>
				</div>

			</div>

		</div>
	</body>

</html>