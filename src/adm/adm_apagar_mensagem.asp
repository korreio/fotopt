<%
' Copyright: (c) 1999-2023, Tiago Fonseca
' GNU General Public License v3.0+ (see LICENSE.md or https://www.gnu.org/licenses/gpl-3.0.html)
' SPDX-License-Identifier: GPL-3.0-or-later
%>

<!-- #include file="inicio_basedados.asp" -->

<%
mensagem = request("mensagem")
assunto = request("assunto")
pagina = request("pagina")
%>

<!-- #include file="topo.asp" -->
<td bgcolor="gray" width="100%" align="left"><font size="-1" color="black" face="arial">&nbsp;APAGAR MENSAGEM</font></td>
<!-- #include file="fim_topo.asp" -->
<!-- #include file="autenticar_webmaster.asp" -->

<%
ApagaSubMensagens mensagem, assunto
%>

<meta http-equiv="refresh" content="0;url=../ver_debates.asp?pagina=<% =pagina %>&assunto=<% =assunto %>">
<font size="+1" color="white" face="arial"><b>Mensagem apagada com sucesso</b></font>

<!-- #include file="fim_autenticacao.asp" -->
<!-- #include file="fim_basedados.asp" -->

<% 
sub ApagaSubMensagens(id, assunto) 
	SQL = "SELECT id, assunto FROM debate_mensagem WHERE subid = " & id
	Set subRes = dbConnection.Execute(SQL)

	do while not subRes.eof
		ApagaSubMensagens subRes("id"), subRes("assunto")
		subRes.MoveNext
	loop

	SQL = "DELETE FROM debate_mensagem WHERE id = " & id
	dbConnection.Execute(SQL)
end sub
%>