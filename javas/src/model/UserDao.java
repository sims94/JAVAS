package model;


import java.util.HashMap;
import java.util.List;
import java.util.Map;
import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class UserDao {

	@Autowired
	SqlSessionFactory factory;

	public boolean joinMember(Map map) {
		if(map.get("month").equals("��")) {
			map.put("month", null);
		}

		SqlSession session = factory.openSession();

 	try {
			session.insert("user.join_step1", map); 
			session.insert("user.join_step2", map);
			session.commit();
			return true;
		} catch (Exception e) {
			e.printStackTrace();
			session.rollback();
			return false;
		} finally {
			session.close();
		}
	}

	public boolean login(Map map) {
		SqlSession session = factory.openSession();
		try {
			System.out.println("login : " + map);
			HashMap rst = session.selectOne("user.login", map);
			
			return rst != null;
		} catch (Exception e) {
			e.getStackTrace();
			return false;
		} finally {
			session.close();
		}
		
	}

	private String change(String str) {
		StringBuilder sb = new StringBuilder(str);
		for (int i = 2; i < sb.length(); i++) {
			sb.setCharAt(i, '*');
		}
		return sb.toString();
	}

	public String findUser(String email) {
		String hid = "";
		String hpass = "";
		String idpass = "no";
		SqlSession session = factory.openSession();
		try {

			HashMap rst = session.selectOne("user.findMember", email);
			if (rst != null) {
				hid = change((String) rst.get("ID"));
				hpass = change((String) rst.get("PASSWORD"));
				idpass = hid + "&" + hpass;
			}
			return idpass;

		} catch (Exception e) {
			System.out.println("[JDBC] ERROR .." + e.toString());
			return null;
		} finally {
			session.close();
		}
	}	

	public boolean idCheck(String id) {

		SqlSession session = factory.openSession();
		try {
			HashMap rst = session.selectOne("user.idCheck", id);
			return rst != null;
		} catch (Exception e) {
			e.printStackTrace();
			return false;
		} finally {
			session.close();
		}
	}

	public boolean emailCheck(String email) {
		SqlSession session = factory.openSession();
		try {
			HashMap rst = session.selectOne("user.findMember", email);
			return rst != null;
		} catch (Exception e) {
			e.printStackTrace();
			return false;
		} finally {
			session.close();
		}
	}
	
	public Map<String, Object> userInfo(String id) {
		SqlSession session = factory.openSession();
		try {
			HashMap<String, Object> map = session.selectOne("user.userInfo", id);
			return map;

		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}finally {
			session.close();
		}
	}
	public boolean infoResult(Map map) {
		if(map.get("month").equals("��")) {
			map.put("month", null);
		}
		if(map.get("voice") == null) {
			map.put("voice", 0);
		}
		SqlSession session = factory.openSession();
		try {
			if(map.get("npass").equals("")) {
				session.update("user.info_step0", map); 
			}else {
				session.update("user.info_step1", map); 
			}
			session.update("user.info_step2", map);
			session.commit();
			return true;
		} catch (Exception e) {
			e.printStackTrace();
			session.rollback();
			return false;
		} finally {
			session.close();
		}
	}
	public boolean userDelete(String id) {
		SqlSession session = factory.openSession();
		try {
			session.delete("user.userDelete", id);
			return true;
		} catch (Exception e) {
			e.printStackTrace();			
			return false;
		} finally {
			session.close();
		}
	}
}
