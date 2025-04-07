package controller;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.Medico;
import persitence.GenericDao;
import persitence.MedicoDao;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

@WebServlet("/Medico")
public class MedicoServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public MedicoServlet() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
	}

	protected  void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		String acao = request.getParameter("b");
		String nome = request.getParameter("nome");
		String rg = request.getParameter("rg");
		String digito = request.getParameter("digito");
		String telefone = request.getParameter("telefone");
		String idEspecialidade = request.getParameter("idEspecialidade");
		String porcentagem = request.getParameter("porcentagem");
		String periodo = request.getParameter("periodo");

		Medico m = new Medico();

		if (!acao.equalsIgnoreCase("Listar")) {
			m.setRg(Integer.parseInt(rg));
			m.setDigitoRg(Integer.parseInt(digito));
			m.setNome(nome);
			m.setTelefone(Integer.parseInt(telefone));
			m.setIdespecialidade(Integer.parseInt(idEspecialidade));
			m.setPorcentagem(Integer.parseInt(porcentagem));
			m.setPeriodo(periodo);
		}

		GenericDao gdao = new GenericDao();
		MedicoDao mdao = new MedicoDao(gdao);
		String saida = "";
		String erro = "";
		List<Medico> medicos = new ArrayList<>();

		try {
			if (acao.equalsIgnoreCase("Inserir")) {
				mdao.inserir(m);
				saida = "Médico inserido com sucesso!";
			}

			if (acao.equalsIgnoreCase("Atualizar")) {
				mdao.atualizar(m);
				saida = "Médico atualizado com sucesso!";
			}

			if (acao.equalsIgnoreCase("Excluir")) {
				mdao.excluir(m);
				saida = "Médico excluído com sucesso!";
			}

			if (acao.equalsIgnoreCase("Buscar")) {
				Medico resultado = mdao.buscar(m);
				request.setAttribute("medico", resultado);
			}

			if (acao.equalsIgnoreCase("Listar")) {
				medicos = mdao.listarTodos();
			}

		} catch (Exception  e) {
			System.err.println(e);
		}finally {
			
		}

		request.setAttribute("saida", saida);
		request.setAttribute("erro", erro);
		request.setAttribute("medicos", medicos);
		request.setAttribute("medico", m);

		RequestDispatcher rd = request.getRequestDispatcher("rMedico.jsp");
		rd.forward(request, response);

	}

}
