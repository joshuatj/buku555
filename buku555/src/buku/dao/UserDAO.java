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
import org.hibernate.boot.registry.StandardServiceRegistryBuilder;
import org.hibernate.cfg.Configuration;
import org.hibernate.criterion.Example;
import org.hibernate.service.ServiceRegistry;
import buku.entities.User;

/**
 * Home object for domain model class User.
 * @see buku.entities.User
 * @author Hibernate Tools
 */
public class UserDAO extends AbstractDAO {

	private static final Log log = LogFactory.getLog(UserDAO.class);

//	private SessionFactory sessionFactory = getSessionFactory();

//	protected SessionFactory getSessionFactory() {
//		try {
////			return (SessionFactory) new InitialContext()
////					.lookup("SessionFactory");
//			Configuration configuration = new Configuration();
//            configuration.configure();
////            sessionFactory = configuration.buildSessionFactory();
//            ServiceRegistry serviceRegistry = new StandardServiceRegistryBuilder().applySettings(
//                            configuration.getProperties()).build();
//            sessionFactory = configuration.buildSessionFactory(serviceRegistry);
//            return sessionFactory;
//
//		} catch (Exception e) {
//			log.error("Could not locate SessionFactory in JNDI", e);
//			throw new IllegalStateException(
//					"Could not locate SessionFactory in JNDI");
//		}
//	}

	public User persist(User transientInstance) {
		log.debug("persisting User instance");
		Session s = getCurrentSession();
		try {
			Transaction tx = s.beginTransaction();
			s.persist(transientInstance);
			tx.commit();
			log.debug("persist successful");
			return transientInstance;
		} catch (RuntimeException re) {
			log.error("persist failed", re);
			throw re;
		} finally{
			closeSession(s);
		}
	}

	public void update(User instance) {
		log.debug("attaching dirty User instance");
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

	public void delete(User persistentInstance) {
		log.debug("deleting User instance");
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

//	public User merge(User detachedInstance) {
//		log.debug("merging User instance");
//		Session s = openSession();
//		try {
//			Transaction tx = s.beginTransaction();
//			User result = (User) s.merge(
//					detachedInstance);
//			tx.commit();
//			log.debug("merge successful");
//			return result;
//		} catch (RuntimeException re) {
//			log.error("merge failed", re);
//			throw re;
//		} finally{
//			closeSession(s);
//		}
//	}

	public User findById(java.lang.Integer id) {
		log.debug("getting User instance with id: " + id);
		Session s = getCurrentSession();
		try {
			Transaction tx = s.beginTransaction();
			User instance = (User) s.get("buku.entities.User", id);
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
	
	public User findByFbId(String fbId) {
		
		Session s = getCurrentSession();
		try {
			Transaction tx = s.beginTransaction();
			List<User> results = s.createQuery("from User u where u.fbUserId = " + fbId).list();
			tx.commit();
			if (!results.isEmpty())
				return results.get(0);
			else 
				return null;
		} catch (RuntimeException re) {
			log.error("get failed", re);
			throw re;
		} finally{
			closeSession(s);
		} 
		
	}

	public List<User> findAll() {
		log.debug("finding User instance by example");
		Session s = getCurrentSession();
		try {
			Transaction tx = s.beginTransaction();
			List<User> results = s.createQuery("from User").list();
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
	
	public List<User> findNotiUser() {
		log.debug("finding User instance by example");
		Session s = getCurrentSession();
		try {
			Transaction tx = s.beginTransaction();
			List<User> results = s.createQuery("from User where email is not null and receiveNotiMail = true and isRegistered = true").list();
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
