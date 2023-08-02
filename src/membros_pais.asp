<%
' Copyright: (c) 1999-2023, Tiago Fonseca
' GNU General Public License v3.0+ (see LICENSE.md or https://www.gnu.org/licenses/gpl-3.0.html)
' SPDX-License-Identifier: GPL-3.0-or-later
%>

<!-- #include file="funcoes_principais.asp" -->

<% 
Menu 3, 2, "MEMBROS POR PA�S" 
%>

<%
SQL = "SELECT distinct(pais) AS paises FROM autor ORDER BY pais"
Set paisRes = dbConnection.Execute(SQL)
%>

<font size="-1" color="white" face="arial">Escolha o pa&iacute;s do qual quer ver os membros:</font><br><br>

<table border="0" cellspacing="0" cellpadding="3">
<% 
i = 0
do while not paisRes.eof 
	SQL = "SELECT count(*) AS num FROM autor WHERE pais = " & paisRes("paises")
	Set numAutoresRes = dbConnection.Execute(SQL)

	SQL = "SELECT nome_pt FROM paises_todos WHERE id = " & paisRes("paises")
	Set nomePaisRes = dbConnection.Execute(SQL)

	if (i MOD 3) = 0 then
%>
	<tr>
<% end if %>
	<td><a href="ver_membros.asp?pais=<% =paisRes("paises") %>"><font size="-1" color="#FFCC66" face="arial"><b><% =nomePaisRes("nome_pt") %></b></font></a> <font color="silver" size="-2" face="arial">&nbsp;(<% =numAutoresRes("num") %>)</font>&nbsp;&nbsp;</td>
<% if ((i + 1) MOD 3) = 0 then %>
	</tr>
<%
	end if
	i = i + 1
	paisRes.MoveNext
Loop 
%>
</table>

<% FimPagina() %>
