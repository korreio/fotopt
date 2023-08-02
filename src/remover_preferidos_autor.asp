<%
' Copyright: (c) 1999-2023, Tiago Fonseca
' GNU General Public License v3.0+ (see LICENSE.md or https://www.gnu.org/licenses/gpl-3.0.html)
' SPDX-License-Identifier: GPL-3.0-or-later
%>

<!-- #include file="funcoes_principais.asp" -->

<%
autor_preferido = request("autor_preferido")
autor = session("login")

SQL = "SELECT id, nome FROM autor WHERE id = " & autor_preferido
Set autorRes = dbConnection.Execute(SQL)
%>

<%
AutenticarMembro(autor)
Menu 3, 4, "REMOVER AUTOR DA MINHA LISTA DE PREFERIDOS"
%>

<font size="-1" color="white" face="arial">
Esta op&ccedil;&atilde;o serve para remover este autor da sua lista pessoal de autores preferidos.
</font>

<form action="remover_preferidos_autor_res.asp?autor_preferido=<% =autor_preferido %>" method=post>
<table border="0" cellpadding="3" cellspacing="0">
	<tr><td><font size="-1" color="#FFCC66" face="arial"><b>ID:</b> </font></td><td><font size="-1" color="white" face="arial"><% =autor_preferido %></font></td></tr>
	<tr><td><font size="-1" color="#FFCC66" face="arial"><b>NOME:</b> </font></td><td><font size="-1" color="white" face="arial"><% =autorRes("nome") %></font></td></tr>
	<tr><td></td><td><input type="Submit" value="Remover dos preferidos"></td></tr>
</table>
</form>

<% FimPagina() %>
