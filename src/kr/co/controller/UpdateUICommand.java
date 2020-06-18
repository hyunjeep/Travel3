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
import kr.co.dto.MemberDTO;

public class UpdateUICommand implements Command {

	@Override
	public CommandAction execute(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String id = request.getParameter("id");

		HttpSession session = request.getSession(false);
		if (session != null) {
			LoginDTO login = (LoginDTO) session.getAttribute("login");
			if (login != null) {
				MemberDAO dao = new MemberDAO();
				MemberDTO dto = dao.selectById(new LoginDTO(id, null));
				request.setAttribute("dto", dto);
				return new CommandAction(false, "updateui.jsp");
			}

		}
		return new CommandAction(false, "loginui.do");
	}

}