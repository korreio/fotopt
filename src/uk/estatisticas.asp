<%
' Copyright: (c) 1999-2023, Tiago Fonseca
' GNU General Public License v3.0+ (see LICENSE.md or https://www.gnu.org/licenses/gpl-3.0.html)
' SPDX-License-Identifier: GPL-3.0-or-later
%>

<!-- #include file="inicio_basedados.asp" -->

<%
intervalo = 30

if request("dia") <> "" then
	dia = request("dia")
	mes = request("mes")
	ano = request("ano")
else
	dia = day(date())
	mes = month(date())
	ano = year(date())
end if

dataFinal = cdate(mes & "/" & dia & "/" & ano)
dataInicial = cdate(mes & "/" & dia & "/" & ano) - intervalo
proximaData = dataFinal + intervalo

SQL = "SELECT count(*) AS num FROM contador WHERE tipo = " & 2 & " AND data > #" & dataFinal & "#"
Set numOutrosDiasRes = dbConnection.Execute(SQL)

SQL = "SELECT count(*) AS num FROM contador WHERE tipo = " & 2
Set numDiasRes = dbConnection.Execute(SQL)

if (numDiasRes("num") mod intervalo) = 0 then
	paginas = numDiasRes("num") / intervalo
else
	paginas = int(numDiasRes("num") / intervalo) + 1
end if

if request("dia") <> "" then
	estaPagina = paginas - int(numOutrosDiasRes("num") / intervalo)
else
	estaPagina = paginas
end if


SQL = "SELECT * FROM contador WHERE tipo = " & 2 & " AND data <= #" & dataFinal & "# AND data > #" & dataInicial & "# ORDER BY data"
Set diarioRes = dbConnection.Execute(SQL)

SQL = "SELECT * FROM contador WHERE tipo = " & 2 & " AND data = #" & date() - 1 & "#"
Set diarioOntemRes = dbConnection.Execute(SQL)

SQL = "SELECT * FROM contador WHERE tipo = " & 2 & " AND data = #" & date() & "#"
Set diarioHojeRes = dbConnection.Execute(SQL)

SQL = "SELECT * FROM contador WHERE tipo = " & 1
Set totalRes = dbConnection.Execute(SQL)

SQL = "SELECT max(visitas) AS maximo FROM contador WHERE tipo = " & 2 & " AND data <= #" & dataFinal & "# AND data > #" & dataInicial & "#"
Set maxDiarioRes = dbConnection.Execute(SQL)


SQL = "SELECT * FROM contador WHERE tipo = " & 3 & " AND data <= #" & dataFinal & "# AND data > #" & dataInicial & "# ORDER BY data"
Set loginRes = dbConnection.Execute(SQL)

SQL = "SELECT * FROM contador WHERE tipo = " & 3 & " AND data = #" & date() - 1 & "#"
Set loginOntemRes = dbConnection.Execute(SQL)

SQL = "SELECT * FROM contador WHERE tipo = " & 3 & " AND data = #" & date() & "#"
Set loginHojeRes = dbConnection.Execute(SQL)

SQL = "SELECT max(visitas) AS maximo FROM contador WHERE tipo = " & 3 & " AND data <= #" & dataFinal & "# AND data > #" & dataInicial & "#"
Set maxLoginRes = dbConnection.Execute(SQL)

SQL = "SELECT sum(visitas) as total FROM contador WHERE tipo = " & 3
Set totalLoginRes = dbConnection.Execute(SQL)

max = maxDiarioRes("maximo")
maxLogin = maxLoginRes("maximo")

Dim meses
meses = Array("JANEIRO", "FEVEREIRO", "MAR&Ccedil;O", "ABRIL", "MAIO", "JUNHO", "JULHO", _
			  "AGOSTO", "SETEMBRO", "OUTUBRO", "NOVEMBRO", "DEZEMBRO")
%>

<!-- #include file="topo.asp" -->
<% if estaPagina <> 1 then %><td align="left"><font size="-2" color="black" face="arial">&lt;&nbsp;</font><a href="estatisticas.asp?dia=<% =day(dataInicial) %>&mes=<% =month(dataInicial) %>&ano=<% =year(dataInicial) %>"><font size="-2" color="black" face="arial">PREVIOUS</font></a><font size="-2">&nbsp;</font></td><% end if %>
<td align="center"><font size="-2" color="black" face="arial">&nbsp;<% =estaPagina %>/<% =paginas %>&nbsp;</font></td>
<% if dataFinal <> date() then %><td align="right"><font size="-2">&nbsp;</font><a href="estatisticas.asp?dia=<% =day(proximaData) %>&mes=<% =month(proximaData) %>&ano=<% =year(proximaData) %>"><font size="-2" color="black" face="arial">NEXT</font></a><font size="-2" color="black" face="arial">&nbsp;&gt;</font></td><% end if %>

<td bgcolor="gray" width="100%" align="left"><font size="-1" color="black" face="arial">&nbsp;DAILY STATISTICS BETWEEN <% =day(diarioRes("data")) %>/<% =month(diarioRes("data")) %>/<% =right(year(diarioRes("data")), 2) %> AND <% =dia %>/<% =mes %>/<% =right(ano, 2) %></font></td>
<!-- #include file="fim_topo.asp" -->

<table border="0" cellpadding="5" cellspacing="0">
<tr>
<td valign="top">
	<table border="1" cellpadding="3" cellspacing="0">
		<tr>
			<td align="center"><font size="-1" color="white" face="arial"><b>DAY</b></font></td>
			<td align="center"><font size="-1" color="white" face="arial"><b>VISITS</b></font></td>
			<td align="center"><font size="-1" color="white" face="arial"><b>LOGINS</b></font></td>
		</tr>
		<% do while not diarioRes.eof %>
		<tr>
			<td align="right"><font size="-1" color="#FFCC66" face="arial"><b><% =day(diarioRes("data")) %>/<% =month(diarioRes("data")) %></b></font></td>
			<td align="right"><font size="-1" color="white" face="arial"><% =diarioRes("visitas") %>&nbsp;</font></td>
			<% if not loginRes.eof then %>
				<td align="right"><font size="-1" color="white" face="arial"><% =loginRes("visitas") %>&nbsp;</font></td>
			<% else %>
				<td align="right"><font size="-1" color="white" face="arial">0&nbsp;</font></td>
			<% end if %>
		</tr>
			<% diarioRes.MoveNext %>
			<% if not loginRes.eof then %>
				<% loginRes.MoveNext %>
			<% end if %>
		<% loop %>
	</table>
</td>
<td valign="top">
	<table border="1" cellpadding="5" cellspacing="0">
	<tr><td align="center">
		<font color="white" face="arial"><b>DAILY ACCESSES</b></font>
	</td></tr>
	<tr><td>
		<table border="0" cellpadding="1" cellspacing="0">
		<tr>
			<td valign="top"><font size="-2" color="#FFCC66" face="verdana, arial"><b><% =max %></b>&nbsp;</font></td>
			<% 
			totalAcessos = 0
			diasAcessos = 0
			diarioRes.MoveFirst
			do while not diarioRes.eof 
			%>
				<td width="12" height="150" valign="bottom">
					<% if diarioRes("visitas") <> 0 then %>
						<img vspace="0" hspace="0" border="0" src="../Imagens/ClassVerde.gif" width=12 height=<% =clng(150 / max * diarioRes("visitas")) %> border=0 alt="">
					<% end if %>
				</td>
				<% 
				diasAcessos = diasAcessos + 1
				totalAcessos = totalAcessos + diarioRes("visitas")
				diarioRes.MoveNext 
				%>
			<% loop %>
		</tr>
		<tr>
			<td></td>
			<% 
			diarioRes.MoveFirst
			do while not diarioRes.eof 
			%>
				<td align="center"><font size="-2" color="white" face="arial"><% =day(diarioRes("data")) %></font></td>
				<% diarioRes.MoveNext %>
			<% loop %>
		</tr>
		</table>
	</td>
	</tr>
	</table>
	
	<br>
	<table border="1" cellpadding="5" cellspacing="0">
	<tr><td align="center">
		<font color="white" face="arial"><b>DAILY LOGINS</b></font>
	</td></tr>
	<tr><td>
		<table border="0" cellpadding="1" cellspacing="0">
		<tr>
			<td valign="top"><font size="-2" color="#FFCC66" face="verdana, arial"><b><% =maxLogin %></b>&nbsp;</font></td>
			<%
			totalLogins = 0
			diasLogins = 0
			loginRes.MoveFirst
			do while not loginRes.eof 
			%>
				<td width="12" height="150" valign="bottom">
					<% if loginRes("visitas") <> 0 then %>
						<img vspace="0" hspace="0" border="0" src="../Imagens/ClassVerde.gif" width=12 height=<% =clng(150 / maxLogin * loginRes("visitas")) %> border=0 alt="">
					<% end if %>
				</td>
				<%
				diasLogins = diasLogins + 1
				totalLogins = totalLogins + loginRes("visitas")
				loginRes.MoveNext 
				%>
			<% loop %>
		</tr>
		<tr>
			<td></td>
			<% 
			loginRes.MoveFirst
			do while not loginRes.eof 
			%>
				<td align="center"><font size="-2" color="white" face="arial"><% =day(loginRes("data")) %></font></td>
				<% loginRes.MoveNext %>
			<% loop %>
		</tr>
		</table>
	</td>
	</tr>
	</table>
	
	<br>
	<table border="1" cellpadding="3" cellspacing="0">
		<tr>
			<td><font size="-1" color="white" face="arial"><b>TOTAL ACCESSES SINCE 23/6/99: </b></font></td>
			<td align="right"><font size="-1" color="#FFCC66" face="arial">&nbsp;<b><% =totalRes("visitas") %></b>&nbsp;</font></td>
		</tr>
		<tr>
			<td><font size="-1" color="white" face="arial"><b>TOTAL ACCESSES IN THIS INTERVAL: </b></font></td>
			<td align="right"><font size="-1" color="#FFCC66" face="arial">&nbsp;<b><% =totalAcessos %></b>&nbsp;</font></td>
		</tr>
		<tr>
			<td><font size="-1" color="white" face="arial"><b>AVERAGE DAILY VISITS IN THIS INTERVAL: </b></font></td>
			<td align="right"><font size="-1" color="#FFCC66" face="arial">&nbsp;<b><% =round(totalAcessos / diasAcessos, 0) %></b>&nbsp;</font></td>
		</tr>
		<tr><td></td><td></td></tr>
		<tr>
			<td><font size="-1" color="white" face="arial"><b>TOTAL LOGINS SINCE 4/4/00: </b></font></td>
			<td align="right"><font size="-1" color="#FFCC66" face="arial">&nbsp;<b><% =totalLoginRes("total") %></b>&nbsp;</font></td>
		</tr>
		<tr>
			<td><font size="-1" color="white" face="arial"><b>TOTAL LOGINS IN THIS INTERVAL: </b></font></td>
			<td align="right"><font size="-1" color="#FFCC66" face="arial">&nbsp;<b><% =totalLogins %></b>&nbsp;</font></td>
		</tr>
		<tr>
			<td><font size="-1" color="white" face="arial"><b>AVERAGE DAILY LOGINS IN THIS INTERVAL: </b></font></td>
			<td align="right"><font size="-1" color="#FFCC66" face="arial">&nbsp;<b><% =round(totalLogins / diasLogins, 0) %></b>&nbsp;</font></td>
		</tr>
	</table>
</td>
</tr>
</table>

<!-- #include file="fim.asp" -->
<!-- #include file="fim_basedados.asp" -->