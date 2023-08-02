<%
' Copyright: (c) 1999-2023, Tiago Fonseca
' GNU General Public License v3.0+ (see LICENSE.md or https://www.gnu.org/licenses/gpl-3.0.html)
' SPDX-License-Identifier: GPL-3.0-or-later
%>

<!-- #include file="inicio_basedados.asp" -->

<%
votacao = request("votacao")
item = request("item")
apagar = request("apagar")
%>

<!-- #include file="topo.asp" -->
<td bgcolor="gray" width="100%" align="left"><font size="-1" color="black" face="arial">&nbsp;APAGAR MEMBROS CONGELADOS</font></td>
<!-- #include file="fim_topo.asp" -->
<!-- #include file="autenticar_webmaster.asp" -->

<%
SQL = "SELECT * FROM autor WHERE congelado = True AND data < #" & date() - 14 & "#"
Set autorRes = dbConnection.Execute(SQL)

do while not autorRes.eof
	autor = autorRes("id")
%>
	<!-- #include file="adm_apagar_autor.asp" -->
<%
	autorRes.MoveNext
loop
%>

<meta http-equiv="refresh" content="0;url=adm_nao_confirmados.asp">
<font size="+1" color="white" face="arial"><b>Membros apagados</b></font>

<!-- #include file="fim_autenticacao.asp" -->
<!-- #include file="fim_basedados.asp" -->