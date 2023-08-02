<%
' Copyright: (c) 1999-2023, Tiago Fonseca
' GNU General Public License v3.0+ (see LICENSE.md or https://www.gnu.org/licenses/gpl-3.0.html)
' SPDX-License-Identifier: GPL-3.0-or-later
%>

<!-- #include file="topo.asp" -->
<td bgcolor="gray" width="100%" align="left"><font size="-1" color="black" face="arial">&nbsp;MUDAR ITEM</font></td>
<!-- #include file="fim_topo.asp" -->
<!-- #include file="autenticar_webmaster.asp" -->
<!-- #include file="../sqltext.asp" -->
<!-- #include file="inicio_basedados.asp" -->

<%
votacao = request("votacao")
item = request("item")
nome = SqlText(request("nome"))

if (nome = "") then
%>
	<font size="+1" color="white" face="arial">O campo <b>nome</b> &eacute; obrigat&oacute;rio.</font>
	<br>
	<font size="+1" color="white" face="arial">prima o botao <b>back</b> no browser e complete a informa&ccedil;&atilde;o.</font>	
<%
else
	SQL = "UPDATE votacao_item SET "
	SQL = SQL & "nome = '" & nome & "' "
	SQL = SQL & "WHERE id = " & item
	dbConnection.Execute(SQL)
%>
	<meta http-equiv="refresh" content="0;url=../votacao_items.asp?votacao=<% =votacao %>">
	<font size="+1" color="white" face="arial"><b>Item mudado com sucesso</b></font>
<% end if %>

<!-- #include file="fim_autenticacao.asp" -->
<!-- #include file="fim_basedados.asp" -->