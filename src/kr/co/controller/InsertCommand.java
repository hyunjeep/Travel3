package kr.co.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kr.co.dao.MemberDAO;
import kr.co.domain.Command;
import kr.co.domain.CommandAction;
import kr.co.dto.MemberDTO;

public class InsertCommand implements Command {

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
		
		MemberDAO dao = new MemberDAO();
		MemberDTO dto = new MemberDTO(id, name, pw, age, email);
		dao.insert(dto);
		
		System.out.println(dto.toString());
		
		return new CommandAction(true, "main.jsp");
	}

}