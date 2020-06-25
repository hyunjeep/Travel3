package kr.co.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

import kr.co.dao.BoardDAO;
import kr.co.domain.Command;
import kr.co.domain.CommandAction;
import kr.co.dto.BoardDTO;
import kr.co.dto.FileDTO;

public class WriteCommand implements Command {

	@Override
	public CommandAction execute(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		
		int size = 10 * 1024 * 1024;
		int fileNum = 0;
		String fileName = "";
		String orgFileName = "";
		String fileUrl = request.getSession().getServletContext().getRealPath("upload");
		
		MultipartRequest multi = new MultipartRequest(request, fileUrl, size, "UTF-8", new DefaultFileRenamePolicy());

		String writer = multi.getParameter("writer");
		String title = multi.getParameter("title");
		String sLocationCode = multi.getParameter("locationCode");
		String content = multi.getParameter("content");

		int locationCode = 0;
		if (sLocationCode != null) {
			locationCode = Integer.parseInt(sLocationCode);
		}

		fileName = multi.getFilesystemName("fileName");
		orgFileName = multi.getOriginalFileName("fileName");
		
		System.out.println(writer);
		System.out.println(locationCode);
		System.out.println(title);
		////////////////////////////////////////////////////
		System.out.println(fileName);
		System.out.println(orgFileName);
		System.out.println(fileUrl);
		
		FileDTO fto = new FileDTO(fileNum, fileName, orgFileName, fileUrl);
		BoardDAO dao = new BoardDAO();
		BoardDTO dto = new BoardDTO(0, writer, title, locationCode, null, content, null, fto, 0, 0, 0, 0);
		dao.write(dto, fto);

		return new CommandAction(true, "list.do?curPage=1&locationCode="+locationCode);
	}

}