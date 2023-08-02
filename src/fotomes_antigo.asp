<%
' Copyright: (c) 1999-2023, Tiago Fonseca
' GNU General Public License v3.0+ (see LICENSE.md or https://www.gnu.org/licenses/gpl-3.0.html)
' SPDX-License-Identifier: GPL-3.0-or-later
%>

<!-- #include file="funcoes_principais.asp" -->

<% 
OpcaoMenu "VER RESULTADOS DE OUTRO M�S", "fotomes_antigo.asp", False, False, -1, False, False
OpcaoMenu "RECALCULAR POSI��ES", "adm/fotomes_calc_pos.asp?mes=" & mes & "&ano=" & ano, False, False, -1, False, True
Menu 4, 1, "FOTO DO M�S ANTERIORES"
%>

<%
SQL = "SELECT min(ano) AS minAno FROM fotomes_votos"
Set minAnoRes = dbConnection.Execute(SQL)

SQL = "SELECT min(mes) AS minMes FROM fotomes_votos WHERE ano = " & minAnoRes("minAno")
Set minMesRes = dbConnection.Execute(SQL)

Dim meses
meses = Array("JANEIRO", "FEVEREIRO", "MAR&Ccedil;O", "ABRIL", "MAIO", "JUNHO", "JULHO", _
			  "AGOSTO", "SETEMBRO", "OUTUBRO", "NOVEMBRO", "DEZEMBRO")
%>

<font size="-1" color="white" face="arial">Escolha o m&ecirc;s do qual quer ver os resultados:</font>
<br><br>

<table cellpadding="2" cellspacing="0">
<%
for ano = minAnoRes("minAno") to year(date())
	if ano = minAnoRes("minAno") then
		mesInicio = minMesRes("minMes")
	else
		mesInicio = 1
	end if
	if ano = year(date()) then
		mesFim = month(date()) - 1
	else
		mesFim = 12
	end if
	
	for mes = mesInicio to mesFim
%>	
	<tr>
		<td><font size="-1" color="#FFCC66" face="arial"><b><% =ano %></b></font></td>
		<td><a href="fotomes.asp?mes=<% =mes %>&ano=<% =ano %>"><font size="-1" color="#FFCC66" face="arial"><b><% =meses(mes - 1) %></b></font></a></td>
	</tr>
<%
	next
next 
%>
</table>

<% FimPagina() %>
