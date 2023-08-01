<!-- #include file="inicio_basedados.asp" -->

<%
votacao = request("votacao")
item = request("item")
apagar = request("apagar")
%>

<!-- #include file="topo.asp" -->
<td bgcolor="gray" width="100%" align="left"><font size="-1" color="black" face="arial">&nbsp;APAGAR ITEM</font></td>
<!-- #include file="fim_topo.asp" -->
<!-- #include file="autenticar_webmaster.asp" -->

<%
if apagar = "on" then
	SQL = "DELETE FROM votacao_voto WHERE item = " & item
	dbConnection.Execute(SQL)
		
	SQL = "DELETE FROM votacao_item WHERE id = " & item
	dbConnection.Execute(SQL)
%>
	<meta http-equiv="refresh" content="0;url=../votacao_items.asp?votacao=<% =votacao %>">
	<font size="+1" color="white" face="arial"><b>Item apagado com sucesso</b></font>
<% else %>
	<font size="+1" color="white" face="arial">Para apagar tem que confirmar na &quot;check box&quot;</font>
	<br>
	<font size="+1" color="white" face="arial">prima o botao <b>back</b> no browser e corrija</font>	
<% end if %>

<!-- #include file="fim_autenticacao.asp" -->
<!-- #include file="fim_basedados.asp" -->