<%
' Copyright: (c) 1999-2023, Tiago Fonseca
' GNU General Public License v3.0+ (see LICENSE.md or https://www.gnu.org/licenses/gpl-3.0.html)
' SPDX-License-Identifier: GPL-3.0-or-later
%>

<!-- #include file="funcoes_principais.asp" -->

<%
comentario = request("comentario")

SQL = "SELECT * FROM comentario_autor WHERE id = " & comentario
Set comentarioRes = dbConnection.Execute(SQL)

SQL = "SELECT id, nome FROM autor WHERE id = " & comentarioRes("autor")
Set autorRes = dbConnection.Execute(SQL)

' Dados referentes a galeria
primeira = request("primeira")
tipo = request("tipo")
id = request("id")
tema = request("tema")
num = request("num")
autor = request("autor")
%>

<%
AutenticarMembro(autor)
Menu 3, 2, "REMOVER COMENTARIO AUTOR"
%>

<font size="-1" color="white" face="arial">
Esta op&ccedil;&atilde;o serve para remover este coment�rio,<br>
depois de removido, n�o ser� possivel recuper�-lo.
</font>

<form action="apagar_comentario_autor_res.asp?comentario=<% =comentario %>&autor=<% =autor %>&primeira=<% =primeira %>&tema=<% =tema %>&tipo=<% =tipo %>&id=<% =id %>&num=<% =num %>" method=post>
<table border="0" cellpadding="3" cellspacing="0">
	<tr><td><font size="-1" color="#FFCC66" face="arial"><b>AUTOR DO<br>COMENT�RIO:</b> </font></td><td><font size="-1" color="white" face="arial"><% =autorRes("nome") %></font></td></tr>
	<tr><td></td><td><input type="Submit" value="Remover coment�rio"></td></tr>
</table>
</form>

<% FimPagina() %>
