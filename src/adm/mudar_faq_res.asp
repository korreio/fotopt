<!-- #include file="topo.asp" -->
<td bgcolor="gray" width="100%" align="left"><font size="-1" color="black" face="arial">&nbsp;MUDAR FAQ</font></td>
<!-- #include file="fim_topo.asp" -->
<!-- #include file="autenticar_webmaster.asp" -->
<!-- #include file="../sqltext.asp" -->
<!-- #include file="inicio_basedados.asp" -->

<%
faq = request("faq")
tipo = request("tipo")
pergunta = SqlText(request("pergunta"))
resposta = SqlTextMemo(request("resposta"))

if (pergunta = "") or (resposta = "") then
%>
	<font size="+1" color="white" face="arial">Os campos <b>pergunta</b> e <b>resposta</b> s&atilde;o obrigat&oacute;rios</font>
	<br>
	<font size="+1" color="white" face="arial">prima o botao <b>back</b> no browser e complete a informa&ccedil;&atilde;o</font>	
<%
else
	SQL = "UPDATE faq SET "
	SQL = SQL & "pergunta = '" & pergunta & "',"
	SQL = SQL & "resposta = '" & resposta & "',"
	SQL = SQL & "tipo = '" & tipo & "'"
	SQL = SQL & "WHERE id = " & faq
	dbConnection.Execute(SQL)
%>
	<meta http-equiv="refresh" content="0;url=../ver_faq.asp?faq=<% =faq %>">
	<font size="+1" color="white" face="arial"><b>Faq mudado com sucesso</b></font>
<% end if %>

<!-- #include file="fim_autenticacao.asp" -->
<!-- #include file="fim_basedados.asp" -->