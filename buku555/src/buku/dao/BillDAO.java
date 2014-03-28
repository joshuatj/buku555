package buku.dao;

// Generated Mar 22, 2014 2:40:29 AM by Hibernate Tools 4.0.0

import java.util.List;
import javax.naming.InitialContext;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.hibernate.LockMode;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;
import org.hibernate.criterion.Example;

import buku.entities.Bill;
import buku.entities.BillSplitees;

/**
 * Home object for domain model class Bill.
 * @see buku.entities.Bill
 * @author Hibernate Tools
 */
public class BillDAO extends AbstractDAO {

	private static final Log log = LogFactory.getLog(BillDAO.class);

	public int persist(Bill transientInstance) {
		log.debug("persisting Bill instance");
		Session s = getCurrentSession();
		try {
			Transaction tx = s.beginTransaction();
			s.persist(transientInstance);
			tx.commit();
			log.debug("persist successful");
			return transientInstance.getId();
		} catch (RuntimeException re) {
			log.error("persist failed", re);
			throw re;
		}
	}

	public void update(Bill instance) {
		log.debug("attaching dirty Bill instance");
		Session s = getCurrentSession();
		try {
			Transaction tx = s.beginTransaction();
			s.saveOrUpdate(instance);
			tx.commit();
			log.debug("attach successful");
		} catch (RuntimeException re) {
			log.error("attach failed", re);
			throw re;
		}
	}


	public void delete(Bill persistentInstance) {
		log.debug("deleting Bill instance");
		Session s = getCurrentSession();
		try {
			Transaction tx = s.beginTransaction();
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

	public Bill findById(java.lang.Integer id) {
		log.debug("getting Bill instance with id: " + id);
		Session s = getCurrentSession();
		try {
			Transaction tx = s.beginTransaction();
			Bill instance = (Bill) s.get("buku.entities.Bill", id);
			tx.commit();
			if (instance == null) {
				log.debug("get successful, no instance found");
			} else {
				log.debug("get successful, instance found");
			}
			return instance;
		} catch (RuntimeException re) {
			log.error("get failed", re);
			throw re;
		}
	}

	public List<Bill> findAll() {
		Session s = getCurrentSession();
		log.debug("finding Bill instance by example");
		try {
			Transaction tx = s.beginTransaction();
			List<Bill> results = s.createQuery("from Bill").list();
			tx.commit();
			log.debug("find by example successful, result size: "
					+ results.size());
			return results;
		} catch (RuntimeException re) {
			log.error("find by example failed", re);
			throw re;
		}
	}
	
	public List<Bill> findByOwnerId(Integer ownerId) {
		Session s = getCurrentSession();
		log.debug("finding Bill instance by example");
		try {
			Transaction tx = s.beginTransaction();
			List<Bill> results = s.createQuery("from Bill b where b.user.id=" + ownerId).list();
			tx.commit();
			log.debug("find by example successful, result size: "
					+ results.size());
			return results;
		} catch (RuntimeException re) {
			log.error("find by example failed", re);
			throw re;
		}
	}
}
