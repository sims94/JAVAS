package controller;

import java.math.BigDecimal;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import model.AdminDao;

@Controller
@RequestMapping("/admin")
public class AdminController {

	@Autowired
	AdminDao adao;

	@RequestMapping("/login.jv")
	public ModelAndView toLogin(HttpSession session) {
		ModelAndView mav = new ModelAndView("t_el");
		mav.addObject("section", "user/login");
		session.setAttribute("title", "관리자로그인");
		mav.addObject("height", "52%");
		return mav;
	}
	
	@RequestMapping("/loginResult.jv")
	public ModelAndView toLoginResult(@RequestParam Map map, HttpSession session, HttpServletResponse resp,
			HttpServletRequest req) {
		ModelAndView mav = new ModelAndView();
		System.out.println(map);
		boolean b = adao.login(map);
		if (b) {
			if (map.get("keep") != null) {
				Cookie c = new Cookie("login", (String) map.get("id"));
				c.setMaxAge(60 * 60 * 24 * 7);
				c.setPath("/");
				resp.addCookie(c);
			}
			if (session.getAttribute("logo") == null) {
				System.out.println(session.getAttribute("logo"));
				mav.setViewName("redirect:/");
			} else {
				mav.setViewName("redirect:/" + session.getAttribute("logo"));
			}
			session.setAttribute("auth", map.get("id"));
			return mav;
		} else {
			mav.setViewName("t_el");
			mav.addObject("section", "admin/login");
			mav.addObject("lfalse", "on");
			return mav;
		}
	}
	
	
	
	
	@RequestMapping("/statistics.jv")
	public ModelAndView statics() {
		ModelAndView mav = new ModelAndView("t_el");

		List<Map<String, Object>> list = adao.statics();
		int c = adao.infocount();

		int mc = 0;
		int wc = 0;
		int nc = 0;

		int cnt1 = 0;
		int cnt2 = 0;
		int cnt3 = 0;
		int cnt4 = 0;
		int cnt5 = 0;
		int cnt6 = 0;
		int cnt7 = 0;

		for (int i = 0; i < list.size(); i++) {
			Map<String, Object> map = list.get(i);

			// map에 담긴 data를 꺼내어 변경 후 변수 result에 저장

			if (map.get("GENDER") == null) {
				nc += 1;
			} else {
				if (map.get("GENDER").equals("남")) {
					mc += 1;
				} else {
					wc += 1;
				}
			}

			int age = 0;
			
			int y = new Date().getYear() + 1900;
			System.out.println(y);
			if (map.get("YEAR") == null) { 
				cnt7++;
			}else {
				age = y - ((BigDecimal)map.get("YEAR")).intValue();
				
				System.out.println(age);			
			
				if (age >= 10 && age < 20) {
					cnt1++;
				} else if (age >= 20 && age < 30) {
					cnt2++;
				} else if (age >= 30 && age < 40) {
					cnt3++;
				} else if (age >= 40 && age < 50) {
					cnt4++;
				} else if (age >= 50 && age < 60) {
					cnt5++;
				} else {
					cnt6++;
				} 
			}
		}

		mav.addObject("man", mc);
		mav.addObject("woman", wc);
		mav.addObject("no", nc);
		mav.addObject("cnt1", cnt1);
		mav.addObject("cnt2", cnt2);
		mav.addObject("cnt3", cnt3);
		mav.addObject("cnt4", cnt4);
		mav.addObject("cnt5", cnt5);
		mav.addObject("cnt6", cnt6);
		mav.addObject("cnt7", cnt7);
		mav.addObject("section", "/admin/statistics");

		return mav;
	}
}
