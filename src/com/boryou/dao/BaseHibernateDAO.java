package com.boryou.dao;



import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.Transaction;
import org.hibernate.criterion.Example;

import com.boryou.HibernateSessionFactory;

/**
 * 
 */
@SuppressWarnings("unchecked")
public class BaseHibernateDAO {
	public Session getSession() {
		return HibernateSessionFactory.getSession();
	}
	
	public void closeSession(){
		HibernateSessionFactory.closeSession();
	}
	
	

	/**
	 * 执行增加操作的旧方法
	 * @param item
	 * @return
	 */
	@Deprecated()
	public void add(Object item) {
		Transaction tx = null;
		try {
			Session session = this.getSession();
			tx = session.beginTransaction();
			session.save(item);
			tx.commit();
		} catch (RuntimeException re) {
			if (tx != null) {
				tx.rollback();
			}
			throw re;
		} finally {
			this.closeSession();
		}
	}
	
	/**
	 * 执行增加操作的新方法，可以获得最新插入的 id
	 * @param item
	 * @return
	 */
	public java.io.Serializable save(Object item) {
		java.io.Serializable id = 0;
		Transaction tx = null;
		try {
			Session session = this.getSession();
			tx = session.beginTransaction();
			id = session.save(item);
			tx.commit();
		} catch (RuntimeException re) {
			if (tx != null) {
				tx.rollback();
			}
			throw re;
		} finally {
			this.closeSession();
		}
		return id;
	}

	public Object load(java.io.Serializable id, Class clazz) {
		try {
			Session session = this.getSession();
			Object item = session.get(clazz, id);
			return item;
		} catch (RuntimeException re) {
			throw re;
		} finally {
			this.closeSession();
		}
		
	}

	public void del(java.io.Serializable id, Class clazz) {
		Transaction tx = null;
		try {
			Object obj = this.load(id, clazz);
			Session session = this.getSession();
			tx = session.beginTransaction();
			session.delete(obj);
			tx.commit();
		} catch (RuntimeException re) {
			if (tx != null)
				tx.rollback();
			throw re;
		} finally {
			this.closeSession();
		}
	}

	public void delete(Object o) {
		Transaction tx = null;
		try {
			Session session = this.getSession();
			tx = session.beginTransaction();
			session.delete(o);
			tx.commit();
		} catch (RuntimeException re) {
			if (tx != null)
				tx.rollback();
			throw re;
		} finally {
			this.closeSession();
		}
	}

	public void update(Object item) {
		Transaction tx = null;
		try {
			Session session = this.getSession();
			tx = session.beginTransaction();
			session.update(item);
			tx.commit();
		} catch (RuntimeException re) {
			if (tx != null)
				tx.rollback();
			throw re;
		} finally {
			this.closeSession();
		}
	}

	public List searchByCriteria(Object condition, Class clazz) {
		try {
			
			List list = this.getSession().createCriteria(clazz).add(
					Example.create(condition)).list();
			return list;
		} catch (RuntimeException re) {
			throw re;
		} finally {
			this.closeSession();
		}
	}
	
	
	
	public List searchByHql(String hql, Object[] values) {
		List list = new ArrayList();
		try {
			Session session = this.getSession();
			Query query = session.createQuery(hql);
			if (values != null && values.length > 0) {
				for (int i = 0; i < values.length; i++) {
					query.setParameter(i, values[i]);
				}
			}
			list = query.list();
		} catch (RuntimeException re) {
			throw re;
		} finally {
			this.closeSession();
		}
		return list;
	}
	
	/**
	 * 
	 * @param hql
	 * @param paramName
	 * @param values 可以是 List 集合，也可以是数组，还可以是单个对象
	 * @return
	 */
	public List searchByHql(String hql, String paramName, List values) {
		List list = new ArrayList();
		try {
			Session session = this.getSession();
			Query query = session.createQuery(hql);
			query.setParameterList(paramName, values);
			list = query.list();
		} catch (RuntimeException re) {
			throw re;
		} finally {
			this.closeSession();
		}
		return list;
		
		/*System.out.println(values.length);
		System.out.println(values instanceof Object);
		System.out.println(values[0] instanceof Integer);
		return null;*/
	}
	
	public Object[] searchByHqlLimit(String hql,Object[] values,int page,int pageSize) {
		List list = new ArrayList();
		long totalNum = 0L;
		try {
			Session session = this.getSession();
			Query query = session.createQuery(hql);
			if (values != null && values.length > 0) {
				for (int i = 0; i < values.length; i++) {
					query.setParameter(i, values[i]);
				}
			}
			totalNum = query.list().size();
			int start=(page-1)*pageSize;
			query.setFirstResult(start);
			query.setMaxResults(pageSize);
			
			list = query.list();
		} catch (RuntimeException re) {
			throw re;
		} finally {
			this.closeSession();
		}
		return new Object[]{list,totalNum};
	}
	
	public int executeByHql(String hql, Object[] values) {
		int noOfRows = 0;
		try {
			Session session = this.getSession();
			Query query = session.createQuery(hql);
			if (values != null && values.length > 0) {
				for (int i = 0; i < values.length; i++) {
					query.setParameter(i, values[i]);
				}
			}
			noOfRows = query.executeUpdate();
		} catch (RuntimeException re) {
			throw re;
		} finally {
			this.closeSession();
		}
		return noOfRows;
	}
	
	/**
	 * 
	 * @param hql 例如：DELETE FROM BFuncType WHERE funcType IN (:toDel)
	 * @param paramName 例如："toDel"
	 * @param values 例如：集合 List<Long> toDelList 
	 * @return 受影响的行数
	 */
	public int executeByHql(String hql, String paramName, Object[] values) {
		int noOfRows = 0;
		try {
			Session session = this.getSession();
			Query query = session.createQuery(hql);
			query.setParameterList(paramName, values);
			noOfRows = query.executeUpdate();
		} catch (RuntimeException re) {
			throw re;
		} finally {
			this.closeSession();
		}
		return noOfRows;
	}
	
	/**
	 * 根据 SQL 语句来执行增、删、改操作
	 * 注意：非 HQL 语句，是 SQL 语句
	 */
	public int executeBySql(String sql, Object[] values) {
		int noOfRows = 0;
		Connection conn = null;
		PreparedStatement pstmt = null;
		try {
			Session session = this.getSession();
			conn = session.connection();
			pstmt = conn.prepareStatement(sql);
			if (values != null && values.length > 0) {
				for (int i = 0; i < values.length; i++) {
					pstmt.setObject(i+1, values[i]);
				}
			}
			noOfRows = pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if (pstmt != null) {
					pstmt.close();
				}
			} catch (SQLException e) {
				e.printStackTrace();
			}
			try {
				if (conn != null) {
					conn.close();
				}
			} catch (SQLException e) {
				e.printStackTrace();
			}
			this.closeSession();
		}
		return noOfRows;
	}
	
	/**
	 * 删除多条记录的汇总方法
	 * 删除某个表中的某个字段的值在某个范围内的记录
	 * 上述 3 个某分别代表：表名、字段名、字段的值（逗号分割的字符串，可以是单个值）
	 */
	public int deleteMany(String tableName, String columnName, String columnValues) {
		String sql = "DELETE FROM " + tableName + " WHERE " 
				+ columnName + " IN (" + columnValues + ")";
		int noOfRows = this.executeBySql(sql, null);
		//System.out.println("=== deleteManySql: " + sql + ", noOfRows: " + noOfRows);
		return noOfRows;
	}
	
	/**
	 * 返回单行的值
	 */
	public Object getUniqueResult(String hql, Object[] values) {
		Object unique = null;
		try {
			Session session = this.getSession();
			Query query = session.createQuery(hql);
			if (values != null && values.length > 0) {
				for (int i = 0; i < values.length; i++) {
					query.setParameter(i, values[i]);
				}
			}
			//query.setFirstResult(0);
			query.setMaxResults(1);
			unique = query.uniqueResult();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			this.closeSession();
		}
		return unique;
	}
	
	
	/**
	 * 执行存储过程
	 * @param sql T-SQL 语句
	 * @param values 输入参数的值数组
	 * @param outTypes 输出参数的类型数组
	 * @return 是否成功执行
	 */
	public int executeProcedure(String sql, Object[] values, int[] outTypes) {
		int noOfRows = 0;
		Connection conn = null;
		CallableStatement cstmt = null;
		
		try {
			conn = this.getSession().connection();
			cstmt = conn.prepareCall(sql);
			int outBegin = 1;
			if (values != null) {
				for (int i = 0; i < values.length; i++) {
					cstmt.setObject(i+1, values[i]);
				}
				outBegin = values.length + 1;
			}
			
			if (outTypes != null && outTypes.length > 0) {
				for (int i = 0; i < outTypes.length; i++) {
					cstmt.registerOutParameter(i+outBegin, outTypes[i]);
				}
			}
			cstmt.execute();
			noOfRows = 1;
			//System.out.printf("out=%d", cstmt.getInt(2));
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			try {
				if (cstmt != null) {
					cstmt.close();
				}
				if (conn != null) {
					conn.close();
				}
				this.closeSession();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		return noOfRows;
	}
	
	public static void main(String[] args) {
		BaseHibernateDAO baseDao = new BaseHibernateDAO();
		
	}
}
