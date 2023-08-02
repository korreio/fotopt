<%
' Copyright: (c) 1999-2023, Tiago Fonseca
' GNU General Public License v3.0+ (see LICENSE.md or https://www.gnu.org/licenses/gpl-3.0.html)
' SPDX-License-Identifier: GPL-3.0-or-later
%>

<!-- #include file="inicio_basedados.asp" -->

<%
SQL = "SELECT distinct(pais) AS paises FROM guestbook ORDER BY pais"
Set paisRes = dbConnection.Execute(SQL)
%>

<!-- #include file="topo.asp" -->
<td bgcolor="gray" width="100%" align="left"><font size="-1" color="black" face="arial">&nbsp;GUESTBOOK</font></td>
<td><font size="-2">&nbsp;</font><a href="guestbook.asp"><font size="-2" color="black" face="arial">SIGN&nbsp;GUESTBOOK</font></a><font size="-2">&nbsp;</font></td>
<!-- #include file="fim_topo.asp" -->

<font color="white" size="-1" face="Arial">
Select the visitor's originary country:
</font><br><br>

<table border="0" cellspacing="0" cellpadding="3">
<% 
i = 0
do while not paisRes.eof 
	SQL = "SELECT nome FROM paises_todos WHERE id = " & paisRes("paises")
	Set nomePaisRes = dbConnection.Execute(SQL)

	SQL = "SELECT count(*) AS num FROM guestbook WHERE pais = " & paisRes("paises")
	Set numVisitasRes = dbConnection.Execute(SQL)

	if (i MOD 3) = 0 then
%>
	<tr>
<% end if %>
	<td><a href="ver_guestbook.asp?pais=<% =paisRes("paises") %>"><font size="-1" color="#FFCC66" face="arial"><b><% =nomePaisRes("nome") %></b></font></a> <font size="-2" color="white" face="arial">(<% =numVisitasRes("num") %>)</font>&nbsp;&nbsp;</td>
<% if ((i + 1) MOD 3) = 0 then %>
	</tr>
<%
	end if
	i = i + 1
	paisRes.MoveNext
Loop 
%>
</table>

<!-- #include file="fim.asp" -->
<!-- #include file="fim_basedados.asp" -->