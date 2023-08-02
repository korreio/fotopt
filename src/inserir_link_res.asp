<%
' Copyright: (c) 1999-2023, Tiago Fonseca
' GNU General Public License v3.0+ (see LICENSE.md or https://www.gnu.org/licenses/gpl-3.0.html)
' SPDX-License-Identifier: GPL-3.0-or-later
%>

<!-- #include file="sqltext.asp" -->
<!-- #include file="funcoes_principais.asp" -->

<% AutenticarMembro(autor) %>

<%
tipo = request("tipo")
link = request("link")
nome = SqlText(request("nome"))
descricao = SqlText(request("descricao"))

SQL = "SELECT id FROM links WHERE link = '" & link & "'"
Set linkRes = dbConnection.Execute(SQL)

if not linkRes.eof then
	Menu 5, 3, "INSERIR LINK"
%>
	<font size="+1" color="white" face="arial">Esse link j&aacute; existe neste site.</font>
<%
elseif (link = "") or (link = "http://") then
	Menu 5, 3, "INSERIR LINK"
%>
	<font size="+1" color="white" face="arial">O campo <b>link</b> &eacute; obrigat&oacute;rio</font>
	<br>
	<font size="+1" color="white" face="arial">prima o botao <b>back</b> no browser e complete a informa&ccedil;&atilde;o</font>	
<%
else
	SQL = "INSERT INTO links (nome, link, descricao, autor, data, tipo)"
	SQL = SQL & " VALUES ('" & nome & "','" & link & "','" & descricao
	SQL = SQL & "','" & session("login") & "','" & date() & " " & time() & "','" & tipo & "')"
	dbConnection.Execute(SQL)

	ComRefresh "links.asp?tipo=" & tipo
	Menu 5, 3, "INSERIR LINK"
%>
	<font size="+1" color="white" face="arial"><b>Link inserido com sucesso</b></font>
<% end if %>

<% FimPagina() %>
