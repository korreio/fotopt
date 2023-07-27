<!-- #include file="topo.asp" -->
<td bgcolor="gray" width="100%" align="left"><font size="-1" color="black" face="arial">&nbsp;INSERIR AUTOR M&Ecirc;S</font></td>
<!-- #include file="fim_topo.asp" -->
<!-- #include file="autenticar_webmaster.asp" -->

<form action="adm_inserir_autor_mes_res.asp" method=post>

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
	<tr><td><font size="-1" color="#FFCC66" face="arial"><b>AUTOR: </b></font></td><td><input type="Text" size="10" name="autor"> <font size="-1" color="white" face="arial">(obrig)</font></td></tr>
	<tr><td></td><td><input type="Submit" value="Inserir autor m&ecirc;s"></td></tr>
</table>

</form>

<!-- #include file="fim_autenticacao.asp" -->
<!-- #include file="fim_basedados.asp" -->