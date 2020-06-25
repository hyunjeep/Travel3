package kr.co.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import kr.co.dao.MemberDAO;
import kr.co.domain.Command;
import kr.co.domain.CommandAction;
import kr.co.dto.LoginDTO;

public class LoginCommand implements Command {

	@Override
	public CommandAction execute(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String id = request.getParameter("id");
		String pw = request.getParameter("pw");
		
		MemberDAO dao = new MemberDAO();
		LoginDTO dto = new LoginDTO(id, pw);
		boolean isLogin = dao.login(dto);
		
		if (isLogin) {
			HttpSession session = request.getSession();
			session.setAttribute("login", new LoginDTO(id, pw));
			return new CommandAction(false, "list.do?curPage=1&locationCode=0");
		} else {
			request.setAttribute("error", "ID와 Password가 일치하지 않습니다.");
			return new CommandAction(false, "loginui.do");
		}
	}

}