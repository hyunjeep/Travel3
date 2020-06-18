package kr.co.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kr.co.dao.BoardDAO;
import kr.co.domain.Command;
import kr.co.domain.CommandAction;
import kr.co.dto.BoardDTO;

public class WriteCommand implements Command {

	@Override
	public CommandAction execute(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		String writer = request.getParameter("writer");
		String title = request.getParameter("title");
		String sLocationCode = request.getParameter("locationCode");
		String content = request.getParameter("content");

		int locationCode = 0;

		if (sLocationCode != null) {
			locationCode = Integer.parseInt(sLocationCode);
		}

		BoardDAO dao = new BoardDAO();
		BoardDTO dto = new BoardDTO(0, writer, title, locationCode, null, content, null, 0, 0, 0, 0);
		dao.write(dto);

		return new CommandAction(true, "list.do");
	}

}