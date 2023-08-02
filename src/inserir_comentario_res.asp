<%
' Copyright: (c) 1999-2023, Tiago Fonseca
' GNU General Public License v3.0+ (see LICENSE.md or https://www.gnu.org/licenses/gpl-3.0.html)
' SPDX-License-Identifier: GPL-3.0-or-later
%>

<!-- #include file="sqltext.asp" -->
<!-- #include file="funcoes_principais.asp" -->

<%
autor = session("login")
foto = request("foto")
comentario = SqlTextMemo(left(request("comentario"), 1200))
onde = request("onde")

' Dados referentes a galeria
primeira = request("primeira")
tipo = request("tipo")
id = request("id")
tema = request("tema")
num = request("num")
%>

<% AutenticarMembro(autor) %>

<%
SQL = "SELECT * FROM comentario WHERE autor = " & autor & " AND foto = " & foto
Set comentarioRes = dbConnection.Execute(SQL)

if comentarioRes.eof then
	if comentario <> "" then
		SQL = "INSERT INTO comentario (comentario, foto, autor, data, moderar) VALUES "
		SQL = SQL & "('" & comentario & "','" & foto & "','" & autor & "','" & date() & " " & time() & "', '1')"
		dbConnection.Execute(SQL)
	else
		Menu 1, GaleriaSubSeccao(tipo, id), "INSERIR, ALTERAR OU APAGAR COMENT�RIO"
%>
		<font size="+1" color="white" face="arial">O campo <b>coment&aacute;rio</b> &eacute; obrigat&oacute;rio</font>
		<br>
		<font size="+1" color="white" face="arial">prima o botao <b>back</b> no browser e complete a informa&ccedil;&atilde;o</font>	
<%
	end if
else
	if comentario <> "" then
		SQL = "UPDATE comentario SET comentario = '" & comentario
		SQL = SQL & "', data = '" & date() & " " & time()
		SQL = SQL & "', moderar = '1' "
		SQL = SQL & "WHERE id = " & comentarioRes("id")
		dbConnection.Execute(SQL)
	else
		SQL = "DELETE FROM comentario WHERE id = " & comentarioRes("id")
		dbConnection.Execute(SQL)
	end if
end if		
%>

<%
if (not comentarioRes.eof) or (comentario <> "") then
	if session("ficha") = "com" then
		ComRefresh "foto.asp?foto=" & foto & "&primeira=" & primeira & "&tema=" & tema & "&tipo=" & tipo & "&id=" & id & "&num=" & num
	else
		ComRefresh "comentarios.asp?foto=" & foto & "&primeira=" & primeira & "&tema=" & tema & "&tipo=" & tipo & "&id=" & id & "&num=" & num
	end if
	Menu 1, GaleriaSubSeccao(tipo, id), "INSERIR, ALTERAR OU APAGAR COMENT�RIO"
%>
	<font size="+1" color="white" face="arial"><b>Coment&aacute;rio inserido com sucesso</b></font>
<% end if %>

<% FimPagina() %>
