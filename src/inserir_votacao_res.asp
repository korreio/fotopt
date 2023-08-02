<%
' Copyright: (c) 1999-2023, Tiago Fonseca
' GNU General Public License v3.0+ (see LICENSE.md or https://www.gnu.org/licenses/gpl-3.0.html)
' SPDX-License-Identifier: GPL-3.0-or-later
%>

<!-- #include file="sqltext.asp" -->
<!-- #include file="funcoes_principais.asp" -->

<% AutenticarMembro(autor) %>

<%
nome = SqlText(request("nome"))
descricao = SqlText(request("descricao"))

if (nome = "") or (descricao = "") then
	Menu 7, 2, "CRIAR VOTA��O"
%>
	<font size="+1" color="white" face="arial">Os campos <b>nome</b> e <b>descri&ccedil;&atilde;o</b> s&atilde;o obrigat&oacute;rios.</font>
	<br>
	<font size="+1" color="white" face="arial">prima o botao <b>back</b> no browser e complete a informa&ccedil;&atilde;o.</font>	
<%
else
	SQL = "INSERT INTO votacao_topico (nome, descricao, autor, data, mostrar) VALUES "
	SQL = SQL & "('" & nome & "','" & descricao & "','" & session("login") & "','" & date() & " " & time() & "', '0')"
	dbConnection.Execute(SQL)

	ComRefresh "votacoes.asp"
	Menu 7, 2, "CRIAR VOTA��O"
%>
	<font size="+1" color="white" face="arial"><b>Vota&ccedil;&atilde;o inserida com sucesso</b></font>
<% end if %>

<% FimPagina() %>
