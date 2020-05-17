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
        <a class="nav-link scroll-link active" href="${contextPath}/offer">Oferta</a>
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
<c:if test="${addproduct eq true}">
    <div class="alert alert-success">Dodano produkt do koszyka!</div>
</c:if>
    <h2>Dostępne leki</h2>
<a class="btn btn-outline-warning btn-sm" href="${contextPath}/offer/name">Sortuj alfabetycznie</a>
<a class="btn btn-outline-warning btn-sm" href="${contextPath}/offer/priceMin">Sortuj od najtańszego</a>
<a class="btn btn-outline-warning btn-sm" href="${contextPath}/offer/priceMax">Sortuj od najdroższego</a>
<a class="btn btn-outline-warning btn-sm" href="${contextPath}/offer/przeziebienie">Przeziębienie</a>
<a class="btn btn-outline-warning btn-sm" href="${contextPath}/offer/przeciwbolowe">Przeciwbólowe</a>
<a class="btn btn-outline-warning btn-sm" href="${contextPath}/offer/urazy">Urazy</a>
<a class="btn btn-outline-warning btn-sm" href="${contextPath}/offer/problemy trawienne">Problemy trawienne</a>
<div class="products">
<c:forEach items="${products}" var="product">
    <div class="product-preview-container">
        <ul>
            <li><img class="product-image" src="data:image/*;base64,${Base64.getEncoder().encodeToString(product.photo)}"/></li>
            <li>Nazwa: ${product.name}</li>
            <li>Cena: ${product.price} zł</li>
            <li>
                <form action="${contextPath}/addtocart/${product.id}" method="post">
                    <button class="btn btn-success" href="#" type="submit">Dodaj do koszyka</button>
                    <input type="number" min=1 max="${product.stock.quantity}" value="1" id="quantity" name="quantity">
                </form>
                </li>
            <c:if test="${isAdmin}">
                <li><form action="${contextPath}/editproduct/${product.id}" method="post">
                    <button class="btn btn-danger" type="submit">Edytuj</button>
                </form></li>
            </c:if>
        </ul>
    </div>

</c:forEach>
</div>



<footer class="footer">
    <p>Autor: Bartosz Dorowski</p>
</footer>
</body>
</html>