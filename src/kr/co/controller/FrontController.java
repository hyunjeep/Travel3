package kr.co.controller;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kr.co.domain.Command;
import kr.co.domain.CommandAction;

public class FrontController extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public FrontController() {
		super();
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String uri = request.getRequestURI();
		String contp = request.getContextPath();
		String sp = uri.substring(contp.length());

		Command com = null;

		Map<String, String> map = new HashMap<String, String>();
		map.put("/loginui.do", "kr.co.controller.LoginUICommand");
		map.put("/login.do", "kr.co.controller.LoginCommand");
		map.put("/logout.do", "kr.co.controller.LogoutCommand");
		map.put("/insertui.do", "kr.co.controller.InsertUICommand");
		map.put("/insert.do", "kr.co.controller.InsertCommand");
		map.put("/memberinfo.do", "kr.co.controller.MemberinfoCommand");
		map.put("/updateui.do", "kr.co.controller.UpdateUICommand");
		map.put("/update.do", "kr.co.controller.UpdateCommand");
		map.put("/deleteid.do", "kr.co.controller.DeleteIDCommand");
		map.put("/selectById.do", "kr.co.controller.SelectByIdCommand");
		map.put("/list.do", "kr.co.controller.ListPageCommand");
		map.put("/write.do", "kr.co.controller.WriteCommand");
		map.put("/writeui.do", "kr.co.controller.WriteUICommand");
		map.put("/modify.do", "kr.co.controller.ModifyCommand");
		map.put("/modifyui.do", "kr.co.controller.ModifyUICommand");
		map.put("/read.do", "kr.co.controller.ReadCommand");
		map.put("/replyui.do", "kr.co.controller.ReplyUICommand");
		map.put("/reply.do", "kr.co.controller.ReplyCommand");
		map.put("/delete.do", "kr.co.controller.DeleteCommand");

		try {
			com = (Command) Class.forName(map.get(sp)).newInstance();
		} catch (Exception e) {
			e.printStackTrace();
		}

		if (com != null) {
			CommandAction action = com.execute(request, response);
			if (action.isRedirect()) {
				response.sendRedirect(action.getWhere());
			} else {
				request.getRequestDispatcher(action.getWhere()).forward(request, response);
			}
		}
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doGet(request, response);
	}

}