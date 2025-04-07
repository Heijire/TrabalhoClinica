package controller;

import java.io.IOException;
import java.sql.SQLException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import model.Especialidade;
import persitence.EspecialidadeDao;
import persitence.GenericDao;

@WebServlet("/Especialidade")
public class EspecialidadeServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public EspecialidadeServlet() {
		super();
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String acao = request.getParameter("acao");

		String msg = "";

		try {
			int id = Integer.parseInt(request.getParameter("id"));
			String nome = request.getParameter("nome");
			double valor = Double.parseDouble(request.getParameter("base"));

			Especialidade e = new Especialidade(id, nome, valor);
			GenericDao gDao = new GenericDao();
			EspecialidadeDao eDao = new EspecialidadeDao(gDao);

			if (acao.equals("inserir")) {
				eDao.inserir(e);
				msg = "Especialidade cadastrada com sucesso!";
			} else if (acao.equals("atualizar")) {
				eDao.atualizar(e);
				msg = "Especialidade atualizada com sucesso!";
			} else if (acao.equals("excluir")) {
				eDao.excluir(e);
				msg = "Especialidade excluída com sucesso!";
			} else if (acao.equals("buscar")) {
				Especialidade buscada = eDao.buscar(e);
				request.setAttribute("especialidade", buscada);
			}
		} catch (NumberFormatException e) {
			msg = "Erro de formato: " + e.getMessage();
		} catch (SQLException | ClassNotFoundException e) {
			msg = "Erro: " + e.getMessage();
		} finally {
			request.setAttribute("msg", msg);
			request.getRequestDispatcher("Especialidade.jsp").forward(request, response);
		}
	}
}

