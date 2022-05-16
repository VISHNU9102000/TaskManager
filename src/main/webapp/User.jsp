<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="java.util.*" %>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<style type="text/css">
.button {
  background-color: #4CAF50;
  border: none;
  color: white;
  padding: 15px 32px;
  text-align: center;
  border-radius :15px;
  text-decoration: none;
  display: inline-block;
  font-size: 16px;
  margin: 4px 2px;
  cursor: pointer;
}
#one{
  background-color:Linen;
  border-radius :10px;
  font-weight :100;
  margin : auto;
}

table, th, td {
  border: 2px solid black;
  border-collapse: collapse;
  padding:20px;
}
th, td {
  padding: 20px;
  padding-top: 20px;
  padding-bottom: 25px;
  padding-left: 20px;
  padding-right: 20px;
}
.a{
  padding:10px;
  border-radius:10px;
 }
 #myInput {
  background-position: 10px 10px;
  background-repeat: no-repeat;
  width: 100%;
  font-size: 16px;
  padding: 12px 20px 12px 40px;
  border: 1px solid #ddd;
  margin-bottom: 12px;
}
.topnav {
  overflow: hidden;
  background-color: #333;
}

.topnav a {
  float: left;
  color: #f2f2f2;
  text-align: center;
  padding: 14px 16px;
  text-decoration: none;
  font-size: 17px;
}

.topnav a:hover {
  background-color: #ddd;
  color: black;
}
.topnav a.split {
  float: right;
  background-color: #04AA6D;
  color: white;
}
</style>
<script type="text/javascript">
function myFunction() {
	  var input, filter, table, tr, td, i, txtValue;
	  input = document.getElementById("myInput");
	  filter = input.value.toUpperCase();
	  table = document.getElementById("myTable");
	  tr = table.getElementsByTagName("tr");
	  for (i = 0; i < tr.length; i++) {
	    td = tr[i].getElementsByTagName("td")[0];
	    if (td) {
	      txtValue = td.textContent || td.innerText;
	      if (txtValue.toUpperCase().indexOf(filter) > -1) {
	        tr[i].style.display = "";
	      } else {
	        tr[i].style.display = "none";
	      }
	    }       
	  }
	}
</script>
<script text="text/javascript">
cPrev = -1; 
 function sortBy(c) {
 rows = document.getElementById("myTable").rows.length; // num of rows
 columns = document.getElementById("myTable").rows[0].cells.length; // num of columns
 arrTable = [...Array(rows)].map(e => Array(columns)); // create an empty 2d array

 for (ro=0; ro<rows; ro++) {
 for (co=0; co<columns; co++) { 
  arrTable[ro][co] = document.getElementById("myTable").rows[ro].cells[co].innerHTML;
  }
 }
 th = arrTable.shift();
 if (c !== cPrev) {	
	arrTable.sort(function(a, b)
	{
		return a[c]-b[c]});

  
  } else {
 arrTable.reverse();
 }
   cPrev = c;
   arrTable.unshift(th);
   for (ro=0; ro<rows; ro++) {
   for (co=0; co<columns; co++) {
    document.getElementById("myTable").rows[ro].cells[co].innerHTML = arrTable[ro][co];
    $(document).ready(function() {
        $("#myTable td:nth-child(3)").each(function() {
            if (parseFloat($(this).text(), 10) <= 30) {
                $(this).parent("tr").css("background-color", "white");
            } else if (parseFloat($(this).text(), 10) > 30 && parseFloat($(this).text(), 10) <= 50) {
                $(this).parent("tr").css("background-color", "orange");
            }else{
            	$(this).parent("tr").css("background-color", "tomato");
            }
        });
      });
   }
  }
}
</script>
<meta charset="ISO-8859-1">
<script src="http://code.jquery.com/jquery-1.7.2.min.js" text="text/javascript"></script>
<script language="javascript">
        $(document).ready(function() {
            $("#myTable td:nth-child(3)").each(function() {
                if (parseFloat($(this).text(), 10) <= 30) {
                    $(this).parent("tr").css("background-color", "white");
                } else if (parseFloat($(this).text(), 10) > 30 && parseFloat($(this).text(), 10) <= 50) {
                    $(this).parent("tr").css("background-color", "orange");
                }else{
                	$(this).parent("tr").css("background-color", "tomato");
                }
            });
        });
    </script>  
<title>DATA</title>
</head>
<body>
<%
response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate"); // HTTP 1.1.
response.setHeader("Pragma", "no-cache"); // HTTP 1.0.
response.setDateHeader("Expires", 0);
  if(session.getAttribute("username")==null)
  {
	  response.sendRedirect("Login.jsp");
  }
   %>
   <%--navigation bar--%>
   <div class="topnav">
  <a class="active">Welcome ${username} </a>
  <a href="<%=request.getContextPath()%>/Logout" class="split">Logout</a>
</div>
<%--header--%>
<h1 style="text-align:center; padding:auto; background-color:DarkSlateGray; color:White">TASK MANAGER</h1>

<%--Refresh button--%>
<form style="text-align:center;" action="Class1" method="GET">
  <input type="submit" class="button" value="REFRESH">
 </form>
 
 <%--Search box--%>
 <input type="text" id="myInput" onkeyup="myFunction()" placeholder="Search for Process.." title="Type in a name">
<div id="one">
<table id="myTable" class="w3-table-all">
<thead>
     <tr style="cursor:pointer">
      <th>NAME</th>
      <th>ID</th>
      <th onclick="sortBy(2)">MEMORY(Mb)</th>
      <th onclick="sortBy(3)">CPU(in Sec)</th>
      <th>PATH</th>
   </thead>
      <tbody id="table_filter2">
    <%ArrayList<String> list = new ArrayList<>();
      list=(ArrayList<String>)request.getAttribute("data");
      for(int i=0;i<list.size();i++){%>
      <% String[] arr = list.get(i).split("\\s",5);
       if(arr.length==5 && arr!=null) {%>
	        <tr>
	          <td><%=arr[0]%></td>
	          <td><%=arr[1]%></td>
	          <td><%=arr[2]%></td>
	          <td><%=arr[3]%></td>
	          <td><%=arr[4]%></td>
	        </tr>
        <%}
       if(arr.length==4 && arr!=null){%>
	          <tr>
		          <td><%=arr[0]%></td>
		          <td><%=arr[1]%></td>
		          <td><%=arr[2]%></td>
		          <td><%=arr[3]%></td>
		          <td><% %></td>
	          </tr>
	      <%}}%> 
	      </tbody>     
      </table>
      <input type="hidden" id="memory_order" value="asc">
     </div> 

</body>
</html>