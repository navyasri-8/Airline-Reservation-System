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
	<h1>View Tickets</h1>
	<%
		}
	%>

	<table style="width: 100%; border-spacing: 0;">
		<tr>
			<th>Ticket ID</th>
			<th>Seat NO</th>
			<th>Date of Journey</th>
			<th>User ID</th>
			<th>Flight ID</th>
			<th>Seating Class</th>
			<%
				if(role.equals("user"))
				{
			%>
					<th>Cancel Ticket</th>
			<%
				}
			%>
		</tr>
		
		<%
			if(role.equals("user"))
			{
		%>
				<%
					int seatno=1;
				
					for (Ticket ticket : getTickets()) {
						
						if(ticket.getUserid().equals(username))
						{
				%>
							<tr>
								<td><%=ticket.getId()%></td>
								<td><%=seatno%></td>
								<td><%=ticket.getDateofjourney()%></td>
								<td><%=ticket.getUserid()%></td>
								<td><%=ticket.getFlightid()%></td>
								<td><%=ticket.getSeatclass()%></td>
								<td><a href="viewtickets.jsp?id=<%=ticket.getId()%>">cancel</a></td>
							</tr>
				<%
						}
					}
				%>
		<%
			}
		%>
		
		<%
			if(role.equals("airlines"))
			{
		%>
				<%
					int seatno=1;
				
					for (Ticket ticket :getTickets()) 
					{
				%>
						<tr>
							<td><%=ticket.getId()%></td>
							<td><%=seatno%></td>
							<td><%=ticket.getDateofjourney()%></td>
							<td><%=ticket.getUserid()%></td>
							<td><%=ticket.getFlightid()%></td>
							<td><%=ticket.getSeatclass()%></td>
						</tr>
				<%
					}
				%>
		<%
			}
		%>
	
	</table>
	
	
	<%
		String id = request.getParameter("id");

		if (id != null) {
			
			if (deleteObject(Ticket.class, Integer.parseInt(id)) == 1) {
				response.sendRedirect("viewtickets.jsp?status=success");
			} else {
				response.sendRedirect("viewtickets.jsp?status=failed");
			}
		}
	%>
	
</div>