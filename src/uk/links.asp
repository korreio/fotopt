<!-- #include file="inicio_basedados.asp" -->

<%
tipo = request("tipo")

if tipo <> "" then
	SQL = "SELECT * FROM links_tipo WHERE id = " & tipo
	Set tipoRes = dbConnection.Execute(SQL)

	SQL = "SELECT * FROM links WHERE tipo = " & tipo & " ORDER BY nome, link"
	Set linksRes = dbConnection.Execute(SQL)
else
	SQL = "SELECT * FROM links ORDER BY nome, link"
	Set linksRes = dbConnection.Execute(SQL)
end if
%>

<!-- #include file="topo.asp" -->
<% if tipo <> "" then %>
	<td bgcolor="gray" width="100%" align="left"><font size="-1" color="black" face="arial">&nbsp;LINKS - <% =tipoRes("en_nome") %></font></td>
<% else %>
	<td bgcolor="gray" width="100%" align="left"><font size="-1" color="black" face="arial">&nbsp;ALL LINKS</font></td>
<% end if %>
<td><font size="-2">&nbsp;</font><a href="links_livros.asp"><font size="-2" color="black" face="arial">OTHER&nbsp;LINKS</font></a><font size="-2">&nbsp;</font></td>
<!-- #include file="fim_topo.asp" -->

<% do while not linksRes.eof %>
	<% if linksRes("nome") <> "" then %>
		&nbsp;&nbsp;<a href="<% =linksRes("link") %>" target="_blank"><font size="-1" face="Arial" color="white"><% =linksRes("nome") %></font></a>
	<% else %>
		&nbsp;&nbsp;<a href="<% =linksRes("link") %>" target="_blank"><font size="-1" face="Arial" color="white"><% =linksRes("link") %></font></a>
	<% end if %>
	<br>
	<% linksRes.MoveNext %>
<% loop %>

<%
if (tipo = 6) or (tipo = "") then %>
	<br>
	<font size="+1" color="white" face="Arial">MEMBERS HOMEPAGES</font><br>
<%
	SQL = "SELECT nome, home_page FROM autor ORDER BY nome"
	Set autorRes = dbConnection.Execute(SQL)
	
	do while not autorRes.eof
		if autorRes("home_page") <> "" then
%>
			&nbsp;&nbsp;<a href="<% =autorRes("home_page") %>" target="_blank"><font size="-1" face="Arial" color="white"><% =autorRes("nome") %></font></a><br>
<%
		end if
		autorRes.MoveNext
	loop
end if
%>

<!-- #include file="fim.asp" -->
<!-- #include file="fim_basedados.asp" -->