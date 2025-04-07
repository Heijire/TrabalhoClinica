package controller;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.Cliente;
import persitence.ClienteDao;
import persitence.GenericDao;

import java.io.IOException;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;


@WebServlet("/Cliente")
public class ClienteServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

    public  ClienteServlet() {
        super();    
    }


	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		String cmd = request.getParameter("acao");
		String nome = request.getParameter("nome");
		String rg = request.getParameter("rg");
		String digito = request.getParameter("digito");
		String telefone = request.getParameter("telefone");
		String nascimento = request.getParameter("nascimento");
		String senha = request.getParameter("senha");

		Cliente c = new Cliente();
		if (cmd != null && !cmd.equalsIgnoreCase("listar")) {
			try {
				c.setRg(Integer.parseInt(rg));
				c.setDigitoRg(Integer.parseInt(digito));
				c.setNome(nome);
				c.setTelefone(Integer.parseInt(telefone));
				c.setDataNascimento(LocalDate.parse(nascimento));
				c.setSenha(senha);
			} catch (Exception e) {
			}
		}
		GenericDao gdao = new GenericDao();
		ClienteDao cdao = new ClienteDao(gdao);
		String saida = "";
		String erro = "";
		List<Cliente> clientes = new ArrayList<>();

		try {
			if (cmd.equalsIgnoreCase("inserir")) {
				cdao.inserir(c);
				saida = "Cliente inserido com sucesso!";
			}

			if (cmd.equalsIgnoreCase("atualizar")) {
				cdao.atualizar(c);
				saida = "Cliente atualizado com sucesso!";
			}

			if (cmd.equalsIgnoreCase("buscar")) {
				Cliente resultado = cdao.buscar(c);
				request.setAttribute("cliente", resultado);
			}

			if (cmd.equalsIgnoreCase("listar")) {
				clientes = cdao.listarTodos();
			}
		} catch (Exception e) {
			erro = e.getMessage();
		}

		request.setAttribute("saida", saida);
		request.setAttribute("erro", erro);
		request.setAttribute("clientes", clientes);

		RequestDispatcher rd = request.getRequestDispatcher("cliente.jsp");
		rd.forward(request, response);
	}
	

}
