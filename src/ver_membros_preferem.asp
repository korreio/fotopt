<%
' Copyright: (c) 1999-2023, Tiago Fonseca
' GNU General Public License v3.0+ (see LICENSE.md or https://www.gnu.org/licenses/gpl-3.0.html)
' SPDX-License-Identifier: GPL-3.0-or-later
%>

<!-- #include file="funcoes_principais.asp" -->

<%
autor = request("autor")

SQL = "SELECT * FROM preferido_autor WHERE autor_preferido = " & autor
Set autoresRes = dbConnection.Execute(SQL)

SQL = "SELECT count(*) AS num FROM preferido_autor WHERE autor_preferido = " & autor
Set autorNumRes = dbConnection.Execute(SQL)

if (autorNumRes("num") mod 3) = 0 then
	porColuna = autorNumRes("num") / 3
else
	porColuna = autorNumRes("num") / 3 + 1
end if
%>

<%
AutenticarMembro(autor)
Menu 3, 4, "MEMBROS QUE T�M O AUTOR " & autor & " COMO PREFERIDO"
%>

<table border="0" cellspacing="0" cellpadding="0">
<tr>
<% for j = 1 to 3 %>
	<td valign="top"><table border="0" cellspacing="0" cellpadding="3">
	<% 
	for i = 1 to porColuna
		if not autoresRes.eof then
			SQL = "SELECT * FROM autor WHERE id = " & autoresRes("autor")
			Set autorRes = dbConnection.Execute(SQL)
	%>
			<tr><td><a href="autor.asp?autor=<% =autorRes("id") %>"><font size="-2" color="#ffcc66" face="verdana, arial"><b><% =autorRes("nome") %></b></font></a><font size="-2">&nbsp;&nbsp;</font></td></tr>
	<%
		autoresRes.MoveNext
		end if
	next
	%>
	</table></td>
<% next %>
</tr>
</table>

<% FimPagina() %>
