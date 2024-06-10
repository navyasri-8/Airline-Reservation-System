<!DOCTYPE HTML>

<html>

<head>

<title>Group:3</title>
<meta name="description" content="website description" />
<meta name="keywords" content="website keywords, website keywords" />
<meta http-equiv="content-type"
	content="text/html; charset=windows-1252" />
<link rel="stylesheet" type="text/css" href="style/style.css"
	title="style" />
</head>

<body>
	<div id="main">
		<div id="header">
			<div id="logo">
				<div id="logo_text">
					<!-- class="logo_colour", allows you to change the colour of the text -->
					<h1>
						<center><font color="black">Airline Reservation System</font></center>
					</h1>
				</div>
			</div>
			<div id="menubar">
				<ul id="menu">
					
					<li><a href="index.jsp">Home</a></li>
					<li><a href="login.jsp">Login</a></li>
					<li><a href="registration.jsp">Registration</a></li>
					<li><a href="activateaccount.jsp">Activate Account</a></li>

				</ul>
			</div>
		</div>
		<div id="content_header"></div>
		<div id="site_content">
			<div id="content">
				<!-- insert the page content here -->
				<%
					String status = request.getParameter("status");

					if (status != null) {
				%>
				<h1>
					<script type="text/javascript">
						window.alert("<%=status%>");
					</script>
				</h1>
				<%
					} else {
				%>
					<h1>Register Here</h1>
				<%
					}
				%>

				<form action="VoidmainServlet" method="post" name="appform">

					<input type="hidden" name="type" value="com.voidmain.pojo.User">
					<input type="hidden" name="operation" value="add"> 
					<input type="hidden" name="redirect" value="registration.jsp">
					<input type="hidden" name="usertype" value="user">
					<input type="hidden" name="status" value="no">

					<div class="form_settings">
						<p>
							<span>Name</span><input class="contact" type="text" name="name"
								value="" />
						</p>
						<p>
							<span>User Name</span><input class="contact" type="text"
								name="username" value="" />
						</p>
						<p>
							<span>Password</span><input class="contact" type="password"
								name="password" value="" />
						</p>
						<p>
							<span>Email Address</span><input class="contact" type="text"
								name="email" value="" />
						</p>
						<p>
							<span>Mobile</span><input class="contact" type="text"
								name="mobile" value="" />
						</p>
						<p>
							<span>Address</span>
							<textarea class="contact" name="address" required="required"></textarea>
						</p>
						<p style="padding-top: 15px">
							<span>&nbsp;</span><input class="submit" type="submit"
								name="contact_submitted" value="Register" onclick="return validate()" />
						</p>
					</div>
				</form>
			</div>
		</div>
	</div>
</body>
</html>
