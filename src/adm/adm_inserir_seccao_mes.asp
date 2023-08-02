<%
' Copyright: (c) 1999-2023, Tiago Fonseca
' GNU General Public License v3.0+ (see LICENSE.md or https://www.gnu.org/licenses/gpl-3.0.html)
' SPDX-License-Identifier: GPL-3.0-or-later
%>

<!-- #include file="topo.asp" -->
<td bgcolor="gray" width="100%" align="left"><font size="-1" color="black" face="arial">&nbsp;INSERIR SEC&Ccedil;&Atilde;O DESTAQUE</font></td>
<!-- #include file="fim_topo.asp" -->
<!-- #include file="autenticar_webmaster.asp" -->

<form action="adm_inserir_seccao_mes_res.asp" method=post>

<table border="0" cellpadding="3" cellspacing="0">
	<tr>
		<td>
			<font size="-1" color="#FFCC66" face="arial"><b>M&Ecirc;S: </b></font>
		</td>
		<td>
			<select name="mes">
				<% for i = 1 to 12 %>
					<% if i = month(date()) then %>
						<option selected value="<% =i %>"><% =i %></option>
					<% else %>
						<option value="<% =i %>"><% =i %></option>
					<% end if %>
				<% next %>
			</select>
			<input value="<% =year(date()) %>" type="Text" size="4" name="ano">
			<font size="-1" color="white" face="arial">(obrig)</font>
		</td>
	</tr>
	<tr><td><font size="-1" color="#FFCC66" face="arial"><b>NOME: </b></font></td><td><input type="Text" size="40" name="nome"> <font size="-1" color="white" face="arial">(obrig)</font></td></tr>
	<tr><td><font size="-1" color="#FFCC66" face="arial"><b>LINK: </b></font></td><td><input type="Text" size="40" name="link"> <font size="-1" color="white" face="arial">(obrig)</font></td></tr>
	<tr><td><font size="-1" color="#FFCC66" face="arial"><b>DESCRI&Ccedil;&Atilde;O: </b></font><font size="-1" color="white" face="arial"><br>(se ultrapassar<br>estas 6 linhas<br>o texto ser&aacute;<br>cortado)</font></td><td><textarea name="descricao" cols="38" rows="6" wrap="VIRTUAL"></textarea></td></tr>
	<tr><td></td><td><input type="Submit" value="Inserir seccao destaque"></td></tr>
</table>

</form>

<!-- #include file="fim_autenticacao.asp" -->
<!-- #include file="fim_basedados.asp" -->