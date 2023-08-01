<!-- #include file="inicio_basedados.asp" -->

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

<!-- #include file="topo.asp" -->
<% if paginaAnterior <> 0 then %><td align="left"><font size="-2" color="black" face="arial">&lt;&nbsp;</font><a href="ver_guestbook.asp?primeira=<% =paginaAnterior %>&pais=<% =pais %>"><font size="-2" color="black" face="arial">PREVIOUS</font></a><font size="-2">&nbsp;</font></td><% end if %>
<td align="center"><font size="-2" color="black" face="arial">&nbsp;<% =estaPagina %>/<% =paginas %>&nbsp;</font></td>
<% if paginaSeguinte <> 0 then %><td align="right"><font size="-2">&nbsp;</font><a href="ver_guestbook.asp?primeira=<% =paginaSeguinte %>&pais=<% =pais %>"><font size="-2" color="black" face="arial">NEXT</font></a><font size="-2" color="black" face="arial">&nbsp;&gt;</font></td><% end if %>

<td bgcolor="gray" width="100%" align="left"><font size="-1" color="black" face="arial">&nbsp;MEMBERS</font></td>
<td><font size="-2">&nbsp;</font><a href="guestbook.asp"><font size="-2" color="black" face="arial">SIGN&nbsp;GUESTBOOK</font></a><font size="-2">&nbsp;</font></td>
<td><font size="-2">&nbsp;</font><a href="guestbook_paises.asp"><font size="-2" color="black" face="arial">COUNTRY&nbsp;LIST</font></a><font size="-2">&nbsp;</font></td>
<!-- #include file="fim_topo.asp" -->

<table border="1" cellpadding="5" cellspacing="0">
	<tr>
		<td align="center"><font color="white" face="arial"><b>NAME</b></font></td>
		<td align="center"><font color="white" face="arial"><b>COMMENT</b></font></td>
		<td align="center"><font color="white" face="arial"><b>HOW DID YOU<br>FIND OUT ABOUT<br>THIS WEBSITE?</b></font></td>
		<td align="center"><font color="white" face="arial"><b>DATE</b></font></td>
	</tr>
	<% if guestRes.eof then %>
		<tr><td align="center" colspan="5"><font size="-1" color="white" face="arial">No one has signed the guestbook yet.</font></td></tr>
	<% end if %>
	<% do while not guestRes.eof %>
		<tr>
			<% if guestRes("email") = "-1" then %>
				<td><font size="-1" color="white" face="arial"><% if guestRes("nome") <> "-1" then %><% =guestRes("nome") %><% end if %>&nbsp;</font></td>
			<% else %>
				<% if guestRes("nome") = "-1" then %>			
					<td><font size="-1" color="white" face="arial"><a href="mailto:<% =guestRes("email") %>"><% =guestRes("email") %></a></font></td>
				<% else %>
					<td><font size="-1" color="white" face="arial"><a href="mailto:<% =guestRes("email") %>"><% =guestRes("nome") %></a></font></td>
				<% end if %>
			<% end if %>
			<td><font size="-1" color="white" face="arial"><% =guestRes("comentario") %>&nbsp;</font></td>
			<td><font size="-1" color="white" face="arial"><% =guestRes("como_chegou_ca") %>&nbsp;</font></td>
			<td align="center"><font size="-2" color="white" face="arial"><% =day(guestRes("data")) & "/" & month(guestRes("data")) & "/" & year(guestRes("data")) %></font></td>
		</tr>
		<% guestRes.MoveNext %>
	<% loop %>
</table>

<!-- #include file="fim.asp" -->
<!-- #include file="fim_basedados.asp" -->