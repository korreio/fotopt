<%
' Copyright: (c) 1999-2023, Tiago Fonseca
' GNU General Public License v3.0+ (see LICENSE.md or https://www.gnu.org/licenses/gpl-3.0.html)
' SPDX-License-Identifier: GPL-3.0-or-later
%>

<!-- #include file="topo.asp" -->
<td bgcolor="gray" width="100%" align="left"><font size="-1" color="black" face="arial">&nbsp;MUDAR HISTORIAL</font></td>
<!-- #include file="fim_topo.asp" -->
<!-- #include file="autenticar_webmaster.asp" -->
<!-- #include file="../sqltext.asp" -->
<!-- #include file="inicio_basedados.asp" -->

<%
tipo = request("tipo")
titulo = SqlText(request("titulo"))
texto = SqlTextMemo(request("texto"))
meio = SqlText(request("meio"))
data = request("data")
tipo_data = request("tipo_data")

if (titulo = "") then
%>
	<font size="+1" color="white" face="arial">O campo <b>t&iacute;tulo</b> &eacute; obrigat&oacute;rio</font>
	<br>
	<font size="+1" color="white" face="arial">prima o botao <b>back</b> no browser e complete a informa&ccedil;&atilde;o</font>	
<%
elseif not isdate(data) then
%>
	<font size="+1" color="white" face="arial">A data n&atilde;o &eacute; v&aacute;lida, o formato certo &eacute; MM/DD/AAAA</font>
	<br>
	<font size="+1" color="white" face="arial">prima o botao <b>back</b> no browser e complete a informa&ccedil;&atilde;o</font>	
<%
else
	SQL = "INSERT INTO historial (titulo, texto, tipo, data, tipo_data, tipo_meio) VALUES "
	SQL = SQL & "('" & titulo & "','" & texto & "','" & tipo & "','" & data & "','" & tipo_data & "','" & meio & "')"
	dbConnection.Execute(SQL)
%>
	<meta http-equiv="refresh" content="0;url=../historial.asp">
	<font size="+1" color="white" face="arial"><b>Historial inserido com sucesso</b></font>
<% end if %>

<!-- #include file="fim_autenticacao.asp" -->
<!-- #include file="fim_basedados.asp" -->