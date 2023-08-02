<%
' Copyright: (c) 1999-2023, Tiago Fonseca
' GNU General Public License v3.0+ (see LICENSE.md or https://www.gnu.org/licenses/gpl-3.0.html)
' SPDX-License-Identifier: GPL-3.0-or-later
%>

<!-- #include file="funcoes_principais.asp" -->
<% 
OpcaoMenu "INSERIR EVENTO", "inserir_evento.asp", False, True, -1, False, False
Menu 2, 4, "EVENTOS"
%>

<%
SQL = "SELECT * FROM evento_tipo"
Set tipoEventoRes = dbConnection.Execute(SQL)

SQL = "SELECT distinct(distrito) FROM evento WHERE distrito > 0 AND (data_fim > #" & date() - 1 & "# OR data_inicio > #" & date() - 1 & "#)"
Set distritosRes = dbConnection.Execute(SQL)

SQL = "SELECT distinct(pais) FROM evento WHERE pais > 0 AND (data_fim > #" & date() - 1 & "# OR data_inicio > #" & date() - 1 & "#)"
Set paisesRes = dbConnection.Execute(SQL)

SQL = "SELECT TOP 10 autores_fotos, tipo, nome, id FROM evento ORDER BY id DESC"
Set novosRes = dbConnection.Execute(SQL)
%>

<table cellpadding="10" cellspacing="0" border="1">
<tr>
	<td valign="top">
		<font color="white" face="Arial"><b>VER POR TIPO EVENTO</b></font><br>
		<table cellpadding="0" cellspacing="0" border="0">
		<% 
		do while not tipoEventoRes.eof 
			SQL = "SELECT count(*) AS num FROM evento WHERE (data_fim > #" & date() - 1 & "# OR data_inicio > #" & date() - 1
			SQL = SQL & "#) AND tipo = " & tipoEventoRes("id")
			Set eventoNumRes = dbConnection.Execute(SQL)
		%>
			<tr>
				<td>&nbsp;&nbsp;<a href="eventos.asp?tipo=grupo&id=<% =tipoEventoRes("id") %>"><font size="-1" color="#FFCC66" face="verdana, Arial"><b><% =tipoEventoRes("nome") %></b></font></a></td>
				<td align="right">&nbsp;&nbsp;<font size="-2" color="silver" face="Arial">(<% =eventoNumRes("num") %>)</font></td>
			</tr>
			<% tipoEventoRes.MoveNext %>
		<% loop %>
		</table>
	</td>
	<td valign="top">
		<font color="white" face="Arial"><b>VER POR DATA</b></font><br>
		<table cellpadding="0" cellspacing="0" border="0">
			<tr>
				<% 
					SQL = "SELECT count(*) AS num FROM evento WHERE (data_fim >= #" & date() & "# AND data_inicio <= #" & date() & "#) OR (data_inicio = #" & date() & "#)"
					Set eventoNumRes = dbConnection.Execute(SQL)

					SQL = "SELECT count(*) AS num FROM evento WHERE (data_fim < #" & date() & "# AND data_inicio < #" & date() & "#)"
					Set eventoAntigoNumRes = dbConnection.Execute(SQL)

					SQL = "SELECT count(*) AS num FROM evento WHERE data_inicio > #" & date() & "#"
					Set eventoFuturoNumRes = dbConnection.Execute(SQL)
				%>
				<td>&nbsp;&nbsp;<a href="eventos.asp?tipo=antigos"><font size="-1" color="#FFCC66" face="verdana, Arial"><b>PASSADOS</font></a></td>
				<td align="right">&nbsp;&nbsp;<font size="-2" color="silver" face="Arial">(<% =eventoAntigoNumRes("num") %>)</font></td>
			</tr>
			<tr>
				<td>&nbsp;&nbsp;<a href="eventos.asp?tipo=adecorrer"><font size="-1" color="#FFCC66" face="verdana, Arial"><b>A DECORRER</font></a></td>
				<td align="right">&nbsp;&nbsp;<font size="-2" color="silver" face="Arial">(<% =eventoNumRes("num") %>)</font></td>
			</tr>
			<tr>
				<td>&nbsp;&nbsp;<a href="eventos.asp?tipo=futuros"><font size="-1" color="#FFCC66" face="verdana, Arial"><b>FUTUROS</font></a></td>
				<td align="right">&nbsp;&nbsp;<font size="-2" color="silver" face="Arial">(<% =eventoFuturoNumRes("num") %>)</font></td>
			</tr>
		</table>
	</td>
</tr>
<tr>
	<td valign="top">
		<font color="white" face="Arial"><b>VER POR DISTRITOS</b></font>
		<table cellpadding="0" cellspacing="0" border="0">
		<% 
		do while not distritosRes.eof 
			SQL = "SELECT * FROM distritos WHERE id = " & distritosRes("distrito")
			Set distritoRes = dbConnection.Execute(SQL)

			SQL = "SELECT count(*) AS num FROM evento WHERE (data_fim > #" & date() - 1 & "# OR data_inicio > #" & date() - 1
			SQL = SQL & "#) AND distrito = " & distritoRes("id")
			Set eventoNumRes = dbConnection.Execute(SQL)
		%>
			<tr>
				<td>&nbsp;&nbsp;<a href="eventos.asp?tipo=regiao&id=<% =distritoRes("id") %>"><font size="-1" color="#FFCC66" face="verdana, Arial"><b><% =distritoRes("nome") %></b></font></a></td>
				<td align="right">&nbsp;&nbsp;<font size="-2" color="silver" face="Arial">(<% =eventoNumRes("num") %>)</font></td>
			</tr>
			<% distritosRes.MoveNext %>
		<% loop %>
		<% if session("login") = 2 then %>
			<tr>
				<td>&nbsp;&nbsp;<a href="eventos.asp?tipo=regiao&id=0"><font size="-1" color="#FFCC66" face="verdana, Arial"><b>OUTROS</b></font></a></td>
				<td align="right">&nbsp;&nbsp;</font></td>
			</tr>
		<% end if %>
		</table>
	</td>
	<td valign="top">
		<font color="white" face="Arial"><b>VER POR PA&Iacute;S</b></font>
		<table cellpadding="0" cellspacing="0" border="0">
		<% 
		do while not paisesRes.eof 
			SQL = "SELECT * FROM paises_todos WHERE id = " & paisesRes("pais")
			Set paisRes = dbConnection.Execute(SQL)

			SQL = "SELECT count(*) AS num FROM evento WHERE (data_fim > #" & date() - 1 & "# OR data_inicio > #" & date() - 1
			SQL = SQL & "#) AND pais = " & paisesRes("pais")
			Set eventoNumRes = dbConnection.Execute(SQL)
		%>
			<tr>
				<td>&nbsp;&nbsp;<a href="eventos.asp?tipo=pais&id=<% =paisRes("id") %>"><font size="-1" color="#FFCC66" face="verdana, Arial"><b><% =paisRes("nome_pt") %></b></font></a></td>
				<td align="right">&nbsp;&nbsp;<font size="-2" color="silver" face="Arial">(<% =eventoNumRes("num") %>)</font></td>
			</tr>
			<% paisesRes.MoveNext %>
		<% loop %>
		<% if session("login") = 2 then %>
			<tr>
				<td>&nbsp;&nbsp;<a href="eventos.asp?tipo=pais&id=0"><font size="-1" color="#FFCC66" face="verdana, Arial"><b>OUTROS</b></font></a></td>
				<td align="right">&nbsp;&nbsp;</font></td>
			</tr>
		<% end if %>
		</table>
	</td>
</tr>
</table>

<% FimPagina() %>
