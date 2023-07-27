<!-- #include file="topo.asp" -->
<td bgcolor="gray" width="100%" align="left"><font size="-1" color="black" face="arial">&nbsp;MUDAR NOVIDADE</font></td>
<!-- #include file="fim_topo.asp" -->
<!-- #include file="autenticar_webmaster.asp" -->
<!-- #include file="../sqltext.asp" -->
<!-- #include file="inicio_basedados.asp" -->

<%
id = request("id")
novidade = SqlTextMemo(request("novidade"))

if (novidade = "") then
%>
	<font size="+1" color="white" face="arial">O campo <b>novidade</b> &eacute; obrigat&oacute;rio</font>
	<br>
	<font size="+1" color="white" face="arial">prima o botao <b>back</b> no browser e complete a informa&ccedil;&atilde;o</font>	
<%
else
	SQL = "UPDATE novidade SET texto = '" & novidade & "' WHERE id = " & id
	dbConnection.Execute(SQL)
%>
	<meta http-equiv="refresh" content="0;url=../novidades.asp">
	<font size="+1" color="white" face="arial"><b>Novidade alterada com sucesso</b></font>
<% end if %>

<!-- #include file="fim_autenticacao.asp" -->
<!-- #include file="fim_basedados.asp" -->