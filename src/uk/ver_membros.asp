<%
' Copyright: (c) 1999-2023, Tiago Fonseca
' GNU General Public License v3.0+ (see LICENSE.md or https://www.gnu.org/licenses/gpl-3.0.html)
' SPDX-License-Identifier: GPL-3.0-or-later
%>

<!-- #include file="inicio_basedados.asp" -->

<%
SQL = "SELECT nome, id FROM autor WHERE autor.id IN "
SQL = SQL & "(SELECT distinct(autor) FROM foto) ORDER BY nome"
Set autorRes = dbConnection.Execute(SQL)
%>

<!-- #include file="topo.asp" -->
<td bgcolor="gray" width="100%" align="left"><font size="-1" color="black" face="arial">&nbsp;MEMBERS WITH PHOTOGRAPHIES</font></td>
<!-- #include file="fim_topo.asp" -->

<table border="0" cellspacing="0" cellpadding="3">
<% 
i = 0
do while not autorRes.eof 
	if (i MOD 3) = 0 then
%>
	<tr>
<% end if %>
	<td><a href="autor.asp?autor=<% =autorRes("id") %>"><font size="-1" color="white" face="arial"><% =autorRes("nome") %></font></a>&nbsp;&nbsp;</td>
<% if ((i + 1) MOD 3) = 0 then %>
	</tr>
<%
	end if
	i = i + 1
	autorRes.MoveNext
Loop 
%>
</table>

<!-- #include file="fim.asp" -->
<!-- #include file="fim_basedados.asp" -->