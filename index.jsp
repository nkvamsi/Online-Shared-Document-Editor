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
    <link href="https://fonts.googleapis.com/css?family=Josefin+Sans:600" rel="stylesheet">
    <title>Login</title>
</head>
<body>
	    <br /><br /><br />
    <h2
      class="container bg-dark text-white text-center p-5 mb-0 banner shadow-lg"
      style="width: 30rem;"
    >
      Log In
    </h2>
    <div class="container card text-center shadow-lg" style="width: 30rem;">
      <div class="card-body">
        <br /><br />
        <form action="loginServlet" method="POST">
          <div class="form-group">
            <input
              type="email"
              class="form-control"
              id="exampleInputEmail1"
              aria-describedby="emailHelp"
              placeholder="Enter email"
              maxlength="30" 
              name="email"
            />
          </div>
          <div class="form-group">
            <input
              type="password"
              class="form-control"
              id="exampleInputPassword1"
              placeholder="Password"
              name="ps"
            />
          </div>
          <button type="submit" class="btn btn-dark">Sign in</button>
        </form>
        <br>
        <a href="verify.html" style="text-decoration: none;"> Forgot Password ? </a>
        <br /><br /><br />
        <p>Don't have an account?</p>
        <a href="Register.html" style="text-decoration: none;"> SIGN UP </a>
        <br><br>
      </div>
    </div>
</body>
</html>
