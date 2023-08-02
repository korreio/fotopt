<%
' Copyright: (c) 1999-2023, Tiago Fonseca
' GNU General Public License v3.0+ (see LICENSE.md or https://www.gnu.org/licenses/gpl-3.0.html)
' SPDX-License-Identifier: GPL-3.0-or-later
%>

<!-- #include file="topo.asp" -->
<td bgcolor="gray" width="100%" align="left"><font size="-1" color="black" face="arial">&nbsp;MUDAR OU APAGAR LINK</font></td>
<!-- #include file="fim_topo.asp" -->
<!-- #include file="autenticar_webmaster.asp" -->
<!-- #include file="inicio_basedados.asp" -->

<%
SQL = "SELECT nome FROM autor WHERE id = " & login
Set autorRes = dbConnection.Execute(SQL)

SQL = "SELECT * FROM links_tipo ORDER BY nome"
Set tipoRes = dbConnection.Execute(SQL)

linkId = request("link")

SQL = "SELECT * FROM links WHERE id = " & linkId
Set linkRes = dbConnection.Execute(SQL)
%>

<form action="adm_mudar_link_res.asp?linkid=<% =linkId %>" method="post">

<table border="0" cellpadding="3" cellspacing="0">
	<tr>
		<td><font size="-1" color="#FFCC66" face="arial"><b>TIPO: </b></font></td>
		<td><select name="tipo">
			<% do while not tipoRes.eof %>
				<% if tipoRes("id") = linkRes("tipo") then %>
					<option selected value="<% =tipoRes("id") %>"><% =tipoRes("nome") %></option>
				<% else %>
					<option value="<% =tipoRes("id") %>"><% =tipoRes("nome") %></option>
				<% end if %>
				<% tipoRes.MoveNext %>
			<% loop %>
		</select> <font size="-1" color="white" face="arial">(obrig)</font></td>
	</tr>
	<tr><td><font size="-1" color="#FFCC66" face="arial"><b>LINK</b> (url)<b>:</b></font></td><td><input value="<% =linkRes("link") %>" maxlength="255" size="40" type="text" name="link"> <font size="-1" color="white" face="arial">(obrig)</font></td></tr>
	<tr><td><br></td><td></td></tr>				
	<tr><td><font size="-1" color="#FFCC66" face="arial"><b>NOME DO SITE: </b></font></td><td><input value="<% =linkRes("nome") %>" maxlength="255" size="40" type="text" name="nome"></td></tr>
	<tr><td><font size="-1" color="#FFCC66" face="arial"><b>DESCRI&Ccedil;&Atilde;O: </b></font><font size="-1" color="white" face="arial"><br>(se ultrapassar<br>estas 6 linhas<br>o texto ser&aacute;<br>cortado)</font></td><td><textarea name="descricao" cols="38" rows="6" wrap="VIRTUAL"><% =linkRes("descricao") %></textarea></td></tr>
	<tr><td></td><td><input type="Submit" value="Mudar Link"></td></tr>	
</table>

</form>

<form method="post" action="adm_apagar_link_res.asp?linkid=<% =linkId %>&tipo=<% =linkRes("tipo") %>">
	<font color="#FFCC66" face="arial"><b>Para apagar este link corfirme aqui <input type="Checkbox" name="apagar"> e prima o bot&atilde;o - </b></font><input type="Submit" value="Apagar">
</form>

<!-- #include file="fim_autenticacao.asp" -->
<!-- #include file="fim_basedados.asp" -->