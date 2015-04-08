package edu.neu.lovesports.orm.dao;

import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.Persistence;
import javax.persistence.Query;

import edu.neu.lovesports.orm.models.Subscription;

public class SubscriptionDAO {
	EntityManagerFactory factory = Persistence.createEntityManagerFactory("LoveSportsORM");
	EntityManager em = factory.createEntityManager();
	
	//crud
	//create
	public Subscription create(Subscription sub){
		em.getTransaction().begin();
		em.persist(sub);
		em.getTransaction().commit();
		return sub;
	}
	
	//read
	public Subscription read(int id){
		return em.find(Subscription.class, id);
	}
	
	//readAll
	@SuppressWarnings("unchecked")
	public List<Subscription> readAll(){
		Query query = em.createQuery("select subscription from Subscription subscription");
		return (List<Subscription>)query.getResultList();
	}
	
	//update
	public Subscription update(Subscription sub){

		em.getTransaction().begin();
		em.merge(sub);
		em.getTransaction().commit();
		return sub;
	}
	
	//delete
	public void delete(int id){
		em.getTransaction().begin();
		Subscription sub = em.find(Subscription.class, id);
		em.remove(sub);
		em.getTransaction().commit();
	}
	
}
