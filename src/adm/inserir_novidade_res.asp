<!-- #include file="topo.asp" -->
<td bgcolor="gray" width="100%" align="left"><font size="-1" color="black" face="arial">&nbsp;INSERIR NOVIDADE</font></td>
<!-- #include file="fim_topo.asp" -->
<!-- #include file="autenticar_webmaster.asp" -->
<!-- #include file="../sqltext.asp" -->
<!-- #include file="inicio_basedados.asp" -->

<%
novidade = SqlTextMemo(request("novidade"))

if (novidade = "") then
%>
	<font size="+1" color="white" face="arial">O campo <b>novidade</b> &eacute; obrigat&oacute;rio</font>
	<br>
	<font size="+1" color="white" face="arial">prima o botao <b>back</b> no browser e complete a informa&ccedil;&atilde;o</font>	
<%
else
	SQL = "INSERT INTO novidade (texto, data) VALUES "
	SQL = SQL & "('" & novidade & "','" & date() & " " & time() & "')"
	dbConnection.Execute(SQL)
%>
	<meta http-equiv="refresh" content="0;url=../novidades.asp">
	<font size="+1" color="white" face="arial"><b>Novidade inserida com sucesso</b></font>
<% end if %>

<!-- #include file="fim_autenticacao.asp" -->
<!-- #include file="fim_basedados.asp" -->