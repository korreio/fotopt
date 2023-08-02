<%
' Copyright: (c) 1999-2023, Tiago Fonseca
' GNU General Public License v3.0+ (see LICENSE.md or https://www.gnu.org/licenses/gpl-3.0.html)
' SPDX-License-Identifier: GPL-3.0-or-later
%>

<!-- #include file="topo.asp" -->
<td bgcolor="gray" width="100%" align="left"><font size="-1" color="black" face="arial">&nbsp;INSERIR SEC&Ccedil;&Atilde;O DESTAQUE</font></td>
<!-- #include file="fim_topo.asp" -->
<!-- #include file="autenticar_webmaster.asp" -->
<!-- #include file="../sqltext.asp" -->
<!-- #include file="inicio_basedados.asp" -->

<%
nome = SqlText(request("nome"))
link = SqlText(request("link"))
descricao = SqlTextMemo(request("descricao"))
mes = request("mes")
ano = request("ano")

if nome = "" then
%>
	<font size="+1" color="white" face="arial">Os campos <b>nome</b> e <b>link</b> s&atilde;o obrigat&oacute;rios</font>
	<br>
	<font size="+1" color="white" face="arial">prima o botao <b>back</b> no browser e complete a informa&ccedil;&atilde;o</font>	
<%
else
	SQL = "SELECT id FROM seccao_mes WHERE mes = " & mes & " AND ano = " & ano
	Set seccaoRes = dbConnection.Execute(SQL)

	if seccaoRes.eof then
		SQL = "INSERT INTO seccao_mes (nome, link, descricao, mes, ano) VALUES ('" & nome & "','" & link & "','" & descricao & "','" & mes & "','" & ano & "')"
		dbConnection.Execute(SQL)
	else
		SQL = "UPDATE seccao_mes SET nome = '" & nome & "'"
		SQL = SQL & ", link = '" & link & "'"
		SQL = SQL & ", descricao = '" & descricao & "'"
		SQL = SQL & "WHERE id = " & seccaoRes("id")
		dbConnection.Execute(SQL)
	end if
%>
	<meta http-equiv="refresh" content="0;url=../destaque.asp?mes=<% =mes %>&ano=<% =ano %>">
	<font size="+1" color="white" face="arial"><b>Seccao inserida com sucesso</b></font>
<% end if %>

<!-- #include file="fim_autenticacao.asp" -->
<!-- #include file="fim_basedados.asp" -->