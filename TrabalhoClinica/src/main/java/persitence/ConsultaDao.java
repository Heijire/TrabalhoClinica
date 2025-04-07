package persitence;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;

import model.Consulta;

public class ConsultaDao implements ICrudDao<Consulta> {
	private GenericDao gDao;

	public ConsultaDao(GenericDao gDao) {
		this.gDao = gDao;
	}

	@Override
	public void inserir(Consulta t) throws SQLException, ClassNotFoundException {
		Connection c = gDao.getConnection();
		String Sql = "exec consulta C, ?, ?, ?, ?, ?, ?";
		PreparedStatement ps = c.prepareStatement(Sql);
		ps.setInt(1, t.getIdConsulta());
		ps.setString(2, t.getDataConsulta().toString());
		ps.setString(3, t.getTipoPlano());
		ps.setInt(4, t.getIdCliente());
		ps.setInt(5, t.getIdMedico());
		ps.setInt(6, t.getIdEspecialidade());
		ps.close();
		c.close();
	}

	@Override
	public void atualizar(Consulta t) throws SQLException, ClassNotFoundException {
		Connection c = gDao.getConnection();
		String Sql = "exec consulta U, ?, ?, ?, ?, ?, ?";
		PreparedStatement ps = c.prepareStatement(Sql);
		ps.setInt(1, t.getIdConsulta());
		ps.setString(2, t.getDataConsulta().toString());
		ps.setString(3, t.getTipoPlano());
		ps.setInt(4, t.getIdCliente());
		ps.setInt(5, t.getIdMedico());
		ps.setInt(6, t.getIdEspecialidade());
		ps.close();
		c.close();
	}

	@Override
	public void excluir(Consulta t) throws SQLException, ClassNotFoundException {
		Connection c = gDao.getConnection();
		String Sql = "exec consulta D, null, null, null, null, null, null";
		PreparedStatement ps = c.prepareStatement(Sql);
		ps.setInt(1, t.getIdConsulta());
	}

	@Override
	public Consulta buscar(Consulta t) throws SQLException, ClassNotFoundException {
		Connection c = gDao.getConnection();
		String sql = "Select Id_Consulta, Data_consulta, Valor_Consulta, Valor_material,TipoConsulta,TipoPlano,IdCliente ,IdMedico ,Id_especialidade "
				+ "from Consulta where Id_Consulta = ?";
		PreparedStatement ps = c.prepareStatement(sql);
		ps.setInt(1, t.getIdConsulta());
		ResultSet rs = ps.executeQuery();
		if (rs.next()) {
			t.setIdConsulta(rs.getInt("Id_Consulta"));
			t.setDataConsulta(LocalDate.parse(rs.getString("Data_consulta")));
			t.setValorMaterial(rs.getDouble("Valor_Consulta"));
			t.setValorMaterial(rs.getDouble("Valor_material"));
			t.setTipoConsulta(rs.getString("TipoConsulta"));
			t.setTipoPlano(rs.getString("TipoPlano"));
			t.setIdCliente(rs.getInt("IdCliente"));
			t.setIdMedico(rs.getInt("IdMedico"));
			t.setIdEspecialidade(rs.getInt("Id_especialidade"));

		}
		rs.close();
		ps.close();
		c.close();
		return t;
	}

	@Override
	public List<Consulta> listarTodos() throws SQLException, ClassNotFoundException {
		List<Consulta> consultas = new ArrayList<Consulta>();
		Connection c = gDao.getConnection();
		String sql = "Select Id_Consulta, Data_consulta, Valor_Consulta, Valor_material,TipoConsulta,TipoPlano,IdCliente ,IdMedico ,Id_especialidade from Consulta ";
		PreparedStatement ps = c.prepareStatement(sql);
		ResultSet rs = ps.executeQuery();

		while (rs.next()) {
			Consulta t = new Consulta();
			t.setIdConsulta(rs.getInt("Id_Consulta"));
			t.setDataConsulta(LocalDate.parse(rs.getString("Data_consulta")));
			t.setValorMaterial(rs.getDouble("Valor_Consulta"));
			t.setValorMaterial(rs.getDouble("Valor_material"));
			t.setTipoConsulta(rs.getString("TipoConsulta"));
			t.setTipoPlano(rs.getString("TipoPlano"));
			t.setIdCliente(rs.getInt("IdCliente"));
			t.setIdMedico(rs.getInt("IdMedico"));
			t.setIdEspecialidade(rs.getInt("Id_especialidade"));
			consultas.add(t);
		}
		rs.close();
		ps.close();
		c.close();
		return consultas;
	}

}
