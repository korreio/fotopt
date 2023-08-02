<%
' Copyright: (c) 1999-2023, Tiago Fonseca
' GNU General Public License v3.0+ (see LICENSE.md or https://www.gnu.org/licenses/gpl-3.0.html)
' SPDX-License-Identifier: GPL-3.0-or-later
%>

<!-- #include file="inicio_basedados.asp" -->

<%
voto = request("voto")
item = request("item")
%>

<!-- #include file="topo.asp" -->
<td bgcolor="gray" width="100%" align="left"><font size="-1" color="black" face="arial">&nbsp;APAGAR VOTO</font></td>
<!-- #include file="fim_topo.asp" -->
<!-- #include file="autenticar_webmaster.asp" -->

<%
SQL = "SELECT id, votos FROM votacao_item WHERE id = " & item
Set itemRes = dbConnection.Execute(SQL)

SQL = "UPDATE votacao_item SET votos = '" & itemRes("votos") - 1 & "' WHERE id = " & itemRes("id")
dbConnection.Execute(SQL)
		
SQL = "DELETE FROM votacao_voto WHERE id = " & voto
dbConnection.Execute(SQL)
%>

<meta http-equiv="refresh" content="0;url=../votacao_votos.asp?item=<% =item %>">
<font size="+1" color="white" face="arial"><b>Voto apagado com sucesso</b></font>

<!-- #include file="fim_autenticacao.asp" -->
<!-- #include file="fim_basedados.asp" -->