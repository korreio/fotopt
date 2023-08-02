<%
' Copyright: (c) 1999-2023, Tiago Fonseca
' GNU General Public License v3.0+ (see LICENSE.md or https://www.gnu.org/licenses/gpl-3.0.html)
' SPDX-License-Identifier: GPL-3.0-or-later
%>

<!-- #include file="sqltext.asp" -->
<!-- #include file="funcoes_principais.asp" -->

<%
mes = month(date())
ano = year(date())

SQL = "SELECT * FROM destaques_principais WHERE antigo = False ORDER BY data DESC"
Set destaqueRes = dbConnection.Execute(SQL)

Dim meses
meses = Array("JANEIRO", "FEVEREIRO", "MAR&Ccedil;O", "ABRIL", "MAIO", "JUNHO", "JULHO", _
			  "AGOSTO", "SETEMBRO", "OUTUBRO", "NOVEMBRO", "DEZEMBRO")
%>

<% 
Menu 2, 3, "EM DESTAQUE ESTE M�S"
%>

<table border="1" cellpadding="20" cellspacing="0">
	<% do while not destaqueRes.eof %>
		<tr><td valign="top" colspan="2">
			<font color="white" face="Arial" size="-1"><% =day(destaqueRes("data")) %>/<% =month(destaqueRes("data")) %>/<% =year(destaqueRes("data")) %> - </font>
			<font color="#FFCC66" face="Arial" size="+1"><b><% =destaqueRes("titulo") %></b></font><br><br>
			<font color="white" face="Arial"><% =destaqueRes("texto") %></font>
		</td></tr>
		<% destaqueRes.MoveNext %>
	<% loop %>
</table>

<% FimPagina() %>
