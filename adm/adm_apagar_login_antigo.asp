<!-- #include file="inicio_basedados.asp" -->

<%
letra = request("letra")
Server.ScriptTimeOut = 999999 
%>

<!-- #include file="topo.asp" -->
<td bgcolor="gray" width="100%" align="left"><font size="-1" color="black" face="arial">&nbsp;APAGAR MEMBROS ANTIGOS</font></td>
<!-- #include file="fim_topo.asp" -->
<!-- #include file="autenticar_webmaster.asp" -->

<%
ha_3meses = date() - (31 * 3)
SQL = "SELECT * FROM autor WHERE (ultima_data < #" & ha_3meses & "# or ultima_data is null) AND (data_anterior < #" & ha_3meses & "# or data_anterior is null) ORDER BY id"
Set autorRes = dbConnection.Execute(SQL)

do while not autorRes.eof
	SQL = "SELECT count(*) AS num FROM foto WHERE autor = " & autorRes("id")
	Set fotoRes = dbConnection.Execute(SQL)

	if fotoRes("num") < 15 then
		autor = autorRes("id")
%>
		<!-- #include file="adm_apagar_autor.asp" -->
<%
	end if
	autorRes.MoveNext
loop
%>

<meta http-equiv="refresh" content="0;url=adm_login_antigo.asp">
<font size="+1" color="white" face="arial"><b>Membros apagados</b></font>

<!-- #include file="fim_autenticacao.asp" -->
<!-- #include file="fim_basedados.asp" -->

<% 
sub ApagaSubMensagens(id, assunto) 
	SQL = "SELECT id, assunto FROM debate_mensagem WHERE subid = " & id & " AND autor <> " & autor
	Set subRes = dbConnection.Execute(SQL)

	do while not subRes.eof
		ApagaSubMensagens subRes("id"), subRes("assunto")
		subRes.MoveNext
	loop

	SQL = "DELETE FROM debate_mensagem WHERE id = " & id
	dbConnection.Execute(SQL)
end sub
%>