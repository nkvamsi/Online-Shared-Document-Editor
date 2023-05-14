<!DOCTYPE html>
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
    <link
      href="https://fonts.googleapis.com/css?family=Josefin+Sans:600"
      rel="stylesheet"
    />
    <title>SignUp for Group</title>
  </head>
  <body>
<body>
	<br />
	<h2 class="container bg-dark text-white text-center p-5 mb-0 banner shadow-lg" style="width: 50rem;">
		Create Group
		</h2>
        <div class="container card text-center shadow-lg" style="width: 50rem;">
            <div class="card-body" >
				<br />
				<form action="CreateGroupServlet" method="POST">
                <div class="row">
                   <!--  <div class="col-sm" style="padding-right:20px; border-right: 1px solid rgb(196, 190, 190);">
                         <br />
                        <div class="form-group">
                            <input type="email" class="form-control" aria-describedby="emailHelp" placeholder="Enter email" maxlength="30" 
                                    name="email" />
                            </div>
                            <div class="form-group">
                                <input type="password" class="form-control" placeholder="Password" name="ps" />
                            </div>
                            <div class="form-group">
                                <input type="password" class="form-control" placeholder=" Confirm Password" name="cps" />
                            </div>
                    </div> -->
                    <div class="col-sm">
                        <br>
                        <div class="form-group">
                                <input type="text" class="form-control" placeholder="Enter group name" maxlength="80" 
                                    name="name" />
                        </div>
<!--                         <div class="form-group">
                                <input type="text" class="form-control" placeholder="Add people with email ID , seperated" maxlength="100" 
                                    name="emails" />
                        </div> -->
                    </div>
                </div>
                <br>
				<button type="submit" class="btn btn-dark">Create Group</button>
				</form>
<!-- 				<br /><br />
				<p>Already have an account?</p>
				<a href="index.jsp" style="text-decoration: none;"> Log In </a> -->
				<br><br>
			</div>
		</div>
</body>
</html>
