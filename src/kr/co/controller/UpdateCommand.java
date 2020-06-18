package kr.co.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kr.co.dao.MemberDAO;
import kr.co.domain.Command;
import kr.co.domain.CommandAction;
import kr.co.dto.LoginDTO;
import kr.co.dto.MemberDTO;

public class UpdateCommand implements Command {

	@Override
	public CommandAction execute(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String id = request.getParameter("id");
		String pw = request.getParameter("pw");
		String name = request.getParameter("name");
		String sAge = request.getParameter("age");
		String email = request.getParameter("email");
		
		int age = 0;
		if (sAge != null) {
			age = Integer.parseInt(sAge);
		}
		
		LoginDTO loginDTO = new LoginDTO(id, pw);
		MemberDAO dao = new MemberDAO();
		boolean login = dao.login(loginDTO);

		if (login) {
			dao.update(new MemberDTO(id, name, pw, age, email));
			return new CommandAction(false, "memberinfo.do");
		} else {
			request.setAttribute("error", "Password가 다릅니다.");
			return new CommandAction(false, "updateui.do");
		}
	}

}