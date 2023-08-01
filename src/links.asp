<!-- #include file="funcoes_principais.asp" -->

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

<% 
OpcaoMenu "INSERIR LINK", "inserir_link.asp", False, True, -1, False, False
if tipo <> "" then
	Menu 4, 3, "LINKS " & tipoRes("nome")
else 
	Menu 4, 3, "LINKS"
end if
%>

<% do while not linksRes.eof %>
	<% if session("login") = 2 then %>
		<a href="adm/adm_mudar_link.asp?link=<% =linksRes("id") %>"><font size="-2" color="red" face="arial"><b>MA</b></font></a><font size="-1" color="red" face="arial"><b> -</b></font>
	<% end if %>

	<% if linksRes("imagem") <> "" then %>
		<br>&nbsp;&nbsp;<a href="<% =linksRes("link") %>" target="_blank"><% =linksRes("imagem") %></a>
	<% else %>
		<% if linksRes("nome") <> "" then %>
			&nbsp;&nbsp;<a href="<% =linksRes("link") %>" target="_blank"><font size="-1" face="Arial" color="#FFCC66"><% =linksRes("nome") %></font></a>
		<% else %>
			&nbsp;&nbsp;<a href="<% =linksRes("link") %>" target="_blank"><font size="-1" face="Arial" color="#FFCC66"><% =linksRes("link") %></font></a>
		<% end if %>
	<% end if %>
	
	<% if linksRes("descricao") <> "" then %>
		<br>&nbsp;&nbsp;&nbsp;<font size="-2" face="Arial" color="white">(<% =linksRes("descricao") %>)</font>
	<% end if %>
	<font size="-1" face="Arial" color="white"><br></font>
	<% linksRes.MoveNext %>
<% loop %>

<%
if (tipo = 6) or (tipo = "") then %>
	<br>
	<font size="+1" color="white" face="Arial">P&Aacute;GINAS DE MEMBROS</font><br>
<%
	SQL = "SELECT nome, home_page FROM autor ORDER BY nome"
	Set autorRes = dbConnection.Execute(SQL)
	
	do while not autorRes.eof
		if autorRes("home_page") <> "" then
%>
			&nbsp;&nbsp;<a href="<% =autorRes("home_page") %>" target="_blank"><font size="-1" face="Arial" color="#FFCC66"><% =autorRes("nome") %></font></a><br>
<%
		end if
		autorRes.MoveNext
	loop
end if
%>

<% FimPagina() %>
