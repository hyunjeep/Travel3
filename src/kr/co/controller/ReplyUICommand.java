package kr.co.controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kr.co.dao.BoardDAO;
import kr.co.domain.Command;
import kr.co.domain.CommandAction;
import kr.co.dto.BoardDTO;

public class ReplyUICommand implements Command {

	@Override
	public CommandAction execute(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		String sNum = request.getParameter("num");
		String sCurPage = request.getParameter("curPage");
		String sLocation = request.getParameter("locationCode");
		
		int num = 0;
		if (sNum != null) {
			num = Integer.parseInt(sNum);
		}
		
		int curPage = 1;
		if (sCurPage != null) {
			curPage = Integer.parseInt(sCurPage);
		}
		
		int location = 0;
		if(sLocation != null) {
			location = Integer.parseInt(sLocation);
		}
		
		BoardDAO dao = new BoardDAO();
		BoardDTO dto = dao.modifyUI(num);

		request.setAttribute("dto", dto);

		return new CommandAction(false, "reply.jsp");
	}

}