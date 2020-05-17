<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.Base64" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt" %>

<c:set var="contextPath" value="${pageContext.request.contextPath}"/>
<% request.setAttribute("isAdmin", request.isUserInRole("ADMIN")); %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Apteka Dorowski</title>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css">
    <link href="${contextPath}/resources/css/style.css" rel="stylesheet">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
</head>
<body>
<div class="header">
    <h1>Apteka Dorowski</h1>
</div>

<nav class="navbar navbar-dark navbar-toggler-right">
    <div class="container">

        <a class="nav-link scroll-link" href="${contextPath}/">Strona główna</a>
        <a class="nav-link scroll-link" href="${contextPath}/offer">Oferta</a>
        <a class="nav-link scroll-link" href="${contextPath}/contact">Kontakt</a>
        <c:if test="${pageContext.request.userPrincipal.name == null}">
            <div class="logreg">
                <a class="nav-link" data-toggle="modal" data-target="#modalLogin">Zaloguj się</a>
                <a class="nav-link" data-toggle="modal" data-target="#modalRegister">Rejestracja</a>
            </div>
        </c:if>
        <c:if test="${pageContext.request.userPrincipal.name != null}">
            <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarNav"
                    aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
                <span></span>
                <span></span>
                <span></span>
            </button>

            <div class="navbar-collapse collapse" id="navbarNav">
                <ul class="navbar-nav mr-auto">
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="${contextPath}/cart">Koszyk</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link active" href="${contextPath}/profile">Profil użytkowika</a>
                    </li>
                    <c:if test="${isAdmin}">
                        <li class="nav-item">

                            <a class="nav-link" href="${contextPath}/adminprofile">Panel administratora</a>
                        </li>
                    </c:if>
                    <li class="nav-item">

                        <form id="logoutForm" method="POST" action="${contextPath}/logout">
                        </form>
                        <a class="nav-link" onclick="document.forms['logoutForm'].submit()">Wyloguj się </a>
                    </li>
                </ul>
            </div>
        </c:if>
    </div>
</nav>
<h2>Profil użytkownika</h2><br>
<h2>Operacje</h2><br>
<button class="btn btn-danger"
        onclick="window.location.href='${contextPath}/deletebyname/${pageContext.request.userPrincipal.name}'">
    Usuń konto
</button>
<button class="btn btn-success" data-toggle="modal" data-target="#changePasswordModal">Zmień hasło</button><br>
<h2>Twoje zakupy</h2><br>
<table class="table table-hover">
    <thead class="thead-light">
    <tr>
        <th>Data</th>
        <th>Kwota</th>
    </tr>
    </thead>
    <tbody>
    <c:forEach items="${purchases}" var="p">
        <tr>
            <td>${p.date}</td>
            <td>${p.amount}</td>
        </tr>
    </c:forEach>
    </tbody>
</table>
<footer class="footer">
    <p>Autor: Bartosz Dorowski</p>
</footer>

<div class="modal fade" id="changePasswordModal">
    <div class="modal-dialog">
        <div class="modal-content">

            <!-- Modal Header -->
            <div class="modal-header">
                <h4 class="modal-title">Zmiana hasła</h4>
                <button type="button" class="close" data-dismiss="modal">&times;</button>
            </div>

            <!-- Modal body -->
            <div class="modal-body">
                <form method="POST" action="${contextPath}/changepassword" class="form-signin">

                    <input type="hidden" id="username" name="username" value="${pageContext.request.userPrincipal.name}"
                           required>

                    <div class="form-group ${error != null ? 'has-error' : ''}">
                        <label for="oldPassword">Stare hasło:</label>
                        <input type="password" class="form-control" id="oldPassword" placeholder="Podaj stare hasło"
                               name="oldPassword" required>
                    </div>
                    <div class="form-group">
                        <label for="newPassword">Hasło:</label>
                        <input type="password" minlength="8" class="form-control" id="newPassword"
                               placeholder="Podaj nowe hasło"
                               name="newPassword" required>
                    </div>
                    <div class="form-group">
                        <label for="passwordConfirm">Podaj ponownie nowe hasło:</label>
                        <input type="password" minlength="8" class="form-control" id="passwordConfirm"
                               placeholder="Podaj ponownie nowe haslo" name="passwordConfirm" required>
                        <div class="valid-feedback">Uzupełniono</div>
                        <div class="invalid-feedback">Proszę wypełnić pole</div>
                    </div>
                    <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>

                    <button class="btn btn-lg btn-dark btn-block" type="submit">Zmień hasło</button>

                </form>
            </div>
            <!-- Modal footer -->
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-dismiss="modal">Zamknij</button>
            </div>

        </div>
    </div>
</div>
</body>
</html>