<%
' Copyright: (c) 1999-2023, Tiago Fonseca
' GNU General Public License v3.0+ (see LICENSE.md or https://www.gnu.org/licenses/gpl-3.0.html)
' SPDX-License-Identifier: GPL-3.0-or-later
%>

<!-- #include file="sqltext.asp" -->
<!-- #include file="funcoes_principais.asp" -->

<%
pais = request("pais")
primeira = request("primeira")
if primeira = "" then
	SQL = "SELECT TOP 1 id FROM guestbook ORDER BY id DESC"
	Set priRes = dbConnection.Execute(SQL)
	primeira = priRes("id")
end if

SQL = "SELECT TOP 10 * FROM guestbook WHERE pais = " & pais & " AND id <= " & primeira & " ORDER BY id DESC"
Set guestRes = dbConnection.Execute(SQL)

SQL = "SELECT * FROM paises_todos WHERE id = " & pais
Set paisRes = dbConnection.Execute(SQL)

SQL = "SELECT count(*) AS num FROM guestbook WHERE pais = " & pais & " AND id > " & primeira
Set numOutrasGuestRes = dbConnection.Execute(SQL)

' Contar assinaturas para calcular numero de paginas
SQL = "SELECT count(*) AS num FROM guestbook WHERE pais = " & pais
Set numGuestRes = dbConnection.Execute(SQL)
if (numGuestRes("num") mod 10) = 0 then
	paginas = numGuestRes("num") / 10
else
	paginas = int(numGuestRes("num") / 10) + 1
end if

if (primeira <> 0) then
	estaPagina = int(numOutrasGuestRes("num") / 10) + 1
else
	estaPagina = 1
end if

' Ver id da ultima foto na sequencia
do while not guestRes.eof
	ultimoId = guestRes("id")
	guestRes.MoveNext
loop
guestRes.MoveFirst
	
' Anteriores e proxima
SQL = "SELECT TOP 1 id FROM guestbook WHERE pais = " & pais & " AND id < " & ultimoId & " ORDER BY id DESC"
Set proximaGuestRes = dbConnection.Execute(SQL)
SQL = "SELECT TOP 10 id FROM guestbook WHERE pais = " & pais & " AND id > " & guestRes("id") & " ORDER BY id"
Set anterioresGuestRes = dbConnection.Execute(SQL)

' Descobrir anterior percorrendo ID da pagina anterior ate ao fim	
paginaAnterior = 0
do while not anterioresGuestRes.eof
	paginaAnterior = anterioresGuestRes("id")
	anterioresGuestRes.MoveNext
loop

' A proxima e' directa	
if not proximaGuestRes.eof then
	paginaSeguinte = proximaGuestRes("id")
else
	paginaSeguinte = 0
end if
%>

<%
if paginaSeguinte <> 0 then
	OpcaoMenu ">> P�GINA SEGUINTE", "ver_guestbook.asp?primeira=" & paginaSeguinte & "&pais=" & pais, True, False, -1, False, False
end if
if paginaAnterior <> 0 then
	OpcaoMenu "<< P�GINA ANTERIOR", "ver_guestbook.asp?primeira=" & paginaAnterior & "&pais=" & pais, True, False, -1, False, False
end if
OpcaoMenu "OUTRO PA�S", "guestbook_paises.asp", False, False, -1, False, False
Menu 2, 3, "LIVRO DE VISITAS - " & paisRes("nome_pt") & " (" & estaPagina & "/" & paginas & ")"
%>

<table border="2" cellpadding="5" cellspacing="0" bgcolor="black">
	<tr>
		<td align="center"><font color="white" face="arial"><b>NOME</b></font></td>
		<td align="center"><font color="white" face="arial"><b>COMENT&Aacute;RIO</b></font></td>
		<td align="center"><font color="white" face="arial"><b>COMO DESCOBRIU<br>ESTE SITE?</b></font></td>
		<td align="center"><font color="white" face="arial"><b>DATA</b></font></td>
		<% if session("login") = 2 then %>	
			<td><font size="-1" color="red" face="arial"><b>ADM</b></font></td>
		<% end if %>
	</tr>
	<% if guestRes.eof then %>
		<tr><td align="center" colspan="5"><font size="-1" color="white" face="arial">Ainda ningu&eacute;m assinou o livro de visitas.</font></td></tr>
	<% end if %>
	<% do while not guestRes.eof %>
		<tr>
			<% if guestRes("email") <> "" then %>
				<% if guestRes("nome") <> "" then %>			
					<td><font size="-1" color="white" face="arial"><a href="mailto:<% =guestRes("email") %>"><% =guestRes("nome") %></a></font></td>
				<% else %>
					<td><font size="-1" color="white" face="arial"><a href="mailto:<% =guestRes("email") %>"><% =guestRes("email") %></a></font></td>
				<% end if %>
			<% else %>
				<td><font size="-1" color="white" face="arial"><% =guestRes("nome") %>&nbsp;</font></td>
			<% end if %>
			<td><font size="-1" color="white" face="arial"><% =guestRes("comentario") %>&nbsp;</font></td>
			<td><font size="-1" color="white" face="arial"><% =guestRes("como_chegou_ca") %>&nbsp;</font></td>
			<td align="center"><font size="-1" color="white" face="arial"><% =day(guestRes("data")) & "/" & month(guestRes("data")) & "/" & year(guestRes("data")) %></font></td>
			<% if session("login") = 2 then %>	
				<td align="center"><a href="adm/adm_del_guest.asp?pais=<% =pais %>&guest=<% =guestRes("id") %>"><font size="-1" color="red" face="arial"><b>A</b></font></a></td>
			<% end if %>
		</tr>
		<% guestRes.MoveNext %>
	<% loop %>
</table>

<% FimPagina() %>
