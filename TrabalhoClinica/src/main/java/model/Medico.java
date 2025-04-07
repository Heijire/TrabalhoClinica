package model;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class Medico {
	private int idmedico;
	private String nome;
	private int rg;
	private int digitoRg;
	private int telefone;
	private int porcentagem;
	private String periodo;
	private int idespecialidade;
}
