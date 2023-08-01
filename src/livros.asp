<!-- #include file="funcoes_principais.asp" -->

<%
tipo = request("tipo")

if tipo <> "" then
	SQL = "SELECT * FROM livros_tipo WHERE id = " & tipo
	Set tipoRes = dbConnection.Execute(SQL)

	SQL = "SELECT * FROM livros WHERE tipo = " & tipo & " ORDER BY nome, autores"
	Set livrosRes = dbConnection.Execute(SQL)
else
	SQL = "SELECT * FROM livros ORDER BY nome, autores"
	Set livrosRes = dbConnection.Execute(SQL)
end if
%>

<%
OpcaoMenu "INSERIR LIVRO", "inserir_livro.asp", False, True, -1, False, False
if tipo <> "" then
	Menu 4, 2, "LIVROS - " & tipoRes("nome")
else
	Menu 4, 2, "TODOS OS LIVROS"
end if
%>

<table border="1" cellpadding="4" cellspacing="0">
<tr align="center">
	<td><font color="white" face="arial"><b>LIVRO</b></font></td>
	<td><font color="white" face="arial"><b>DESCRI&Ccedil;&Atilde;O</b></font></td>
	<td><font color="white" face="arial"><b>AUTOR(ES)</b></font></td>	
</tr>
<% 
do while not livrosRes.eof
%>
	<tr>
		<td><a href="ver_livro.asp?livro=<% =livrosRes("id") %>"><font color="#FFCC66" size="-1" face="arial"><b><% =livrosRes("nome") %></b></font></a></td>
		<td><font size="-1" color="white" face="arial"><% =livrosRes("descricao") %>&nbsp;</font></td>		
		<td><font size="-1" color="white" face="arial"><% =livrosRes("autores") %>&nbsp;</font></td>		
	</tr>
	<% livrosRes.MoveNext %>
<% Loop %>
</table>

<% FimPagina() %>
