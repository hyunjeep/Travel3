package kr.co.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kr.co.dao.BoardDAO;
import kr.co.domain.Command;
import kr.co.domain.CommandAction;
import kr.co.dto.PageTO;

public class ListPageCommand implements Command {

	@Override
	public CommandAction execute(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		
		String sCurPage = request.getParameter("curPage");
		String sLocation = request.getParameter("locationCode");
		
		int curPage = 1;
		
		if (sCurPage != null) {
			curPage = Integer.parseInt(sCurPage);
		}
		
		int location = 0;
		
		if(sLocation != null) {
			location = Integer.parseInt(sLocation);
		}
		
		BoardDAO dao = new BoardDAO();
		PageTO to = dao.page(curPage, location);

		request.setAttribute("to", to);
		request.setAttribute("list", to.getList());
		
		return new CommandAction(false, "list.jsp");
	}

}