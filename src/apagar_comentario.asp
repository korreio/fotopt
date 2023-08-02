<%
' Copyright: (c) 1999-2023, Tiago Fonseca
' GNU General Public License v3.0+ (see LICENSE.md or https://www.gnu.org/licenses/gpl-3.0.html)
' SPDX-License-Identifier: GPL-3.0-or-later
%>

<!-- #include file="funcoes_principais.asp" -->

<%
comentario = request("comentario")

SQL = "SELECT * FROM comentario WHERE id = " & comentario
Set comentarioRes = dbConnection.Execute(SQL)

SQL = "SELECT * FROM foto WHERE id = " & comentarioRes("foto")
Set fotoRes = dbConnection.Execute(SQL)

SQL = "SELECT id, nome FROM autor WHERE id = " & comentarioRes("autor")
Set autorRes = dbConnection.Execute(SQL)

' Dados referentes a galeria
primeira = request("primeira")
tipo = request("tipo")
id = request("id")
tema = request("tema")
num = request("num")

autor = fotoRes("autor")
%>

<%
AutenticarMembro(autor)
Menu 1, GaleriaSubSeccao(tipo, id), "REMOVER COMENTARIO"
%>

<font size="-1" color="white" face="arial">
Esta op&ccedil;&atilde;o serve para remover este coment�rio feito � sua foto,<br>
depois de removido, n�o ser� possivel recuperar o coment�rio.
</font>

<form action="apagar_comentario_res.asp?comentario=<% =comentario %>&foto=<% =fotoRes("id") %>&primeira=<% =primeira %>&tema=<% =tema %>&tipo=<% =tipo %>&id=<% =id %>&num=<% =num %>" method=post>
<table border="0" cellpadding="3" cellspacing="0">
	<tr><td><font size="-1" color="#FFCC66" face="arial"><b>ID:</b> </font></td><td><font size="-1" color="white" face="arial"><% =fotoRes("id") %></font></td></tr>
	<% if fotoRes("titulo") <> "" then %>
		<tr><td><font size="-1" color="#FFCC66" face="arial"><b>T&Iacute;TULO:</b> </font></td><td><font size="-1" color="white" face="arial"><% =fotoRes("titulo") %></font></td></tr>
	<% else %>
		<tr><td><font size="-1" color="#FFCC66" face="arial"><b>T&Iacute;TULO:</b> </font></td><td><font size="-1" color="white" face="arial"><i>sem t&iacute;tulo</i></font></td></tr>
	<% end if %>
	<tr><td><font size="-1" color="#FFCC66" face="arial"><b>AUTOR:</b> </font></td><td><font size="-1" color="white" face="arial"><% =autorRes("nome") %></font></td></tr>
	<tr><td></td><td><input type="Submit" value="Remover coment�rio"></td></tr>
</table>
</form>

<% FimPagina() %>
