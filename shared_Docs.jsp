<!doctype html>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.io.*"%>
<%@ page import="java.util.Properties"%>
<% if(request.getSession().getAttribute("user_id") == null){
	response.sendRedirect("index.jsp");
	}
%>
<html>
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>Shared Documents</title>
	<!-- Bootstrap CSS -->
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css" integrity="sha384-MCw98/SFnGE8fJT3GXwEOngsV7Zt27NXFoaoApmYm81iuXoPkFOJwJ8ERdknLPMO"
        crossorigin="anonymous">
    <!-- Bootstrap JS -->
    <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo"
        crossorigin="anonymous"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js" integrity="sha384-ZMP7rVo3mIykV+2+9J3UJ46jBk0WLaUAdn689aCwoqbBJiSnjAK/l8WvCWPIPm49"
        crossorigin="anonymous"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/js/bootstrap.min.js" integrity="sha384-ChfqqxuZUCnJSK3+MXmPNIyE6ZbWh2IMqE241rYiqJxyMiZ6OW/JmZQ5stwEULTy"
        crossorigin="anonymous"></script>
    <!-- font-awesome -->
    <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.6.3/css/all.css" integrity="sha384-UHRtZLI+pbxtHCWp1t77Bi1L4ZtiqrqD80Kn4Z8NTSRyMA2Fd33n5dQ8lWUE00s/"
        crossorigin="anonymous">
    <!-- CSS -->
	<link href="css/style.css" rel="stylesheet" type="text/css">
	<link href="https://fonts.googleapis.com/css?family=Josefin+Sans:600" rel="stylesheet">
</head>
<body>
<!-- Main Container -->
<div class="p-3 bg-dark text-white">Shared Documents</div>
  <!-- nav Section -->
	<nav class="navbar navbar-expand-lg navbar-light bg-light">
        <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent"
            aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarSupportedContent">
            <ul class="navbar-nav mr-auto">
                <li class="nav-item">
                    <a class="nav-link text-dark" href="home.jsp">Home</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link text-dark" href="shared_Docs.jsp">Shared Docs</a>
                </li>
               	<li class="nav-item"><a class="nav-link text-dark"
					href="groups.jsp">Groups</a></li>
				<li class="nav-item"><a class="nav-link text-dark"
					href="requests.jsp">Requests</a></li>
                <li class="nav-item">
                    <a class="nav-link text-dark" href="LogOut.jsp">Log Out</a>
                </li>
            </ul>
			<form action="SearchServlet" method = "POST" class="form-inline my-2 my-lg-0">
				<input class="form-control mr-sm-2" type="search" placeholder="Search" name="search">
				<button type="submit" class="btn btn-light">
					<i class="fas fa-search"></i>
				</button>
			</form>
        </div>
    </nav>
 <!-- Banner Section -->
 <div class="p-3 bg-dark text-white">
        <div class="container">
            <div class="row">
                <div class="col-sm">
                    <br><br><br><br>
                    <h2 class="mb-3">Welcome</h2>
                    <h3><%=request.getSession().getAttribute("name").toString() %></h3>
                </div>
                <div class="col-sm">
                    <img class="img-circle" src="images/profile.png">
                </div>
            </div>
        </div>
    </div>
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
	String current_email = request.getSession().getAttribute("current_email").toString();
	PreparedStatement ps = con.prepareStatement("select * from document where id in (select doc_id from sharing where user_email = ?)");
	if (request.getParameter("tag") != null) {
		ps = con.prepareStatement("select * from document where id in (select doc_id from sharing where user_email = ? and tag=?)");
		ps.setString(2, request.getParameter("tag").toString());
	}
	ps.setString(1, current_email);
	ResultSet rs = ps.executeQuery();
	
	%>	  

	<script type="text/javascript">
    window.onload = function(){
        location.href=document.getElementById("selectbox").value;
    }       
	</script>
	<div class="bg-light">
        <div class="card-columns p-5">
        <%
				while (rs.next()) {
						String color = rs.getString("tag");
						if (color.equals("Yellow"))
							color = "warning";
						else if (color.equals("Red"))
							color = "danger";
						else if (color.equals("Blue"))
							color = "info";
						else if (color.equals("Grey"))
							color = "secondary";
						else if (color.equals("Green"))
							color = "success";
						else
							color = "light";
			%>
        <div class="card bg-<%=color%>">
          <img class="card-img-top p-3" src="images/icon.png" alt="image_icon">
          <div class="card-body">
            <a href ="ViewSharedDocument.jsp?id=<%=rs.getString("id")%>"><h5 class="card-title"><%=rs.getString("name") %></h5></a>
            <p class="card-text"><%=rs.getString("tag") %></p>
          </div>
        </div>
            <%} %>
            </div>
        
    </div>
	<%
	con.close();

} catch (Exception e) {
	e.printStackTrace();
}
%>

 <!-- Footer Section -->
 <div class="p-3 mt-3 bg-dark text-white">View Your Documents</div>
<!-- Main Container Ends -->
</body>
</html>
