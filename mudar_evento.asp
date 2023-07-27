<!-- #include file="sqltext.asp" -->
<!-- #include file="funcoes_principais.asp" -->

<%
evento = request("evento")

SQL = "SELECT * FROM evento WHERE id = " & evento
Set eventoRes = dbConnection.Execute(SQL)

autor = eventoRes("autor")

SQL = "SELECT nome FROM autor WHERE id = " & autor
Set autorRes = dbConnection.Execute(SQL)

SQL = "SELECT * FROM evento_tipo"
Set tipoRes = dbConnection.Execute(SQL)

SQL = "SELECT * FROM distritos WHERE id > 0 ORDER BY nome"
Set distritoRes = dbConnection.Execute(SQL)

SQL = "SELECT id, nome_pt FROM paises_todos WHERE id > 0 ORDER BY nome_pt"
Set paisRes = dbConnection.Execute(SQL)
%>

<% 
AutenticarMembro(autor)
OpcaoMenu "INSERIR EVENTO", "inserir_evento.asp", False, True, -1, False, False
Menu 6, 1, "MUDAR EVENTO"
%>

<form action="mudar_evento_res.asp?evento=<% =evento %>" method="post">

<table border="0" cellpadding="3" cellspacing="0">
	<tr><td><font size="-1" color="#FFCC66" face="arial"><b>INSERIDO POR: </b></font></td><td><font color="white" face="arial"><% =autorRes("nome") %></font></td></tr>
	<tr><td><br></td><td></td></tr>	
	<tr>
		<td><font size="-1" color="#FFCC66" face="arial"><b>TIPO: </b></font></td>
		<td><select name="tipo">
			<% do while not tipoRes.eof %>
				<% if tipoRes("id") = eventoRes("tipo") then %>
					<option selected value="<% =tipoRes("id") %>"><% =tipoRes("nome") %></option>
				<% else %>
					<option value="<% =tipoRes("id") %>"><% =tipoRes("nome") %></option>
				<% end if %>
				<% tipoRes.MoveNext %>
			<% loop %>
		</select> <font size="-1" color="white" face="arial">(obrig)</font></td>
	</tr>
	<tr><td><font size="-1" color="#FFCC66" face="arial"><b>NOME EVENTO: </b></font></td><td><input value="<% =Aspas2Quot(eventoRes("nome")) %>" maxlength="255" type="Text" size="40" name="nome"> <font size="-1" color="white" face="arial">(obrig)</font></td></tr>
	<tr><td><font size="-1" color="#FFCC66" face="arial"><b>AUTORES: </b></font><br><font size="-1" color="white" face="arial">(das fotografias<br>expostas)</font></td><td><input maxlength="255" type="Text" size="40" value="<% =Aspas2Quot(eventoRes("autores_fotos")) %>" name="autores_fotos"> <font size="-1" face="arial" color="white">(s&oacute; para exposi&ccedil;&otilde;es)</font></td></tr>
	
	<tr><td><br></td><td></td></tr>		
	<tr><td><font size="-1" color="#FFCC66" face="arial"><b>LUGAR OU<br>MORADA: </b></font></td><td><input value="<% =Aspas2Quot(eventoRes("lugar")) %>" maxlength="255" type="Text" size="40" name="lugar"></td></tr>
	<tr>
		<td><font size="-1" color="#FFCC66" face="arial"><b>DISTRITO: </b></font></td>
		<td><select name="distrito">
			<option value="0">V&Aacute;RIOS / N&Atilde;O SE APLICA</option>
			<option value="0"></option>
			<% do while not distritoRes.eof %>
				<% if distritoRes("id") = eventoRes("distrito") then %>
					<option selected value="<% =distritoRes("id") %>"><% =distritoRes("nome") %></option>
				<% else %>
					<option value="<% =distritoRes("id") %>"><% =distritoRes("nome") %></option>
				<% end if %>
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
				<% if paisRes("id") = eventoRes("pais") then %>
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
			<input value="<% =day(eventoRes("data_inicio")) %>" maxlength="2" type="Text" size="3" name="dia_inicio">
			<select name="mes_inicio">
				<option <% if month(eventoRes("data_inicio")) = 1 then %>selected<% end if %> value="1">Janeiro</option>
				<option <% if month(eventoRes("data_inicio")) = 2 then %>selected<% end if %> value="2">Fevereiro</option>
				<option <% if month(eventoRes("data_inicio")) = 3 then %>selected<% end if %> value="3">Mar&ccedil;o</option>
				<option <% if month(eventoRes("data_inicio")) = 4 then %>selected<% end if %> value="4">Abril</option>
				<option <% if month(eventoRes("data_inicio")) = 5 then %>selected<% end if %> value="5">Maio</option>
				<option <% if month(eventoRes("data_inicio")) = 6 then %>selected<% end if %> value="6">Junho</option>
				<option <% if month(eventoRes("data_inicio")) = 7 then %>selected<% end if %> value="7">Julho</option>
				<option <% if month(eventoRes("data_inicio")) = 8 then %>selected<% end if %> value="8">Agosto</option>
				<option <% if month(eventoRes("data_inicio")) = 9 then %>selected<% end if %> value="9">Setembro</option>
				<option <% if month(eventoRes("data_inicio")) = 10 then %>selected<% end if %> value="10">Outubro</option>
				<option <% if month(eventoRes("data_inicio")) = 11 then %>selected<% end if %> value="11">Novembro</option>
				<option <% if month(eventoRes("data_inicio")) = 12 then %>selected<% end if %> value="12">Dezembro</option>
			</select>
			<input value="<% =year(eventoRes("data_inicio")) %>" maxlength="4" type="Text" size="5" name="ano_inicio">
			<font size="-1" color="white" face="arial">(obrig)</font>
		</td>
	</tr>
	<tr>
		<td>
			<font size="-1" color="#FFCC66" face="arial"><b>DATA FIM: </b></font>
		</td>
		<td>
			<input value="<% =day(eventoRes("data_fim")) %>" maxlength="2" type="Text" size="3" name="dia_fim">
			<select name="mes_fim">
				<option <% if month(eventoRes("data_fim")) = 1 then %>selected<% end if %> value="1">Janeiro</option>
				<option <% if month(eventoRes("data_fim")) = 2 then %>selected<% end if %> value="2">Fevereiro</option>
				<option <% if month(eventoRes("data_fim")) = 3 then %>selected<% end if %> value="3">Mar&ccedil;o</option>
				<option <% if month(eventoRes("data_fim")) = 4 then %>selected<% end if %> value="4">Abril</option>
				<option <% if month(eventoRes("data_fim")) = 5 then %>selected<% end if %> value="5">Maio</option>
				<option <% if month(eventoRes("data_fim")) = 6 then %>selected<% end if %> value="6">Junho</option>
				<option <% if month(eventoRes("data_fim")) = 7 then %>selected<% end if %> value="7">Julho</option>
				<option <% if month(eventoRes("data_fim")) = 8 then %>selected<% end if %> value="8">Agosto</option>
				<option <% if month(eventoRes("data_fim")) = 9 then %>selected<% end if %> value="9">Setembro</option>
				<option <% if month(eventoRes("data_fim")) = 10 then %>selected<% end if %> value="10">Outubro</option>
				<option <% if month(eventoRes("data_fim")) = 11 then %>selected<% end if %> value="11">Novembro</option>
				<option <% if month(eventoRes("data_fim")) = 12 then %>selected<% end if %> value="12">Dezembro</option>
			</select>
			<input value="<% =year(eventoRes("data_fim")) %>" maxlength="4" type="Text" size="5" name="ano_fim">
			<font size="-1" color="white" face="arial">(se omitida considera-se que o evento s&oacute; dura um dia)</font>
		</td>
	</tr>
	<tr>
	<td><font size="-1" color="#FFCC66" face="arial"><b>HOR&Aacute;RIO: </b></font></td><td><input value="<% =Aspas2Quot(eventoRes("horario")) %>" maxlength="255" type="Text" size="40" name="horario"></td></tr>
	<td><font size="-1" color="#FFCC66" face="arial"><b>CUSTO: </b></font></td><td><input value="<% =Aspas2Quot(eventoRes("custo")) %>" maxlength="255" type="Text" size="40" name="custo"></td>
	<tr><td><br></td><td></td></tr>			
	<tr><td><font size="-1" color="#FFCC66" face="arial"><b>DESCRI&Ccedil;&Atilde;O: </b></font><font size="-1" color="white" face="arial"><br>(se ultrapassar<br>estas 6 linhas<br>o texto ser&aacute;<br>cortado)</font></td><td><textarea name="descricao" cols="38" rows="6" wrap="VIRTUAL"><% =eventoRes("descricao") %></textarea></td></tr>
	<tr><td><br></td><td></td></tr>									  
	<tr><td><font size="-1" color="#FFCC66" face="arial"><b>ORGANIZA&Ccedil;&Atilde;O: </b></font></td><td><input value="<% =Aspas2Quot(eventoRes("organizacao")) %>" maxlength="255" type="Text" size="40" name="organizacao"></td></tr>
	<tr><td><font size="-1" color="#FFCC66" face="arial"><b>CONTACTO: </b></font></td><td><input value="<% =Aspas2Quot(eventoRes("contacto")) %>" maxlength="255" type="Text" size="40" name="contacto"></td></tr>	
	<tr><td><font size="-1" color="#FFCC66" face="arial"><b>OBSERVA&Ccedil;&Otilde;ES: </b></font><font size="-1" color="white" face="arial"><br>(se ultrapassar<br>estas 6 linhas<br>o texto ser&aacute;<br>cortado)</font></td><td><textarea name="observacoes" cols="38" rows="6" wrap="VIRTUAL"><% =eventoRes("observacoes") %></textarea></td></tr>
	
	<tr><td></td><td><input type="Submit" value="Mudar evento"></td></tr>
</table>

</form>

<form method="post" action="apagar_evento_res.asp?evento=<% =evento %>">
	<font color="#FFCC66" face="arial"><b>Para apagar este evento confirme aqui <input type="Checkbox" name="apagar"> e prima o bot&atilde;o - </b></font><input type="Submit" value="Apagar">
</form>

<% FimPagina() %>
