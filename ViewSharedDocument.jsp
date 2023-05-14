<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.io.*"%>
<%@ page import="java.util.Properties"%>
<% if(request.getSession().getAttribute("user_id") == null){
	response.sendRedirect("index.jsp");
	}
	FileReader reader=new FileReader("/opt/tomcat/apache-tomcat-8.5.83/webapps/config.properties");  
	Properties p=new Properties();  
	p.load(reader);  
	String user = p.getProperty("user");
	String pass = p.getProperty("password");
	String url = p.getProperty("url");
	String db = p.getProperty("db");
	String doc_id = request.getParameter("id").toString();
	String is_a = "-";
	
	 try {
		Class.forName("com.mysql.jdbc.Driver");
		Connection con = DriverManager.getConnection("jdbc:mysql://" +url+ "/" + db,user,pass);
		String curr_email = request.getSession().getAttribute("current_email").toString();
		PreparedStatement cps = con.prepareStatement("select doc_id from sharing where doc_id = ? AND (user_email=? or group_name in (select group_name from group_sharing where user_email = ?))");
		cps.setString(1, doc_id);
		cps.setString(2, curr_email);
		cps.setString(3, curr_email);
	
		ResultSet crs = cps.executeQuery();
		while (crs.next()) {
			is_a = crs.getString(1);
		}
		if(!is_a.equals(doc_id)){
			response.sendRedirect("home.jsp");
		}
		con.close();
	
	}
	catch(Exception e){
		e.printStackTrace();
	}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
    <link
      rel="stylesheet"
      href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css"
      integrity="sha384-MCw98/SFnGE8fJT3GXwEOngsV7Zt27NXFoaoApmYm81iuXoPkFOJwJ8ERdknLPMO"
      crossorigin="anonymous"
    />
     <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo"
        crossorigin="anonymous"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js" integrity="sha384-ZMP7rVo3mIykV+2+9J3UJ46jBk0WLaUAdn689aCwoqbBJiSnjAK/l8WvCWPIPm49"
        crossorigin="anonymous"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/js/bootstrap.min.js" integrity="sha384-ChfqqxuZUCnJSK3+MXmPNIyE6ZbWh2IMqE241rYiqJxyMiZ6OW/JmZQ5stwEULTy"
        crossorigin="anonymous"></script>
    <!-- font-awesome -->
    <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.6.3/css/all.css" integrity="sha384-UHRtZLI+pbxtHCWp1t77Bi1L4ZtiqrqD80Kn4Z8NTSRyMA2Fd33n5dQ8lWUE00s/"
        crossorigin="anonymous">
	<link href="https://fonts.googleapis.com/css?family=Josefin+Sans:600" rel="stylesheet">
  <script src="https://cdn.tiny.cloud/1/wkmlr1je2y5855ajmlk0ld5nirz4pb4pl3ncgad1pm4y10ym/tinymce/6/tinymce.min.js" referrerpolicy="origin"></script>
<script>
    tinymce.init({
      selector: 'textarea',
      plugins: 'anchor autolink charmap codesample emoticons image link lists media searchreplace table visualblocks wordcount checklist mediaembed casechange export formatpainter pageembed linkchecker a11ychecker tinymcespellchecker permanentpen powerpaste advtable advcode editimage tinycomments tableofcontents footnotes mergetags autocorrect',
      toolbar: 'undo redo | blocks fontfamily fontsize | bold italic underline strikethrough | link image media table mergetags | addcomment showcomments | spellcheckdialog a11ycheck | align lineheight | checklist numlist bullist indent outdent | emoticons charmap | removeformat',
      tinycomments_mode: 'embedded',
      tinycomments_author: 'Author name',
      mergetags_list: [
        { value: 'First.Name', title: 'First Name' },
        { value: 'Email', title: 'Email' },
      ]
    });
  </script>
<title>Shared Document</title>
</head>
<body style="font-family: Josefin Sans, sans-serif;">
	<nav class="navbar navbar-expand-lg bg-dark">
        <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent"
            aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarSupportedContent">
            <ul class="navbar-nav">
                <li class="nav-item">
                    <a class="nav-link text-light" href="home.jsp">Home</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link text-light" href="shared_Docs.jsp">Shared Docs</a>
                </li>
				<li class="nav-item"><a class="nav-link text-light"
					href="groups.jsp">Groups</a></li>
				<li class="nav-item"><a class="nav-link text-light"
					href="requests.jsp">Requests</a></li>
                <li class="nav-item">
                    <a class="nav-link text-light" href="LogOut.jsp">Log Out</a>
                </li>
            </ul>
        </div>
    </nav>
	<br>
	<%
	String name = null;
		try {
			String html = "";
			Class.forName("com.mysql.jdbc.Driver");
			Connection con = DriverManager.getConnection("jdbc:mysql://" +url+ "/" + db,user,pass);
			/* String doc_id = request.getParameter("id").toString(); */
			String user_id = request.getSession().getAttribute("user_id").toString();
			String curr_email = request.getSession().getAttribute("current_email").toString();
			
			PreparedStatement ps = con.prepareStatement("select * from document where id=?");
			ps.setString(1, doc_id);
			int kc = 0;
			ResultSet rs = ps.executeQuery();
			while (rs.next()) {
			kc = 1;
			html = rs.getString("code");
			String title = rs.getString("name");
			String tag = rs.getString("tag");
			String description = rs.getString("description");
	%>
	<form method="post">
	<span>Title :<input type="text" name="title" value="<%=title %>" disabled="disabled"/></span>
	<span>Description : <input type="text" name="description" maxlength="500" value="<%=description %>" disabled="disabled"/></span>
	<textarea name="content" disabled="disabled"><%=html%></textarea>
	
	</form>
	<%
			}		
			con.close();

		} catch (Exception e) {
			e.printStackTrace();
		}
	%>
</body>
</html>