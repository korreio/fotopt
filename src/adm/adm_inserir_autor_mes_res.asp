<!-- #include file="topo.asp" -->
<td bgcolor="gray" width="100%" align="left"><font size="-1" color="black" face="arial">&nbsp;INSERIR AUTOR M&Ecirc;S</font></td>
<!-- #include file="fim_topo.asp" -->
<!-- #include file="autenticar_webmaster.asp" -->
<!-- #include file="../sqltext.asp" -->
<!-- #include file="inicio_basedados.asp" -->

<%
autor = SqlText(request("autor"))
mes = request("mes")
ano = request("ano")

if (autor = "") then
%>
	<font size="+1" color="white" face="arial">O campo <b>autor</b> &eacute; obrigat&oacute;rio</font>
	<br>
	<font size="+1" color="white" face="arial">prima o botao <b>back</b> no browser e complete a informa&ccedil;&atilde;o</font>	
<%
else
	SQL = "SELECT id FROM autor_mes WHERE mes = " & mes & " AND ano = " & ano
	Set autorRes = dbConnection.Execute(SQL)

	if autorRes.eof then
		SQL = "INSERT INTO autor_mes (autor, mes, ano) VALUES ('" & autor & "','" & mes & "','" & ano & "')"
		dbConnection.Execute(SQL)
	else
		SQL = "UPDATE autor_mes SET autor = '" & autor & "' WHERE id = " & autorRes("id")
		dbConnection.Execute(SQL)
	end if

	SQL = "DELETE FROM juri_autor_mes WHERE autor = " & autor
	dbConnection.Execute(SQL)

	SQL = "DELETE FROM juri_autor_mencao_honrosa WHERE autor = " & autor
	dbConnection.Execute(SQL)

	SQL = "DELETE FROM autor_mencao_honrosa WHERE autor = " & autor
	dbConnection.Execute(SQL)
%>
	<meta http-equiv="refresh" content="0;url=../destaque.asp?mes=<% =mes %>&ano=<% =ano %>">
	<font size="+1" color="white" face="arial"><b>Autor m&ecirc;s inserido com sucesso</b></font>
<% end if %>

<!-- #include file="fim_autenticacao.asp" -->
<!-- #include file="fim_basedados.asp" -->