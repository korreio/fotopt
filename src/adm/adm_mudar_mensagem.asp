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

SQL = "SELECT * FROM debate_assunto ORDER BY nome"
Set tipoRes = dbConnection.Execute(SQL)
%>

<!-- #include file="topo.asp" -->
<td bgcolor="gray" width="100%" align="left"><font size="-1" color="black" face="arial">&nbsp;APAGAR MENSAGEM</font></td>
<!-- #include file="fim_topo.asp" -->
<!-- #include file="autenticar_webmaster.asp" -->

<form action="adm_mudar_mensagem_res.asp?pagina=<% =pagina %>&mensagem=<% =mensagem %>" method="post">

<table border="0" cellpadding="3" cellspacing="0">
	<tr>
		<td><font size="-1" color="#FFCC66" face="arial"><b>ASSUNTO: </b></font></td>
		<td><select name="tipo">
			<% do while not tipoRes.eof %>
				<option value="<% =tipoRes("id") %>"><% =tipoRes("nome") %></option>
				<% tipoRes.MoveNext %>
			<% loop %>
		</select> <font size="-1" color="white" face="arial">(obrig)</font></td>
	</tr>
	<tr><td></td><td><input type="Submit" value="Mudar mensagem"></td></tr>
</table>

</form>


<!-- #include file="fim_autenticacao.asp" -->
<!-- #include file="fim_basedados.asp" -->
