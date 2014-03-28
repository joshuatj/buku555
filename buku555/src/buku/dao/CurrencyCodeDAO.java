package buku.dao;

// Generated Mar 22, 2014 2:40:29 AM by Hibernate Tools 4.0.0

import java.util.List;
import javax.naming.InitialContext;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.hibernate.LockMode;
import org.hibernate.SessionFactory;
import org.hibernate.criterion.Example;

import buku.entities.CurrencyCode;

/**
 * Home object for domain model class CurrencyCode.
 * @see buku.entities.CurrencyCode
 * @author Hibernate Tools
 */
public class CurrencyCodeDAO {

	private static final Log log = LogFactory.getLog(CurrencyCodeDAO.class);

	private final SessionFactory sessionFactory = getSessionFactory();

	protected SessionFactory getSessionFactory() {
		try {
			return (SessionFactory) new InitialContext()
					.lookup("SessionFactory");
		} catch (Exception e) {
			log.error("Could not locate SessionFactory in JNDI", e);
			throw new IllegalStateException(
					"Could not locate SessionFactory in JNDI");
		}
	}

	public void persist(CurrencyCode transientInstance) {
		log.debug("persisting CurrencyCode instance");
		try {
			sessionFactory.getCurrentSession().persist(transientInstance);
			log.debug("persist successful");
		} catch (RuntimeException re) {
			log.error("persist failed", re);
			throw re;
		}
	}

	public void attachDirty(CurrencyCode instance) {
		log.debug("attaching dirty CurrencyCode instance");
		try {
			sessionFactory.getCurrentSession().saveOrUpdate(instance);
			log.debug("attach successful");
		} catch (RuntimeException re) {
			log.error("attach failed", re);
			throw re;
		}
	}

	public void attachClean(CurrencyCode instance) {
		log.debug("attaching clean CurrencyCode instance");
		try {
			sessionFactory.getCurrentSession().lock(instance, LockMode.NONE);
			log.debug("attach successful");
		} catch (RuntimeException re) {
			log.error("attach failed", re);
			throw re;
		}
	}

	public void delete(CurrencyCode persistentInstance) {
		log.debug("deleting CurrencyCode instance");
		try {
			sessionFactory.getCurrentSession().delete(persistentInstance);
			log.debug("delete successful");
		} catch (RuntimeException re) {
			log.error("delete failed", re);
			throw re;
		}
	}

	public CurrencyCode merge(CurrencyCode detachedInstance) {
		log.debug("merging CurrencyCode instance");
		try {
			CurrencyCode result = (CurrencyCode) sessionFactory
					.getCurrentSession().merge(detachedInstance);
			log.debug("merge successful");
			return result;
		} catch (RuntimeException re) {
			log.error("merge failed", re);
			throw re;
		}
	}

	public CurrencyCode findById(java.lang.Integer id) {
		log.debug("getting CurrencyCode instance with id: " + id);
		try {
			CurrencyCode instance = (CurrencyCode) sessionFactory
					.getCurrentSession().get("buku.entities.CurrencyCode", id);
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

	public List findByExample(CurrencyCode instance) {
		log.debug("finding CurrencyCode instance by example");
		try {
			List results = sessionFactory.getCurrentSession()
					.createCriteria("buku.entities.CurrencyCode")
					.add(Example.create(instance)).list();
			log.debug("find by example successful, result size: "
					+ results.size());
			return results;
		} catch (RuntimeException re) {
			log.error("find by example failed", re);
			throw re;
		}
	}
}
