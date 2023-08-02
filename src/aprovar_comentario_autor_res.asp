<%
' Copyright: (c) 1999-2023, Tiago Fonseca
' GNU General Public License v3.0+ (see LICENSE.md or https://www.gnu.org/licenses/gpl-3.0.html)
' SPDX-License-Identifier: GPL-3.0-or-later
%>

<!-- #include file="funcoes_principais.asp" -->

<%
comentario = clng(request("comentario"))

' Dados galeria
primeira = request("primeira")
tipo = request("tipo")
id = request("id")
tema = request("tema")
num = request("num")
autor = request("autor")
%>

<% AutenticarMembro(autor) %>

<%
if comentario = -1 then
	SQL = "UPDATE comentario_autor SET moderar = '0'"
	SQL = SQL & "WHERE autor = " & autor
	dbConnection.Execute(SQL)
else
	SQL = "UPDATE comentario_autor SET moderar = '0'"
	SQL = SQL & "WHERE id = " & comentario
	dbConnection.Execute(SQL)
end if

ComRefresh "comentarios_autor.asp?id=" & autor & "&primeira=" & primeira & "&tema=" & tema & "&tipo=" & tipo & "&id=" & id & "&num=" & num
Menu 3, 2, "APROVAR COMENT�RIO AUTOR"
%>

<font size="+1" color="white" face="arial"><b>Coment�rio aprovado com sucesso</b></font>

<% FimPagina() %>
