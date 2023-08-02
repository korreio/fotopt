<%
' Copyright: (c) 1999-2023, Tiago Fonseca
' GNU General Public License v3.0+ (see LICENSE.md or https://www.gnu.org/licenses/gpl-3.0.html)
' SPDX-License-Identifier: GPL-3.0-or-later
%>

<!-- #include file="inicio_basedados.asp" -->
<!-- #include file="topo.asp" -->
<td bgcolor="gray" width="100%" align="left"><font size="-1" color="black" face="arial">&nbsp;APAGAR GALERIAS TEMA DO M&Ecirc;S</font></td>
<!-- #include file="fim_topo.asp" -->
<!-- #include file="autenticar_webmaster.asp" -->

<%
SQL = "DELETE FROM juri_folder_foto WHERE folder IN (SELECT id FROM juri_folder WHERE tema_mes = true)"
dbConnection.Execute(SQL)
%>

<meta http-equiv="refresh" content="0;url=../juri/opcoes_juri.asp">
<font size="+1" color="white" face="arial"><b>Galerias apagadas com sucesso</b></font>

<!-- #include file="fim_autenticacao.asp" -->
<!-- #include file="fim_basedados.asp" -->