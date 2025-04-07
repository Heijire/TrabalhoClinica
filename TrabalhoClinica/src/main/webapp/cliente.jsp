<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Cliente</title>
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
		<li class="nav-item"><a class="nav-link" href="indexcliente.jsp">Cliente</a>
		</li>
	</ul>
	<br>
	<div class="conteeiner" align="center">
		<h1>Cadastro Cliente</h1>

		<form method="post" action="Cliente">
			<label>Nome: <input type="text" name="nome"
				class="form-control" placeholder="Nome" required><br> <label>RG:</label>
				<input type="number" name="rg" placeholder="rg" id="rg"> <input
				type="number" name="digito" placeholder="digito"><br> <br>
				<label>Telefone:</label> <input type="text" name="telefone"
				class="form-control" placeholder="Telefone"><br> <label>Data
					Nascimento:</label> <input type="date" name="nascimento"
				placeholder="ID Especialidade"><br> <label>Senha:</label>
				<input type="text" name="senha"
				placeholder="Senha (minimo 8 digitos e sendo 1 deles um numero)"><br>
				<button type="submit" class="btn btn-secondary"
					onclick="document.getElementById('acao').value='inserir'">Cadastrar</button>
				<button type="submit" class="btn btn-secondary"
					onclick="document.getElementById('acao').value='buscar'">Consultar</button>
				<button type="submit" class="btn btn-secondary"
					onclick="document.getElementById('acao').value='atualizar'">Atualizar</button>



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
									<th>data nascimento:</th>
									<th>senha:</th>

								</tr>
							</thead>
							<tbody>
								<c:forEach var="C" items="${Cliente}">
									<tr>
										<td>${C.idPessoa}</td>
										<td>${C.nome}</td>
										<td>${C.rg}</td>
										<td>${C.digitoRg}</td>
										<td>${C.telefone}</td>
										<td>${C.dataNascimento}</td>
										<td>${C.senha}</td>
									</tr>
								</c:forEach>
							</tbody>
						</table>
					</c:if>
				</div>
</body>
</html>