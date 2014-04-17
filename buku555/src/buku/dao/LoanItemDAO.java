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

import buku.entities.LoanItem;
import buku.entities.User;

/**
 * Home object for domain model class LoanItem.
 * @see buku.entities.LoanItem
 * @author Hibernate Tools
 */
public class LoanItemDAO extends AbstractDAO {

	private static final Log log = LogFactory.getLog(LoanItemDAO.class);

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

	public Integer persist(LoanItem transientInstance) {
		log.debug("persisting LoanItem instance");
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

	public void update(LoanItem instance) {
		log.debug("attaching dirty LoanItem instance");
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


	public void delete(LoanItem persistentInstance) {
		log.debug("deleting LoanItem instance");
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


	public LoanItem findById(java.lang.Integer id) {
		log.debug("getting LoanItem instance with id: " + id);
		Session s = getCurrentSession();
		try {
			Transaction tx = s.beginTransaction();
			LoanItem instance = (LoanItem) s.get("buku.entities.LoanItem", id);
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

	public List<LoanItem> findAll() {
		log.debug("finding LoanItem instance by example");
		Session s = getCurrentSession();
		try {
			Transaction tx = s.beginTransaction();
			List<LoanItem> results = s.createQuery("from LoanItem").list();
			tx.commit();
			log.debug("find by example successful, result size: "
					+ results.size());
			return results;
		} catch (RuntimeException re) {
			log.error("find by example failed", re);
			throw re;
		}
	}
	
	public List<LoanItem> findByOwnerId(Integer ownerId) {
		log.debug("finding LoanItem instance by example");
		Session s = getCurrentSession();
		try {
			Transaction tx = s.beginTransaction();
			List<LoanItem> results = s.createQuery("from LoanItem l where l.userByOwnerUserId.id=" + ownerId).list();
			tx.commit();
			log.debug("find by example successful, result size: "
					+ results.size());
			return results;
		} catch (RuntimeException re) {
			log.error("find by example failed", re);
			throw re;
		}
	}
	
	public List<LoanItem> findByLoanUserId(Integer loanUserId) {
		log.debug("finding LoanItem instance by example");
		Session s = getCurrentSession();
		try {
			Transaction tx = s.beginTransaction();
			List<LoanItem> results = s.createQuery("from LoanItem l where l.userByLoanUserId.id=" + loanUserId).list();
			tx.commit();
			log.debug("find by example successful, result size: "
					+ results.size());
			return results;
		} catch (RuntimeException re) {
			log.error("find by example failed", re);
			throw re;
		}
	}
	
	public Integer getLatestInsertedId(){
		Session s = getCurrentSession();
		try {
			org.hibernate.Transaction tx = s.beginTransaction();
			Integer maxID = (Integer) s.createQuery("select max(id) from LoanItem").uniqueResult();
			tx.commit();
			return maxID == null ? 0 : maxID;
		} catch (RuntimeException re) {
			log.error("find by example failed", re);
			throw re;
		}
	}
}
