<%
' Copyright: (c) 1999-2023, Tiago Fonseca
' GNU General Public License v3.0+ (see LICENSE.md or https://www.gnu.org/licenses/gpl-3.0.html)
' SPDX-License-Identifier: GPL-3.0-or-later
%>

<!-- #include file="inicio_basedados.asp" -->

<%
' Testar se se vem do foto@pt
if instr(Request.ServerVariables("HTTP_REFERER"), "fotopt.net") = 0 then
	Randomize
	SSUID = cstr(clng(Rnd * 1000000)) & cstr(clng(Rnd * 1000000))
	
	' Cookie "eterno"
	if Request.Cookies("SSUID") = "" then
		Response.Cookies("SSUID") = SSUID
		Response.Cookies("SSUID").Expires = #January 1, 2038#
	end if
		
	' Calcular numero de utilizadores
	if session("SSUID") = "" then
		session("SSUID") = SSUID
		
		SQL = "SELECT visitas, ultimo_ip FROM contador WHERE tipo = 1"
		Set contadorRes = dbConnection.Execute(SQL)
			
		SQL = "SELECT visitas, ultimo_ip FROM contador WHERE tipo = 2 AND data = #" & date() & "#"
		Set contadorDiarioRes = dbConnection.Execute(SQL)
			
		if contadorDiarioRes.eof then
			SQL = "INSERT INTO contador (visitas, tipo, ultimo_ip, data) VALUES ("
			SQL = SQL & "'1', '2', '" & Request.ServerVariables("REMOTE_ADDR") & "', '" & date() & "')"
			dbConnection.Execute(SQL)
		end if
			
		if contadorRes("ultimo_ip") <> Request.ServerVariables("REMOTE_ADDR") then
			SQL = "UPDATE contador SET visitas = '" & contadorRes("visitas") + 1 & "'"
			SQL = SQL & ", ultimo_ip = '" & Request.ServerVariables("REMOTE_ADDR") & "'"
			SQL = SQL & " WHERE tipo = 1"
			dbConnection.Execute(SQL)
				
			if not contadorDiarioRes.eof then
				SQL = "UPDATE contador SET visitas = '" & contadorDiarioRes("visitas") + 1 & "'"
				SQL = SQL & ", ultimo_ip = '" & Request.ServerVariables("REMOTE_ADDR") & "'"
				SQL = SQL & " WHERE tipo = 2 AND data = #" & date() & "#"
				dbConnection.Execute(SQL)
			end if
		end if
	end if
end if
%>

<html>

<head>
	<title>foto@pt - Photography in Portuguese</title>
	<meta name"robots" content="noindex, follow">
	<meta name="owner" content="info@fotopt.net">
	<meta name="author" content="Tiago Fonseca">
</head>

<frameset frameborder="no" border="0" framespacing=0 cols="125,*">
	<frame name="menu" src="menu.asp" marginwidth="1" marginheight="4" scrolling="auto" frameborder="no">
	<frame name="corpo"src="autor.asp?autor=<% =request("membro") %>&directo=1" marginwidth="1" marginheight="4" scrolling="auto" frameborder="no">
<noframes>
	<!-- #include file="sem_frames.asp" -->
</noframes>
</frameset>

</html>

<!-- #include file="fim_basedados.asp" -->