<%
' Copyright: (c) 1999-2023, Tiago Fonseca
' GNU General Public License v3.0+ (see LICENSE.md or https://www.gnu.org/licenses/gpl-3.0.html)
' SPDX-License-Identifier: GPL-3.0-or-later
%>

<!-- #include file="sqltext.asp" -->
<!-- #include file="funcoes_principais.asp" -->

<% AutenticarMembro(autor) %>

<%
votacao = request("votacao")
nome = SqlText(request("nome"))

if (nome = "") then
	Menu 7, 2, "INSERIR ITEM NUMA VOTA��O"
%>
	<font size="+1" color="white" face="arial">O campo <b>nome</b> &eacute; obrigat&oacute;rio.</font>
	<br>
	<font size="+1" color="white" face="arial">prima o botao <b>back</b> no browser e complete a informa&ccedil;&atilde;o.</font>	
<%
else
	SQL = "INSERT INTO votacao_item (nome, autor, data, topico, votos) VALUES "
	SQL = SQL & "('" & nome & "','" & session("login") & "','" & date() & " " & time() & "','" & votacao & "', '0')"
	dbConnection.Execute(SQL)

	ComRefresh "votacao_items.asp?votacao=" & votacao
	Menu 7, 2, "INSERIR ITEM NUMA VOTA��O"
%>
	<font size="+1" color="white" face="arial"><b>Item inserido com sucesso</b></font>
<% end if %>

<% FimPagina() %>
