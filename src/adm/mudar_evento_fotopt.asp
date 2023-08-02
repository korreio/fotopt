<%
' Copyright: (c) 1999-2023, Tiago Fonseca
' GNU General Public License v3.0+ (see LICENSE.md or https://www.gnu.org/licenses/gpl-3.0.html)
' SPDX-License-Identifier: GPL-3.0-or-later
%>

<!-- #include file="inicio_basedados.asp" -->

<% 
evento = request("evento")

SQL = "SELECT * FROM eventos_fotopt WHERE id = " & evento
Set eventoRes = dbConnection.Execute(SQL)
%>

<!-- #include file="topo.asp" -->
<td bgcolor="gray" width="100%" align="left"><font size="-1" color="black" face="arial">&nbsp;MUDAR EVENTO FOTOPT</font></td>
<!-- #include file="fim_topo.asp" -->
<!-- #include file="autenticar_webmaster.asp" -->

<form action="mudar_evento_fotopt_res.asp?evento=<% =evento %>" method=post>

<table border="0" cellpadding="3" cellspacing="0">
	<tr><td><font size="-1" color="#FFCC66" face="arial"><b>NOME: </b></font></td><td><input value="<% =eventoRes("nome") %>" type="Text" name="nome" size="40" maxlength="255"> <font size="-1" color="white" face="arial">(obrig)</font></td></td></tr>
	<tr><td><font size="-1" color="#FFCC66" face="arial"><b>DESCRI��O: </b></font></td><td><textarea name="descricao" cols="38" rows="10" wrap="VIRTUAL"><% =eventoRes("descricao") %></textarea></td></tr>
	<tr><td><font size="-1" color="#FFCC66" face="arial"><b>DATA:</b></font><br><font size="-1" color="white" face="arial">(MM/DD/AAAA)</b></font></td><td><input  value="<% =eventoRes("data") %>" type="Text" name="data" size="10" maxlength="10"> <font size="-1" color="white" face="arial">(obrig)</font></td></td></tr>
	<tr><td><font size="-1" color="#FFCC66" face="arial"><b>OFICIAL:</b></font></td><td><input <% if eventoRes("oficial") = True then %>checked<% end if %> type="checkbox" name="oficial" value="1"> <font size="-1" color="white" face="arial">(obrig)</font></td></td></tr>
	<tr><td></td><td><input type="Submit" value="Mudar evento fotopt"></td></tr>
</table>

</form>

<form method="post" action="apagar_evento_fotopt_res.asp?evento=<% =evento %>">
	<font color="#FFCC66" face="arial"><b>Para apagar este evento confirme aqui <input type="Checkbox" name="apagar"> e prima o bot&atilde;o - </b></font><input type="Submit" value="Apagar">
</form>


<!-- #include file="fim_autenticacao.asp" -->
<!-- #include file="fim_basedados.asp" -->