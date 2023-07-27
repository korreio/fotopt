<!-- #include file="funcoes_principais.asp" -->

<%
artigo = request("artigo")

SQL = "SELECT autor FROM venda_artigo WHERE id = " & artigo
Set artigoRes = dbConnection.Execute(SQL)

autor = artigoRes("autor")
apagar = request("apagar")
%>

<% AutenticarMembro(autor) %>

<%
if apagar = "on" then
	SQL = "DELETE FROM venda_artigo WHERE id = " & artigo
	dbConnection.Execute(SQL)

	ComRefresh "vendese.asp"
	Menu 6, 2, "APAGAR ARTIGO PARA VENDA"
%>
	<font size="+1" color="white" face="arial"><b>Artigo para venda apagado com sucesso</b></font>
<%
else
	Menu 6, 2, "APAGAR ARTIGO PARA VENDA"
%>
	<font size="+1" color="white" face="arial">Para apagar tem que confirmar na &quot;check box&quot;</font>
	<br>
	<font size="+1" color="white" face="arial">prima o botao <b>back</b> no browser e corrija</font>	
<% end if %>

<% FimPagina() %>
