<!-- #include file="inicio_basedados.asp" -->

<%
votacao = request("votacao")
%>

<!-- #include file="topo.asp" -->
<td bgcolor="gray" width="100%" align="left"><font size="-1" color="black" face="arial">&nbsp;APROVAR VOTAÇÃO</font></td>
<!-- #include file="fim_topo.asp" -->
<!-- #include file="autenticar_webmaster.asp" -->

<%
SQL = "UPDATE votacao_topico SET mostrar = 1, data = '" & date() & " " & time() & "' WHERE id = " & votacao
dbConnection.Execute(SQL)
%>

<meta http-equiv="refresh" content="0;url=../votacoes.asp">
<font size="+1" color="white" face="arial"><b>Votação aprovada com sucesso</b></font>

<!-- #include file="fim_autenticacao.asp" -->
<!-- #include file="fim_basedados.asp" -->
