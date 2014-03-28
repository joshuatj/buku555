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

import buku.entities.ItemType;

/**
 * Home object for domain model class ItemType.
 * @see buku.entities.ItemType
 * @author Hibernate Tools
 */
public class ItemTypeDAO extends AbstractDAO {

	private static final Log log = LogFactory.getLog(ItemTypeDAO.class);

	public void persist(ItemType transientInstance) {
		log.debug("persisting ItemType instance");
		Session s = getCurrentSession();
		try {
			Transaction tx = s.beginTransaction();
			s.persist(transientInstance);
			tx.commit();
			log.debug("persist successful");
		} catch (RuntimeException re) {
			log.error("persist failed", re);
			throw re;
		} finally{
			closeSession(s);
		}
	}

	public void update(ItemType instance) {
		log.debug("attaching dirty ItemType instance");
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

	public void delete(ItemType persistentInstance) {
		log.debug("deleting ItemType instance");
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

	public ItemType findById(java.lang.Integer id) {
		log.debug("getting ItemType instance with id: " + id);
		Session s = getCurrentSession();
		try {
			Transaction tx = s.beginTransaction();
			ItemType instance = (ItemType) s.get("buku.entities.ItemType", id);
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

	public List<ItemType> findAll() {
		log.debug("finding ItemType instance by example");
		Session s = getCurrentSession();
		try {
			Transaction tx = s.beginTransaction();
			List<ItemType> results = s.createQuery("from ItemType").list();
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
