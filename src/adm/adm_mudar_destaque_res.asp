<%
' Copyright: (c) 1999-2023, Tiago Fonseca
' GNU General Public License v3.0+ (see LICENSE.md or https://www.gnu.org/licenses/gpl-3.0.html)
' SPDX-License-Identifier: GPL-3.0-or-later
%>

<!-- #include file="../funcoes_principais.asp" -->
<!-- #include file="topo.asp" -->
<td bgcolor="gray" width="100%" align="left"><font size="-1" color="black" face="arial">&nbsp;MUDAR DESTAQUE</font></td>
<!-- #include file="fim_topo.asp" -->
<!-- #include file="autenticar_webmaster.asp" -->
<!-- #include file="../sqltext.asp" -->

<%
destaque = request("destaque")
seccao = clng(request("seccao"))
texto = SqlTextMemo(request("texto"))
data = request("data")

if not isdate(data) then
%>
	<font size="+1" color="white" face="arial">A data n�o � v�lida.</font>
	<br>
	<font size="+1" color="white" face="arial">prima o botao <b>back</b> no browser e complete a informa&ccedil;&atilde;o.</font>	
<%
elseif (texto = "") or (data = "") then
%>
	<font size="+1" color="white" face="arial">Os campos <b>texto</b> e <b>data</b> s�o obrigat&oacute;rios.</font>
	<br>
	<font size="+1" color="white" face="arial">prima o botao <b>back</b> no browser e complete a informa&ccedil;&atilde;o.</font>	
<%
else
	SQL = "UPDATE destaques SET "
	SQL = SQL & "seccao = '" & seccao & "', "
	SQL = SQL & "texto = '" & texto & "', "
	SQL = SQL & "data = '" & data & "' "
	SQL = SQL & "WHERE id = " & destaque
	dbConnection.Execute(SQL)
%>
	<% if (seccao = -1) or (seccao = 0) then %>
		<meta http-equiv="refresh" content="0;url=/index.asp">
	<% else %>
		<meta http-equiv="refresh" content="0;url=/<% =menuPrincipal(seccao - 1)(1) %>">
	<% end if %>
	<font size="+1" color="white" face="arial"><b>Destaque mudado com sucesso</b></font>
<% end if %>

<!-- #include file="fim_autenticacao.asp" -->
<!-- #include file="fim_basedados.asp" -->