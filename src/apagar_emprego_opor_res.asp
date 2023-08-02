<%
' Copyright: (c) 1999-2023, Tiago Fonseca
' GNU General Public License v3.0+ (see LICENSE.md or https://www.gnu.org/licenses/gpl-3.0.html)
' SPDX-License-Identifier: GPL-3.0-or-later
%>

<!-- #include file="funcoes_principais.asp" -->

<%
opor = request("opor")

SQL = "SELECT autor FROM emprego_oportunidade WHERE id = " & opor
Set oporRes = dbConnection.Execute(SQL)

autor = oporRes("autor")
apagar = request("apagar")
%>

<% AutenticarMembro(autor) %>

<%
if apagar = "on" then
	SQL = "DELETE FROM emprego_oportunidade WHERE id = " & opor
	dbConnection.Execute(SQL)

	ComRefresh "emprego.asp"
	Menu 6, 3, "APAGAR OPORTUNIDADE DE EMPREGO"
%>
	<font size="+1" color="white" face="arial"><b>Emprego apagado com sucesso</b></font>
<%
else
	Menu 6, 3, "APAGAR OPORTUNIDADE DE EMPREGO"
%>
	<font size="+1" color="white" face="arial">Para apagar tem que confirmar na &quot;check box&quot;</font>
	<br>
	<font size="+1" color="white" face="arial">prima o botao <b>back</b> no browser e corrija</font>	
<% end if %>

<% FimPagina() %>
