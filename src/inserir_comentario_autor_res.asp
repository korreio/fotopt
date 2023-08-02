<%
' Copyright: (c) 1999-2023, Tiago Fonseca
' GNU General Public License v3.0+ (see LICENSE.md or https://www.gnu.org/licenses/gpl-3.0.html)
' SPDX-License-Identifier: GPL-3.0-or-later
%>

<!-- #include file="sqltext.asp" -->
<!-- #include file="funcoes_principais.asp" -->

<% AutenticarMembro(autor) %>

<%
autor = request("autor")
primeira = request("primeira")
tema = request("tema")
comentario = SqlTextMemo(left(request("comentario"), 1200))

SQL = "SELECT * FROM comentario_autor WHERE autor = " & autor & " AND comentador = " & session("login")
Set comentarioRes = dbConnection.Execute(SQL)

if comentarioRes.eof then
	if comentario <> "" then
		SQL = "INSERT INTO comentario_autor (comentario, autor, comentador, data, moderar) VALUES "
		SQL = SQL & "('" & comentario & "','" & autor & "','" & session("login") & "','" & date() & " " & time() & "', '1')"
		dbConnection.Execute(SQL)
	else
		Menu 3, 2, "COMENTAR AUTOR"
%>
		<font size="+1" color="white" face="arial">O campo <b>coment&aacute;rio</b> &eacute; obrigat&oacute;rio</font>
		<br>
		<font size="+1" color="white" face="arial">prima o botao <b>back</b> no browser e complete a informa&ccedil;&atilde;o</font>	
<%
	end if
else
	if comentario <> "" then
		SQL = "UPDATE comentario_autor SET comentario = '" & comentario
		SQL = SQL & "', data = '" & date() & " " & time()
		SQL = SQL & "', moderar = '1' "
		SQL = SQL & "WHERE id = " & comentarioRes("id")
		dbConnection.Execute(SQL)
	else
		SQL = "DELETE FROM comentario_autor WHERE id = " & comentarioRes("id")
		dbConnection.Execute(SQL)
	end if
end if		

if (not comentarioRes.eof) or (comentario <> "") then
	ComRefresh "comentarios_autor.asp?primeira=" & primeira & "&id=" & autor & "&tema=" & tema
	Menu 3, 2, "COMENTAR AUTOR"
%>
	<font size="+1" color="white" face="arial"><b>Coment&aacute;rio inserido com sucesso</b></font>
<% end if %>
	
<% FimPagina() %>
