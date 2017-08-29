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
		SqlSession session = factory.openSession();
		try {
			session.insert("member.join_step1", map); // ����� ������ int
			session.insert("member.join_step2", map);
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

	public boolean existCheck(Map map) {
		SqlSession session = factory.openSession();
		try {
			HashMap rst = session.selectOne("member.login", map);
			
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

	public String findMember(String email) {
		String hid = "";
		String hpass = "";
		String idpass = "no";
		SqlSession session = factory.openSession();
		try {

			HashMap rst = session.selectOne("member.findMember", email);
			if (rst != null) {
				hid = change((String) rst.get("ID"));
				hpass = change((String) rst.get("PASS"));
				idpass = hid + "&" + hpass;
			}
			return idpass;

		} catch (Exception e) {
			System.out.println("[JDBC] ERROR .." + e.toString());
			return null;
		} finally {
			session.close();
		}
		// =======================================================
	}

	public Map<String, Object> readMember(String id) {
		SqlSession session = factory.openSession();
		try {
			HashMap<String, Object> map = session.selectOne("member.readInfo", id);
			return map;

		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}finally {
			session.close();
		}
	}

	

	public boolean idCheck(String id) {

		try {
			SqlSession session = factory.openSession();
			HashMap rst = session.selectOne("user.idCheck", id);
			return rst != null;
		} catch (Exception e) {
			e.printStackTrace();
			return false;
		}
	}

	public boolean emailCheck(String email) {
		try {
			SqlSession session = factory.openSession();
			HashMap rst = session.selectOne("user.findMember", email);
			return rst != null;
		} catch (Exception e) {
			e.printStackTrace();
			return false;
		}
	}
	
	public List<Map<String, Object>> genderList() {
		SqlSession session = factory.openSession();
		try {
			List<Map<String, Object>> list = session.selectList("member.gender");
			return list;
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		} finally {
			session.close();
		}
	}
}