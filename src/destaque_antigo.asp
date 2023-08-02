<%
' Copyright: (c) 1999-2023, Tiago Fonseca
' GNU General Public License v3.0+ (see LICENSE.md or https://www.gnu.org/licenses/gpl-3.0.html)
' SPDX-License-Identifier: GPL-3.0-or-later
%>

<!-- #include file="../funcoes_principais.asp" -->
<% 
Menu 6, 2, "DESTAQUES DE MESES ANTERIORES"
%>

<%
SQL = "SELECT min(ano) AS minAno FROM autor_mes"
Set minAnoRes = dbConnection.Execute(SQL)

SQL = "SELECT min(mes) AS minMes FROM autor_mes WHERE ano = " & minAnoRes("minAno")
Set minMesRes = dbConnection.Execute(SQL)

Dim meses
meses = Array("JANEIRO", "FEVEREIRO", "MAR&Ccedil;O", "ABRIL", "MAIO", "JUNHO", "JULHO", _
			  "AGOSTO", "SETEMBRO", "OUTUBRO", "NOVEMBRO", "DEZEMBRO")
%>

<font size="-1" color="white" face="arial">
Todos os meses um <a href="juri.asp">j�ri</a> destacava as melhores imagens e um autor. Entretanto
esta sec��o deixou de existir. Escolha o m&ecirc;s do qual quer ver os destaques:
</font>
<br><br>

<table cellpadding="2" cellspacing="0">
<%
for ano = minAnoRes("minAno") to 2002
	if ano = minAnoRes("minAno") then
		mesInicio = minMesRes("minMes")
	else
		mesInicio = 1
	end if
	if ano = 2002 then
		mesFim = 4
	else
		mesFim = 12
	end if
	
	for mes = mesInicio to mesFim
%>	
	<tr>
		<td><font size="-1" color="#FFCC66" face="arial"><b><% =ano %></b></font></td>
		<td><a href="destaque.asp?mes=<% =mes %>&ano=<% =ano %>"><font size="-1" color="#FFCC66" face="arial"><b><% =meses(mes - 1) %></b></font></a></td>
	</tr>
<%
	next
next 
%>
</table>

<% FimPagina() %>
