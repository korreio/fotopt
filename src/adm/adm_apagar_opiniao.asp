<%
' Copyright: (c) 1999-2023, Tiago Fonseca
' GNU General Public License v3.0+ (see LICENSE.md or https://www.gnu.org/licenses/gpl-3.0.html)
' SPDX-License-Identifier: GPL-3.0-or-later
%>

<!-- #include file="inicio_basedados.asp" -->

<%
ordem = request("ordem")
artigo = request("artigo")
opiniao = request("opiniao")
%>

<!-- #include file="topo.asp" -->
<td bgcolor="gray" width="100%" align="left"><font size="-1" color="black" face="arial">&nbsp;APAGAR OPINI&Atilde;O DE ARTIGO</font></td>
<!-- #include file="fim_topo.asp" -->
<!-- #include file="autenticar_webmaster.asp" -->

<%
SQL = "SELECT id, artigo, classificacao FROM opiniao WHERE id = " & opiniao
Set opiniaoRes = dbConnection.Execute(SQL)

SQL = "SELECT valor FROM opiniao_classificacao WHERE id = " & opiniaoRes("classificacao")
Set classificacaoRes = dbConnection.Execute(SQL)

SQL = "SELECT soma_opinioes, num_opinioes, media_opinioes FROM opiniao_artigo WHERE id = " & opiniaoRes("artigo")
Set artigoRes = dbConnection.Execute(SQL)

if artigoRes("num_opinioes") > 1 then
	SQL = "UPDATE opiniao_artigo SET soma_opinioes = '" & artigoRes("soma_opinioes") - classificacaoRes("valor")
	SQL = SQL & "', num_opinioes = '" & artigoRes("num_opinioes") - 1
	SQL = SQL & "', media_opinioes = '" & (artigoRes("soma_opinioes") - classificacaoRes("valor")) / (artigoRes("num_opinioes") - 1)
	SQL = SQL & "' WHERE id = " & opiniaoRes("artigo")
	dbConnection.Execute(SQL)
else
	SQL = "UPDATE opiniao_artigo SET soma_opinioes = '0', num_opinioes = '0', media_opinioes = '0' WHERE id = " & opiniaoRes("artigo")
	dbConnection.Execute(SQL)
end if		

SQL = "DELETE FROM opiniao WHERE id = " & opiniao
dbConnection.Execute(SQL)
		
%>
<meta http-equiv="refresh" content="0;url=../opiniao_artigo.asp?ordem=<% =ordem %>&artigo=<% =artigo %>">
<font size="+1" color="white" face="arial"><b>Artigo opini&atilde;o apagado com sucesso</b></font>

<!-- #include file="fim_autenticacao.asp" -->
<!-- #include file="fim_basedados.asp" -->