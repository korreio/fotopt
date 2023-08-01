<!-- #include file="funcoes_principais.asp" -->
<% 
OpcaoMenu "INSERIR LIVRO", "inserir_livro.asp", False, True, -1, False, False
Menu 4, 2, "BIBLIOGRAFIA" 
%>

<%
SQL = "SELECT * FROM livros_tipo ORDER BY nome"
Set tipoLivrosRes = dbConnection.Execute(SQL)
%>

<table border="1" cellpadding="10" cellspacing="0">
<tr>
<td valign="top">
	<font color="white" face="arial"><a href="livros.asp"><b>LIVROS E REVISTAS</b></a></font><br>
	<% 
	do while not tipoLivrosRes.eof
	%>
		&nbsp;&nbsp;<a href="livros.asp?tipo=<% =tipoLivrosRes("id") %>"><font color="#FFCC66" size="-2" face="verdana, arial"><b><% =tipoLivrosRes("nome") %></b></font></a><br>
		<% tipoLivrosRes.MoveNext %>
	<% Loop %>
</td>
</tr>
</table>

<% FimPagina() %>
