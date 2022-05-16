<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<meta name="viewport" content="width=device-width, initial-scale=1">
<style>
body {
font-family: Arial, Helvetica, sans-serif;
max-width: 500px;
margin: auto;
padding:20px;
}
form {border: 3px solid #f1f1f1;}

input[type=text], input[type=password] {
  width: 100%;
  padding: 12px 20px;
  margin: 8px 0;
  display: inline-block;
  border: 1px solid #ccc;
  box-sizing: border-box;
}

button {
  background-color: #04AA6D;
  color: white;
  padding: 14px 20px;
  margin: 8px 0;
  border: none;
  cursor: pointer;
  width: 100%;
}

button:hover {
  opacity: 0.8;
}
.imgcontainer {
  text-align: center;
  margin: 24px 0 12px 0;
}
img.user {
  width: 40%;
  border-radius: 50%;
}
.container {
  padding: 16px;
}
span.psw {
  float: center;
  padding-top: 16px;
}
}
</style>
<title>WELCOME</title>
</head>
<body>
<%
response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate"); // HTTP 1.1.
response.setHeader("Pragma", "no-cache"); // HTTP 1.0.
response.setDateHeader("Expires", 0);
String uname = "", password = "", reme = "";
System.out.println(reme);
Cookie[] cookies = request.getCookies();
if (cookies != null) {
	for (Cookie cook : cookies) {
		if (cook.getName().equals("Cookuname"))
	uname = cook.getValue();
		else if (cook.getName().equals("Cookpass"))
	password = cook.getValue();
		else if (cook.getName().equals("Cookrem"))
	reme = cook.getValue();
	}
}
%>
  <h1 style="text-align:center">WELCOME USER</h1>
  <form action="<%=request.getContextPath()%>/login" method="post">
  <div class="imgcontainer">
    <img src="images.jpg" alt="User" class="user">
  </div>
<%
    if(session.getAttribute("ErrorMessage")!=null)
    {%>
    	<h3>USERNAME OR PASSWORD MISMATCH</h3>
    	
    <%session.removeAttribute("ErrorMessage");
    }
    %>
  <div class="container">
    <label for="uname"><b>USERNAME</b></label>
    <input type="text" name="username" placeholder="username"
			value="<%=uname%>" required />

    <label for="psw"><b>PASSWORD</b></label>
    <input type="password"
			name="password" placeholder="password" value="<%=password%>" required />
    <label>
      <input type="checkbox" name="rem" value="1"
			<%="1".equals(reme) ? "checked='/checked'" : " "%> /> RememberMe <br>
    </label>
    <button type="submit">Login</button>
  </div>

  <div class="container" style="background-color:#f1f1f1">
    <span class="psw">Forgot <a href="#">password?</a></span>
  </div>
</form>
</body>
</html>