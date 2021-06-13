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
		<title>Insert title here</title>
		<style type="text/css">
			.form-control {
				width: 300px;
				height: 30px;
				float: right;
			}
			
			select {
				width: 210px;
				height: 30px;
			}
			
			.submit {
				margin-left: 100px;
				margin-right: 30px;
			}
			
			.contain {
				width: 1000px;
				border: 1px #bbb solid;
				background-color: #eee;
				padding-top: 20px;
				border-radius: 10px;
			}
			
			label {
				display: inline-block;
				width: 100px;
				margin-right: 10px;
			}
			
			form {
				margin-left: 300px;
			}
		</style>
	</head>

	<body>
	<%
		if((String)session.getAttribute("user")==null){
			out.print("<script language='JavaScript'>alert('Log IN First！');window.location.href='Login.html'</script>");
		}
	%>
		<div class="contain">
			<form action="DaoAddStudent.jsp" method="post">
				<div class="form-group form-inline">
					<label for="id">Student ID:</label>
				<input type="text" class="form-control" id="id" name="id" maxlength="15" required="required">
				</div>
			<div class="form-group form-inline">
				<label for="name">Name:</label>
					<input type="text" class="form-control" id="name" name="name" required="required">
				</div>
				<div class="form-group form-inline">
					<label for="sex">Gender:</label>
					<select name="sex" id="sex">
						<option value="male">Male</option>
						<option value="female">Female</option>
					</select>
				</div>
				<div class="form-group form-inline">
					<label for="birthday">Date of Birth:</label>
					<input type="date" class="form-control" id="birthday" name="birthday" required="required">
				</div>
				<div class="form-group form-inline">
					<label for="schoolday">Admission Date:</label>
					<input type="date" class="form-control" id="schoolday" name="schoolday" required="required">
				</div>
				<div class="form-group form-inline">
					<label for="college">Section :</label>
					<select name="college" id="college" class="college">
						<option selected="selected">---Choose---</option>
					</select>
				</div>
				<div class="form-group form-inline">
					<label for="major">Grade:</label>
					<select name="major" id="major" class="major">
						<option selected="selected">---Choose---</option>
					</select>
				</div>
				<div class="form-group form-inline">
					<input type="submit" id="" name="" class="btn btn-primary submit" /><input type="reset" class="btn btn-warning" value="重置" />
				</div>
			</form>
		</div>
	</body>
	<script type="text/javascript">
		var librarians = ['junior', 'middle', 'senior'];
		var choice = ['---please choose---'];
		var junior = ['1', '2', '3', '4', '5'];
		var middle = ['6', '7', '8', '9', '10', '11'];
		var senior = ['12','13'];

		var professional = new Array;
		professional[0] = choice;
		professional[1] = junior;
		professional[2] = middle;
		professional[3] = senior;

		function add_option(select, option) {
			var target = document.getElementById(select);
			for(var i = option.length - 1; i >= 0; i--) {
				var add_option = document.createElement("option");
				add_option.text = option[i];
				target.add(add_option, null);
				target.lastChild.setAttribute("value", option[i]);
			}

		}
		add_option("college", librarians);

		document.getElementById("college").addEventListener("change", function() {

			var selevted_college = document.getElementById("college");
			var selected_major = document.getElementById("major");

			for(var i = selected_major.length - 1; i >= 0; i--) {
				selected_major.remove(i);
			}
			var selected = selevted_college.selectedIndex;
			if(selected == 0) {
				add_option("major", professional[0]);
			} else {
				add_option("major", professional[selected]);
			}
		})
	</script>

</html>