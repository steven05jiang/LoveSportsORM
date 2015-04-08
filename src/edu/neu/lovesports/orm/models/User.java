package edu.neu.lovesports.orm.models;

import java.util.List;

import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.MapsId;
import javax.persistence.OneToMany;
import javax.persistence.OneToOne;

@Entity
public class User {
	@Id
	private String username;
	private String password;
	private String firstName;
	private String lastName;
	private String email;

	@OneToMany(mappedBy = "editor")
	private List<Category> categories;
	
	@OneToMany(mappedBy = "user")
	private List<Subscription> subs;
	
	@OneToMany(mappedBy = "user")
	private List<Blog> blogs;
	
	@OneToMany(mappedBy = "user")
	private List<Group> groups;
	
	@OneToMany(mappedBy = "user")
	private List<Comment> comments;
	
	@OneToMany(mappedBy = "user")
	private List<Collection> collections;
	
	
	public String getUsername() {
		return username; 
	}
	public void setUsername(String username) {
		this.username = username;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	public String getFirstName() {
		return firstName;
	}
	public void setFirstName(String firstName) {
		this.firstName = firstName;
	}
	public String getLastName() {
		return lastName;
	}
	public void setLastName(String lastName) {
		this.lastName = lastName;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}

	public List<Category> getCategories() {
		return categories;
	}
	public void setCategories(List<Category> categories) {
		this.categories = categories;
	}
	public List<Subscription> getSubs() {
		return subs;
	}
	public void setSubs(List<Subscription> subs) {
		this.subs = subs;
	}
	public List<Blog> getBlogs() {
		return blogs;
	}
	public void setBlogs(List<Blog> blogs) {
		this.blogs = blogs;
	}
	public List<Group> getGroups() {
		return groups;
	}
	public void setGroups(List<Group> groups) {
		this.groups = groups;
	}
	public List<Comment> getComments() {
		return comments;
	}
	public void setComments(List<Comment> comments) {
		this.comments = comments;
	}
	public List<Collection> getCollections() {
		return collections;
	}
	public void setCollections(List<Collection> collections) {
		this.collections = collections;
	}
	public User(String username, String password, String firstName,
			String lastName, String email) {
		super();
		this.username = username;
		this.password = password;
		this.firstName = firstName;
		this.lastName = lastName;
		this.email = email;
	}
	public User() {
		super();
	}
}
