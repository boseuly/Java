package comment.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import comment.model.CommentDTO;
import comment.service.CommentService;
import emp.model.EmpDTO;


@WebServlet("/comment/delete")
public class CommentDeleteController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("application/json; charset=utf-8");
		HttpSession session = request.getSession();
		CommentService service = new CommentService();
		
		String id = request.getParameter("id"); // comment id
		
		CommentDTO commentData = service.getData(Integer.parseInt(id));
		EmpDTO empData = (EmpDTO) session.getAttribute("loginData");
		
		StringBuilder sb = new StringBuilder();
		sb.append("{");
		if(commentData.getEmpId() == empData.getEmpId()) {
			boolean result = service.remove(commentData);
			if(result) { // comment 제거 완료시
				sb.append(String.format("\"%s\": \"%s\"", "code", "success"));
			}
		}
		sb.append("}");
		
		response.getWriter().append(sb.toString());
		response.getWriter().flush();
	}

}
