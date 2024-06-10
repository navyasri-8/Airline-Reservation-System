import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class mainServlet extends HttpServlet
 {

	HttpServletRequest request;
	HttpServletResponse response;

	Object obj=null;
	String redirect=null;
	String type;
	String operation=null;

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		this.request=request;
		this.response=response;

		try {

			type=request.getParameter("type");
			redirect=request.getParameter("redirect");
			operation=request.getParameter("operation");

			if(type!=null && redirect!=null && operation!=null)
			{
				obj=Class.forName(type).newInstance();
				Object object=HttpRequestParser.parseRequest(request, obj);

				if(type.equals("com.voidmain.pojo.User"))
				{
					String otp=MailService.getOtp();

					Login login=new Login();
					login.setUsername(request.getParameter("username"));
					login.setPassword(request.getParameter("password"));
					login.setRole(request.getParameter("usertype"));
					login.setStatus("no");
					login.setOtp(otp);

					User user=(User)obj;

					if(!isUserRegistred(request.getParameter("username")))
					{
						if(addObject(object)==1 && addObject(login)==1)
						{
							try {
								MailService.mailsend("Otp for Dream Destination",otp,user.getEmail());
							} catch (Exception e) {
								e.printStackTrace();
							}
							response.sendRedirect(redirect+"?status=success");
						}
						else
						{
							response.sendRedirect(redirect+"?status=failed");
						}
					}
					else
					{
						response.sendRedirect(redirect+"?status=User All ready Registred");
					}

				}
				else if(type.equals("Ticket"))
				{
					Ticket ticket=(Ticket)obj;
					User user=HibernateDAO.getUserById(ticket.getUserid());

					if(addObject(ticket)==1)
					{
						try {
							
							String info="Your Flight ID:"+ticket.getFlightid()+"\n";
							info=info+"Date of Journey:"+ticket.getDateofjourney()+"\n";
							info=info+"Seat Type:"+ticket.getSeatclass()+"\n";
							
							MailService.mailsend("Your Flight Ticket Info",info,user.getEmail());
							
						} catch (Exception e) {
							e.printStackTrace();
						}
						
						response.sendRedirect(redirect+"?status=success");
					}
					else
					{
						response.sendRedirect(redirect+"?status=failed");
					}

				}
				else
				{
					if(operation.equals("add"))
					{
						if(addObject(object)==1)
						{
							response.sendRedirect(redirect+"?status=success");
						}
						else
						{
							response.sendRedirect(redirect+"?status=failed");
						}					
					}
					else if(operation.equals("update"))
					{
						if(HibernateTemplate.updateObject(object)==1)
						{
							response.sendRedirect(redirect+"?status=success");
						}
						else
						{
							response.sendRedirect(redirect+"?status=failed");
						}
					}
				}
			}
		} catch (Exception e) {

			e.printStackTrace();
		}
	}
}
