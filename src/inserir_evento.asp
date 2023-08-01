<!-- #include file="funcoes_principais.asp" -->
<% 
AutenticarMembro(autor)
Menu 6, 1, "INSERIR EVENTO"
%>

<%
SQL = "SELECT nome FROM autor WHERE id = " & session("login")
Set autorRes = dbConnection.Execute(SQL)

SQL = "SELECT * FROM evento_tipo"
Set tipoRes = dbConnection.Execute(SQL)

SQL = "SELECT * FROM distritos WHERE id > 0 ORDER BY nome"
Set distritoRes = dbConnection.Execute(SQL)

SQL = "SELECT id, nome_pt FROM paises_todos WHERE id > 0 ORDER BY nome_pt"
Set paisRes = dbConnection.Execute(SQL)
%>

<form action="inserir_evento_res.asp" method="post">

<table border="0" cellpadding="3" cellspacing="0">
	<tr><td><font size="-1" color="#FFCC66" face="arial"><b>INSERIDO POR: </b></font></td><td><font color="white" face="arial"><% =autorRes("nome") %></font></td></tr>
	<tr><td><br></td><td></td></tr>	
	<tr>
		<td><font size="-1" color="#FFCC66" face="arial"><b>TIPO: </b></font></td>
		<td><select name="tipo">
			<% do while not tipoRes.eof %>
				<option value="<% =tipoRes("id") %>"><% =tipoRes("nome") %></option>
				<% tipoRes.MoveNext %>
			<% loop %>
		</select> <font size="-1" color="white" face="arial">(obrig)</font></td>
	</tr>
	<tr><td><font size="-1" color="#FFCC66" face="arial"><b>NOME EVENTO: </b></font></td><td><input maxlength="255" type="Text" size="40" name="nome"> <font size="-1" color="white" face="arial">(obrig)</font></td></tr>
	<tr><td><font size="-1" color="#FFCC66" face="arial"><b>AUTORES: </b></font><br><font size="-1" color="white" face="arial">(das fotografias<br>expostas)</font></td><td><input maxlength="255" type="Text" size="40" name="autores_fotos"> <font size="-1" face="arial" color="white">(s&oacute; para exposi&ccedil;&otilde;es)</font></td></tr>

	
	<tr><td><br></td><td></td></tr>		
	<tr><td><font size="-1" color="#FFCC66" face="arial"><b>LUGAR OU<br>MORADA: </b></font></td><td><input maxlength="255" type="Text" size="40" name="lugar"></td></tr>
	<tr>
		<td><font size="-1" color="#FFCC66" face="arial"><b>DISTRITO: </b></font></td>
		<td><select name="distrito">
			<option value="0">V&Aacute;RIOS / N&Atilde;O SE APLICA</option>
			<option value="0"></option>
			<% do while not distritoRes.eof %>
				<option value="<% =distritoRes("id") %>"><% =distritoRes("nome") %></option>
				<% distritoRes.MoveNext %>
			<% loop %>
		</select> <font size="-1" color="white" face="arial">(escolher um se o evento &eacute; em Portugal)</font></td>
	</tr>
	<tr>
		<td><font size="-1" color="#FFCC66" face="arial"><b>PA&Iacute;S: </b></font></td>
		<td><select name="pais">
			<option value="0">V&Aacute;RIOS / N&Atilde;O SE APLICA</option>
			<option value="0"></option>
			<% do while not paisRes.eof %>
				<% if paisRes("id") = 139 then %>
					<option selected value="<% =paisRes("id") %>"><% =paisRes("nome_pt") %></option>
				<% else %>	
					<option value="<% =paisRes("id") %>"><% =paisRes("nome_pt") %></option>
				<% end if %>
				<% paisRes.MoveNext %>
			<% loop %>
		</select></td>
	</tr>

	<tr><td><br></td><td></td></tr>		
	<tr>
		<td>
			<font size="-1" color="#FFCC66" face="arial"><b>DATA IN&Iacute;CIO: </b></font>
		</td>
		<td>
			<input maxlength="2" type="Text" size="3" name="dia_inicio">
			<select name="mes_inicio">
				<option value="1">Janeiro</option>
				<option value="2">Fevereiro</option>
				<option value="3">Mar&ccedil;o</option>
				<option value="4">Abril</option>
				<option value="5">Maio</option>
				<option value="6">Junho</option>
				<option value="7">Julho</option>
				<option value="8">Agosto</option>
				<option value="9">Setembro</option>
				<option value="10">Outubro</option>
				<option value="11">Novembro</option>
				<option value="12">Dezembro</option>
			</select>
			<input value="<% =year(date()) %>" maxlength="4" type="Text" size="5" name="ano_inicio">
			<font size="-1" color="white" face="arial">(obrig)</font>
		</td>
	</tr>
	<tr>
		<td>
			<font size="-1" color="#FFCC66" face="arial"><b>DATA FIM: </b></font>
		</td>
		<td>
			<input maxlength="2" type="Text" size="3" name="dia_fim">
			<select name="mes_fim">
				<option value="1">Janeiro</option>
				<option value="2">Fevereiro</option>
				<option value="3">Mar&ccedil;o</option>
				<option value="4">Abril</option>
				<option value="5">Maio</option>
				<option value="6">Junho</option>
				<option value="7">Julho</option>
				<option value="8">Agosto</option>
				<option value="9">Setembro</option>
				<option value="10">Outubro</option>
				<option value="11">Novembro</option>
				<option value="12">Dezembro</option>
			</select>
			<input maxlength="4" type="Text" size="5" name="ano_fim">
			<font size="-1" color="white" face="arial">(se omitida considera-se que o evento s&oacute; dura um dia)</font>
		</td>
	</tr>
	<tr>
	<td><font size="-1" color="#FFCC66" face="arial"><b>HOR&Aacute;RIO: </b></font></td><td><input maxlength="255" type="Text" size="40" name="horario"></td></tr>
	<td><font size="-1" color="#FFCC66" face="arial"><b>CUSTO: </b></font></td><td><input maxlength="255" type="Text" size="40" name="custo"></td>
	<tr><td><br></td><td></td></tr>			
	<tr><td><font size="-1" color="#FFCC66" face="arial"><b>DESCRI&Ccedil;&Atilde;O: </b></font><font size="-1" color="white" face="arial"><br>(se ultrapassar<br>estas 6 linhas<br>o texto ser&aacute;<br>cortado)</font></td><td><textarea name="descricao" cols="38" rows="6" wrap="VIRTUAL"></textarea></td></tr>
	<tr><td><br></td><td></td></tr>									  
	<tr><td><font size="-1" color="#FFCC66" face="arial"><b>ORGANIZA&Ccedil;&Atilde;O: </b></font></td><td><input maxlength="255" type="Text" size="40" name="organizacao"></td></tr>
	<tr><td><font size="-1" color="#FFCC66" face="arial"><b>CONTACTO: </b></font></td><td><input maxlength="255" type="Text" size="40" name="contacto"></td></tr>	
	<tr><td><font size="-1" color="#FFCC66" face="arial"><b>OBSERVA&Ccedil;&Otilde;ES: </b></font><font size="-1" color="white" face="arial"><br>(se ultrapassar<br>estas 6 linhas<br>o texto ser&aacute;<br>cortado)</font></td><td><textarea name="observacoes" cols="38" rows="6" wrap="VIRTUAL"></textarea></td></tr>
	<tr><td></td><td><input type="Submit" value="Inserir evento"></td></tr>
</table>

</form>

<% FimPagina() %>
