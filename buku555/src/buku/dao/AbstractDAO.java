package buku.dao;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.boot.registry.StandardServiceRegistryBuilder;
import org.hibernate.cfg.Configuration;
import org.hibernate.service.ServiceRegistry;


public class AbstractDAO {
	
	private static final Log log = LogFactory.getLog(AbstractDAO.class);
	private static SessionFactory sessionFactory = getSessionFactory();
	
	
	protected static SessionFactory getSessionFactory() {
		try {
			Configuration configuration = new Configuration();
            configuration.configure();
            ServiceRegistry serviceRegistry = new StandardServiceRegistryBuilder().applySettings(
                            configuration.getProperties()).build();
            sessionFactory = configuration.buildSessionFactory(serviceRegistry);
            return sessionFactory;

		} catch (Exception e) {
			log.error("Could not get session factory");
			return null;
		}
	}
	
	protected Session getCurrentSession(){
		Session s = sessionFactory.getCurrentSession();
		if (s == null)
		return sessionFactory.openSession();
		else return s;
	}
	
	protected void closeSession(Session s){
//		if (s != null)
////			s.disconnect();
	}

}
