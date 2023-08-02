<%
' Copyright: (c) 1999-2023, Tiago Fonseca
' GNU General Public License v3.0+ (see LICENSE.md or https://www.gnu.org/licenses/gpl-3.0.html)
' SPDX-License-Identifier: GPL-3.0-or-later
%>

<!-- #include file="funcoes_principais.asp" -->

<%
Menu 2, 3, "LIVRO DE VISITAS"
%>

<%
SQL = "SELECT distinct(pais) AS paises FROM guestbook ORDER BY pais"
Set paisRes = dbConnection.Execute(SQL)
%>

<font color="white" size="-1" face="Arial">
Escolha o pa&iacute;s origin&aacute;rio dos assinantes<br>(n&uacute;mero de assinaturas desse pa&iacute;s entre par&ecirc;ntesis):
</font><br><br>

<table border="0" cellspacing="0" cellpadding="3">
<% 
i = 0
do while not paisRes.eof 
	SQL = "SELECT nome_pt FROM paises_todos WHERE id = " & paisRes("paises")
	Set nomePaisRes = dbConnection.Execute(SQL)

	SQL = "SELECT count(*) AS num FROM guestbook WHERE pais = " & paisRes("paises")
	Set numVisitasRes = dbConnection.Execute(SQL)

	if (i MOD 3) = 0 then
%>
	<tr>
<% end if %>
	<td><a href="ver_guestbook.asp?pais=<% =paisRes("paises") %>"><font size="-1" color="#FFCC66" face="verdana, arial"><b><% =nomePaisRes("nome_pt") %></b></font></a> <font size="-2" color="silver" face="arial">(<% =numVisitasRes("num") %>)</font>&nbsp;&nbsp;</td>
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
