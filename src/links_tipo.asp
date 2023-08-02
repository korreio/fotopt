<%
' Copyright: (c) 1999-2023, Tiago Fonseca
' GNU General Public License v3.0+ (see LICENSE.md or https://www.gnu.org/licenses/gpl-3.0.html)
' SPDX-License-Identifier: GPL-3.0-or-later
%>

<!-- #include file="funcoes_principais.asp" -->
<% 
OpcaoMenu "INSERIR LINK", "inserir_link.asp", False, True, -1, False, False
Menu 4, 3, "LINKS" 
%>

<%
SQL = "SELECT * FROM links_tipo ORDER BY nome"
Set tipoLinksRes = dbConnection.Execute(SQL)
%>

<table border="1" cellpadding="10" cellspacing="0">
<tr>
<td valign="top">
	<font color="white" face="arial"><a href="links.asp"><b>LINKS</b></a></font><br>
	<% 
	do while not tipoLinksRes.eof
	%>
		&nbsp;&nbsp;<a href="links.asp?tipo=<% =tipoLinksRes("id") %>"><font color="#FFCC66" size="-2" face="verdana, arial"><b><% =tipoLinksRes("nome") %></b></font></a><br>
		<% tipoLinksRes.MoveNext %>
	<% Loop %>
</td>	
</tr>
</table>

<% FimPagina() %>
