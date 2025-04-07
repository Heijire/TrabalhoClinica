<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Clinica</title>
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
<div class="container text-center">
		<h1>Tela Clínica</h1>
		<br>
		<div class="btn-group" role="group" aria-label="Basic outlined example">
			<button type="button" class="btn btn-outline-primary" onclick="window.location.href='Medico.jsp'">Médico</button>
			<button type="button" class="btn btn-outline-primary" onclick="window.location.href='Especialidade.jsp'">Especialidade</button>
			<button type="button" class="btn btn-outline-primary" onclick="window.location.href='material.jsp'">Material</button>
		</div>
	</div>
</body>
</html>