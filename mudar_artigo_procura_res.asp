<!-- #include file="sqltext.asp" -->
<!-- #include file="funcoes_principais.asp" -->

<%
artigo = request("artigo")

SQL = "SELECT * FROM procura_artigo WHERE id = " & artigo
Set artigoRes = dbConnection.Execute(SQL)

autor = artigoRes("autor")
%>

<% AutenticarMembro(autor) %>

<%
tipo = request("tipo")
nome = SqlText(request("nome"))
observacoes = SqlText(request("observacoes"))
if observacoes = "" then
	observacoes = "-1"
end if

if nome = "" then
	Menu 6, 2, "MUDAR ARTIGO PROCURADO"
%>
	<font size="+1" color="white" face="arial">O campo <b>nome</b> &eacute; obrigat&oacute;rio</font>
	<br>
	<font size="+1" color="white" face="arial">prima o botao <b>back</b> no browser e complete a informa&ccedil;&atilde;o</font>	
<%
else
	SQL = "UPDATE procura_artigo SET "
	SQL = SQL & "nome = '" & nome & "',"
	SQL = SQL & "tipo = '" & tipo & "',"	
	SQL = SQL & "observacoes = '" & observacoes & "' "
	SQL = SQL & "WHERE id = " & artigo
	dbConnection.Execute(SQL)

	ComRefresh "procura_artigo.asp?artigo=" & artigo
	Menu 6, 2, "MUDAR ARTIGO PROCURADO"
%>
	<font size="+1" color="white" face="arial"><b>Artigo mudado com sucesso.</b></font>
<% end if %>

<% FimPagina() %>
