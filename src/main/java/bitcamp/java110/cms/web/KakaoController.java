package bitcamp.java110.cms.web;

import java.util.HashMap;
import java.util.Map;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import bitcamp.java110.cms.domain.Member;
import bitcamp.java110.cms.service.AuthService;

@Controller
@RequestMapping("/kakao")
public class KakaoController {

    AuthService authService;
    
    public KakaoController(AuthService authService) {
        this.authService = authService;
    }

    @GetMapping("form")
    public void form() {
    }
    
    @PostMapping("login")
    public String login(
            String type,
            String email,
            String password,
            String save,
            HttpServletResponse response,
            HttpSession session) {
        
        if (save != null) {// 이메일 저장하기를 체크했다면,
            Cookie cookie = new Cookie("email", email);
            cookie.setMaxAge(60 * 60 * 24 * 15);
            response.addCookie(cookie);
            
        } else {// 이메일을 저장하고 싶지 않다면,
            Cookie cookie = new Cookie("email", "");
            cookie.setMaxAge(0);
            response.addCookie(cookie);
        }
        
        Member loginUser = authService.getMember(email, password, type);
        
        if (loginUser != null) {
            // 회원 정보를 세션에 보관한다.
            session.setAttribute("loginUser", loginUser);
            String redirectUrl = null;
            
            switch (type) {
            case "manager":
                redirectUrl = "../manager/list";
                break; 
            }
            return "redirect:" + redirectUrl;
            
        } else {
            session.invalidate();
            return "redirect:form";
        }
    }
    
    @GetMapping("logout")
    public String logout(HttpSession session) {
        session.invalidate();
        return "redirect:form";
    }
    
    
    @RequestMapping("kakao")
    public void kakao(
        String email,
        String id,
        String profile_image,
        String nickname,
            HttpSession session) {
//      authService.getNaverMember(accessToken);
      
      Map<String, String> map = new HashMap<>();
      
      map.put("email", email);
      map.put("profile_image", profile_image);
      map.put("nickname", nickname);
      
      System.out.println(email);
      System.out.println(id);
      System.out.println(profile_image);
      System.out.println(nickname);
      
      authService.getKakaoMember(map);
//      return "redirect:../auth/form";
    }
    
    
    
}














