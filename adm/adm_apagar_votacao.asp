<!-- #include file="inicio_basedados.asp" -->

<%
votacao = request("votacao")
apagar = request("apagar")
%>

<!-- #include file="topo.asp" -->
<td bgcolor="gray" width="100%" align="left"><font size="-1" color="black" face="arial">&nbsp;APAGAR VOTA&Ccedil;&Atilde;O</font></td>
<!-- #include file="fim_topo.asp" -->
<!-- #include file="autenticar_webmaster.asp" -->

<%
if apagar = "on" then
	SQL = "SELECT id FROM votacao_item WHERE topico = " & votacao
	Set itemsRes = dbConnection.Execute(SQL)
	
	do while not itemsRes.eof
		SQL = "DELETE FROM votacao_voto WHERE item = " & itemsRes("id")
		dbConnection.Execute(SQL)
		
		itemsRes.MoveNext
	loop

	SQL = "DELETE FROM votacao_item WHERE topico = " & votacao
	dbConnection.Execute(SQL)
	
	SQL = "DELETE FROM votacao_topico WHERE id = " & votacao
	dbConnection.Execute(SQL)
%>
	<meta http-equiv="refresh" content="0;url=../votacoes.asp">
	<font size="+1" color="white" face="arial"><b>Vota&ccedil;&atilde;o apagado com sucesso</b></font>
<% else %>
	<font size="+1" color="white" face="arial">Para apagar tem que confirmar na &quot;check box&quot;</font>
	<br>
	<font size="+1" color="white" face="arial">prima o botao <b>back</b> no browser e corrija</font>	
<% end if %>

<!-- #include file="fim_autenticacao.asp" -->
<!-- #include file="fim_basedados.asp" -->