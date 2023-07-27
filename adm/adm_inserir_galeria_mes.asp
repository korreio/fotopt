<!-- #include file="inicio_basedados.asp" -->

<%
SQL = "SELECT * FROM juri_folder WHERE tema_mes <> true ORDER BY nome"
Set assuntoRes = dbConnection.Execute(SQL)
%>

<!-- #include file="topo.asp" -->
<td bgcolor="gray" width="100%" align="left"><font size="-1" color="black" face="arial">&nbsp;TRANSFERIR FOTOS PARA GALERIA DESTAQUE</font></td>
<!-- #include file="fim_topo.asp" -->
<!-- #include file="autenticar_webmaster.asp" -->

<form action="adm_inserir_galeria_mes_res.asp" method=post>
<table border="0" cellpadding="3" cellspacing="0">
<tr>
	<td><font size="-1" color="#FFCC66" face="arial"><b>TIPO: </b></font></td>
	<td>
		<select name="tipo">
			<option value="0">FOTOGRAFIAS DO M&Ecirc;S</option>
			<option value="1">SUPER FOTO PR&Aacute;TICA</option>
			<option value="2">RAIO X</option>
		</select> 
	<font size="-1" color="white" face="arial">(obrig)</font>
	</td>
</tr>
<tr>
	<td><font size="-1" color="#FFCC66" face="arial"><b>GALERIA: </b></font></td>
	<td><select name="tema">
		<%
		do while not assuntoRes.eof 
			SQL = "SELECT nome FROM autor WHERE id = " & assuntoRes("autor")
			Set autorRes = dbConnection.Execute(SQL)
		%>
			<option value="<% =assuntoRes("id") %>"><% =assuntoRes("nome") %> (<% =autorRes("nome") %>)</option>
			<% assuntoRes.MoveNext %>
		<% loop %>
	</select> 
	<font size="-1" color="white" face="arial">(obrig)</font></td>
</tr>
<tr>
	<td>
		<font size="-1" color="#FFCC66" face="arial"><b>M&Ecirc;S: </b></font><br><font size="-1" color="white" face="arial">(m&ecirc;s do<br>destaque)</font>
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
<tr><td><font size="-1" color="#FFCC66" face="arial"><b>T&Iacute;TULO<br>GALERIA: </b></font></td><td><input maxlength="50" size="40" type="text" name="nome"></td></tr>
<tr><td><font size="-1" color="#FFCC66" face="arial"><b>DESCRI&Ccedil;&Atilde;O: </b></font></td><td><textarea name="descricao" cols="38" rows="6" wrap="VIRTUAL"></textarea></td></tr>
<tr><td></td><td></td></tr>		
<tr><td></td><td><input type="Submit" value="Inserir"></td></tr>
</table>
</form>

<!-- #include file="fim_autenticacao.asp" -->
<!-- #include file="fim_basedados.asp" -->