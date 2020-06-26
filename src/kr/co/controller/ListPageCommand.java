package kr.co.controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kr.co.dao.BoardDAO;
import kr.co.domain.Command;
import kr.co.domain.CommandAction;
import kr.co.dto.FileDTO;
import kr.co.dto.LocationDTO;
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
		if (sLocation != null) {
			location = Integer.parseInt(sLocation);
		}

		BoardDAO dao = new BoardDAO();
		PageTO to = dao.page(curPage, location);
		List<LocationDTO> loclist = dao.location();
		List<FileDTO> fileNumList = dao.fileNumList();

		request.setAttribute("to", to);
		request.setAttribute("list", to.getList());
		request.setAttribute("locationCode", location);
		request.setAttribute("locationList", loclist);
		request.setAttribute("fileNumList", fileNumList);

		return new CommandAction(false, "list.jsp");
	}

}