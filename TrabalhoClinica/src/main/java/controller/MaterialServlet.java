package controller;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.Material;
import persitence.GenericDao;
import persitence.MaterialDao;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

/**
 * Servlet implementation class MaterialServlet
 */
@WebServlet("/Material")
public class MaterialServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public MaterialServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		String cmd = request.getParameter("acao");
		String id = request.getParameter("idMaterial");
		String nome = request.getParameter("nome");
		String valor = request.getParameter("valorUnitario");

		String saida = "";
		String erro = "";
		List<Material> materiais = new ArrayList<>();

		Material m = new Material();

		try {
			if (cmd != null && !cmd.equalsIgnoreCase("listar")) {
				m.setIdMaterial(Integer.parseInt(id));
			}
			if (cmd != null && (cmd.equalsIgnoreCase("inserir") || cmd.equalsIgnoreCase("atualizar"))) {
				m.setNome(nome);
				m.setValorUnitario(Double.parseDouble(valor));
			}
		} catch (Exception e) {
			erro = "Erro ao converter dados: " + e.getMessage();
		}

		try {
			GenericDao gDao = new GenericDao();
			MaterialDao mDao = new MaterialDao(gDao);

			if (cmd.equalsIgnoreCase("inserir")) {
				mDao.inserir(m);
				saida = "Material inserido com sucesso!";
			}
			if (cmd.equalsIgnoreCase("atualizar")) {
				mDao.atualizar(m);
				saida = "Material atualizado com sucesso!";
			}
			if (cmd.equalsIgnoreCase("excluir")) {
				mDao.excluir(m);
				saida = "Material excluído com sucesso!";
			}
			if (cmd.equalsIgnoreCase("buscar")) {
				Material resultado = mDao.buscar(m);
				request.setAttribute("material", resultado);
			}
			if (cmd.equalsIgnoreCase("listar")) {
				materiais = mDao.listarTodos();
			}

		} catch (Exception e) {
			erro = e.getMessage();
		}

		request.setAttribute("saida", saida);
		request.setAttribute("erro", erro);
		request.setAttribute("materiais", materiais);

		RequestDispatcher rd = request.getRequestDispatcher("resultadoMaterial.jsp");
		rd.forward(request, response);
	}

}
