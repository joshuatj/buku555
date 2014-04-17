package buku.dao;

// Generated Mar 19, 2014 6:50:59 PM by Hibernate Tools 4.0.0

import java.util.List;
import javax.naming.InitialContext;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.hibernate.LockMode;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.criterion.Example;

import buku.entities.Transaction;

/**
 * Home object for domain model class Transaction.
 * @see buku.entities.Transaction
 * @author Hibernate Tools
 */
public class TransactionDAO extends AbstractDAO {

	private static final Log log = LogFactory.getLog(TransactionDAO.class);

	public int persist(Transaction transientInstance) {
		log.debug("persisting Transaction instance");
		Session s = getCurrentSession();
		try {
			org.hibernate.Transaction tx = s.beginTransaction();
			s.persist(transientInstance);
			tx.commit();
			log.debug("persist successful");
			return transientInstance.getId();
		} catch (RuntimeException re) {
			log.error("persist failed", re);
			throw re;
		} finally{
			closeSession(s);
		}
	}

	public void update(Transaction instance) {
		log.debug("attaching dirty Transaction instance");
		Session s = getCurrentSession();
		try {
			org.hibernate.Transaction tx = s.beginTransaction();
			s.saveOrUpdate(instance);
			tx.commit();
			log.debug("attach successful");
		} catch (RuntimeException re) {
			log.error("attach failed", re);
			throw re;
		} finally{
			closeSession(s);
		}
	}

	public void delete(Transaction persistentInstance) {
		log.debug("deleting Transaction instance");
		Session s = getCurrentSession();
		try {
			org.hibernate.Transaction tx = s.beginTransaction();
			s.delete(persistentInstance);
			tx.commit();
			log.debug("delete successful");
		} catch (RuntimeException re) {
			log.error("delete failed", re);
			throw re;
		} finally{
			closeSession(s);
		}
	}

	public Transaction findById(java.lang.Integer id) {
		log.debug("getting Transaction instance with id: " + id);
		Session s = getCurrentSession();
		try {
			Transaction instance = (Transaction) s.get("buku.entities.Transaction", id);
			if (instance == null) {
				log.debug("get successful, no instance found");
			} else {
				log.debug("get successful, instance found");
			}
			return instance;
		} catch (RuntimeException re) {
			log.error("get failed", re);
			throw re;
		} finally{
			closeSession(s);
		} 
	}

	public List<Transaction> findAll() {
		log.debug("finding Transaction instance by example");
		Session s = getCurrentSession();
		try {
			List<Transaction> results = s.createQuery("from Transaction").list();
			log.debug("find by example successful, result size: "
					+ results.size());
			return results;
		} catch (RuntimeException re) {
			log.error("find by example failed", re);
			throw re;
		} finally{
			closeSession(s);
		}
	}
	
	public List<Transaction> findHistory(Integer userId){
		Session s = getCurrentSession();
		try {
			org.hibernate.Transaction tx = s.beginTransaction();
			List<Transaction> results = s.createQuery("from Transaction t where t.userByFromUserId=" + userId + " or t.userByToUserId=" + userId).list();
			tx.commit();
			return results;
		} catch (RuntimeException re) {
			log.error("find by example failed", re);
			throw re;
		} finally{
			closeSession(s);
		}
	}
	
	public Integer getLatestInsertedId(){
		Session s = getCurrentSession();
		try {
			org.hibernate.Transaction tx = s.beginTransaction();
			Integer maxID = (Integer) s.createQuery("select max(id) from Transaction").uniqueResult();
			tx.commit();
			return maxID == null ? 0 : maxID;
		} catch (RuntimeException re) {
			log.error("find by example failed", re);
			throw re;
		}
	}
}
