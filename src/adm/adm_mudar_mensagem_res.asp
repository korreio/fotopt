<!-- #include file="inicio_basedados.asp" -->

<%
mensagem = request("mensagem")
assunto = request("tipo")
%>

<!-- #include file="topo.asp" -->
<td bgcolor="gray" width="100%" align="left"><font size="-1" color="black" face="arial">&nbsp;MUDAR MENSAGEM</font></td>
<!-- #include file="fim_topo.asp" -->
<!-- #include file="autenticar_webmaster.asp" -->

<%
SQL = "UPDATE debate_mensagem SET assunto = '" & assunto & "' WHERE raiz = " & mensagem
dbConnection.Execute(SQL)

SQL = "UPDATE debate_mensagem SET assunto = '" & assunto & "' WHERE id = " & mensagem
dbConnection.Execute(SQL)
%>

<meta http-equiv="refresh" content="0;url=../ver_debates.asp?assunto=<% =assunto %>">
<font size="+1" color="white" face="arial"><b>Mensagem mudada com sucesso</b></font>

<!-- #include file="fim_autenticacao.asp" -->
<!-- #include file="fim_basedados.asp" -->
