/*
 * Copyright (c) 2006 Sun Microsystems, Inc.  All rights reserved.  U.S.
 * Government Rights - Commercial software.  Government users are subject
 * to the Sun Microsystems, Inc. standard license agreement and
 * applicable provisions of the FAR and its supplements.  Use is subject
 * to license terms.
 *
 * This distribution may include materials developed by third parties.
 * Sun, Sun Microsystems, the Sun logo, Java and J2EE are trademarks
 * or registered trademarks of Sun Microsystems, Inc. in the U.S. and
 * other countries.
 *
 * Copyright (c) 2006 Sun Microsystems, Inc. Tous droits reserves.
 *
 * Droits du gouvernement americain, utilisateurs gouvernementaux - logiciel
 * commercial. Les utilisateurs gouvernementaux sont soumis au contrat de
 * licence standard de Sun Microsystems, Inc., ainsi qu'aux dispositions
 * en vigueur de la FAR (Federal Acquisition Regulations) et des
 * supplements a celles-ci.  Distribue par des licences qui en
 * restreignent l'utilisation.
 *
 * Cette distribution peut comprendre des composants developpes par des
 * tierces parties. Sun, Sun Microsystems, le logo Sun, Java et J2EE
 * sont des marques de fabrique ou des marques deposees de Sun
 * Microsystems, Inc. aux Etats-Unis et dans d'autres pays.
 */

package database;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

// The instance of BookDBAO gets created when the application
// is deployed. It maintains the Connection object to the
// database. The Connection object is created from DataSource
// object, which is retrieved through JNDI.
// For more information on DataSource, please see
// http://java.sun.com/j2se/1.4.2/docs/api/javax/sql/DataSource.html.
public class userDBAO {

	Connection con;
	private boolean conFree = true;

	// Database configuration
	public static String url = "jdbc:mysql://localhost:3306/buku555";
	public static String dbdriver = "com.mysql.jdbc.Driver";
	public static String username = "root";
	public static String password = "123456";

	public userDBAO() throws Exception {
		try {
			/*
			 * Context initCtx = new InitialContext(); Context envCtx =
			 * (Context) initCtx.lookup("java:comp/env"); DataSource ds =
			 * (DataSource) envCtx.lookup("jdbc/BookDB"); con =
			 * ds.getConnection();
			 */
			Class.forName(dbdriver);
			con = DriverManager.getConnection(url, username, password);

		} catch (Exception ex) {
			System.out.println("Exception in BookDBAO: " + ex);
			throw new Exception("Couldn't open connection to database: "
					+ ex.getMessage());
		}
	}

	public void remove() {
		try {
			con.close();
		} catch (SQLException ex) {
			System.out.println(ex.getMessage());
		}
	}

	protected synchronized Connection getConnection() {
		while (conFree == false) {
			try {
				wait();
			} catch (InterruptedException e) {
			}
		}

		conFree = false;
		notify();

		return con;
	}

	protected synchronized void releaseConnection() {
		while (conFree == true) {
			try {
				wait();
			} catch (InterruptedException e) {
			}
		}

		conFree = true;
		notify();
	}

	public void checkUser(String id, String email, String role) {
		// boolean status = false;
		// System.out.print(id + " " + email + " " + accessToken + " " + country
		// + " " + role);
		try {
			String selectStatement = "select * "
					+ "from user where user_id = ?";
			getConnection();

			PreparedStatement prepStmt = con.prepareStatement(selectStatement);
			prepStmt.setString(1, id);

			ResultSet rs = prepStmt.executeQuery();

			if (rs.next()) {
				// status = true;
				// return;
				System.out.println("ddfafaffss");
			} else {
				String insertStatement = "insert into user (user_id, email, role) values(?,?,?)";

				prepStmt = con.prepareStatement(insertStatement);
				// System.out.println("auauauau" + insertStatement);
				prepStmt.setString(1, id);
				prepStmt.setString(2, email);
				prepStmt.setString(3, role);
				prepStmt.executeUpdate();
			}

			prepStmt.close();
			releaseConnection();

		} catch (SQLException ex) {
			releaseConnection();
			ex.printStackTrace();
		}

		// return status;
	}

	public boolean authenticate(String id, String password) {
		boolean status = false;
		try {
			String selectStatement = "select * "
					+ "from accounts where id = ? and password = ?";
			getConnection();

			PreparedStatement prepStmt = con.prepareStatement(selectStatement);
			prepStmt.setString(1, id);
			prepStmt.setString(2, password);

			ResultSet rs = prepStmt.executeQuery();

			if (rs.next()) {
				status = true;

			}

			prepStmt.close();
			releaseConnection();

		} catch (SQLException ex) {
			releaseConnection();
			ex.printStackTrace();
		}
		return status;
	}

}