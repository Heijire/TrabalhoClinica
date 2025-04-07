package controller;

import java.io.IOException;
import java.sql.*;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import persitence.GenericDao;

@WebServlet("/Login")
public class LoginServelet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    public LoginServelet() {
        super();
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String rg = request.getParameter("Rg");
        String senha = request.getParameter("senha");
        String msg = "";
        String destino = "login.jsp";

        try {
            GenericDao gDao = new GenericDao();
            Connection c = gDao.getConnection();

            String sql = "exec Autentificar ?, ? ";
            PreparedStatement ps = c.prepareStatement(sql);
            ps.setString(1, rg);
            ps.setString(2, senha);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                HttpSession session = request.getSession();
                session.setAttribute("usuario", rs.getString("nome")); 
                destino = "consulta.jsp"; 
            } else {
                msg = "RG ou senha inválidos!";
            }

            rs.close();
            ps.close();
            c.close();

        } catch (Exception e) {
            msg = "Erro: " + e.getMessage();
        }

        request.setAttribute("msg", msg);
        request.getRequestDispatcher(destino).forward(request, response);
    }
}
