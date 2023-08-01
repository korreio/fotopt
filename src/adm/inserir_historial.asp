<!-- #include file="inicio_basedados.asp" -->

<% 
SQL = "SELECT * FROM historial_tipo"
Set tipoRes = dbConnection.Execute(SQL)

SQL = "SELECT * FROM data_tipo WHERE id <= 3 ORDER BY id DESC"
Set tipoDataRes = dbConnection.Execute(SQL)
%>

<!-- #include file="topo.asp" -->
<td bgcolor="gray" width="100%" align="left"><font size="-1" color="black" face="arial">&nbsp;INSERIR HISTORIAL</font></td>
<!-- #include file="fim_topo.asp" -->
<!-- #include file="autenticar_webmaster.asp" -->

<form action="inserir_historial_res.asp" method=post>

<table border="0" cellpadding="3" cellspacing="0">
	<tr>
		<td><font size="-1" color="#FFCC66" face="arial"><b>TIPO: </b></font></td>
		<td><select name="tipo">
			<% do while not tipoRes.eof %>
				<option value="<% =tipoRes("id") %>"><% =tipoRes("nome") %></option>
				<% tipoRes.MoveNext %>
			<% loop %>
		</select> 
		<font size="-1" color="white" face="arial">(obrig)</font></td>
	</tr>
	<tr><td><font size="-1" color="#FFCC66" face="arial"><b>T&Iacute;TULO: </b></font></td><td><input type="Text" name="titulo" size="40"> <font size="-1" color="white" face="arial">(obrig)</font></td></td></tr>
	<tr><td><font size="-1" color="#FFCC66" face="arial"><b>TEXTO: </b></font></td><td><textarea name="texto" cols="38" rows="20" wrap="VIRTUAL"></textarea></td></tr>
	<tr><td><font size="-1" color="#FFCC66" face="arial"><b>MEIO<br>COMUNICA&Ccedil;&Atilde;O: </b></font></td><td><input type="Text" name="meio" size="40"></td></tr>
	<tr>
		<td>
			<font size="-1" color="#FFCC66" face="arial"><b>DATA: </b></font>
		</td>
		<td>
			<input value="MM/DD/AAAA" type="Text" name="data" size="12">
			<select name="tipo_data">
				<% do while not tipoDataRes.eof %>
					<option value="<% =tipoDataRes("id") %>"><% =tipoDataRes("tipo") %></option>
					<% tipoDataRes.MoveNext %>
				<% loop %>
			</select>
		 	<font size="-1" color="white" face="arial">(obrig)</font>
		</td>
	</tr>
	<tr><td></td><td><input type="Submit" value="Inserir Historial"></td></tr>
</table>

</form>

<!-- #include file="fim_autenticacao.asp" -->
<!-- #include file="fim_basedados.asp" -->