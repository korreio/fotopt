<!-- #include file="topo.asp" -->
<td bgcolor="gray" width="100%" align="left"><font size="-1" color="black" face="arial">&nbsp;MUDAR VOTA&Ccedil;&Atilde;O</font></td>
<!-- #include file="fim_topo.asp" -->
<!-- #include file="autenticar_webmaster.asp" -->
<!-- #include file="../sqltext.asp" -->
<!-- #include file="inicio_basedados.asp" -->

<%
votacao = request("votacao")
antigo = request("antigo")
nome = SqlText(request("nome"))
descricao = SqlText(request("descricao"))

if (nome = "") or (descricao = "") then
%>
	<font size="+1" color="white" face="arial">Os campos <b>nome</b> e <b>descri&ccedil;&atilde;o</b> s&atilde;o obrigat&oacute;rios.</font>
	<br>
	<font size="+1" color="white" face="arial">prima o botao <b>back</b> no browser e complete a informa&ccedil;&atilde;o.</font>	
<%
else
	SQL = "UPDATE votacao_topico SET "
	SQL = SQL & "nome = '" & nome & "',"
	SQL = SQL & "descricao = '" & descricao & "',"
	SQL = SQL & "antigo = '" & antigo & "' "
	SQL = SQL & "WHERE id = " & votacao
	dbConnection.Execute(SQL)
%>
	<meta http-equiv="refresh" content="0;url=../votacoes.asp">
	<font size="+1" color="white" face="arial"><b>Vota&ccedil;&atilde;o mudada com sucesso</b></font>
<% end if %>

<!-- #include file="fim_autenticacao.asp" -->
<!-- #include file="fim_basedados.asp" -->