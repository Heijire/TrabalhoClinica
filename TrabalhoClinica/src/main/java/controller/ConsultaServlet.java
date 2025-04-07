package controller;

import java.io.IOException;
import java.sql.SQLException;
import java.time.LocalDate;
import java.util.List;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.Consulta;
import persitence.ConsultaDao;
import persitence.GenericDao;

@WebServlet("/Consulta")
public class ConsultaServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String acao = request.getParameter("acao");

		String saida = "";
		String erro = "";

		Consulta c = new Consulta();

		try {
			if (!acao.equalsIgnoreCase("listar")) {
				c.setIdConsulta(Integer.parseInt(request.getParameter("id")));
				c.setDataConsulta(LocalDate.parse(request.getParameter("data")));
				c.setTipoPlano(request.getParameter("tipo"));
				c.setIdCliente(Integer.parseInt(request.getParameter("idcliente")));
				c.setIdMedico(Integer.parseInt(request.getParameter("idmedico")));
				c.setIdEspecialidade(Integer.parseInt(request.getParameter("idespecialidade")));
				c.setTipoConsulta(""); 
				c.setValorConsulta(0.0); 
				c.setValorMaterial(0.0); 
			}

			GenericDao gDao = new GenericDao();
			ConsultaDao cDao = new ConsultaDao(gDao);

			if (acao.equalsIgnoreCase("inserir")) {
				cDao.inserir(c);
				saida = "Consulta inserida com sucesso!";
			} else if (acao.equalsIgnoreCase("atualizar")) {
				cDao.atualizar(c);
				saida = "Consulta atualizada com sucesso!";
			} else if (acao.equalsIgnoreCase("excluir")) {
				cDao.excluir(c);
				saida = "Consulta excluída com sucesso!";
			} else if (acao.equalsIgnoreCase("buscar")) {
				c = cDao.buscar(c);
				request.setAttribute("Consulta", c);
			}

			List<Consulta> lista = cDao.listarTodos();
			request.setAttribute("Consultas", lista);

		} catch (SQLException | ClassNotFoundException e) {
			erro = e.getMessage();
			e.printStackTrace();
		} finally {
			request.setAttribute("saida", saida);
			request.setAttribute("erro", erro);
			request.getRequestDispatcher("consulta.jsp").forward(request, response);
		}
	}
}
