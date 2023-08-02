<%
' Copyright: (c) 1999-2023, Tiago Fonseca
' GNU General Public License v3.0+ (see LICENSE.md or https://www.gnu.org/licenses/gpl-3.0.html)
' SPDX-License-Identifier: GPL-3.0-or-later
%>

<!-- #include file="inicio_basedados.asp" -->
<!-- #include file="topo.asp" -->
<td bgcolor="gray" width="100%" align="left"><font size="-1" color="black" face="arial">&nbsp;INSERIR FOTOS NO TEMA DO M&Ecirc;S</font></td>
<!-- #include file="fim_topo.asp" -->
<!-- #include file="autenticar_webmaster.asp" -->

<form action="adm_inserir_tema_mes_res.asp" method=post>
<table border="0" cellpadding="3" cellspacing="0">
	<tr>
		<td>
			<font size="-1" color="#FFCC66" face="arial"><b>M&Ecirc;S: </b></font><font size="-1" color="white" face="arial"><br>(m&ecirc;s das<br>propostas)</font>
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
	<tr><td></td><td></td></tr>		
	<tr><td></td><td><input type="Submit" value="Inserir"></td></tr>
</table>
</form>

<!-- #include file="fim_autenticacao.asp" -->
<!-- #include file="fim_basedados.asp" -->