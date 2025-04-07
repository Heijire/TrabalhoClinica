package persitence;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import model.Especialidade;

public class EspecialidadeDao implements ICrudDao<Especialidade> {
	private GenericDao gDao;

	public EspecialidadeDao(GenericDao gDao) {
		this.gDao = gDao;
	}

	@Override
	public void inserir(Especialidade t) throws SQLException, ClassNotFoundException {
		Connection c = gDao.getConnection();
		String Sql = "exec especialidade C, ?, ?, ?";
		PreparedStatement ps = c.prepareStatement(Sql);
		ps.setInt(1, t.getIdEspecialidade());
		ps.setString(2, t.getNomeEspecialidade());
		ps.setDouble(3, t.getValorBase());
	}

	@Override
	public void atualizar(Especialidade t) throws SQLException, ClassNotFoundException {
		Connection c = gDao.getConnection();
		String Sql = "exec especialidade U, ?, ?, ?";
		PreparedStatement ps = c.prepareStatement(Sql);
		ps.setInt(1, t.getIdEspecialidade());
		ps.setString(2, t.getNomeEspecialidade());
		ps.setDouble(3, t.getValorBase());
	}

	@Override
	public void excluir(Especialidade t) throws SQLException, ClassNotFoundException {
		Connection c = gDao.getConnection();
		String Sql = "exec especialidade D, ?, null, null";
		PreparedStatement ps = c.prepareStatement(Sql);
		ps.setInt(1, t.getIdEspecialidade());
	}

	@Override
	public Especialidade buscar(Especialidade t) throws SQLException, ClassNotFoundException {
		Connection c = gDao.getConnection();
		String Sql = "Select Id_especialidade, Nome_especialidade, ValorBase from Especialidade where Id_especialidade= ?";
		PreparedStatement ps = c.prepareStatement(Sql);
		ps.setInt(1, t.getIdEspecialidade());
		ResultSet rs = ps.executeQuery();
		if(rs.next()) {
			t.setIdEspecialidade(rs.getInt("Id_especialidade"));
			t.setNomeEspecialidade(rs.getString("Nome_especialidade"));
			t.setValorBase(rs.getDouble("ValorBase"));
		}
		
		return t;
	}

	@Override
	public List<Especialidade> listarTodos() throws SQLException, ClassNotFoundException {
		List<Especialidade> especialidades = new ArrayList<Especialidade>();
		Connection c = gDao.getConnection();
		String Sql = "Select Id_especialidade, Nome_especialidade, ValorBase from Especialidade";
		PreparedStatement ps = c.prepareStatement(Sql);
		ResultSet rs = ps.executeQuery();
		while(rs.next()){
			Especialidade e = new Especialidade();
			e.setIdEspecialidade(rs.getInt("Id_especialidade"));
			e.setNomeEspecialidade(rs.getString("Nome_especialidade"));
			e.setValorBase(rs.getDouble("ValorBase"));
		
			especialidades.add(e);
		}
		rs.close();
		ps.close();
		c.close();
		return especialidades;
	}

}
