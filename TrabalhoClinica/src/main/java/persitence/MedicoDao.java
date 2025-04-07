package persitence;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import model.Medico;

public class MedicoDao implements ICrudDao<Medico> {
	private GenericDao gDao;

	public MedicoDao(GenericDao gDao) {
		this.gDao = gDao;
	}

	@Override
	public void inserir(Medico m) throws SQLException, ClassNotFoundException {
		Connection c = gDao.getConnection();
		String sql = "EXEC medico C, ?, ?, ?, ?, ?, ?, ?";
		PreparedStatement ps = c.prepareStatement(sql);
		ps.setInt(1, m.getIdmedico());
		ps.setString(2, m.getNome());
		ps.setInt(3, m.getRg());
		ps.setInt(4, m.getDigitoRg());
		ps.setInt(5, m.getTelefone());
		ps.setInt(6, m.getPorcentagem());
		ps.setString(7, m.getPeriodo());
		ps.execute();
		ps.close();
		c.close();
	}


	@Override
	public void atualizar(Medico m) throws SQLException, ClassNotFoundException {
		Connection c = gDao.getConnection();
		String sql = "EXEC medico U, ?, ?, ?, ?, ?, ?, ?";
		PreparedStatement ps = c.prepareStatement(sql);
		ps.setInt(1, m.getIdmedico());
		ps.setString(2, m.getNome());
		ps.setInt(3, m.getRg());
		ps.setInt(4, m.getDigitoRg());
		ps.setInt(5, m.getTelefone());
		ps.setInt(6, m.getPorcentagem());
		ps.setString(7, m.getPeriodo());
		ps.execute();
		ps.close();
		c.close();
	}


	@Override
	public void excluir(Medico m) throws SQLException, ClassNotFoundException {
		Connection c = gDao.getConnection();
		String sql = "EXEC medico D, ?, NULL, NULL, NULL, NULL, NULL, NULL, NULL";
		PreparedStatement ps = c.prepareStatement(sql);
		ps.setInt(1, m.getIdmedico());
		ps.execute();
		ps.close();
		c.close();
	}

	@Override
	public Medico buscar(Medico m) throws SQLException, ClassNotFoundException {
		Connection c = gDao.getConnection();
		String Sql = "Select IdPessoa, Nome, Rg, DigitoRg, Telefone From Pessoa where IdPessoa= ?"
				+ "Select Porcentagem, Perioco from Medico where IdPessoa = ?";
		PreparedStatement ps = c.prepareStatement(Sql);
		ps.setInt(1, m.getIdmedico());
		ps.setInt(2, m.getIdmedico());
		ResultSet rs = ps.executeQuery();
		if (rs.next()) {
			m.setIdmedico(rs.getInt("IdMedico"));
			m.setNome(rs.getString("Nome"));
			m.setRg(rs.getInt("Rg"));
			m.setDigitoRg(rs.getInt("DigitoRg"));
			m.setTelefone(rs.getInt("Telefone"));
			m.setPorcentagem(rs.getInt("Porcentagem"));
			m.setPeriodo(rs.getString("Periodo"));
		
		}
		rs.close();
		ps.close();
		c.close();
		return m;
	}

	@Override
	public List<Medico> listarTodos() throws SQLException, ClassNotFoundException {
		List<Medico> medicos = new ArrayList<>();
		Connection c = gDao.getConnection();
		String Sql = "Select IdPessoa, Nome, Rg, DigitoRg, Telefone From Pessoa"
				+ "Select Porcentagem, Perioco from Medico";
		PreparedStatement ps = c.prepareStatement(Sql);
		ResultSet rs = ps.executeQuery();

		while (rs.next()) {
			Medico m = new Medico();
			m.setIdmedico(rs.getInt("IdMedico"));
			m.setNome(rs.getString("Nome"));
			m.setRg(rs.getInt("Rg"));
			m.setDigitoRg(rs.getInt("DigitoRg"));
			m.setTelefone(rs.getInt("Telefone"));
			m.setPorcentagem(rs.getInt("Porcentagem"));
			m.setPeriodo(rs.getString("Periodo"));
			medicos.add(m);
		}

		rs.close();
		ps.close();
		c.close();
		return medicos;
	}
}
