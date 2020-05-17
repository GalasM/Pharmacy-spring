<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

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
            <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
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

<h2>Dodaj produkt:</h2>


<form method="POST" action="${contextPath}/addproduct" enctype="multipart/form-data" modelAttribute="product">
    <table style="text-align:left;">
        <tr>
            <td>
                <form:hidden path="product.id"/>
            </td>
        </tr>
        <tr>
            <td>
                <label for="name">
                Nazwa *
            <form:input class="form-control mb-2 mr-sm-2" type="text" id="name" placeholder="Podaj nazwę"
                            name="name" path="product.name" required="true"/>
                </label>
            </td>
        </tr>

        <tr>
            <td>
            <label for="price">
                Cena *
            <form:input class="form-control mb-2 mr-sm-2" type="number" id="price" placeholder="Podaj cene"
                            name="price" path="product.price" required="true"/>
            </label>
            </td>
        </tr>
        <tr>
            <td>
                <label for="type">
                    Typ *
                    <form:input class="form-control mb-2 mr-sm-2" type="text" id="type" placeholder="Podaj rodzaj leku"
                                name="type" path="product.type" required="true"/>
                </label>
            </td>
        </tr>
        <tr>
            <td>
                <label for="photo">
                    Dodaj zdjęcie
                    <form:input type="file" accept="image/*" id="photo" name="photo" path="product.photo"/>
                </label>
            </td>
        </tr>
        <tr>
            <td><input class="btn btn-primary" type="submit" value="Zatwierdź"/></td>
        </tr>
    </table>
</form>


<footer class="footer">
    <p>Autor: Bartosz Dorowski</p>
</footer>

</body>
</html>