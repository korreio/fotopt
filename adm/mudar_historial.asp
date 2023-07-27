<!-- #include file="inicio_basedados.asp" -->

<% 
historial = request("historial")

SQL = "SELECT * FROM historial WHERE id = " & historial
Set historialRes = dbConnection.Execute(SQL)

SQL = "SELECT * FROM historial_tipo"
Set tipoRes = dbConnection.Execute(SQL)

SQL = "SELECT * FROM data_tipo ORDER BY id DESC"
Set tipoDataRes = dbConnection.Execute(SQL)
%>

<!-- #include file="topo.asp" -->
<td bgcolor="gray" width="100%" align="left"><font size="-1" color="black" face="arial">&nbsp;MUDAR HISTORIAL OU APAGAR</font></td>
<!-- #include file="fim_topo.asp" -->
<!-- #include file="autenticar_webmaster.asp" -->

<form action="mudar_historial_res.asp?historial=<% =historial %>" method=post>

<table border="0" cellpadding="3" cellspacing="0">
	<tr>
		<td><font size="-1" color="#FFCC66" face="arial"><b>TIPO: </b></font></td>
		<td><select name="tipo">
			<% do while not tipoRes.eof %>
				<% if tipoRes("id") = historialRes("tipo") then %>
					<option selected value="<% =tipoRes("id") %>"><% =tipoRes("nome") %></option>
				<% else %>
					<option value="<% =tipoRes("id") %>"><% =tipoRes("nome") %></option>
				<% end if %>
				<% tipoRes.MoveNext %>
			<% loop %>
		</select> 
		<font size="-1" color="white" face="arial">(obrig)</font></td>
	</tr>
	<tr><td><font size="-1" color="#FFCC66" face="arial"><b>T&Iacute;TULO: </b></font></td><td><input value="<% =historialRes("titulo") %>" type="Text" name="titulo" size="40"> <font size="-1" color="white" face="arial">(obrig)</font></td></td></tr>
	<tr><td><font size="-1" color="#FFCC66" face="arial"><b>TEXTO: </b></font></td><td><textarea name="texto" cols="38" rows="20" wrap="VIRTUAL"><% =historialRes("texto") %></textarea></td></tr>
	<tr><td><font size="-1" color="#FFCC66" face="arial"><b>MEIO<br>COMUNICA&Ccedil;&Atilde;O: </b></font></td><td><input value="<% =historialRes("tipo_meio") %>" type="Text" name="meio" size="40"></td></tr>
	<tr>
		<td>
			<font size="-1" color="#FFCC66" face="arial"><b>DATA: </b></font>
		</td>
		<td>
			<input value="<% =historialRes("data") %>" type="Text" name="data" size="12">
			<select name="tipo_data">
				<% do while not tipoDataRes.eof %>
					<% if tipoDataRes("id") = historialRes("tipo_data") then %>
						<option selected value="<% =tipoDataRes("id") %>"><% =tipoDataRes("tipo") %></option>
					<% else %>
						<option value="<% =tipoDataRes("id") %>"><% =tipoDataRes("tipo") %></option>
					<% end if %>
					<% tipoDataRes.MoveNext %>
				<% loop %>
			</select>
		 	<font size="-1" color="white" face="arial">(obrig)</font>
		</td>
	</tr>
	<tr><td></td><td><input type="Submit" value="Mudar Historial"></td></tr>
</table>

</form>

<form method="post" action="adm_apagar_historial_res.asp?historial=<% =historial %>">
	<font color="#FFCC66" face="arial"><b>Para apagar este historial confirme aqui <input type="Checkbox" name="apagar"> e prima o bot&atilde;o - </b></font><input type="Submit" value="Apagar">
</form>

<!-- #include file="fim_autenticacao.asp" -->
<!-- #include file="fim_basedados.asp" -->