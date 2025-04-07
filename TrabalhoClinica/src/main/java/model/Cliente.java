package model;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.time.LocalDate;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class Cliente {
	private int idPessoa;
	private String nome;
	private int rg;
	private int digitoRg;
	private int telefone;
	private LocalDate dataNascimento;
	private String senha;
}
