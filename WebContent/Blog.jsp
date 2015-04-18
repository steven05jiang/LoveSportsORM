<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"
	import="edu.neu.lovesports.orm.dao.*, java.util.Date, java.util.List, edu.neu.lovesports.orm.method.*, edu.neu.lovesports.orm.models.*, java.sql.*, javax.script.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>LoveSports</title>
<script type="text/javascript" src="js/jquery-2.1.3.js">
</script>
<script>
	$(function(){
		var text = $('<p></p>').text($('#loadText').val());
		$('#blog').append(text);
	});
</script>
</head>
<body>
	<%
		UserLog check = new UserLog();
		String action = request.getParameter("action");
		String username = request.getParameter("username");
		String password = request.getParameter("password");
		String blogId = request.getParameter("blogId");
		BlogDAO bdao = new BlogDAO();
		Blog blog = null;
		if(blogId != null)
			blog = bdao.read(Integer.parseInt(blogId));

		if (action != null) {
			if ("signup".equals(action)){
				response.sendRedirect("/LoveSportsORM/UserSignUp.jsp");
				action = null;
			}
			else if ("logout".equals(action)){
				session.removeAttribute("User");
				response.sendRedirect("/LoveSportsORM/Blog.jsp?blogId="+blogId);
				action = null;
			}
			else if ("login".equals(action)) {
					if (username == "" || password == "")
						out.println("Please enter account and password.");
					else if (check.Login(request, response, username, password)){
						response.sendRedirect("/LoveSportsORM/Blog.jsp?blogId="+blogId);
					}
					else{
						out.println("Username and Password are not matched.");
					}
					action = null;
				}
		}
		User user = (User) session.getAttribute("User");
	%>
	<div id="top">
		<%
			if (user == null) {
				%>
				<div id="login">
					<form id="form" action="Blog.jsp">
						Account: <input  name="username" type="text" /> 
						Password:<input  name="password" type="password" />
						<button type="submit" name="action" value="login">Log In</button>
						<button name="action" value="signup">Sign Up</button>
						<input type="hidden" name="blogId" value="<%=blogId%>" />
					</form>
				</div>
				<%
				} 
			else {
				%>
				<div id="login">
					<strong>Hello <%=user.getNickname()%>!</strong>
					<form action="Blog.jsp">
						<button type="submit" name="action" value="logout">Log Out</button>
						<input type="hidden" name="blogId" value="<%=blogId%>" />
					</form>
				</div>
				<%
			}
				%>
	</div>
	<%
	StampDAO stdao = new StampDAO();
	CommentDAO cmtdao = new CommentDAO();
	String commentTitle = request.getParameter("title");
	String commentText =request.getParameter("text");
	if(action != null){
		if(user != null){
			if("like".equals(action)){
				if(stdao.read(blog, user) == null)
					stdao.create(blog, user);
				else
					stdao.delete(blog, user);
			}
			else if("postComment".equals(action)){
				if(commentText != ""){
					Date date = new Date();
					Comment comment = new Comment(null, commentTitle, commentText, date, user, blog);
					cmtdao.create(comment);
					}
			}
			else if("editBlog".equals(action)){
					response.sendRedirect("/LoveSportsORM/BlogEditor.jsp?blogId="+blogId);
			}
			else if("removeComment".equals(action)){
					cmtdao.delete(Integer.parseInt(request.getParameter("commentId")));
			}
		}
		if(!"editBlog".equals(action))
			response.sendRedirect("/LoveSportsORM/Blog.jsp?blogId="+blogId);
	}
	%>
	<div id="content">
		<div id="blog">
			<h1><%=blog.getTitle()%></h1>
			<p><strong> Written by: </strong><i><a href="/LoveSportsORM/UserProfile.jsp?user=<%=blog.getUser().getUsername()%>"><%=blog.getUser().getNickname()%></a></i></p>
			<p><tt>Created on <%=blog.getCreateDate() %></tt></p>
			<p><tt>Modified on <%=blog.getModifyDate() %></tt></p>
			<%
			if(user != null){
				if(blog.getUser().getUsername().equals(user.getUsername())){
					%>
					<form>
					<button name="action" value="editBlog">Edit</button>
					<input type="hidden" name="blogId" value="<%=blogId%>" />
					</form>
					<%
				}
			}
			%>
			<p>
			<a href="#comment"><button>Skip to Comment</button></a></p>
			<textarea id="loadText" style="display:none"><%=blog.getText() %></textarea>
		</div>
 		<div>
			<%
			List<Stamp> stamps = bdao.read(Integer.parseInt(blogId)).getStamps();
			%>
			<form id="stampForm" action="Blog.jsp">
				<button id="stampButton" type="submit" name="action" value="like"><%=stamps.size()%>LIKES</button>
				<input type="hidden" name="blogId" value="<%=blogId%>" />
			</form>
			<%
			List<Comment> comments = bdao.read(Integer.parseInt(blogId)).getComments();
			%>
			<button><%=comments.size()%>COMMENTS</button>
		</div>
		<div id="comment">
			<div>
				<form action="Blog.jsp">
					<input type="hidden" name="blogId" value="<%=blogId%>" /> 
					<input type="text" name="title" placeholder="Enter title" autofocus="autofocus" /><br /> 
					<input type="text" name="text" required="required" placeholder="Enter comment" autofocus="autofocus" /><br />
					<button name="action" value="postComment">Submit</button>
					<button type="reset">Reset</button>
				</form>
			</div>
			<div>
				<%
				int n = 0;
				if (request.getParameter("commentPage") != null)
					n = (Integer.parseInt(request.getParameter("commentPage"))-1)*10;
				%>
				<ul>
					<%
						for (int i = 0; i < 10 ; i++) {
									if(comments.size() == 0)
										break;
									else{
									Comment comment = comments.get(i+n);
					%>
					<li>
						<div>
							<h3>Title: <%=comment.getTitle()%></h3> 
							<i>Author: <a href="/LoveSportsORM/UserProfile.jsp?user=<%=comment.getUser().getUsername() %>">
							<%=comment.getUser().getNickname()%></a></i><br />
							<tt><%=comment.getCreateDate() %></tt>
							<p><%=comment.getText()%></p>
							<form action="Blog.jsp">
								<button>Reply</button>
								<%
								if(user != null){
									if(comment.getUser().getUsername().equals(user.getUsername())){
										%>
										<button name="action" value="removeComment">Delete</button>
										<input type="hidden" name="commentId" value="<%=comment.getId()%>" />
										<%
									}
								}
								%>
								<input type="hidden" name="blogId" value="<%=blogId%>" /> 
							</form>
						</div>
					</li>
					<%
						if((i+n) == (comments.size()-1))
							break;
									}
					}
					%>
				</ul>
				<p>
				Page
					<%				
					int pageNum = (int) (comments.size() / 10) + 1;
					int pageNow = n/10 + 1;
					int i;
					for(i = 1; i <= pageNum; i++){
						if(i == pageNow){ 
						%>
						<strong><%=i %></strong>
						<%
						}
						else if(pageNum > 5){
							if(pageNow < 4){
								if(i == 6){
									%>
									<a href="/LoveSportsORM/Blog.jsp?blogId=<%=blogId %>&commentPage=<%=i %>#comment">&gt&gt</a>
									<%
									}
								else if(i < 6){
									%>
									<a href="/LoveSportsORM/Blog.jsp?blogId=<%=blogId %>&commentPage=<%=i %>#comment"><%=i %></a>
									<%
									}
								}
							else if(pageNow > (pageNum - 2)){
								if(i == (pageNum - 5)){
									%>
									<a href="/LoveSportsORM/Blog.jsp?blogId=<%=blogId %>&commentPage=<%=i %>#comment">&lt&lt</a>
									<%
								}
								else if(i > (pageNum - 5)){
									%>
									<a href="/LoveSportsORM/Blog.jsp?blogId=<%=blogId %>&commentPage=<%=i %>#comment"><%=i %></a>
									<%
									}
								}
							else{
								if(i == (pageNow - 3)){
									%>
									<a href="/LoveSportsORM/Blog.jsp?blogId=<%=blogId %>&commentPage=<%=i %>#comment">&lt&lt</a>
									<%
								}
								else if(i == (pageNow + 3)){
									%>
									<a href="/LoveSportsORM/Blog.jsp?blogId=<%=blogId %>&commentPage=<%=i %>#comment">&gt&gt</a>
									<%
								}
								else if(((pageNow - 3) < i) && (i <(pageNow + 3))){
									%>
									<a href="/LoveSportsORM/Blog.jsp?blogId=<%=blogId %>&commentPage=<%=i %>#comment"><%=i %></a>
									<%
									}
								}
							}
						else{
							%>
							<a href="/LoveSportsORM/Blog.jsp?blogId=<%=blogId %>&commentPage=<%=i %>#comment"><%=i %></a>
							<%
							}
					}
						%>
				</p>
			</div>
		</div> 

	</div>
</body>
</html>