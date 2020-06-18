package kr.co.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kr.co.dao.BoardDAO;
import kr.co.domain.Command;
import kr.co.domain.CommandAction;
import kr.co.dto.BoardDTO;

public class ModifyUICommand implements Command {

	@Override
	public CommandAction execute(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		String sNum = request.getParameter("num");
		String sCurPage = request.getParameter("curPage");
		String sLocationCode = request.getParameter("locationCode");

		int num = 0;
		if (sNum != null) {
			num = Integer.parseInt(sNum);
		}
		
		int curPage = 1;
		if (sCurPage != null) {
			curPage = Integer.parseInt(sCurPage);
		}
		
		int locationCode = 0;
		if (sLocationCode != null) {
			locationCode = Integer.parseInt(sLocationCode);
		}

		BoardDAO dao = new BoardDAO();
		BoardDTO dto = dao.modifyUI(num);
		
		request.setAttribute("dto", dto);

		return new CommandAction(false, "modify.jsp");
	}

}