<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Cliente Menu</title>
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
		<li class="nav-item"><a class="nav-link" href="indexclinica.jsp">Cinica</a></li>
		<li class="nav-item"><a class="nav-link" href="indexcliente.jsp">Cliente</a>
		<li class="nav-item"><a class="nav-link" href="consulta.jsp">Logado</a></li>
        <li class="nav-item"><a class="nav-link" href="consulta.jsp">Logado</a></li>
        
		</li>
	</ul>
	<br />
	<div class="container text-center">
		<h1>Tela Cliente</h1>
		<br>
		<div class="btn-group" role="group" aria-label="Basic outlined example">
			<button type="button" class="btn btn-outline-primary" onclick="window.location.href='cliente.jsp'">Cadastrar cliente</button>
			<button type="button" class="btn btn-outline-primary" onclick="window.location.href='login.jsp'">Consultas</button>
		</div>
	</div>

</body>
</html>