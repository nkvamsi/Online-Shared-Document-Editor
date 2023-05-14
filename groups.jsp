<!doctype html>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.io.*"%>
<%@ page import="java.util.Properties"%>
<% 
	if(request.getSession().getAttribute("user_id") == null)
		response.sendRedirect("index.jsp");
%>
<html>
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>Home Page</title>
<!-- Bootstrap CSS -->
<link rel="stylesheet"
	href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css">
<!-- Bootstrap JS -->
<script src="https://code.jquery.com/jquery-3.3.1.slim.min.js"></script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js"></script>
<script
	src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/js/bootstrap.min.js"></script>
<!-- font-awesome -->
<link rel="stylesheet"
	href="https://use.fontawesome.com/releases/v5.6.3/css/all.css">
<!-- CSS -->
<link href="css/style.css" rel="stylesheet" type="text/css">
<link href="https://fonts.googleapis.com/css?family=Josefin+Sans:600"
	rel="stylesheet">
<script type="text/javascript">
window.onload = function () {
	/* location.href=document.getElementById("selectbox").value; */
    var fileupload = document.getElementById("FileUpload1");
    var filePath = document.getElementById("spnFilePath");
    var image = document.getElementById("imgFileUpload");
    image.onclick = function () {
        fileupload.click();
    };
};

function encodeImage(element) {
	var file = element.files[0];
	var reader = new FileReader();
	reader.onloadend = function() {
	var base64 = (reader.result);
	document.getElementById("pic").value = base64;
	var form = document.getElementById("picture");
	form.submit();
	}
	reader.readAsDataURL(file);
}

function encodeImageFileAsURL(element) {
	var fileName = document.getElementById("FileUpload1").value;
    var idxDot = fileName.lastIndexOf(".") + 1;
    var extFile = fileName.substr(idxDot, fileName.length).toLowerCase();
    if (extFile=="jpg" || extFile=="jpeg" || extFile=="png"){
    	encodeImage(element);
    }else{
        alert("Only jpg/jpeg and png files are allowed!");
    }   
}
</script>
</head>
<body>
	<!-- Main Container -->
	<div class="p-3 bg-dark text-white">Documents</div>
	<!-- nav Section -->
	<nav class="navbar navbar-expand-lg navbar-light bg-light">
		<button class="navbar-toggler" type="button" data-toggle="collapse"
			data-target="#navbarSupportedContent"
			aria-controls="navbarSupportedContent" aria-expanded="false"
			aria-label="Toggle navigation">
			<span class="navbar-toggler-icon"></span>
		</button>
		<div class="collapse navbar-collapse" id="navbarSupportedContent">
			<ul class="navbar-nav mr-auto">
				<li class="nav-item"><a class="nav-link text-dark"
					href="home.jsp">Home</a></li>
				<li class="nav-item"><a class="nav-link text-dark"
					href="shared_Docs.jsp">Shared Docs</a></li>
               	<li class="nav-item"><a class="nav-link text-dark"
					href="groups.jsp">Groups</a></li>
				<li class="nav-item"><a class="nav-link text-dark"
					href="requests.jsp">Requests</a></li>
				<li class="nav-item"><a class="nav-link text-dark" href="LogOut.jsp">Log Out</a></li>
			</ul>
			<!-- <form action="SearchServlet" method = "POST" class="form-inline my-2 my-lg-0">
				<input class="form-control mr-sm-2" type="search" placeholder="Search" name="search">
				<button type="submit" class="btn btn-light">
					<i class="fas fa-search"></i>
				</button>
			</form> -->
		</div>
	</nav>
	<%
	
	FileReader reader=new FileReader("/opt/tomcat/apache-tomcat-8.5.83/webapps/config.properties");  
    Properties p=new Properties();  
    p.load(reader);  
	String user = p.getProperty("user");
	String pass = p.getProperty("password");
	String url = p.getProperty("url");
	String db = p.getProperty("db");

	try {
		Class.forName("com.mysql.jdbc.Driver");
		Connection con = DriverManager.getConnection("jdbc:mysql://" +url+ "/" + db,user,pass);
		String user_email = request.getSession().getAttribute("current_email").toString();
		String user_id = request.getSession().getAttribute("user_id").toString();
		PreparedStatement ps = con.prepareStatement("select * from grp where group_name in (select group_name from group_sharing where user_email = ? and is_approved = ?) and admin != ?");
		ps.setString(1, user_email);
		ps.setString(2, "Y");
		ps.setString(3, user_email);
		
		PreparedStatement adps = con.prepareStatement("select * from grp where group_name in (select group_name from group_sharing where user_email = ?) and admin = ?");
		adps.setString(1, user_email);
		adps.setString(2, user_email);
		
		PreparedStatement aps = con.prepareStatement("select * from grp where group_name not in (select group_name from group_sharing where user_email = ?  and is_approved = ?)");
		aps.setString(1, user_email);
		aps.setString(2, "Y");
		
		PreparedStatement us = con.prepareStatement("select * from user where id=?");
		us.setString(1, user_id);
		/* if (request.getParameter("tag") != null) {
			ps = con.prepareStatement("select * from document where user_id=? and tag=?");
			ps.setString(1, user_id);
			ps.setString(2, request.getParameter("tag").toString());
		} */
		if(request.getParameter("search") != null){
			String search = request.getParameter("search").toString();
			ps = con.prepareStatement("select * from grp where (group_name in (select group_name from group_sharing where user_email = ?) and group_name like '%"+search+"%';");
			ps.setString(1, user_id);
		}

		ResultSet rs = ps.executeQuery();
		ResultSet adrs = adps.executeQuery();
		ResultSet ars = aps.executeQuery();
		ResultSet urs = us.executeQuery();
		urs.next();
	%>
	<!-- Banner Section -->
	<div class="p-3 bg-dark text-white">
		<div class="container">
			<div class="row">
				<div class="col-sm">
					<br><br><br><br>
					<h2 class="mb-3">Welcome</h2>
					<h3><%=request.getSession().getAttribute("name").toString()%></h3>
				</div>
				<div class="col-sm">
				<form id="picture" action="PictureServlet" method="POST">
					<% String dp = urs.getString("display_picture");
					if(dp != null){ %>
						<img class="img-circle" id="imgFileUpload" title="Change Picture" src="<%=urs.getString("display_picture") %>" style="cursor: pointer;width: 50%;border-radius: 20%">
						<span id="spnFilePath"></span>
						<input type="hidden" name= "pic" id = "pic"/>
   						<input type="file" id="FileUpload1" style="display: none" accept="image/png, image/gif, image/jpeg"  onchange="encodeImageFileAsURL(this)" />
					<% 		}
					else{%>
						<img class="img-circle" id="imgFileUpload" title="Change Picture" src="images/profile.png" style="cursor: pointer;">
						<span id="spnFilePath"></span>
						<input type="hidden" name= "pic" id = "pic"/>
   						<input type="file" id="FileUpload1" style="display: none" accept="image/png, image/gif, image/jpeg"  onchange="encodeImageFileAsURL(this)" />
					<%} %>
				</form>
				</div>
			</div>
		</div>
	</div>
	<button type="submit" class="btn btn-light ml-3 float-left"
		title="Create New Group"
		onclick="location.href = 'CreateGroup.jsp';">
		<i class="fas fa-plus"></i> New Group
	</button>


	<div class="bg-light">
	
	<br>

	<h3 >My Own Groups</h3>
		<div class="card-columns p-5">
			<%
				while (adrs.next()) {
			%>
			<div class="card bg-light>">
				<img class="card-img-top p-3" src="images/group.jpeg" alt="image_icon">
				<div class="card-body">
					<a href="viewgrouphome.jsp?id=<%=adrs.getString("group_id")%>"><h5 class="card-title"><%=adrs.getString("group_name")%></h5></a>
					<%-- <p class="card-text"><%=rs.getString("tag")%></p> --%>	
					<form action="DeleteGroupServlet" method="POST">
						 <input type="hidden" name="delete_id" value="<%=adrs.getString("group_id")%>">
						<button type="submit" class="btn btn-light" title="Delete">
						<i class="fa fa-trash" aria-hidden="true"></i>
					</button>
					</form>

				</div>
			</div>
			<%
				}
			%>
		</div>
	</div>
	
	<div class="bg-light">
	<h3 >Joined Groups</h3>
		<div class="card-columns p-5">
			<%
				while (rs.next()) {
			%>
			<div class="card bg-light>">
				<img class="card-img-top p-3" src="images/group.jpeg" alt="image_icon">
				<div class="card-body">
					<a href="viewgrouphome.jsp?id=<%=rs.getString("group_id")%>"><h5 class="card-title"><%=rs.getString("group_name")%></h5></a>
					<%-- <p class="card-text"><%=rs.getString("tag")%></p> --%>	

				</div>
			</div>
			<%
				}
			%>
		</div>
	</div>
	
	<div class="bg-light">
	<h3 >Available Groups</h3>
		<div class="card-columns p-5">
			<%
				while (ars.next()) {
			%>
			<div class="card bg-light>">
				<img class="card-img-top p-3" src="images/group.jpeg" alt="image_icon">
				<div class="card-body">
					<h5 class="card-title"><%=ars.getString("group_name")%></h5>
					<%-- <p class="card-text"><%=rs.getString("tag")%></p> --%>	
					<form action="RequestGroupServlet" method="POST">
						<input type="hidden" name="user_email" value="<%=user_email%>">
						<input type="hidden" name="group_name" value="<%=ars.getString("group_name")%>">
						<button type="submit" class="btn btn-dark" title="Request Join">Request Join
						<!-- <i class="fa fa-trash" aria-hidden="true"></i> -->
					</button>

				</div>
			</div>
			<%
				}
			%>
		</div>
	</div>
	
	<%
		con.close();

		} catch (Exception e) {
			e.printStackTrace();
		}
	%>
	<!-- Footer Section -->
	<div class="p-3 mt-3 bg-dark text-white">View Groups</div>
	<!-- Main Container Ends -->
</body>
</html>