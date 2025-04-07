package persitence;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;

import model.Cliente;

public class ClienteDao implements ICrudDao<Cliente> {
	private GenericDao gDao;

	public ClienteDao(GenericDao gDao) {
		this.gDao = gDao;
	}

	@Override
	public void inserir(Cliente cl) throws SQLException, ClassNotFoundException {
		Connection c = gDao.getConnection();
		String Sql = "exec paciente C, ?, ?, ?, ?, ?, ?, ? ";
		PreparedStatement ps = c.prepareStatement(Sql);
		ps.setInt(1, cl.getIdPessoa());
		ps.setString(2, cl.getNome());
		ps.setInt(3, cl.getRg());
		ps.setInt(4, cl.getDigitoRg());
		ps.setInt(5, cl.getTelefone());
		ps.setString(6, cl.getDataNascimento().toString());
		ps.setString(7, cl.getSenha());
		ps.execute();
		ps.close();
		c.close();
	}

	@Override
	public void atualizar(Cliente cl) throws SQLException, ClassNotFoundException {
		Connection c = gDao.getConnection();
		String Sql = "exec paciente U, ?, ?, ?, ?, ?, ?, ? ";
		PreparedStatement ps = c.prepareStatement(Sql);
		ps.setInt(1, cl.getIdPessoa());
		ps.setString(2, cl.getNome());
		ps.setInt(3, cl.getRg());
		ps.setInt(4, cl.getDigitoRg());
		ps.setInt(5, cl.getTelefone());
		ps.setString(6, cl.getDataNascimento().toString());
		ps.setString(7, cl.getSenha());
		ps.execute();
		ps.close();
		c.close();
	}

	@Override
	public void excluir(Cliente t) throws SQLException, ClassNotFoundException {
	}

	@Override
	public Cliente buscar(Cliente cl) throws SQLException, ClassNotFoundException {
		Connection c = gDao.getConnection();
		String Sql = "Select IdPessoa, Nome, Rg, DigitoRg, Telefone From Pessoa where IdPessoa= ?"
				+ "Select DataNacimento, Senha from Cliente where IdPessoa = ?";
		PreparedStatement ps = c.prepareStatement(Sql);
		ps.setInt(1, cl.getIdPessoa());
		ps.setInt(2, cl.getIdPessoa());
		ResultSet rs = ps.executeQuery();
		if (rs.next()) {
			cl.setIdPessoa(rs.getInt("IdPessoa"));
			cl.setNome(rs.getString("Nome"));
			cl.setRg(rs.getInt("Rg"));
			cl.setDigitoRg(rs.getInt("DigitoRg"));
			cl.setTelefone(rs.getInt("Telefone"));
			cl.setDataNascimento(LocalDate.parse(rs.getString("DataNascimento")));
			cl.setSenha(rs.getString("Senha"));
		}
		rs.close();
		ps.close();
		c.close();
		return cl;
	}

	@Override
	public List<Cliente> listarTodos() throws SQLException, ClassNotFoundException {
		List<Cliente> clientes = new ArrayList<>();
		Connection c = gDao.getConnection();
		String Sql = "Select IdPessoa, Nome, Rg, DigitoRg, Telefone From Pessoa"
				+ "Select DataNacimento, Senha from Cliente";
		PreparedStatement ps = c.prepareStatement(Sql);
		ResultSet rs = ps.executeQuery();
		while (rs.next()) {
			Cliente cl = new Cliente();
			cl.setIdPessoa(rs.getInt("IdPessoa"));
			cl.setNome(rs.getString("Nome"));
			cl.setRg(rs.getInt("Rg"));
			cl.setDigitoRg(rs.getInt("DigitoRg"));
			cl.setTelefone(rs.getInt("Telefone"));
			cl.setDataNascimento(LocalDate.parse(rs.getString("DataNascimento")));
			cl.setSenha(rs.getString("Senha"));

			clientes.add(cl);
		}
		rs.close();
		ps.close();
		c.close();
		return clientes;

	}
}
