<!-- #include file="funcoes_principais.asp" -->

<%
livro = request("livro")

SQL = "SELECT autor FROM livros WHERE id = " & livro
Set livroRes = dbConnection.Execute(SQL)

autor = livroRes("autor")
apagar = request("apagar")
%>

<% AutenticarMembro(autor) %>

<%
if apagar = "on" then
	SQL = "DELETE FROM livros WHERE id = " & livro
	dbConnection.Execute(SQL)

	ComRefresh "livros_tipo.asp"
	Menu 5, 2, "APAGAR LIVRO"
%>
	<font size="+1" color="white" face="arial"><b>Livro apagado com sucesso</b></font>
<%
else
	Menu 5, 2, "APAGAR LIVRO"
%>
	<font size="+1" color="white" face="arial">Para apagar tem que confirmar na &quot;check box&quot;</font>
	<br>
	<font size="+1" color="white" face="arial">prima o botao <b>back</b> no browser e corrija</font>	
<% end if %>

<% FimPagina() %>
