<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"
	import="edu.neu.lovesports.orm.dao.*, java.util.*, edu.neu.lovesports.orm.method.*, edu.neu.lovesports.orm.models.*, java.sql.* "%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
	<h1>Hello</h1>
	<% 
	SubscriptionDAO sdao = new SubscriptionDAO();
	CategoryDAO cdao = new CategoryDAO();
	UserDAO udao = new UserDAO();
	Category c = cdao.read(2);
	User u = udao.read("Hera@gmail.com");
	Subscription sub = sdao.read(1);
	sub.setUser(u);
	sdao.delete(2);
	
	%>
</body>
</html>