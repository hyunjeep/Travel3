package kr.co.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kr.co.dao.BoardDAO;
import kr.co.domain.Command;
import kr.co.domain.CommandAction;
import kr.co.dto.BoardDTO;

public class ReplyCommand implements Command {

	@Override
	public CommandAction execute(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		
		String sNum = request.getParameter("num");
		String writer = request.getParameter("writer");
		String title = request.getParameter("title");
		String sLocationCode = request.getParameter("locationCode");
		String content = request.getParameter("content");
		
		int orgNum = -1;
		if (sNum != null) {
			orgNum = Integer.parseInt(sNum);
		}
		
		int locationCode = -1;
		if (sLocationCode != null) {
			locationCode = Integer.parseInt(sLocationCode);
		}

		BoardDAO dao = new BoardDAO();
		BoardDTO dto = new BoardDTO(-1, writer, title, locationCode, null, content, null, null, 0, -1, -1, -1);
		dao.reply(orgNum, dto);
		
		return new CommandAction(true, "list.do?curPage=1&locationCode="+locationCode);
	}

}