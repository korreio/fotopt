<%
' Copyright: (c) 1999-2023, Tiago Fonseca
' GNU General Public License v3.0+ (see LICENSE.md or https://www.gnu.org/licenses/gpl-3.0.html)
' SPDX-License-Identifier: GPL-3.0-or-later
%>

<!-- #include file="funcoes_principais.asp" -->

<%
Dim meses
meses = Array("Janeiro", "Fevereiro", "Mar&ccedil;o", "Abril", "Maio", "Junho", "Julho", _
			  "Agosto", "Setembro", "Outubro", "Novembro", "Dezembro")

historial = request("historial")

SQL = "SELECT * FROM historial WHERE id = " & historial
Set historialRes = dbConnection.Execute(SQL)

SQL = "SELECT nome FROM historial_tipo WHERE id = " & historialRes("tipo")
Set tipoHistorialRes = dbConnection.Execute(SQL)
%>

<%
OpcaoMenu "MUDAR DADOS OU APAGAR", "adm/mudar_historial.asp?historial=" & historial, False, False, -1, False, True
Menu 2, 6, "HISTORIAL - " & historialRes("titulo")
%>

<table border="0" cellpadding="2" cellspacing="0">
	<tr><td><font size="-1" color="#FFCC66" face="arial"><b>TIPO: </b></font></td><td><font size="-1" color="white" face="arial"><% =tipoHistorialRes("nome") %></font></td></tr>
	<% if historialRes("tipo_data") = 3 then %>
		<tr><td><font size="-1" color="#FFCC66" face="arial"><b>DATA: </b></font></td><td><font size="-1" color="white" face="arial"><% =day(historialRes("data")) %>&nbsp;<% =meses(month(historialRes("data")) - 1) %>&nbsp;<% =year(historialRes("data")) %></font></td></tr>
	<% else %>
		<tr><td><font size="-1" color="#FFCC66" face="arial"><b>DATA: </b></font></td><td><font size="-1" color="white" face="arial"><% =meses(month(historialRes("data")) - 1) %>&nbsp;<% =year(historialRes("data")) %></font></td></tr>
	<% end if %>
</table>

<br>
<table border="1" cellpadding="10" cellspacing="0"><tr><td>
	<font size="-1" color="white" face="arial"><% =historialRes("texto") %></font>
</td></tr></table>

<% FimPagina() %>
