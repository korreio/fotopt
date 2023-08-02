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
nome = SqlText(request("nome"))
observacoes = SqlText(request("observacoes"))
if observacoes = "" then
	observacoes = "-1"
end if

if nome = "" then
	Menu 6, 2, "INSERIR ARTIGO PARA VENDA"
%>
	<font size="+1" color="white" face="arial">O campo <b>nome</b> &eacute; obrigat&oacute;rio</font>
	<br>
	<font size="+1" color="white" face="arial">prima o botao <b>back</b> no browser e complete a informa&ccedil;&atilde;o</font>	
<%
else
	SQL = "INSERT INTO procura_artigo (nome, observacoes, autor, data, tipo)"
	SQL = SQL & " VALUES ('" & nome & "','" & observacoes & "','" & session("login") & "','" & date() & " " & time() 
	SQL = SQL & "','" & tipo & "')"
	dbConnection.Execute(SQL)

	SQL = "SELECT id FROM procura_artigo WHERE autor = " & session("login") & " ORDER BY id DESC"
	Set artigoRes = dbConnection.Execute(SQL)

	ComRefresh "procura_artigo.asp?artigo=" & artigoRes("id")
	Menu 6, 2, "INSERIR ARTIGO PARA VENDA"
%>
	<font size="+1" color="white" face="arial"><b>Artigo procurado inserido com sucesso</b></font>
<% end if %>

<% FimPagina() %>
