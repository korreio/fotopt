<!-- #include file="sqltext.asp" -->
<!-- #include file="funcoes_principais.asp" -->

<%
foto = request("foto")

' Dados referentes a galeria
primeira = request("primeira")
tipo = request("tipo")
id = request("id")
temaid = request("tema")
num = request("num")

SQL = "SELECT * FROM foto WHERE id = " & foto
Set fotoRes = dbConnection.Execute(SQL)

autor = fotoRes("autor")

SQL = "SELECT nome FROM autor WHERE id = " & autor
Set autorRes = dbConnection.Execute(SQL)

' Nao colocar os momentos historicos na lista
if session("login") <> 2 then
	if fotoRes("assunto") <> 22 then
		SQL = "SELECT * FROM assunto WHERE id <> 22 ORDER BY nome"
	else
		SQL = "SELECT * FROM assunto ORDER BY nome"
	end if
else
	SQL = "SELECT * FROM assunto ORDER BY nome"
end if
Set assuntoRes = dbConnection.Execute(SQL)

SQL = "SELECT id, nome FROM folder WHERE autor = " & autor & " ORDER BY nome"
Set temaRes = dbConnection.Execute(SQL)

Dim meses
meses = Array("JANEIRO", "FEVEREIRO", "MAR&Ccedil;O", "ABRIL", "MAIO", "JUNHO", _
			  "JULHO", "AGOSTO", "SETEMBRO", "OUTUBRO", "NOVEMBRO", "DEZEMBRO")
%>

<% 
AutenticarMembro(autor)
Menu 1, GaleriaSubSeccao(tipo, id), "ALTERAR OU APAGAR FOTO"
%>

<form method="post" action="mudar_foto_res.asp?foto=<% =foto %>&primeira=<% =primeira %>&temaid=<% =temaid %>&tipo=<% =tipo %>&id=<% =id %>&num=<% =num %>">

<table border="0" cellpadding="3" cellspacing="0">
	<% if fotoRes("anonima") <> 0 then %>
		<tr>
			<td><font size="-1" color="#FFCC66" face="arial"><b>IDENTIFICAÇÃO<br>DESTA FOTO: </b></font></td>
			<td><select name="anonima">
				<option value="0">Mostrar sempre o meu nome de autor com esta foto</option>
				<option <% if fotoRes("anonima") = 1 then %>selected<% end if %> value="1">Foto anónima por uma semana, mas aparece na minha galeria pessoal</option>
				<option <% if fotoRes("anonima") = 2 then %>selected<% end if %> value="2">Completamente anónima por uma semana, só eu a vejo na minha galeria</option>
			</select><br>
			<font size="-2" color="white" face="arial">(Nota: para remover a foto do anonimato antes do fim da semana usar a opção MUDAR DADOS da foto)</font>
			</td>
		</tr>
		<tr><td><br></td><td></td></tr>		
	<% end if %>
	<tr><td><font size="-1" color="#FFCC66" face="arial"><b>T&Iacute;TULO: </b></font></td><td><input maxlength="50" value="<% =Aspas2Quot(fotoRes("titulo")) %>" size="40" type="text" name="titulo"></td></tr>
	<tr><td><font size="-2" color="#FFCC66" face="arial"><b>T&Iacute;TULO<br>EM INGL&Ecirc;S: </b></font></td><td><input value="<% =Aspas2Quot(fotoRes("titulo_uk")) %>" maxlength="50" size="40" type="text" name="titulo_uk"> <font size="-1" color="white" face="arial">(para a vers&atilde;o internacional do site)</font></td></tr>
	<tr><td><br></td><td></td></tr>		
	<tr>
		<td><font size="-1" color="#FFCC66" face="arial"><b>ASSUNTO: </b></font></td>
		<td><select name="assunto">
			<% do while not assuntoRes.eof %>
				<% if assuntoRes("id") = fotoRes("assunto") then %>
					<option selected value="<% =assuntoRes("id") %>"><% =assuntoRes("nome") %><% if assuntoRes("descricao") <> "" then %>&nbsp;&nbsp;(<% =assuntoRes("descricao") %>)<% end if %></option>
				<% else %>
					<option value="<% =assuntoRes("id") %>"><% =assuntoRes("nome") %><% if assuntoRes("descricao") <> "" then %>&nbsp;&nbsp;(<% =assuntoRes("descricao") %>)<% end if %></option>
				<% end if %>
				<% assuntoRes.MoveNext %>
			<% loop %>
		</select> 
		<font size="-1" color="white" face="arial">(obrig)</font></td>
	</tr>

	<tr>
		<td><font size="-1" color="#FFCC66" face="arial"><b>SUB-TEMA: </b></font></td>
		<td><select name="tema">
			<option value="0">Geral</option>
			<% do while not temaRes.eof %>
				<% if temaRes("id") = fotoRes("tema") then %>
					<option selected value="<% =temaRes("id") %>"><% =temaRes("nome") %></option>
				<% else %>
					<option value="<% =temaRes("id") %>"><% =temaRes("nome") %></option>				
				<% end if %>
				<% temaRes.MoveNext %>
			<% loop %>
		</select>
		<font size="-1" color="white" face="arial">(Temas pessoais. Pode cria-los indo a <a href="editar_temas.asp"><font size="-1" color="white" face="arial"><b>EDITAR TEMAS</b></font></a>)</font></td>
	</tr>

	<tr><td><br></td><td></td></tr>
	<tr><td><font size="-1" color="#FFCC66" face="arial"><b>LUGAR: </b></font></td><td><input maxlength="255" value="<% =Aspas2Quot(fotoRes("lugar")) %>" size="40" type="text" name="lugar"></td></tr>
	<tr>
		<td>
			<font size="-1" color="#FFCC66" face="arial"><b>TIRADA EM: </b></font><br><font size="-1" color="white" face="arial">(dia/m&ecirc;s/ano)</font>
		</td>
		<td>
			<% if fotoRes("data_tipo") = 3 then  %>
				<input value="<% =day(fotoRes("data_foto")) %>" maxlength="2" type="Text" size="3" name="dia">
			<% else %>
				<input maxlength="2" type="Text" size="3" name="dia">
			<% end if %>
			<select name="mes">
				<option value="0"></option>
				<% for i = 0 to 11 %>
					<% if (fotoRes("data_tipo") > 1) and ((i + 1) = month(fotoRes("data_foto"))) then  %>
						<option selected value="<% =i + 1 %>"><% =meses(i) %></option>
					<% else %>
						<option value="<% =i + 1 %>"><% =meses(i) %></option>
					<% end if %>
				<% next %>
			</select>
			<% if fotoRes("data_tipo") > 0 then  %>
				<input value="<% =year(fotoRes("data_foto")) %>" maxlength="4" type="Text" size="5" name="ano">
			<% else %>
				<input maxlength="4" type="Text" size="5" name="ano">
			<% end if %>
			<font size="-1" color="white" face="arial">(nada, ano, mes/ano ou dia/mes/ano)</font>
		</td>
	</tr>
	<tr><td><font size="-1" color="#FFCC66" face="arial"><b>DESCRI&Ccedil;&Atilde;O: </b></font><font size="-1" color="white" face="arial"><br>(se ultrapassar<br>estas 6 linhas<br>o texto ser&aacute;<br>cortado)</font></td><td><textarea name="descricao" cols="38" rows="6" wrap="VIRTUAL"><% =fotoRes("descricao") %></textarea></td></tr>
	<tr><td><br></td><td></td></tr>		
	<tr><td><font size="-1" color="#FFCC66" face="arial"><b>M&Aacute;QUINA: </b></font></td><td><input maxlength="255" value="<% =Aspas2Quot(fotoRes("maquina")) %>" size="40" type="Text" name="maquina"></td></tr>
	<tr><td><font size="-1" color="#FFCC66" face="arial"><b>OBJECTIVA: </b></font></td><td><input maxlength="255" value="<% =Aspas2Quot(fotoRes("lente")) %>" size="40" type="Text" name="lente"></td></tr>
	<tr><td><font size="-1" color="#FFCC66" face="arial"><b>FILME: </b></font></td><td><input maxlength="255" value="<% =Aspas2Quot(fotoRes("filme")) %>" size="40" type="Text" name="filme"></td></tr>
	<tr><td><font size="-1" color="#FFCC66" face="arial"><b>FILTROS: </b></font></td><td><input maxlength="255" value="<% =Aspas2Quot(fotoRes("filtros")) %>" size="40" type="Text" name="filtros"></td></tr>
	<tr><td><font size="-1" color="#FFCC66" face="arial"><b>ILUMINAÇÃO: </b></font></td><td><input maxlength="255" value="<% =Aspas2Quot(fotoRes("flash")) %>" size="40" type="Text" name="flash"></td></tr>
	<tr><td><br></td><td></td></tr>	
	<tr><td><font size="-1" color="#FFCC66" face="arial"><b>TEMPO DE<br>EXPOSI&Ccedil;&Atilde;O: </b></font></td><td><input maxlength="255" value="<% =Aspas2Quot(fotoRes("velocidade")) %>" size="20" type="Text" name="velocidade"></td></tr>
	<tr><td><font size="-1" color="#FFCC66" face="arial"><b>ABERTURA: </b></font></td><td><input maxlength="255" value="<% =Aspas2Quot(fotoRes("abertura")) %>" size="20" type="Text" name="abertura"></td></tr>
	<tr><td><br></td><td></td></tr>
	<tr><td><font size="-1" color="#FFCC66" face="arial"><b>TRATAMENTO<br>DIGITAL: </b></font><font size="-1" color="white" face="arial"><br>(se ultrapassar<br>estas 6 linhas<br>o texto ser&aacute;<br>cortado)</font></td><td><textarea name="tratamento_digital" cols="38" rows="6" wrap="VIRTUAL"><% =fotoRes("tratamento_digital") %></textarea></td></tr>
	<tr><td><font size="-1" color="#FFCC66" face="arial"><b>OUTROS<br>DADOS: </b></font><font size="-1" color="white" face="arial"><br>(se ultrapassar<br>estas 6 linhas<br>o texto ser&aacute;<br>cortado)</font></td><td><textarea name="outros" cols="38" rows="6" wrap="VIRTUAL"><% =fotoRes("outros") %></textarea></td></tr>
	<tr><td></td><td><input type="Submit" value="Mudar dados">&nbsp;&nbsp;<input type="Reset"></td></tr>
</table>
</form>

<form method="post" action="apagar_foto_res.asp?foto=<% =foto %>">
	<font color="#FFCC66" face="arial"><b>Para apagar esta foto confirme aqui <input type="Checkbox" name="apagar"> e prima o bot&atilde;o - </b></font><input type="Submit" value="Apagar">
</form>

<% FimPagina() %>
