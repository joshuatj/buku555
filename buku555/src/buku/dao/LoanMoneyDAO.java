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

import buku.entities.LoanMoney;

/**
 * Home object for domain model class LoanMoney.
 * @see buku.entities.LoanMoney
 * @author Hibernate Tools
 */
public class LoanMoneyDAO extends AbstractDAO {

	private static final Log log = LogFactory.getLog(LoanMoneyDAO.class);

	public void persist(LoanMoney transientInstance) {
		log.debug("persisting LoanMoney instance");
		Session s = getCurrentSession();
		try {
			Transaction tx = s.beginTransaction();
			s.persist(transientInstance);
			tx.commit();
			log.debug("persist successful");
		} catch (RuntimeException re) {
			log.error("persist failed", re);
			throw re;
		}
	}

	public void update(LoanMoney instance) {
		log.debug("attaching dirty LoanMoney instance");
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

	public void delete(LoanMoney persistentInstance) {
		log.debug("deleting LoanMoney instance");
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

	public LoanMoney findById(java.lang.Integer id) {
		log.debug("getting LoanMoney instance with id: " + id);
		Session s = getCurrentSession();
		try {
			Transaction tx = s.beginTransaction();
			LoanMoney instance = (LoanMoney) s.get("buku.entities.LoanMoney", id);
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

	public List<LoanMoney> findAll(LoanMoney instance) {
		log.debug("finding LoanMoney instance by example");
		Session s = getCurrentSession();
		try {
			Transaction tx = s.beginTransaction();
			List<LoanMoney> results = s.createQuery("from LoanMoney").list();
			tx.commit();
			log.debug("find by example successful, result size: "
					+ results.size());
			return results;
		} catch (RuntimeException re) {
			log.error("find by example failed", re);
			throw re;
		}
	}
	
	public List<LoanMoney> findLoanMoneyByOwnerUserId(Integer userId) {
		log.debug("finding LoanMoney instance by example");
		Session s = getCurrentSession();
		try {
			Transaction tx = s.beginTransaction();
			List<LoanMoney> results = s.createQuery("from LoanMoney l where l.userByOwnerUserId.id = " + userId).list();
			tx.commit();
			log.debug("find by example successful, result size: "
					+ results.size());
			return results;
		} catch (RuntimeException re) {
			log.error("find by example failed", re);
			throw re;
		}
	}
	
	public List<LoanMoney> findLoanMoneyByLoanUserId(Integer userId) {
		log.debug("finding LoanMoney instance by example");
		Session s = getCurrentSession();
		try {
			Transaction tx = s.beginTransaction();
			List<LoanMoney> results = s.createQuery("from LoanMoney l where l.userByLoanUserId.id = " + userId).list();
			tx.commit();
			log.debug("find by example successful, result size: "
					+ results.size());
			return results;
		} catch (RuntimeException re) {
			log.error("find by example failed", re);
			throw re;
		}
	}
	
	public LoanMoney findLoanMoneyByOwnerUserIdAndLoanUserId(Integer userOwnerId, Integer userLoanId) {
		System.out.println("#############findLoanMoneyByOwnerUserIdAndLoanUserId");
		System.out.println("from LoanMoney l where l.userByLoanUserId.id = " + userLoanId + " and l.userByOwnerUserId.id = " + userOwnerId);
		log.debug("finding LoanMoney instance by example");
		Session s = getCurrentSession();
		try {
			Transaction tx = s.beginTransaction();
			List<LoanMoney> results = s.createQuery("from LoanMoney l where l.userByLoanUserId.id = " + userLoanId + " and l.userByOwnerUserId.id = " + userOwnerId).list();
			tx.commit();
			log.debug("find by example successful, result size: "
					+ results.size());
			if (!results.isEmpty())
				return results.get(0);
			return null;
		} catch (RuntimeException re) {
			log.error("find by example failed", re);
			throw re;
		}
	}
}
