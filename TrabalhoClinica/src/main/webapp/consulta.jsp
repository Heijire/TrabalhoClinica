<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Consulta</title>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.5/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-SgOJa3DmI69IUzQ2PVdRZhwQ+dy64/BUtbMJw1MZ8t5HZApcHrRKUc4W0kG879m7"
	crossorigin="anonymous">
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.5/dist/js/bootstrap.bundle.min.js"
	integrity="sha384-k6d4wzSIapyDyv1kpU366/PK5hCdSbCRGRCMv+eplOQJWyd1fbcAu9OCUj5zNLiq"
	crossorigin="anonymous"></script>
<script src="https://code.jquery.com/jquery-3.7.1.min.js"
	integrity="sha256-/JqT3SQfawRcv/BIHPThkBvs0OEvtFFmqPF/lYI/Cxo="
	crossorigin="anonymous"></script>
</head>
</head>
<body>
	<!-- Navegação -->
	<ul class="nav justify-content-center bg-light p-2">
		<li class="nav-item"><a class="nav-link active"
			aria-current="page" href="index.jsp">Início</a></li>
		<li class="nav-item"><a class="nav-link" href="indexclinica.jsp">Clinica</a></li>
		<li class="nav-item"><a class="nav-link" href=indexcliente.jsp>Cliente</a>
		</li>
		<li class="nav-item"><a class="nav-link" href="consulta.jsp">Logado</a></li>
        
	</ul>
	<br>
	<div class="conteeiner" align="center">
		<h1>Tela consulta</h1>

		<form method="post" action="Consulta">
			<label>Id Consulta: <input type="number" name="id"
				class="form-control" placeholder="Nome" ><br> <label>Data
					Consulta:</label> <input type="date" name="data"> <label>Tipo:</label>
				<select name="tipo" class="form-select" >
					<option value="" disabled selected>Selecione o Tipo de
						consulta</option>
					<option value="Particular">Particular</option>
					<option value="Plano">Plano</option>
					<label>Id Cliente:</label>
					<input type="number" name="idcliente" placeholder="ID Cliente"
					>
					<br>
					<label>Id medico:</label>
					<input type="number" name="idmedico" placeholder="ID Medico"
					>
					<br />
					<label>Id especialidade:</label>
					<input type="number" name="idespecialidade"
					placeholder="ID Especialidade" >
					<br />
					<label>Tipo Consulta: sera calculado apos</label>
					<label>Valor Material: sera calculado apos</label>
					<label>Valor Consulta: sera calculado apos</label>
					<input type="hidden" name="acao" id="acao">
					<br>

					<button type="submit" class="btn btn-secondary"
						onclick="document.getElementById('acao').value='inserir'">Cadastrar</button>
					<button type="submit" class="btn btn-secondary"
						onclick="document.getElementById('acao').value='buscar'">Consultar</button>
					<button type="submit" class="btn btn-secondary"
						onclick="document.getElementById('acao').value='atualizar'">Atualizar</button>
					<button type="submit" class="btn btn-secondary"
						onclick="document.getElementById('acao').value='excluir'">Excluir</button>



					<div class="container" align="center">
						<c:if test="${not empty Consultas}">
							<table class="table table-dark table-striped-columns">
								<thead>
									<tr>
										<th>Id Consulta</th>
										<th>Data Consulta:</th>
										<th>Tipo:</th>
										<th>Id medico:</th>
										<th>Id Cliente:</th>
										<th>Id especialidade:</th>
										<th>Tipo Consulta:</th>
										<th>Valor Material:</th>
										<th>Valor Consulta:</th>
									</tr>
								</thead>
								<tbody>
									<c:forEach var="C" items="${Consulta}">
										<tr>
											<td>${C.idConsulta}</td>
											<td>${C.dataConsulta}</td>
											<td>${C.valorConsulta}</td>
											<td>${C.valorMaterial}</td>
											<td>${C.tipoConsulta}</td>
											<td>${C.tipoPlano}</td>
											<td>${C.idCliente}</td>
											<td>${C.idMedico}</td>
											<td>${C.idEspecialidade}</td>
										</tr>
									</c:forEach>
								</tbody>
							</table>
						</c:if>
					</div>
</body>
</html>
