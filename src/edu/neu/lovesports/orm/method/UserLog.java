package edu.neu.lovesports.orm.method;

import java.io.IOException;
import java.security.NoSuchAlgorithmException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import edu.neu.lovesports.orm.dao.UserDAO;
import edu.neu.lovesports.orm.models.User;

public class UserLog {
	User user = null;

	public boolean Login(HttpServletRequest request,
			HttpServletResponse response, String username, String password)
			throws NoSuchAlgorithmException, ServletException, IOException {
		UserDAO dao = new UserDAO();
		user = dao.read(username);
		if (user != null)
			if (password.equals(user.getPassword())) {
				HandleCookie cookie = new HandleCookie();
				cookie.setCookie(request, response);
				return true;
			}
		return false;
	}
}
