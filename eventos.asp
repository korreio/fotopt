<!-- #include file="funcoes_principais.asp" -->

<%
tipo = request("tipo")
id = request("id")

if tipo = "grupo" then
	SQL = "SELECT * FROM evento_tipo WHERE id = " & id
	Set tipoEventoRes = dbConnection.Execute(SQL)
else
	SQL = "SELECT * FROM evento_tipo"
	Set tipoEventoRes = dbConnection.Execute(SQL)
end if

if tipo = "pais" then
	SQL = "SELECT * FROM paises_todos WHERE id = " & id
	Set paisRes = dbConnection.Execute(SQL)
end if

if tipo = "regiao" then
	SQL = "SELECT * FROM distritos WHERE id = " & id
	Set distritoRes = dbConnection.Execute(SQL)
end if
%>

<% 
OpcaoMenu "INSERIR EVENTO", "inserir_evento.asp", False, True, -1, False, False
if tipo = "grupo" then
	Menu 2, 4, "EVENTOS - " & tipoEventoRes("nome")
elseif tipo = "pais" then
	Menu 2, 4, "EVENTOS - " & paisRes("nome")
elseif tipo = "regiao" then
	Menu 2, 4, "EVENTOS - " & distritoRes("nome")
elseif tipo = "antigos" then
	Menu 2, 4, "EVENTOS - PASSADOS"
elseif tipo = "futuros" then
	Menu 2, 4, "EVENTOS - FUTUROS"
elseif tipo = "adecorrer" then
	Menu 2, 4, "EVENTOS - A DECORRER"
else
	Menu 2, 4, "EVENTOS - TODOS"
end if
%>

<table cellpadding="10" cellspacing="0" border="1">
<%
do while not tipoEventoRes.eof 
	if tipo = "grupo" then
		SQL = "SELECT * FROM evento WHERE (data_fim > #" & date() - 1 & "# OR data_inicio > #" & date() - 1
		SQL = SQL & "#) AND tipo = " & tipoEventoRes("id") & " ORDER BY data_inicio"
		Set eventoRes = dbConnection.Execute(SQL)
	elseif tipo = "regiao" then
		SQL = "SELECT * FROM evento WHERE (data_fim > #" & date() - 1 & "# OR data_inicio > #" & date() - 1
		SQL = SQL & "#) AND tipo = " & tipoEventoRes("id") & " AND distrito = " & id & " ORDER BY data_inicio"
		Set eventoRes = dbConnection.Execute(SQL)
	elseif tipo = "pais" then
		SQL = "SELECT * FROM evento WHERE (data_fim > #" & date() - 1 & "# OR data_inicio > #" & date() - 1
		SQL = SQL & "#) AND tipo = " & tipoEventoRes("id") & " AND pais = " & id & " ORDER BY data_inicio"
		Set eventoRes = dbConnection.Execute(SQL)
	elseif tipo = "antigos" then
		SQL = "SELECT * FROM evento WHERE (data_fim < #" & date() & "# AND data_inicio < #" & date()
		SQL = SQL & "#) AND tipo = " & tipoEventoRes("id") & " ORDER BY data_inicio"
		Set eventoRes = dbConnection.Execute(SQL)
	elseif tipo = "futuros" then
		SQL = "SELECT * FROM evento WHERE data_inicio > #" & date()
		SQL = SQL & "# AND tipo = " & tipoEventoRes("id") & " ORDER BY data_inicio"
		Set eventoRes = dbConnection.Execute(SQL)
	elseif tipo = "adecorrer" then
		SQL = "SELECT * FROM evento WHERE ((data_fim >= #" & date() & "# AND data_inicio <= #" & date() & "#) OR (data_inicio = #" & date() & "#))"
		SQL = SQL & " AND tipo = " & tipoEventoRes("id") & " ORDER BY data_inicio"
		Set eventoRes = dbConnection.Execute(SQL)
	else
		SQL = "SELECT * FROM evento WHERE (data_fim > #" & date() - 1 & "# OR data_inicio > #" & date() - 1
		SQL = SQL & "#) AND tipo = " & tipoEventoRes("id") & " ORDER BY data_inicio"
		Set eventoRes = dbConnection.Execute(SQL)
	end if
%>
	<tr><td>
	<font color="white" face="Arial"><b><% =tipoEventoRes("nome") %></b></font>
	<table cellpadding="2" cellspacing="0" border="0">
	<% do while not eventoRes.eof %>
		<tr>
		<td align="right" valign="top">
			<font size="-2" color="white" face="Arial">
			&nbsp;&nbsp;<% =day(eventoRes("data_inicio")) %>/<% =month(eventoRes("data_inicio")) %></font>
			<% if eventoRes("data_fim") <> "" then %>
				<font size="-2" color="white" face="Arial">a <% =day(eventoRes("data_fim")) %>/<% =month(eventoRes("data_fim")) %></font>
			<% end if %>
		</td>
		<td>
			<a href="ver_evento.asp?evento=<% =eventoRes("id") %>&tipo=<% =tipo %>&id=<% =id %>"><font size="2" color="#FFCC66" face="verdana, Arial"><b><% =eventoRes("nome") %></b></font></a>
			<% if (eventoRes("tipo") = 1) and (eventoRes("autores_fotos") <> "") then %>
				<br><font size="-2" color="white" face="verdana, Arial">(fotografias de <% =eventoRes("autores_fotos") %>)</font>
			<% end if %>
			<br>
			<% if eventoRes("lugar") <> "" then %><font size="-2" color="white" face="Arial"><% =eventoRes("lugar") %></font><% end if %>
		</td>
		<% eventoRes.MoveNext %>
		</tr>
	<% loop %>
	</table>
	<% tipoEventoRes.MoveNext %>
	</td></tr>
<% loop %>
</table>

<% FimPagina() %>
