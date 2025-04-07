<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>medico</title>
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
<body>
	<!-- Navegação -->
	<ul class="nav justify-content-center bg-light p-2">
		<li class="nav-item"><a class="nav-link active"
			aria-current="page" href="index.jsp">Início</a></li>
		<li class="nav-item"><a class="nav-link" href="indexclinica.jsp">Clinica</a></li>
		<li class="nav-item"><a class="nav-link" href="indexcliente.jsp">Cliente</a>
		</li>
	</ul>
	<div class="conteeiner" align="center">
		<h2>CRUD Medico</h2>
		<form method="post" action="Medico">
			<label>Nome: <input type="text" name="nome"
				class="form-control" placeholder="Nome"><br> <label>RG:</label>
				<input type="number" name="rg" placeholder="rg" required> <input
				type="number" name="digito" placeholder="digito"><br>
				<br> <label>Telefone:</label> <input type="text"
				name="telefone" class="form-control" placeholder="Telefone"><br>
				<label>Id Especialidade:</label> <input type="number"
				name="idEspecialidade" placeholder="ID Especialidade"><br>
				<label>Porcentagem:</label> <input type="number" name="porcentagem"
				placeholder="Porcentagem (Digite um numero Inteiro)"><br>
				<br> <label>Período:</label> <select name="periodo"
				class="form-select">
					<option value="" disabled selected>Selecione o período</option>
					<option value="Manhã">Manhã</option>
					<option value="Tarde">Tarde</option>
					<option value="Noite">Noite</option>
			</select> <input type="hidden" name="acao" id="acao"> <br>
				<button type="button" class="btn btn-secondary" type="submit"
					onclick="window.location.href='${pageContext.request.contextPath}/Medico?acao=inserir'">Cadastrar</button>
				<button type="button" class="btn btn-secondary" type="submit"
					onclick="window.location.href='${pageContext.request.contextPath}/Medico?acao=buscar'">Consultar</button>
				<button type="button" class="btn btn-secondary" type="submit"
					onclick="window.location.href='${pageContext.request.contextPath}/Medico?acao=atualizar'">Atualizar</button>
				<button type="button" class="btn btn-secondary" type="submit"
					onclick="window.location.href='${pageContext.request.contextPath}/Medico?acao=excluir'">Excluir</button>
		</form>
	</div>




	<div class="container" align="center">
		<c:if test="${not empty Cliente}">
			<table class="table table-dark table-striped-columns">
				<thead>
					<tr>
						<th>id</th>
						<th>Nome</th>
						<th>Rg</th>
						<th>digito:</th>
						<th>telefone:</th>
						<th>porcentagem:</th>
						<th>periodo</th>
						<th>idespecialidade:</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach var="C" items="${Medico}">
						<tr>
							<td>${C.idmedico}</td>
							<td>${C.nome}</td>
							<td>${C.rg}</td>
							<td>${C.digitoRg}</td>
							<td>${C.telefone}</td>
							<td>${C.porcentagem}</td>
							<td>${C.periodo}</td>
							<td>${C.idespecialidade}</td>

						</tr>
					</c:forEach>
				</tbody>
			</table>
		</c:if>
	</div>

</body>
</html>