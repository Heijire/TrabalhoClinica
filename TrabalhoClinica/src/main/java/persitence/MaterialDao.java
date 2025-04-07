package persitence;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import model.Material;

public class MaterialDao implements ICrudDao<Material> {
	private GenericDao gDao;

	public MaterialDao(GenericDao gDao) {
		this.gDao = gDao;
	}

	@Override
	public void inserir(Material t) throws SQLException, ClassNotFoundException {
		Connection c = gDao.getConnection();
		String sql = "Insert into Material(Id_Material, Nome, Valor_Unitario) values (?,?,?)";
		PreparedStatement ps = c.prepareStatement(sql);
		ps.setInt(1, t.getIdMaterial());
		ps.setString(2, t.getNome());
		ps.setDouble(3, t.getValorUnitario());
		ps.execute();
		ps.close();
		c.close();
	}

	@Override
	public void atualizar(Material t) throws SQLException, ClassNotFoundException {
		Connection c = gDao.getConnection();
		String sql = "Update Material set Nome = ?, Valor_Unitario = ? where Id_Material = ?";
		PreparedStatement ps = c.prepareStatement(sql);
		ps.setString(1, t.getNome());
		ps.setDouble(2, t.getValorUnitario());
		ps.setInt(3, t.getIdMaterial());
		ps.execute();
		ps.close();
		c.close();
	}

	@Override
	public void excluir(Material t) throws SQLException, ClassNotFoundException {
		Connection c = gDao.getConnection();
		String sql = "Delete Material where Id_Material = ?";
		PreparedStatement ps = c.prepareStatement(sql);
		ps.setInt(1, t.getIdMaterial());
		ps.execute();
		ps.close();
	}

	@Override
	public Material buscar(Material t) throws SQLException, ClassNotFoundException {
		Connection c = gDao.getConnection();
		String sql = "Select Id_Material, Nome,Valor_Unitario from Material where Id_Material = ?";
		PreparedStatement ps = c.prepareStatement(sql);
		ps.setInt(1, t.getIdMaterial());
		ResultSet rs = ps.executeQuery();
		if (rs.next()) {
			t.setIdMaterial(rs.getInt("Id_Material"));
			t.setNome(rs.getString("Nome"));
			t.setValorUnitario(rs.getDouble("Valor_Unitario"));
		}
		rs.close();
		ps.close();
		c.close();
		return t;
	}

	@Override
	public List<Material> listarTodos() throws SQLException, ClassNotFoundException {
		List<Material> Materiais = new ArrayList<>();
		Connection c = gDao.getConnection();
		String Sql = "Select Id_Material, Nome,Valor_Unitario from Material";
		PreparedStatement ps = c.prepareStatement(Sql);
		ResultSet rs = ps.executeQuery();
		while (rs.next()) {
			Material m = new Material();
			m.setIdMaterial(rs.getInt("Id_Material"));
			m.setNome(rs.getString("Nome"));
			m.setValorUnitario(rs.getDouble("Rg"));
			Materiais.add(m);
		}
		ps.close();
		rs.close();
		c.close();
		return Materiais;
	}
}
