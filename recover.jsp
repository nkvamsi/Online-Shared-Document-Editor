<!DOCTYPE html>
<%@page import="javax.management.Query"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.io.*"%>
<%@ page import="java.util.Properties"%>
<html lang="en">
  <head>
    <!-- Required meta tags -->
    <meta charset="utf-8" />
    <meta
      name="viewport"
      content="width=device-width, initial-scale=1, shrink-to-fit=no"
    />

    <!-- Bootstrap CSS -->
    <link
      rel="stylesheet"
      href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css"
    />
    <!-- CSS -->
    <link rel="stylesheet" type="text/css" href="css/styles_index.css" />
    <link href="https://fonts.googleapis.com/css?family=Josefin+Sans:600" rel="stylesheet">
    <title>Login</title>
</head>
<body>
	<%
		String question = "";
		String email = "";
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
			PreparedStatement ps = con.prepareStatement("select * from user");
			if (request.getParameter("id") != null) {
				ps = con.prepareStatement("select * from user where id=?");
				ps.setString(1, request.getParameter("id").toString());
			}

			ResultSet rs = ps.executeQuery();
			rs.next();
			question = rs.getString("question");
			email = rs.getString("email");
			con.close();
			ps.close();
			
		}
		catch(Exception e)	{}	
		%>
	    <br /><br />
    <h2
      class="container bg-dark text-white text-center p-5 mb-0 banner shadow-lg" style="width: 30rem;"
    >
      Reset Password
    </h2>
    <div class="container card text-center shadow-lg" style="width: 30rem;">
      <div class="card-body">
        <form action="ResetServlet" method="POST">
          <div class="form-group">
              <input type="hidden" class="form-control" name="email" value="<%=email%>" />
            </div>
          <div class="form-group">
            <input type="text" class="form-control" name="question" disabled value ="<%=question %>" />
          </div>
          <div class="form-group">
            <input type="text" class="form-control" placeholder="Enter Answer" name="answer"/>
          </div>
          <div class="form-group">
              <input type="password" class="form-control" placeholder="New Password" name="new_password" />
            </div>
            <div class="form-group">
              <input type="password" class="form-control" placeholder="Confirm New Password" name="confirm_password" />
            </div>
            
            <button type="submit" class="btn btn-dark">Reset</button>
        </form>
        <br /><br />
        <a href="index.jsp" style="text-decoration: none;">Back to Log In </a>
        <br><br>
      </div>
    </div>
</body>
</html>