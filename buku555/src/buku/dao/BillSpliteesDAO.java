package buku.dao;

// Generated Mar 19, 2014 6:50:59 PM by Hibernate Tools 4.0.0

import java.util.List;
import javax.naming.InitialContext;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.hibernate.LockMode;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;
import org.hibernate.criterion.Example;

import buku.entities.BillSplitees;
import buku.entities.User;

/**
 * Home object for domain model class BillSplitees.
 * @see buku.entities.BillSplitees
 * @author Hibernate Tools
 */
public class BillSpliteesDAO extends AbstractDAO {

	private static final Log log = LogFactory.getLog(BillSpliteesDAO.class);

//	private final SessionFactory sessionFactory = getSessionFactory();
//
//	protected SessionFactory getSessionFactory() {
//		try {
//			return (SessionFactory) new InitialContext()
//					.lookup("SessionFactory");
//		} catch (Exception e) {
//			log.error("Could not locate SessionFactory in JNDI", e);
//			throw new IllegalStateException(
//					"Could not locate SessionFactory in JNDI");
//		}
//	}

	public int persist(BillSplitees transientInstance) {
		log.debug("persisting BillSplitees instance");
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
		} finally{
			closeSession(s);
		}
	}

	public void update(BillSplitees instance) {
		log.debug("attaching dirty BillSplitees instance");
		Session s = getCurrentSession();
		try {
			Transaction tx = s.beginTransaction();
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

	public void delete(BillSplitees persistentInstance) {
		log.debug("deleting BillSplitees instance");
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

	public BillSplitees findById(java.lang.Integer id) {
		log.debug("getting BillSplitees instance with id: " + id);
		Session s = getCurrentSession();
		try {
			Transaction tx = s.beginTransaction();
			BillSplitees instance = (BillSplitees) s.get("buku.entities.BillSplitees", id);
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
		} finally{
			closeSession(s);
		} 
	}

	public List<BillSplitees> findAll() {
		log.debug("finding BillSplitees instance by example");
		Session s = getCurrentSession();
		try {
			Transaction tx = s.beginTransaction();
			List<BillSplitees> results = s.createQuery("from BillSplitees").list();
			tx.commit();
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
	
	public List<BillSplitees> findByBillId(Integer billID) {
		log.debug("finding BillSplitees instance by example");
		Session s = getCurrentSession();
		try {
			Transaction tx = s.beginTransaction();
			List<BillSplitees> results = s.createQuery("from BillSplitees as b where b.billId=" + billID ).list();
			tx.commit();
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
}
