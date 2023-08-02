<%
' Copyright: (c) 1999-2023, Tiago Fonseca
' GNU General Public License v3.0+ (see LICENSE.md or https://www.gnu.org/licenses/gpl-3.0.html)
' SPDX-License-Identifier: GPL-3.0-or-later
%>

<!-- #include file="inicio_basedados.asp" -->

<%
mes = request("mes")
ano = request("ano")

SQL = "SELECT * FROM destaque_galeria WHERE mes = " & mes & " AND ano = " & ano
Set galeriaRes = dbConnection.Execute(SQL)
%>

<!-- #include file="topo.asp" -->
<td bgcolor="gray" width="100%" align="left"><font size="-1" color="black" face="arial">&nbsp;MUDAR GALERIA M&Ecirc;S</font></td>
<!-- #include file="fim_topo.asp" -->
<!-- #include file="autenticar_webmaster.asp" -->

<form action="adm_mudar_galeria_mes_res.asp?mes=<% =mes %>&ano=<% =ano %>" method=post>
<table border="0" cellpadding="3" cellspacing="0">
<tr><td><font size="-1" color="#FFCC66" face="arial"><b>T&Iacute;TULO<br>GALERIA: </b></font></td><td><input value="<% =galeriaRes("nome") %>" maxlength="50" size="40" type="text" name="nome"></td></tr>
<tr><td><font size="-1" color="#FFCC66" face="arial"><b>DESCRI&Ccedil;&Atilde;O: </b></font></td><td><textarea name="descricao" cols="38" rows="6" wrap="VIRTUAL"><% =galeriaRes("descricao") %></textarea></td></tr>
<tr><td></td><td></td></tr>		
<tr><td></td><td><input type="Submit" value="Mudar"></td></tr>
</table>
</form>

<!-- #include file="fim_autenticacao.asp" -->
<!-- #include file="fim_basedados.asp" -->