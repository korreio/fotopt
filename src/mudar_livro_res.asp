<%
' Copyright: (c) 1999-2023, Tiago Fonseca
' GNU General Public License v3.0+ (see LICENSE.md or https://www.gnu.org/licenses/gpl-3.0.html)
' SPDX-License-Identifier: GPL-3.0-or-later
%>

<!-- #include file="sqltext.asp" -->
<!-- #include file="funcoes_principais.asp" -->

<%
livro = request("livro")

SQL = "SELECT autor FROM livros WHERE id = " & livro
Set livroRes = dbConnection.Execute(SQL)

autor = livroRes("autor")
%>

<% AutenticarMembro(autor) %>

<%
tipo = request("tipo")
nome = SqlText(request("nome"))
isbn = SqlText(request("isbn"))
autores = SqlText(request("autores"))
editora = SqlText(request("editora"))
descricao = SqlText(request("descricao"))
comentario = SqlText(request("comentario"))

if (nome = "") or (descricao = "") then
	Menu 5, 2, "ALTERAR OU APAGAR LIVRO"
%>
	<font size="+1" color="white" face="arial">Os campos <b>nome</b> e <b>descri&ccedil;&atilde;o</b> s&atilde;o obrigat&oacute;rios</font>
	<br>
	<font size="+1" color="white" face="arial">prima o botao <b>back</b> no browser e complete a informa&ccedil;&atilde;o</font>	
<%
else
	SQL = "UPDATE livros SET "
	SQL = SQL & "nome = '" & nome & "',"
	SQL = SQL & "tipo = '" & tipo & "',"	
	SQL = SQL & "autores = '" & autores & "',"	
	SQL = SQL & "isbn = '" & isbn & "',"	
	SQL = SQL & "editora = '" & editora & "',"	
	SQL = SQL & "comentario = '" & comentario & "',"	
	SQL = SQL & "descricao = '" & descricao & "' "
	SQL = SQL & "WHERE id = " & livro
	dbConnection.Execute(SQL)

	ComRefresh "ver_livro.asp?livro=" & livro
	Menu 5, 2, "ALTERAR OU APAGAR LIVRO"
%>
	<font size="+1" color="white" face="arial"><b>Livro modificado com sucesso.</b></font>
<% end if %>

<% FimPagina() %>
