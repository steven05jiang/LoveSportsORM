package edu.neu.lovesports.orm.dao;

import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.Persistence;
import javax.persistence.Query;

import edu.neu.lovesports.orm.models.Blog;
import edu.neu.lovesports.orm.models.Group;

public class BlogDAO {
	
	EntityManagerFactory factory = Persistence.createEntityManagerFactory("LoveSportsORM");
	EntityManager em = factory.createEntityManager();
	
	//crud
	//create
	public Blog create(Blog blog){
		em.getTransaction().begin();
		em.persist(blog);
		em.getTransaction().commit();
		return blog;
	}
	
	//read
	public Blog read(int id){
		return em.find(Blog.class, id);
	}
	
	@SuppressWarnings("unchecked")
	public List<Blog> readByGroup(String name){
		Group group = em.find(Group.class, name);
		Query query = em.createQuery("select blog from Blog blog where blog.group = :group");
		query.setParameter("group", group);
		return (List<Blog>)query.getResultList();
	}
	
	//read
	@SuppressWarnings("unchecked")
	public List<Blog> readAll(){
		Query query = em.createQuery("select blog from Blog blog");
		return (List<Blog>)query.getResultList();
	}
	
	//update
	public Blog update(Blog blog){
		em.getTransaction().begin();
		em.merge(blog);
		em.getTransaction().commit();
		return blog;
	}
	
	//delete
	public void delete(int id){
		em.getTransaction().begin();
		Blog blog = em.find(Blog.class, id);
		em.remove(blog);
		em.getTransaction().commit();
	}
	
}
