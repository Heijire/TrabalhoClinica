package model;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class Especialidade {
    private int idEspecialidade;
    private String nomeEspecialidade;
    private double valorBase;
}
