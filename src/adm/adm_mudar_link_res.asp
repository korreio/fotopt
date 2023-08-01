<!-- #include file="topo.asp" -->
<td bgcolor="gray" width="100%" align="left"><font size="-1" color="black" face="arial">&nbsp;MUDAR LINK</font></td>
<!-- #include file="fim_topo.asp" -->
<!-- #include file="autenticar_webmaster.asp" -->
<!-- #include file="../sqltext.asp" -->
<!-- #include file="inicio_basedados.asp" -->

<%
tipo = request("tipo")
link = request("link")
nome = SqlText(request("nome"))
descricao = SqlText(request("descricao"))
linkid = request("linkid")

SQL = "SELECT id FROM links WHERE link = '" & link & "' AND id <> " & linkid
Set linkRes = dbConnection.Execute(SQL)

if not linkRes.eof then
%>
	<font size="+1" color="white" face="arial">Esse link j&aacute; existe neste site.</font>
<%
elseif (link = "") or (link = "http://") then
%>
	<font size="+1" color="white" face="arial">O campo <b>link</b> &eacute; obrigat&oacute;rio</font>
	<br>
	<font size="+1" color="white" face="arial">prima o botao <b>back</b> no browser e complete a informa&ccedil;&atilde;o</font>	
<%
else
	SQL = "UPDATE links SET "
	SQL = SQL & "nome = '" & nome & "',"
	SQL = SQL & "link = '" & link & "',"	
	SQL = SQL & "descricao = '" & descricao & "',"
	SQL = SQL & "tipo = '" & tipo & "' "
	SQL = SQL & "WHERE id = " & linkid
	dbConnection.Execute(SQL)
%>
	<meta http-equiv="refresh" content="0;url=../links.asp?tipo=<% =tipo %>">
	<font size="+1" color="white" face="arial"><b>Link mudado com sucesso</b></font>
<% end if %>

<!-- #include file="fim_autenticacao.asp" -->
<!-- #include file="fim_basedados.asp" -->