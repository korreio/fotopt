<!-- #include file="inicio_basedados.asp" -->
<% Server.ScriptTimeOut = 999999 %>

<!-- #include file="topo.asp" -->
<td bgcolor="gray" width="100%" align="left"><font size="-1" color="black" face="arial">&nbsp;ALTERAR NOMES</font></td>
<!-- #include file="fim_topo.asp" -->
<!-- #include file="autenticar_webmaster.asp" -->

<%
SQL = "SELECT * FROM autor WHERE nome_real <> nome_inscricao ORDER BY nome_inscricao"
Set autorRes = dbConnection.Execute(SQL)

do while not autorRes.eof
	if request("mudar" & autorRes("id")) = "on" then
		SQL = "UPDATE autor SET nome_inscricao = '" & autorRes("nome_real") & "' WHERE id = " & autorRes("id")
		dbConnection.Execute(SQL)
	end if

	if request("recusar" & autorRes("id")) = "on" then
		SQL = "UPDATE autor SET nome_real = '" & autorRes("nome_inscricao") & "' WHERE id = " & autorRes("id")
		dbConnection.Execute(SQL)
	end if

	autorRes.MoveNext
loop
%>

<meta http-equiv="refresh" content="0;url=adm_nome_real_alterado.asp">
<font size="+1" color="white" face="arial"><b>Nomes alterados</b></font>

<!-- #include file="fim_autenticacao.asp" -->
<!-- #include file="fim_basedados.asp" -->