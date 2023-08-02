<%
' Copyright: (c) 1999-2023, Tiago Fonseca
' GNU General Public License v3.0+ (see LICENSE.md or https://www.gnu.org/licenses/gpl-3.0.html)
' SPDX-License-Identifier: GPL-3.0-or-later
%>

<!-- #include file="topo.asp" -->
<td bgcolor="gray" width="100%" align="left"><font size="-1" color="black" face="arial">&nbsp;INSERIR AUTOR MEN&Ccedil;&Atilde;O HONROSA</font></td>
<!-- #include file="fim_topo.asp" -->
<!-- #include file="autenticar_webmaster.asp" -->
<!-- #include file="../sqltext.asp" -->
<!-- #include file="inicio_basedados.asp" -->

<%
autor = SqlText(request("autor"))

if (autor = "") then
%>
	<font size="+1" color="white" face="arial">O campo <b>autor</b> &eacute; obrigat&oacute;rio</font>
	<br>
	<font size="+1" color="white" face="arial">prima o botao <b>back</b> no browser e complete a informa&ccedil;&atilde;o</font>	
<%
else
	SQL = "SELECT id FROM autor_mencao_honrosa WHERE autor = " & autor
	Set autorRes = dbConnection.Execute(SQL)

	if autorRes.eof then
		SQL = "INSERT INTO autor_mencao_honrosa (autor, data) VALUES ('" & autor & "','" & date() & " " & time() & "')"
		dbConnection.Execute(SQL)
	else
	end if

	SQL = "DELETE FROM juri_autor_mencao_honrosa WHERE autor = " & autor
	dbConnection.Execute(SQL)
%>
	<meta http-equiv="refresh" content="0;url=../juri/juri_autor_mencao_honrosa.asp">
	<font size="+1" color="white" face="arial"><b>Autor men&ccedil;&atilde;o honrosa inserido com sucesso</b></font>
<% end if %>

<!-- #include file="fim_autenticacao.asp" -->
<!-- #include file="fim_basedados.asp" -->