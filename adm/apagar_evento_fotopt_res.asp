<!-- #include file="inicio_basedados.asp" -->

<%
evento = request("evento")
apagar = request("apagar")
%>

<!-- #include file="topo.asp" -->
<td bgcolor="gray" width="100%" align="left"><font size="-1" color="black" face="arial">&nbsp;APAGAR EVENTO FOTOPT</font></td>
<!-- #include file="fim_topo.asp" -->
<!-- #include file="autenticar_webmaster.asp" -->

<%
if apagar = "on" then
	SQL = "DELETE FROM eventos_fotopt_foto WHERE evento_fotopt = " & evento
	dbConnection.Execute(SQL)

	SQL = "DELETE FROM eventos_fotopt WHERE id = " & evento
	dbConnection.Execute(SQL)
%>
	<meta http-equiv="refresh" content="0;url=../eventos_fotopt.asp">
	<font size="+1" color="white" face="arial"><b>Evento fotopt apagado com sucesso</b></font>
<% else %>
	<font size="+1" color="white" face="arial">Para apagar tem que confirmar na &quot;check box&quot;</font>
	<br>
	<font size="+1" color="white" face="arial">prima o botao <b>back</b> no browser e corrija</font>	
<% end if %>

<!-- #include file="fim_autenticacao.asp" -->
<!-- #include file="fim_basedados.asp" -->