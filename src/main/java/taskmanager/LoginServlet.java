package taskmanager;

import java.io.IOException;
import java.io.PrintWriter;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
    //private static final long serialVersionUID = 1 L;
    private LoginDao loginDao;
    public void init() {
        loginDao = new LoginDao();
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
    	PrintWriter out=response.getWriter(); 
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String remember = request.getParameter("rem");
        LoginBean loginBean = new LoginBean();
        loginBean.setUsername(username);
        loginBean.setPassword(password);
        RequestDispatcher rd = null;
        HttpSession session = request.getSession();
        String link=null;
        link = (String) session.getAttribute("url");
        try {
            if (loginDao.validate(loginBean)) {
                session.setAttribute("username",username);
                boolean remember1 = request.getParameter("rem") != null;
                if (remember1) {
					Cookie checkuser = new Cookie("Cookuname", username);
					checkuser.setMaxAge(5000);
					response.addCookie(checkuser);
					Cookie checkpswd = new Cookie("Cookpass", password);
					checkpswd.setMaxAge(5000);
					response.addCookie(checkpswd);
					Cookie ckReme = new Cookie("CookRem", remember);
					ckReme.setMaxAge(5000);
					response.addCookie(ckReme);
                    if(loginDao.Role(loginBean))
                       {
                	     System.out.println("Hello Administrator");
                	     session.setAttribute("Role", "Admin");
                	     if(link==null)
              	           {
              	             System.out.println(link);
              	             rd = request.getRequestDispatcher("Home.jsp");
						     rd.forward(request, response);
              	          }
                	      else
                	       {
                		      System.out.println(link);
                		      session.removeAttribute("url");
                    	      response.sendRedirect(link);
                	       }
                      }
                        else {
                	       System.out.println("Hello User");
                	       session.setAttribute("Role", "User");
                	       System.out.println(link);
                	       if(link==null)
              	           {
                	         rd = request.getRequestDispatcher("Home.jsp");
 						    rd.forward(request, response);
              	           }
                	       else 
              	           {
              	        	   System.out.println(link);
              	        	   session.removeAttribute("url");
                   	           response.sendRedirect(link);  
              	           }
                       }
                }
                else {
 						if(loginDao.Role(loginBean))
                        {
                 	       System.out.println("Hello Administrator->No Cookie");
                 	      session.setAttribute("Role", "Admin");
                 	       System.out.println(link);
                 	       if(link==null)
              	             {
              	              System.out.println(link);
              	              
              	              response.sendRedirect("Home.jsp");
              	             }
              	             else {
               	                System.out.println(link);
               	                response.sendRedirect(link);
              	               }
                         }
                      else {
                 	           System.out.println("Hello User->No Cookie");
                 	           System.out.println(link);
                 	          session.setAttribute("Role", "User");
                 	           if(link==null)
                 	           {
                 	             System.out.println(link);
                 	            
                 	            response.sendRedirect("Home.jsp");
                 	           }
                 	           else {
                  	             System.out.println(link);
                  	             response.sendRedirect(link);
                 	           }
                         }
                  }
                
            } else {
            	session.setAttribute("ErrorMessage", "Login Failed");
            	System.out.println("Error");
				request.getRequestDispatcher("Login.jsp").forward(request, response);
            }
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        }
    }
}
