<%
' Copyright: (c) 1999-2023, Tiago Fonseca
' GNU General Public License v3.0+ (see LICENSE.md or https://www.gnu.org/licenses/gpl-3.0.html)
' SPDX-License-Identifier: GPL-3.0-or-later
%>

<!-- #include file="funcoes_principais.asp" -->

<%
evento = request("evento")

SQL = "SELECT autor FROM evento WHERE id = " & evento
Set eventoRes = dbConnection.Execute(SQL)

autor = eventoRes("autor")
apagar = request("apagar")
%>

<% AutenticarMembro(autor) %>

<%
if apagar = "on" then
	SQL = "DELETE FROM evento WHERE id = " & evento
	dbConnection.Execute(SQL)

	ComRefresh "eventos_tipo.asp"
	Menu 6, 1, "APAGAR EVENTO"
%>
	<font size="+1" color="white" face="arial"><b>Evento apagado com sucesso</b></font>
<%
else
	Menu 6, 1, "APAGAR EVENTO"
%>
	<font size="+1" color="white" face="arial">Para apagar tem que confirmar na &quot;check box&quot;</font>
	<br>
	<font size="+1" color="white" face="arial">prima o botao <b>back</b> no browser e corrija</font>	
<% end if %>

<% FimPagina() %>
