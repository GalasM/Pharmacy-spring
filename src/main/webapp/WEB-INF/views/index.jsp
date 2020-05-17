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
    <script>
        <c:if test="${pageContext.request.getAttribute('login') eq 'login'}">
        $(document).ready(function(){
            $("#modalLogin").modal('show');
        });
        </c:if>
    </script>
</head>
<body>
<div class="header">
    <h1>Apteka Dorowski</h1>
</div>


<nav class="navbar navbar-dark navbar-toggler-right">
    <div class="container">

        <a class="nav-link scroll-link active" href="${contextPath}/">Strona główna</a>
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

    <%--<div class="topnav">
        <a class="active" href="#home">Strona główna</a>
        <a href="${contextPath}/offer">Oferta</a>
        <a href="#contact">Contact</a>
        <c:if test="${pageContext.request.userPrincipal.name != null}">
            <form id="logoutForm" method="POST" action="${contextPath}/logout">
            </form>
            <a style="float: right;" onclick="document.forms['logoutForm'].submit()">Wyloguj się </a>
            <a style="float: right;" href="${contextPath}/cart">Koszyk</a>
            <c:if test="${isAdmin}">
                <li><a style="float: right;" href="${contextPath}/adminprofile">Panel administratora</a></li>
            </c:if>
            <h6 style="float: right;">Zalogowany: <b>${pageContext.request.userPrincipal.name}</b></h6>
        </c:if>

        <c:if test="${pageContext.request.userPrincipal.name == null}">
            <div class="logreg">
                <a style="float: right;" data-toggle="modal" data-target="#modalLogin">Zaloguj się</a>
                <a style="float: right;" data-toggle="modal" data-target="#modalRegister">Rejestracja</a>
            </div>
        </c:if>
    </div>--%>

    <div class="content">
        <h2>Apteka internetowa Dorowski - Szybko i na najwyższym poziomie</h2>
        <p>Apteka internetowa to idealne rozwiązanie dla osób, które chcą kupić potrzebne leki bez konieczności wychodzenia z domu. W skład bogatej oferty wchodzą m.in. suplementy diety, leki bez recepty oraz wyroby medyczne, kosmetyki i sprzęt medyczny. Wszystkie produkty są starannie opisane, ze szczególnym uwzględnieniem składu, zaleceń i przeciwwskazań oraz sposobu dawkowania. W aptece internetowej Melissa znajdą Państwo również wiele pomysłów na prezent, próbki produktów oraz specjalnie przygotowane zestawy kosmetyków. Taki sposób zakupów przypadnie do gustu osobom zapracowanym i chorym, a także tym, którzy chcą dokładnie poznać ofertę dostępną na rynku. Zakupy w aptece on line to gwarancja wysokiej jakości. Dają one możliwość porównania cen leków w aptekach internetowych i wybór najlepiej dopasowanych produktów. Skompletowane zamówienia wysyłane są zwykle w przeciągu 24-48 godzin. Zapraszamy!</p>
    </div>

<footer class="footer">
    <p>Autor: Bartosz Dorowski</p>
</footer>


<div class="modal fade" id="modalLogin">
    <div class="modal-dialog">
        <div class="modal-content">

            <div class="modal-header">
                <h4 class="modal-title">Logowanie</h4>
                <button type="button" class="close" data-dismiss="modal">&times;</button>
            </div>

            <div class="modal-body">
                <c:if test="${pageContext.request.userPrincipal.name == null}">
                    <form method="POST" action="${contextPath}/login" class="form-signin">

                        <div class="form-group ${error != null ? 'has-error' : ''}">
                            <label for="username">Nazwa użytkownika:</label>
                            <input type="username" class="form-control" id="username"
                                   placeholder="Podaj nazwę użytkownika"
                                   name="username">
                        </div>
                        <div class="form-group">
                            <label for="password">Hasło:</label>
                            <input type="password" class="form-control" id="password" placeholder="Podaj hasło"
                                   name="password">
                        </div>
                        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>

                        <button class="btn btn-lg btn-primary btn-block" type="submit">Zaloguj się!</button>

                    </form>
                    <br/>
                </c:if>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-dismiss="modal">Zamknij</button>
            </div>

        </div>
    </div>
</div>


<div class="modal fade" id="modalRegister">
    <div class="modal-dialog">
        <div class="modal-content">

            <div class="modal-header">
                <h4 class="modal-title">Rejestracja</h4>
                <button type="button" class="close" data-dismiss="modal">&times;</button>
            </div>

            <div class="modal-body">

                <form action="${contextPath}/registration" method="POST">
                    <div class="form-group">
                        <label for="username">Nazwa użytkownika:</label>
                        <input type="text" minlength="6" class="form-control" id="RegisterUsername"
                               placeholder="Podaj nazwe uzytkownika"
                               name="username" required>
                        <div class="valid-feedback">Uzupełniono</div>
                        <div class="invalid-feedback">Proszę wypełnić pole</div>
                    </div>
                    <div class="form-group">
                        <label for="password">Haslo:</label>
                        <input type="password" minlength="8" class="form-control" id="registerPassword"
                               placeholder="Podaj haslo"
                               name="password" required>
                        <div class="valid-feedback">Uzupełniono</div>
                        <div class="invalid-feedback">Proszę wypełnić pole</div>
                    </div>
                    <div class="form-group">
                        <label for="passwordConfirm">Potwierdz hasło:</label>
                        <input type="password" minlength="8" class="form-control" id="passwordConfirm"
                               placeholder="Podaj ponownie haslo" name="passwordConfirm" required>
                        <div class="valid-feedback">Uzupełniono</div>
                        <div class="invalid-feedback">Proszę wypełnić pole</div>
                    </div>
                    <button type="submit" class="btn btn-primary">Zarejestruj</button>
                </form>
                <br/>
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