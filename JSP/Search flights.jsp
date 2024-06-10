<%@page import="java.util.List"%>
<%@include file="header.jsp"%>
<div id="content">
	<!-- insert the page content here -->

	<%
		String status = request.getParameter("status");

		if (status != null) {
	%>
	<h1><%=status%></h1>
	<%
		} else {
	%>
	<h1>View Flights</h1>
	<%
		}
	%>
	
	<%
		if(role.equals("airlines"))
		{
	%>
			<table style="width: 100%; border-spacing: 0;">
				<tr>
					<th>Name</th>
					<th>Source</th>
					<th>Destination</th>
					<th>Timings</th>
					<th>View Fares</th>
					<th>Delete</th>
				</tr>
				<%
					for (Flight flight : getFlights()) {
				%>
		
				<tr>
					<td><%=flight.getName()%></td>
					<td><%=flight.getSource()%></td>
					<td><%=flight.getDestination()%></td>
					<td><%=flight.getTimings()%></td>
					<td><a href="viewfares.jsp?flightid=<%=flight.getId()%>">view fares</a></td>
					<td><a href="viewflights.jsp?id=<%=flight.getId()%>">delete</a></td>
				</tr>
			 </table>
		<%
			}
		}
		else if(role.equals("user"))
		{
	%>
				<form action="viewflights.jsp">
	
					<div class="form_settings">
						<p>
							<span>Enter Your Destination:</span><input class="contact" type="text" name="destination"
								value="" required="required"/>
						</p>
						<p style="padding-top: 15px">
							<span>&nbsp;</span><input class="submit" type="submit"
								name="contact_submitted" value="Search Flight" />
						</p>
					</div>
				</form>
	
				<hr/>
	<%
		}
	%>
	
	<%
		if(role.equals("user"))
		{
			String destination=request.getParameter("destination");
			
			if(destination!=null)
			{
	%>
				<table style="width: 100%; border-spacing: 0;">
					<tr>
						<th>Name</th>
						<th>Source</th>
						<th>Destination</th>
						<th>Timings</th>
						<th>Book Ticket</th>
					</tr>
					
					<%
						for (Flight flight : getFlights()) 
						{
							if(flight.getDestination().toLowerCase().contains(destination.toLowerCase()))
							{
					%>
							<tr>
								<td><%=flight.getName()%></td>
								<td><%=flight.getSource()%></td>
								<td><%=flight.getDestination()%></td>
								<td><%=flight.getTimings()%></td>
								<td><a href="bookticket.jsp?flightid=<%=flight.getId()%>">book ticket</a></td>
							</tr>
					<%
							}
						}
					%>
					
				</table>
	<%
			}
			else
			{
	%>
				<table style="width: 100%; border-spacing: 0;">
					<tr>
						<th>Name</th>
						<th>Source</th>
						<th>Destination</th>
						<th>Timings</th>
						<th>Book Ticket</th>
					</tr>
					<%
						for (Flight flight : HibernateDAO.getFlights()) 
						{
					%>
							<tr>
								<td><%=flight.getName()%></td>
								<td><%=flight.getSource()%></td>
								<td><%=flight.getDestination()%></td>
								<td><%=flight.getTimings()%></td>
								<td><a href="bookticket.jsp?flightid=<%=flight.getId()%>">book ticket</a></td>
							</tr>
					<%
						}
					%>
				</table>
	<%			
			}
		}
	%>	

	<%
		String id = request.getParameter("id");

		if (id != null) {
			
			for(Fare fare : getFares())
			{
				if(fare.getFlightid().equals(id))
				{
					deleteObject(Fare.class, fare.getId());
				}
			}
			
			if (deleteObject(Flight.class, Integer.parseInt(id)) == 1) {
				response.sendRedirect("viewflights.jsp?status=success");
			} else {
				response.sendRedirect("viewflights.jsp?status=failed");
			}
		}
	%>

</div>