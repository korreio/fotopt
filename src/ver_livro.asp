<%
' Copyright: (c) 1999-2023, Tiago Fonseca
' GNU General Public License v3.0+ (see LICENSE.md or https://www.gnu.org/licenses/gpl-3.0.html)
' SPDX-License-Identifier: GPL-3.0-or-later
%>

<!-- #include file="sqltext.asp" -->
<!-- #include file="funcoes_principais.asp" -->

<%
livro = request("livro")

SQL = "SELECT * FROM livros WHERE id = " & livro
Set livroRes = dbConnection.Execute(SQL)

SQL = "SELECT id, nome FROM autor WHERE id = " & livroRes("autor")
Set autorRes = dbConnection.Execute(SQL)

SQL = "SELECT nome FROM livros_tipo WHERE id = " & livroRes("tipo")
Set tipoRes = dbConnection.Execute(SQL)
%>

<% 
OpcaoMenu "ALTERAR DADOS OU APAGAR LIVRO", "mudar_livro.asp?livro=" & livro, False, True, livroRes("autor"), False, False
Menu 4, 2, "LIVRO " & livroRes("nome")
%>

<table border="1" cellpadding="5" cellspacing="0">
	<tr><td><font size="-1" color="#FFCC66" face="arial"><b>TIPO: </b></font></td><td><font size="-1" color="white" face="arial"><% =tipoRes("nome") %></font></td></tr>
	<tr><td height="5" colspan="2"><font size="-2" color="white" face="arial">&nbsp;</font></td></tr>		
	<% if livroRes("autores") <> "" then %>
		<tr><td><font size="-1" color="#FFCC66" face="arial"><b>AUTOR(ES): </b></font></td><td><font size="-1" color="white" face="arial"><% =livroRes("autores") %></font></td></tr>
	<% end if %>
	<% if livroRes("editora") <> "" then %>	
		<tr><td><font size="-1" color="#FFCC66" face="arial"><b>EDITORA: </b></font></td><td><font size="-1" color="white" face="arial"><% =livroRes("editora") %></font></td></tr>	
	<% end if %>
	<% if livroRes("isbn") <> "" then %>	
		<tr><td><font size="-1" color="#FFCC66" face="arial"><b>ISBN: </b></font></td><td><font size="-1" color="white" face="arial"><% =livroRes("isbn") %></font></td></tr>	
	<% end if %>
	<tr><td height="5" colspan="2"><font size="-2" color="white" face="arial">&nbsp;</font></td></tr>		
	<% if livroRes("descricao") <> "" then %>
		<tr><td><font size="-1" color="#FFCC66" face="arial"><b>DESCRI&Ccedil;&Atilde;O: </b></font></td><td><font size="-1" color="white" face="arial"><% =livroRes("descricao") %></font></td></tr>
	<% end if %>
	<% if livroRes("comentario") <> "" then %>	
		<tr><td><font size="-1" color="#FFCC66" face="arial"><b>COMENT&Aacute;RIOS: </b></font></td><td><font size="-1" color="white" face="arial"><% =livroRes("comentario") %></font></td></tr>	
	<% end if %>
	<tr><td height="5" colspan="2"><font size="-2" color="white" face="arial">&nbsp;</font></td></tr>		
	<tr><td><font size="-1" color="#FFCC66" face="arial"><b>INSERIDO POR: </b></font></td><td><font size="-1" color="white" face="arial"><% =autorRes("nome") %> a <% =day(livroRes("data")) %>/<% =month(livroRes("data")) %>/<% =year(livroRes("data")) %></font></td></tr>	
</table>

<% FimPagina() %>
