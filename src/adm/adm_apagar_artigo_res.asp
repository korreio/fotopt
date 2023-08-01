<!-- #include file="inicio_basedados.asp" -->

<%
ordem = request("ordem")
artigo = request("artigo")
apagar = request("apagar")
%>

<!-- #include file="topo.asp" -->
<td bgcolor="gray" width="100%" align="left"><font size="-1" color="black" face="arial">&nbsp;APAGAR ARTIGO PARA OPINI&Atilde;O</font></td>
<!-- #include file="fim_topo.asp" -->
<!-- #include file="autenticar_webmaster.asp" -->

<%
if apagar = "on" then
	SQL = "DELETE FROM opiniao WHERE artigo = " & artigo
	dbConnection.Execute(SQL)

	SQL = "DELETE FROM opiniao_artigo WHERE id = " & artigo
	dbConnection.Execute(SQL)
%>
	<meta http-equiv="refresh" content="0;url=../opiniao_temas.asp?ordem=<% =ordem %>">
	<font size="+1" color="white" face="arial"><b>Artigo opini&atilde;o apagado com sucesso</b></font>
<% else %>
	<font size="+1" color="white" face="arial">Para apagar tem que confirmar na &quot;check box&quot;</font>
	<br>
	<font size="+1" color="white" face="arial">prima o botao <b>back</b> no browser e corrija</font>	
<% end if %>

<!-- #include file="fim_autenticacao.asp" -->
<!-- #include file="fim_basedados.asp" -->