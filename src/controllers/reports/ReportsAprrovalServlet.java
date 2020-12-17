package controllers.reports;

import java.io.IOException;

import javax.persistence.EntityManager;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import models.Report;
import utils.DBUtil;

/**
 * Servlet implementation class ReportsAprrovalServlet
 */
@WebServlet("/reports/approval")
public class ReportsAprrovalServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    /**
     * @see HttpServlet#HttpServlet()
     */
    public ReportsAprrovalServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

    /**
     * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
     */
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        EntityManager em = DBUtil.createEntityManager();
        Report r = em.find(Report.class, Integer.parseInt(request.getParameter("report_id")));

        String approvalFlg = request.getParameter("approval");
        if (approvalFlg.equals("0")) {
            r.setApproval(0);
        } else if (approvalFlg.equals("1")) {
            r.setApproval(1);
        } else {
            r.setApproval(2);
        }
        em.getTransaction().begin();
        em.getTransaction().commit();
        em.close();
        response.sendRedirect(request.getContextPath() + "/reports/index");
    }
}

