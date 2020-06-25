package kr.co.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kr.co.dao.MemberDAO;
import kr.co.dto.LoginDTO;
import kr.co.dto.MemberDTO;

@WebServlet("/idChack")
public class IdChack extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public IdChack() {
		super();

	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String id = request.getParameter("id");
		MemberDAO dao = new MemberDAO();
		MemberDTO dto = dao.selectById(new LoginDTO(id, null));

		if (dto.getId() != null) {
			response.getWriter().print("사용 할 수 없는 ID입니다.");
		} else {
			response.getWriter().print("사용 가능한 ID입니다.");
		}
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doGet(request, response);
	}

}