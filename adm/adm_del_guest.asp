<!-- #include file="topo.asp" -->
<td bgcolor="gray" width="100%" align="left"><font size="-1" color="black" face="arial">&nbsp;APAGAR ASSINATURA</font></td>
<!-- #include file="fim_topo.asp" -->
<!-- #include file="autenticar_webmaster.asp" -->
<!-- #include file="inicio_basedados.asp" -->

<%
guest = request("guest")
pais = request("pais")

SQL = "DELETE FROM guestbook WHERE id = " & guest
dbConnection.Execute(SQL)
%>

<meta http-equiv="refresh" content="0;url=../ver_guestbook.asp?pais=<% =pais %>">
<font size="+1" color="white" face="arial"><b>Assinatura apagado com sucesso</b></font>

<!-- #include file="fim_autenticacao.asp" -->
<!-- #include file="fim_basedados.asp" -->