package kr.co.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kr.co.dao.BoardDAO;
import kr.co.domain.Command;
import kr.co.domain.CommandAction;
import kr.co.dto.BoardDTO;

public class ModifyCommand implements Command {

	@Override
	public CommandAction execute(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		String sNum = request.getParameter("num");
		String writer = request.getParameter("writer");
		String title = request.getParameter("title");
		String sLocationCode = request.getParameter("locationCode");
		String content = request.getParameter("content");
		
		int num = 0;
		if (sNum != null) {
			num = Integer.parseInt(sNum);
		}
		
		int locationCode = -1;
		if (sLocationCode != null) {
			locationCode = Integer.parseInt(sLocationCode);
		}
	
		new BoardDAO().modify(new BoardDTO(num, writer, title, locationCode, null, content, null, -1, -1, -1, -1));

		return new CommandAction(true, "list.do");
	}

}