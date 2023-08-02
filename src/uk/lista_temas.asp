<%
' Copyright: (c) 1999-2023, Tiago Fonseca
' GNU General Public License v3.0+ (see LICENSE.md or https://www.gnu.org/licenses/gpl-3.0.html)
' SPDX-License-Identifier: GPL-3.0-or-later
%>

<!-- #include file="inicio_basedados.asp" -->

<%
autor = request("autor")

SQL = "SELECT * FROM folder WHERE autor = " & autor & " ORDER BY nome_uk, nome"
Set folderRes = dbConnection.Execute(SQL)

SQL = "SELECT nome FROM autor WHERE id = " & autor
Set autorRes = dbConnection.Execute(SQL)

SQL = "SELECT count(*) AS numFotos FROM foto WHERE autor = " & autor & " AND tema = 0"
Set geralRes = dbConnection.Execute(SQL)
%>

<!-- #include file="topo.asp" -->
<td bgcolor="gray" width="100%" align="left"><font size="-1" color="black" face="arial">&nbsp;THEMES FROM <% =autorRes("nome") %>'s GALLERY</font></td>
<!-- #include file="fim_topo.asp" -->

<font size="-1" color="white" face="arial">This author has his gallery divided in several themes, select one theme to see the photos.</font>
<br><br>

<table border="1" cellpadding="4" cellspacing="0">
<tr align="center">
	<td><font color="white" face="arial"><b>THEME</b></font></td>
	<td><font color="white" face="arial"><b>DESCRIPTION</b></font></td>
	<td><font color="white" face="arial"><b>PHOTOS</b></font></td>	
</tr>
<tr>
	<td><a href="galeria.asp?tipo=autor&id=<% =autor %>&tema=0"><font color="#FFCC66" size="-1" face="arial"><b>Generic</b></font></a></td>
	<td><font size="-1" color="white" face="arial">Photos which do not fit in the following themes.</font></td>		
	<td align="center"><font size="-1" color="white" face="arial"><% =geralRes("numFotos") %></font></td>		
</tr>

<% 
i = 0
do while not folderRes.eof
	if (session("login") = 2) or (session("login") = clng(autor)) then
		SQL = "SELECT count(*) AS numFotos FROM foto WHERE autor = " & autor & " AND tema = " & folderRes("id")
		Set porTemaRes = dbConnection.Execute(SQL)
	else
		SQL = "SELECT count(*) AS numFotos FROM foto WHERE autor = " & autor & " AND tema = " & folderRes("id") & " AND (anonima <> 2 OR (anonima = 2 AND data < #" & cdate(date() & " " & time()) - 7 & "#))"
		Set porTemaRes = dbConnection.Execute(SQL)
	end if
%>
	<tr>
		<% if folderRes("nome_uk") <> "" then %>
			<td><a href="galeria.asp?tipo=autor&id=<% =autor %>&tema=<% =folderRes("id") %>"><font color="#FFCC66" size="-1" face="arial"><b><% =folderRes("nome_uk") %></b></font></a></td>
			<td><font size="-1" color="white" face="arial"><% =folderRes("descricao_uk") %>&nbsp;</font></td>
		<% 
		else 
			i = i + 1
		%>
			<td><a href="galeria.asp?tipo=autor&id=<% =autor %>&tema=<% =folderRes("id") %>"><font color="#FFCC66" size="-1" face="arial"><b>Theme <% =i %></b></font></a></td>
			<td><font size="-1" color="white" face="arial">&nbsp;</font></td>
		<% end if %>
		<td align="center"><font size="-1" color="white" face="arial"><% =porTemaRes("numFotos") %></font></td>		
	</tr>
	<% folderRes.MoveNext %>
<% Loop %>
<tr>
	<td align="center" colspan="3"><a href="galeria.asp?tipo=autor&id=<% =autor %>&tema=-1"><font color="white" size="-1" face="arial"><b>SHOW ALL PHOTOS</b></font></a></td>
</tr>
</table>

<!-- #include file="fim.asp" -->
<!-- #include file="fim_basedados.asp" -->