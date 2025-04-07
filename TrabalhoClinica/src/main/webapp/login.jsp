<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Login</title>
<link
    href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.5/dist/css/bootstrap.min.css"
    rel="stylesheet">
</head>
<body>
    <!-- Navegação -->
    <ul class="nav justify-content-center bg-light p-2">
        <li class="nav-item"><a class="nav-link active" href="index.jsp">Início</a></li>
        <li class="nav-item"><a class="nav-link" href="indexclinica.jsp">Clínica</a></li>
        <li class="nav-item"><a class="nav-link" href="indexcliente.jsp">Cliente</a></li>
        <li class="nav-item"><a class="nav-link" href="consulta.jsp">Logado</a></li>
        
    </ul>

    <div class="container mt-5" style="max-width: 400px;">
        <h2 class="text-center">Tela de Login</h2>
        <form action="Login" method="post">
            <div class="mb-3">
                <label for="Rg" class="form-label">RG (sem dígito verificador):</label>
                <input type="number" id="Rg" name="Rg" class="form-control" placeholder="Digite seu RG" required>
            </div>
            <div class="mb-3">
                <label for="senha" class="form-label">Senha:</label>
                <input type="password" id="senha" name="senha" class="form-control" placeholder="Digite sua senha" required>
            </div>
            <button type="submit" class="btn btn-outline-info w-100">Logar</button>

            <c:if test="${not empty msg}">
                <div class="alert alert-danger mt-3">${msg}</div>
            </c:if>
        </form>
    </div>
</body>
</html>
