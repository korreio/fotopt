<%
' Copyright: (c) 1999-2023, Tiago Fonseca
' GNU General Public License v3.0+ (see LICENSE.md or https://www.gnu.org/licenses/gpl-3.0.html)
' SPDX-License-Identifier: GPL-3.0-or-later
%>

<!-- #include file="../funcoes_principais.asp" -->

<%
destaque = request("destaque")
seccao = request("seccao")
apagar = request("apagar")
%>

<!-- #include file="topo.asp" -->
<td bgcolor="gray" width="100%" align="left"><font size="-1" color="black" face="arial">&nbsp;APAGAR DESTAQUE</font></td>
<!-- #include file="fim_topo.asp" -->
<!-- #include file="autenticar_webmaster.asp" -->

<%
if apagar = "on" then
	SQL = "DELETE FROM destaques WHERE id = " & destaque
	dbConnection.Execute(SQL)
%>
	<% if (seccao = -1) or (seccao = 0) then %>
		<meta http-equiv="refresh" content="0;url=/index.asp">
	<% else %>
		<meta http-equiv="refresh" content="0;url=/<% =menuPrincipal(seccao - 1)(1) %>">
	<% end if %>
	<font size="+1" color="white" face="arial"><b>Destaque apagado com sucesso</b></font>
<% else %>
	<font size="+1" color="white" face="arial">Para apagar tem que confirmar na &quot;check box&quot;</font>
	<br>
	<font size="+1" color="white" face="arial">prima o botao <b>back</b> no browser e corrija</font>	
<% end if %>

<!-- #include file="fim_autenticacao.asp" -->
<!-- #include file="fim_basedados.asp" -->