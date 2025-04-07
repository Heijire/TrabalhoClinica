package model;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.time.LocalDate;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class Consulta {
    private int idConsulta;
	private LocalDate dataConsulta;
    private double valorConsulta;
    private double valorMaterial;
    private String tipoConsulta;
    private String tipoPlano;
    private int idCliente;
    private int idMedico;
    private int idEspecialidade;
}
