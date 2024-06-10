<%@page import="java.util.*"%>
<%@page import="java.util.List"%>
<%@include file="header.jsp"%>
<div id="content">
	<!-- insert the page content here -->

	<%
		String status = request.getParameter("status");
		String flightid = request.getParameter("flightid");

		if (status != null) {
	%>
	<h1><%=status%></h1>
	<%
		} else {
	%>
	<h1>View Fares</h1>
	<%
		}
	%>

	<%
		if(flightid!=null)
		{
	%>
			<form action="bookticket.jsp">
				<input type="hidden" name="fid" value="<%=flightid%>">
				<div class="form_settings">
					<p>
						<span>Select Date of Journey:</span><input class="contact" type="date" name="doj"/>
					</p>
					<p style="padding-top: 15px">
						<span>&nbsp;</span><input class="submit" type="submit"
							name="contact_submitted" value="Submit" />
					</p>
				</div>
			</form>
	<%
		}
	%>
	
	<%
		String fid=request.getParameter("fid");
		String doj=request.getParameter("doj");
		
		if(fid!=null && doj!=null)
		{
	%>
			<table style="width: 100%; border-spacing: 0;">
				<tr>
					<th>Seat Class</th>
					<th>Price</th>
					<th>Available Tickets</th>
					<th>Book Ticket</th>
				</tr>
				<%
				for (Fare fare : getFares())
				{
					if(fare.getFlightid().equals(fid))
					{
				%>
				<tr>
					<td><%=fare.getSeatclass()%></td>
					<td><%=fare.getPrice()%></td>
					<td><%=fare.getNoOfTickets()-AppService.getAvaliableTickets(doj,fare.getSeatclass(),fid)%></td>
					<td><a href="conformticket.jsp?fareid=<%=fare.getId()%>&doj=<%=doj%>">book ticket</a></td>
				</tr>
				<%
					}
				}
				%>
			</table>
	<%
		}
	%>

	<%
		String id = request.getParameter("id");

		if (id != null) {
			if (deleteObject(Fare.class,Integer.parseInt(id))== 1) {
				response.sendRedirect("viewfares.jsp?status=success&flightid="+id);
			} else {
				response.sendRedirect("viewfares.jsp?status=success&flightid="+id);
			}
		}
	%>

</div>