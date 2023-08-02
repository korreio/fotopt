<%
' Copyright: (c) 1999-2023, Tiago Fonseca
' GNU General Public License v3.0+ (see LICENSE.md or https://www.gnu.org/licenses/gpl-3.0.html)
' SPDX-License-Identifier: GPL-3.0-or-later
%>

<!-- #include file="topo.asp" -->
<td bgcolor="gray" width="100%" align="left"><font size="-1" color="black" face="arial">&nbsp;MUDAR ARTIGO PARA OPINIAO</font></td>
<!-- #include file="fim_topo.asp" -->
<!-- #include file="autenticar_webmaster.asp" -->
<!-- #include file="../sqltext.asp" -->
<!-- #include file="inicio_basedados.asp" -->

<%
ordem = request("ordem")
artigo = request("artigo")

tipo = request("tipo")
marca = SqlText(request("marca"))
modelo = SqlText(request("modelo"))

descricao = SqlTextMemo(request("descricao"))

if (marca = "") or (modelo = "") then
%>
	<font size="+1" color="white" face="arial">Os campos <b>marca</b> e <b>modelo</b> s&atilde;o obrigat&oacute;rios</font>
	<br>
	<font size="+1" color="white" face="arial">prima o botao <b>back</b> no browser e complete a informa&ccedil;&atilde;o</font>	
<%
else
	SQL = "UPDATE opiniao_artigo SET "
	SQL = SQL & "tipo = '" & tipo & "',"
	SQL = SQL & "marca = '" & marca & "',"	
	SQL = SQL & "modelo = '" & modelo & "',"
	SQL = SQL & "descricao = '" & descricao & "' "
	SQL = SQL & "WHERE id = " & artigo
	dbConnection.Execute(SQL)
%>
	<meta http-equiv="refresh" content="0;url=../opiniao_artigo.asp?ordem=<% =ordem %>&artigo=<% =artigo %>">
	<font size="+1" color="white" face="arial"><b>Artigo mudado com sucesso</b></font>
<% end if %>

<!-- #include file="fim_autenticacao.asp" -->
<!-- #include file="fim_basedados.asp" -->