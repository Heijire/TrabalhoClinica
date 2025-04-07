<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Especialidade</title>
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
		<li class="nav-item"><a class="nav-link active" href="index.jsp">Início</a></li>
		<li class="nav-item"><a class="nav-link" href="indexclinica.jsp">Clínica</a></li>
		<li class="nav-item"><a class="nav-link" href="indexcliente.jsp">Cliente</a></li>
	</ul>
	<br>

	<div class="container" align="center">
		<h1>CRUD Especialidade</h1>
		<form method="post" action="Especialidade">
			<label>Id:</label> <input type="number" name="id" placeholder="Id"
				class="form-control" required><br /> <label>Nome:</label> <input
				type="text" name="nome" placeholder="Nome" class="form-control"
				required><br /> <label>Valor:</label> <input type="number"
				step="0.01" name="base" placeholder="Valor Base"
				class="form-control" required><br /> <input type="hidden"
				name="acao" id="acao"><br />

			<!-- Botões -->
			<button type="submit" class="btn btn-secondary"
				onclick="document.getElementById('acao').value='inserir'">Cadastrar</button>
			<button type="submit" class="btn btn-secondary"
				onclick="document.getElementById('acao').value='buscar'">Consultar</button>
			<button type="submit" class="btn btn-secondary"
				onclick="document.getElementById('acao').value='atualizar'">Atualizar</button>
			<button type="submit" class="btn btn-secondary"
				onclick="document.getElementById('acao').value='excluir'">Excluir</button>
		</form>
	</div>
	<div class="container" align="center">
		<c:if test="${not empty Especialidade}">
			<table class="table table-dark table-striped-columns">
				<thead>
					<tr>
						<th>id</th>
						<th>Nome</th>
						<th>valor</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach var="C" items="${Especialidade}">
						<tr>
							<td>${C.idEspecialidade}</td>
							<td>${C.nomeEspecialidade}</td>
							<td>${C.valorBase}</td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
		</c:if>
	</div>








</body>
</html>
