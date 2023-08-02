<%
' Copyright: (c) 1999-2023, Tiago Fonseca
' GNU General Public License v3.0+ (see LICENSE.md or https://www.gnu.org/licenses/gpl-3.0.html)
' SPDX-License-Identifier: GPL-3.0-or-later
%>

<!-- #include file="inicio_basedados.asp" -->

<%
voto = request("voto")
foto = request("foto")
ano = request("ano")
mes = request("mes")
%>

<!-- #include file="topo.asp" -->
<td bgcolor="gray" width="100%" align="left"><font size="-1" color="black" face="arial">&nbsp;APAGAR VOTO NA FOTO DO M&Ecirc;S</font></td>
<!-- #include file="fim_topo.asp" -->
<!-- #include file="autenticar_webmaster.asp" -->

<%
SQL = "SELECT id, votos FROM fotomes_votos WHERE foto = " & foto
Set votosRes = dbConnection.Execute(SQL)

if votosRes("votos") <> 1 then
	SQL = "UPDATE fotomes_votos SET votos = '" & votosRes("votos") - 1 & "' WHERE id = " & votosRes("id")
	dbConnection.Execute(SQL)
else
	SQL = "DELETE FROM fotomes_votos WHERE id = " & votosRes("id")
	dbConnection.Execute(SQL)
end if
		
SQL = "DELETE FROM foto_mes WHERE id = " & voto
dbConnection.Execute(SQL)
%>

<meta http-equiv="refresh" content="0;url=../fotomes.asp">
<font size="+1" color="white" face="arial"><b>Voto apagado com sucesso</b></font>

<!-- #include file="fim_autenticacao.asp" -->
<!-- #include file="fim_basedados.asp" -->