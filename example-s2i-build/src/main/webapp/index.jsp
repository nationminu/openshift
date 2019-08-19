<html>
  <head><title>Session Tracking Test</title>
</head>
    <body>
    <h1>Session Tracking Test #1</h1>
    Session tracking with JSP is easy
    <P>
<%@ page session="true" %>
<%@ page import="java.net.InetAddress" %>
<%
	String hostname = InetAddress.getLocalHost().getHostName().toString();
	String ip 		= InetAddress.getLocalHost().getHostAddress().toString(); 

	// Get the session data value
    Integer ival = (Integer) session.getValue ("counter");
	if (ival == null) ival = new Integer (1);
	else ival = new Integer (ival.intValue() + 1);
	session.putValue ("counter", ival);
%> 
    You have hit this page <%= ival %> times.<br>
<%
    out.println("Your Session ID is " + session.getId() +  "<br>");
	out.println("hostname/ip is " + hostname + "/" + ip +  "<br>");
    System.out.println("session=" + session.getId() + ", hostname="+ hostname+ ", ip="+ ip);
%>		 
</body></html>

