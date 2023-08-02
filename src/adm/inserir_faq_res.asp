<%
' Copyright: (c) 1999-2023, Tiago Fonseca
' GNU General Public License v3.0+ (see LICENSE.md or https://www.gnu.org/licenses/gpl-3.0.html)
' SPDX-License-Identifier: GPL-3.0-or-later
%>

<!-- #include file="topo.asp" -->
<td bgcolor="gray" width="100%" align="left"><font size="-1" color="black" face="arial">&nbsp;INSERIR FAQ</font></td>
<!-- #include file="fim_topo.asp" -->
<!-- #include file="autenticar_webmaster.asp" -->
<!-- #include file="../sqltext.asp" -->
<!-- #include file="inicio_basedados.asp" -->

<%
tipo = request("tipo")
pergunta = SqlText(request("pergunta"))
resposta = SqlTextMemo(request("resposta"))

if (pergunta = "") or (resposta = "") then
%>
	<font size="+1" color="white" face="arial">Os campos <b>pergunta</b> e <b>resposta</b> s&atilde;o obrigat&oacute;rios</font>
	<br>
	<font size="+1" color="white" face="arial">prima o botao <b>back</b> no browser e complete a informa&ccedil;&atilde;o</font>	
<%
else
	SQL = "INSERT INTO faq (pergunta, resposta, tipo) VALUES "
	SQL = SQL & "('" & pergunta & "','" & resposta & "','" & tipo & "')"
	dbConnection.Execute(SQL)
%>
	<meta http-equiv="refresh" content="0;url=../faq.asp">
	<font size="+1" color="white" face="arial"><b>Faq inserido com sucesso</b></font>
<% end if %>

<!-- #include file="fim_autenticacao.asp" -->
<!-- #include file="fim_basedados.asp" -->