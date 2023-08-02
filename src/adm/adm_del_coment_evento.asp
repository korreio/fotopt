<%
' Copyright: (c) 1999-2023, Tiago Fonseca
' GNU General Public License v3.0+ (see LICENSE.md or https://www.gnu.org/licenses/gpl-3.0.html)
' SPDX-License-Identifier: GPL-3.0-or-later
%>

<!-- #include file="topo.asp" -->
<td bgcolor="gray" width="100%" align="left"><font size="-1" color="black" face="arial">&nbsp;APAGAR COMENT&Aacute;RIO</font></td>
<!-- #include file="fim_topo.asp" -->
<!-- #include file="autenticar_webmaster.asp" -->
<!-- #include file="inicio_basedados.asp" -->

<%
comentario = request("comentario")

' Dados galeria
primeira = request("primeira")
evento = request("evento")
num = request("num")

SQL = "SELECT * FROM eventos_fotopt_comentarios WHERE id = " & comentario
Set comentarioRes = dbConnection.Execute(SQL)

SQL = "SELECT id FROM eventos_fotopt_foto WHERE id = " & comentarioRes("foto")
Set fotoRes = dbConnection.Execute(SQL)

SQL = "DELETE FROM eventos_fotopt_comentarios WHERE id = " & comentario
dbConnection.Execute(SQL)
%>

<meta http-equiv="refresh" content="0;url=../comentarios_evento.asp?foto=<% =fotoRes("id") %>&primeira=<% =primeira %>&evento=<% =evento %>&num=<% =num %>">
<font size="+1" color="white" face="arial"><b>Comet&aacute;rio apagado com sucesso</b></font>

<!-- #include file="fim_autenticacao.asp" -->
<!-- #include file="fim_basedados.asp" -->