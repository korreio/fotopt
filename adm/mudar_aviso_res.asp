<!-- #include file="topo.asp" -->
<td bgcolor="gray" width="100%" align="left"><font size="-1" color="black" face="arial">&nbsp;MUDAR MENSAGEM</font></td>
<!-- #include file="fim_topo.asp" -->
<!-- #include file="autenticar_webmaster.asp" -->
<!-- #include file="../sqltext.asp" -->
<!-- #include file="inicio_basedados.asp" -->

<%
id = request("id")
mensagem = SqlTextMemo(request("mensagem"))

if (mensagem = "") then
%>
	<font size="+1" color="white" face="arial">O campo <b>mensagem</b> &eacute; obrigat&oacute;rio</font>
	<br>
	<font size="+1" color="white" face="arial">prima o botao <b>back</b> no browser e complete a informa&ccedil;&atilde;o</font>	
<%
else
	SQL = "UPDATE avisos_webmaster SET texto = '" & mensagem & "' WHERE id = " & id
	dbConnection.Execute(SQL)
%>
	<meta http-equiv="refresh" content="0;url=adm_avisos.asp">
	<font size="+1" color="white" face="arial"><b>Mensagem alterada com sucesso</b></font>
<% end if %>

<!-- #include file="fim_autenticacao.asp" -->
<!-- #include file="fim_basedados.asp" -->