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
                        <a class="nav-link" href="${contextPath}/profile">Profil użytkowika</a>
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
<c:if test="${deleteproduct eq true}">
    <div class="alert alert-success">Produkt został usunięty!</div>
</c:if>
<c:if test="${productinstock eq true}">
    <div class="alert alert-danger">Ilość sztuk tego produktu w magazynie jest większa od 0!</div>
</c:if>
<c:if test="${order eq true}">
    <div class="alert alert-success">Zamówiona ilość produktu została dodana do magazynu!</div>
</c:if>

<h2>Produkty w magazynie:</h2>

<table class="table table-hover">
    <thead class="thead-light">
    <tr>
        <th>Nazwa</th>
        <th>Ilość sztuk w magazynie</th>
        <th>Operacje</th>
    </tr>
    </thead>
    <tbody>
    <c:forEach items="${products}" var="product">
        <tr>
            <td>
                    <h4>${product.medicament.name}</h4>
            </td>
            <td>
                <h4>${product.quantity}</h4>
            </td>
            <td>
                <button style="margin: 3px 0px 3px 0px" class="btn btn-success" onclick="window.location.href='/orderform/'+${product.medicament.id}">Zamów</button>
                <form action="${contextPath}/editproduct/${product.medicament.id}" method="post">
                    <button style="margin: 3px 0px 3px 0px" class="btn btn-danger" type="submit">Edytuj</button>
                </form>
                <button style="margin: 3px 0px 3px 0px" class="btn btn-danger" onclick="window.location.href='/deleteFromStock/'+${product.medicament.id}">Usuń</button>
            </td>
        </tr>
    </c:forEach>
    </tbody>
</table>


<footer class="footer">
    <p>Autor: Bartosz Dorowski</p>
</footer>
</body>
</html>