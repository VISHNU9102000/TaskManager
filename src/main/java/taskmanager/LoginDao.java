package taskmanager;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import taskmanager.LoginBean;

public class LoginDao {
	public static Connection connect()throws ClassNotFoundException
	{
		Connection connection = null;

	        try {
					Class.forName("com.mysql.cj.jdbc.Driver");
	        	 connection= DriverManager.getConnection("jdbc:mysql://localhost:3306/taskmanager", "root", "vishnu");
	        	}catch(SQLException e){
	        		e.printStackTrace();
	        }
	        return connection;
	}

    public boolean validate(LoginBean loginBean) throws ClassNotFoundException {
        boolean status = false;
          Connection con = LoginDao.connect();
            try(PreparedStatement preparedStatement = con
            .prepareStatement("select * from members where Name = ? and password = ? ")) {
            preparedStatement.setString(1, loginBean.getUsername());
            preparedStatement.setString(2, loginBean.getPassword());

            System.out.println(preparedStatement);
            ResultSet rs = preparedStatement.executeQuery();
            status = rs.next();

        } catch (SQLException e) {
            // process sql exception
            printSQLException(e);
        }
        return status;
    }
    public boolean Role(LoginBean loginBean) throws ClassNotFoundException {
        boolean status = false;
        String role = null;
          Connection connect = LoginDao.connect();
            try(PreparedStatement preparedStatement2 = connect.prepareStatement("SELECT Role FROM members WHERE Name=?")) {
            	 preparedStatement2.setString(1, loginBean.getUsername());
                 System.out.println(preparedStatement2);
                 ResultSet res = preparedStatement2.executeQuery();
                 
                 while(res.next() != false){

                     role = res.getString("Role");
                     System.out.println(role);
                 }
                 
                 if(role.equals("Admin"))
                 {
                	 //System.out.println(role);
                	 status=true;
                 }

        } catch (SQLException e) {
            // process sql exception
            printSQLException(e);
        }
        return status;
    }

    private void printSQLException(SQLException ex) {
        for (Throwable e: ex) {
            if (e instanceof SQLException) {
                e.printStackTrace(System.err);
                System.err.println("SQLState: " + ((SQLException) e).getSQLState());
                System.err.println("Error Code: " + ((SQLException) e).getErrorCode());
                System.err.println("Message: " + e.getMessage());
                Throwable t = ex.getCause();
                while (t != null) {
                    System.out.println("Cause: " + t);
                    t = t.getCause();
                }
            }
        }
    }
}

	
