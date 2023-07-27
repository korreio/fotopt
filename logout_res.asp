<!-- #include file="funcoes_principais.asp" -->

<%
session("login") = 0 
ComRefresh "login.asp"
Menu 3, 1, "LOGOUT" 
%>

<font size="+1" color="white" face="arial"><b>Logout realizado com sucesso.</b></font>

<% FimPagina() %>
