package taskmanager;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
@WebServlet("/Welcome")
public class DataServlet extends HttpServlet {

	public void doGet(HttpServletRequest req,HttpServletResponse res) throws IOException,ServletException,NullPointerException
	{
		String role = null;
		 HttpSession session=req.getSession(true); 
		 res.setHeader("Cache-Control", "no-cache, no-store, must-revalidate"); // HTTP 1.1.
		 res.setHeader("Pragma", "no-cache"); // HTTP 1.0.
		 res.setDateHeader("Expires", 0);
		  if(session.getAttribute("username")==null || session.getAttribute("Role")==null)
		  {
			  StringBuffer url = req.getRequestURL();
			  String URL = url.toString();
			  session.setAttribute("url", URL);
			  res.sendRedirect("Login.jsp");
			  
		  }
		  
		  else {
			PrintWriter out = res.getWriter();  
			res.setContentType("text/html");
			ArrayList<String> arr = new ArrayList<>();
			if(System.getProperty("os.name").contains("Windows"))
			{
				arr = Windows.value();
			}
			else
			{
				arr = Linux.value();
			}
			req.setAttribute("data", arr);
			role= (String)session.getAttribute("Role");
				if(role.equals("Admin"))
				{
					RequestDispatcher rd = req.getRequestDispatcher("Admin.jsp");
					rd.include(req, res);
				}
				else
				{
					RequestDispatcher rd = req.getRequestDispatcher("User.jsp");
					rd.forward(req, res);
				}
			}
		  }
	}
