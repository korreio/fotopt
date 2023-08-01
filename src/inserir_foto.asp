<!-- #include file="funcoes_principais.asp" -->

<% 
AutenticarMembro(autor)

if (session("login") = 2) and (request("autor") <> "") then
	login = request("autor")
else
	login = session("login")
end if

OpcaoMenu "EDITAR TEMAS", "editar_temas.asp?autor=" & login, False, True, -1, False, False
OpcaoMenu "VER O MEU LIMITE DE FOTOS", "limite_fotos.asp?autor=" & login, False, True, -1, False, False
Menu 1, 8, "INSERIR FOTOGRAFIA"
%>

<%
SQL = "SELECT nome FROM autor WHERE id = " & login
Set autorRes = dbConnection.Execute(SQL)

SQL = "SELECT count(*) AS num FROM foto WHERE autor = " & login
Set numFotosRes = dbConnection.Execute(SQL)

' Ja foi autor do mes?
SQL = "SELECT id FROM autor_mes WHERE autor = " & login
Set autorMesRes = dbConnection.Execute(SQL)

' Tem mencao honrosa?
SQL = "SELECT id FROM autor_mencao_honrosa WHERE autor = " & login
Set autorMencaoRes = dbConnection.Execute(SQL)

' Momentos historicos
SQL = "SELECT count(*) AS num FROM foto WHERE autor = " & login & " AND assunto = 22"
Set momentosRes = dbConnection.Execute(SQL)

' Contar fotos do mes
SQL = "SELECT count(*) AS num FROM foto "
SQL = SQL & "INNER JOIN fotomes_votos AS fotomes ON foto.id = fotomes.foto WHERE votos IN "
SQL = SQL & "(SELECT DISTINCT TOP 3 votos FROM fotomes_votos WHERE fotomes.mes = fotomes_votos.mes AND fotomes.ano = fotomes_votos.ano ORDER BY votos DESC) "
SQL = SQL & "AND NOT (fotomes.mes = " & month(date()) & " AND fotomes.ano = " & year(date()) & ") AND foto.autor = " & login
Set fotomesRes = dbConnection.Execute(SQL)

' Contar fotos em destaque
SQL = "SELECT count(*) AS num FROM destaque_galeria_foto WHERE foto IN (SELECT id FROM foto WHERE autor = " & login & ")"
Set destaqueRes = dbConnection.Execute(SQL)

' Contar cronicas em destaque
SQL = "SELECT count(*) AS num FROM destaque_cronica WHERE foto IN (SELECT id FROM foto WHERE autor = " & login & ")"
Set cronicaMesRes = dbConnection.Execute(SQL)

' Contar fotos tema do mes
SQL = "SELECT count(*) AS num FROM tema_mes_foto WHERE autor = " & login & " AND vencedora = true"
Set temaMesRes = dbConnection.Execute(SQL)

' Contar fotos que participaram em livros ou exposicoes do site
SQL = "SELECT count(*) AS num FROM galeria_especial_foto WHERE foto IN (SELECT id FROM foto WHERE autor = " & login & ")"
Set galeriaEspecialRes = dbConnection.Execute(SQL)

bonus = temaMesRes("num") + destaqueRes("num") + fotomesRes("num") + momentosRes("num") + cronicaMesRes("num") + galeriaEspecialRes("num")
if autorMesRes.eof then
	if autorMencaoRes.eof then
		maxFotos = 100 + bonus
	else
		maxFotos = 120 + bonus
	end if
else
	maxFotos = 200 + bonus
end if

SQL = "SELECT max(data) AS maximo FROM foto WHERE autor = " & login
Set ultimaDataRes = dbConnection.Execute(SQL)
if isdate(ultimaDataRes("maximo")) then
	numDiasSemFotos = cdate(date() & " " & time()) - ultimaDataRes("maximo")
	numeroHorasSemFotos = numDiasSemFotos / (1 / 24)
	proximaFoto = ultimaDataRes("maximo") + 1
	proximaFotoDentroDe = cdate(date() & " " & time()) - (ultimaDataRes("maximo") + 1)
	if numeroHorasSemFotos >= 24 then
		numFotosHoje = 1
	else
		numFotosHoje = 0
	end if
else
	numFotosHoje = 1
end if

if session("login") = 2 then
	maxFotos = 99999
	numFotosHoje = 99999
end if

' Nao colocar os momentos historicos na lista
if session("login") <> 2 then
	SQL = "SELECT * FROM assunto WHERE id <> 22 ORDER BY nome"
else
	SQL = "SELECT * FROM assunto ORDER BY nome"
end if
Set assuntoRes = dbConnection.Execute(SQL)

SQL = "SELECT id, nome FROM folder WHERE autor = " & login & " ORDER BY nome"
Set temaRes = dbConnection.Execute(SQL)

Dim meses
meses = Array("JANEIRO", "FEVEREIRO", "MAR&Ccedil;O", "ABRIL", "MAIO", "JUNHO", _
			  "JULHO", "AGOSTO", "SETEMBRO", "OUTUBRO", "NOVEMBRO", "DEZEMBRO")

if ((numFotosRes("num") < maxFotos) and (numFotosHoje > 0)) then 
%>
	<form enctype="multipart/form-data" action="inserir_foto_res.asp" method="post">
	
	<font size="-1" color="white" face="arial">
	Por favor consulte a AJUDA para saber pormenores sobre o envio de fotografias (leia com especial aten&ccedil;&atilde;o a parte que est&aacute; <font color="#FFCC66">nesta cor</font>).
	</font>
	<br><br>
	
	<table border="0" cellpadding="3" cellspacing="0">
		<tr><td><font size="-1" color="#FFCC66" face="arial"><b>AUTOR: </b></font></td><td><font size="-1" color="white" face="arial"><% =autorRes("nome") %></font></td></tr>
		<tr>
			<td><font size="-1" color="#FFCC66" face="arial"><b>LIVRE:</b></font></td>
			<td><font size="-1" color="white" face="arial">Pode inserir mais <font color="#FFCC66"><b><% =maxFotos - numFotosRes("num") %></b></font> fotos na sua galeria (prima <a href="limite_fotos.asp">limite fotos</a> para detalhes).</font></td>
		</tr>
		<tr>
			<td><font size="-1" color="#FFCC66" face="arial"><b>HOJE:</b></font></td>
			<td><font size="-1" color="white" face="arial">
				Depois de inserir esta imagem ter� que esperar pelo menos <font color="#FFCC66"><b>24 horas at� poder inserir outra</b></font>,<br>podendo no entanto remove-la e voltar a inseri-la quantas vezes for necess�rio.
			</font></td>
		</tr>
		<% if numFotosRes("num") < 7 then %>
			<tr><td><br></td><td></td></tr>			
			<tr>
				<td><font size="-1" color="#FFCC66" face="arial"><b>AVISO NOVOS<br>UTILIZADORES<br>DAS GALERIAS:</b></font></td>
				<td><font size="-1" color="white" face="arial">
					Para evitar abusos as primeiras 7 imagens que insere no site ser�o moderadas pelo administrador, <br>
					e enquanto n�o forem aprovadas s� voc� as poder� ver na sua galeria. A aprova��o pode chegar a <br>
					levar 2 ou 3 dias, mas entretanto pode inserir mais fotos. Pe�o desculpa pelo inc�modo.
				</font></td>
			</tr>
		<% end if %>
		<tr><td><br></td><td></td></tr>			

		<tr><td valign="top"><font size="-1" color="#FFCC66" face="arial"><b>FOTOGRAFIA<br>A INSERIR: </b></font></td><td><input type="file" name="foto"> <br><font size="-2" color="white" face="arial">(Campo obrigat&oacute;rio. Imagem no formato &quot;JPG&quot; e com um tamanho m&aacute;ximo de 100 kbytes)</font></td></tr>

		<tr><td><br></td><td></td></tr>			
		<tr>
			<td><font size="-1" color="#FFCC66" face="arial"><b>IDENTIFICA��O<br>DESTA FOTO: </b></font></td>
			<td><select name="anonima">
				<option selected value="0">Mostrar sempre o meu nome de autor com esta foto</option>
				<option value="1">Foto an�nima por uma semana, mas aparece na minha galeria pessoal</option>
				<option value="2">Completamente an�nima por uma semana, s� eu a vejo na minha galeria</option>
			</select><br>
			<font size="-2" color="white" face="arial">(Nota: para remover a foto do anonimato antes do fim da semana usar a op��o MUDAR DADOS da foto)</font>
			</td>
		</tr>
		<tr><td><br></td><td></td></tr>		
		<tr><td><font size="-1" color="#FFCC66" face="arial"><b>T&Iacute;TULO: </b></font></td><td><input maxlength="50" size="40" type="text" name="titulo"></td></tr>
		<tr><td><font size="-2" color="#FFCC66" face="arial"><b>T&Iacute;TULO<br>EM INGL&Ecirc;S: </b></font></td><td><input maxlength="50" size="40" type="text" name="titulo_uk"> <font size="-1" color="white" face="arial">(para a vers&atilde;o internacional do site)</font></td></tr>

		<tr><td><br></td><td></td></tr>			
		<tr>
			<td><font size="-1" color="#FFCC66" face="arial"><b>ASSUNTO: </b></font></td>
			<td><select name="assunto">
				<% do while not assuntoRes.eof %>
					<% if assuntoRes("id") = 5 then %>
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
					<option value="<% =temaRes("id") %>"><% =temaRes("nome") %></option>
					<% temaRes.MoveNext %>
				<% loop %>
			</select>
			<font size="-1" color="white" face="arial">(Temas pessoais. Pode cria-los indo a <a href="editar_temas.asp?autor=<% =login %>"><font size="-1" color="white" face="arial"><b>EDITAR TEMAS</b></font></a>)</font></td>
		</tr>
	
		<tr><td><br></td><td></td></tr>		
		<tr><td><font size="-1" color="#FFCC66" face="arial"><b>LUGAR: </b></font></td><td><input maxlength="255" size="40" type="text" name="lugar"></td></tr>
		<tr>
			<td>
				<font size="-1" color="#FFCC66" face="arial"><b>TIRADA EM: </b></font><br><font size="-1" color="white" face="arial">(dia/m&ecirc;s/ano)</font>
			</td>
			<td>
				<input maxlength="2" type="Text" size="3" name="dia">
				<select name="mes">
					<option value="0"></option>
					<% for i = 0 to 11 %>
						<option value="<% =i + 1 %>"><% =meses(i) %></option>
					<% next %>
				</select>
				<input maxlength="4" type="Text" size="5" name="ano">
				<font size="-1" color="white" face="arial">(nada, ano, mes/ano ou dia/mes/ano)</font>
			</td>
		</tr>
		<tr><td><font size="-1" color="#FFCC66" face="arial"><b>DESCRI&Ccedil;&Atilde;O: </b></font><font size="-1" color="white" face="arial"><br>(se ultrapassar<br>estas 6 linhas<br>o texto ser&aacute;<br>cortado)</font></td><td><textarea name="descricao" cols="38" rows="6" wrap="VIRTUAL"></textarea></td></tr>
		<tr><td><br></td><td></td></tr>		
		<tr><td><font size="-1" color="#FFCC66" face="arial"><b>M&Aacute;QUINA: </b></font></td><td><input maxlength="255" size="40" type="Text" name="maquina"></td></tr>
		<tr><td><font size="-1" color="#FFCC66" face="arial"><b>OBJECTIVA: </b></font></td><td><input maxlength="255" size="40" type="Text" name="lente"></td></tr>
		<tr><td><font size="-1" color="#FFCC66" face="arial"><b>FILME: </b></font></td><td><input maxlength="255" size="40" type="Text" name="filme"></td></tr>
		<tr><td><font size="-1" color="#FFCC66" face="arial"><b>FILTROS: </b></font></td><td><input maxlength="255" size="40" type="Text" name="filtros"></td></tr>
		<tr><td><font size="-1" color="#FFCC66" face="arial"><b>ILUMINA��O: </b></font></td><td><input maxlength="255" size="40" type="Text" name="flash"></td></tr>
		<tr><td><br></td><td></td></tr>	
		<tr><td><font size="-1" color="#FFCC66" face="arial"><b>TEMPO DE<br>EXPOSI&Ccedil;&Atilde;O: </b></font></td><td><input maxlength="255" size="20" type="Text" name="velocidade"></td></tr>
		<tr><td><font size="-1" color="#FFCC66" face="arial"><b>ABERTURA: </b></font></td><td><input maxlength="255" size="20" type="Text" name="abertura"></td></tr>
		<tr><td><br></td><td></td></tr>
		<tr><td><font size="-1" color="#FFCC66" face="arial"><b>TRATAMENTO<br>DIGITAL: </b></font><font size="-1" color="white" face="arial"><br>(se ultrapassar<br>estas 6 linhas<br>o texto ser&aacute;<br>cortado)</font></td><td><textarea name="tratamento_digital" cols="38" rows="6" wrap="VIRTUAL"></textarea></td></tr>
		<tr><td><font size="-1" color="#FFCC66" face="arial"><b>OUTROS<br>DADOS: </b></font><font size="-1" color="white" face="arial"><br>(se ultrapassar<br>estas 6 linhas<br>o texto ser&aacute;<br>cortado)</font></td><td><textarea name="outros" cols="38" rows="6" wrap="VIRTUAL"></textarea></td></tr>
		<tr><td><br></td><td></td></tr>		
		<tr><td></td><td>
			<% if session("login") = 2 then	%>
				<input type="hidden" name="autor" value="<% =login %>">
			<% end if %>
			<input type="Submit" value="Inserir foto"><br>
			<font size="-1" color="white" face="arial">
				(logo a seguir a premir este bot&atilde;o &eacute; normal que pare&ccedil;a que	nada acontece.<br>
				Tem que	esperar uns momentos enquanto a foto &eacute; enviada.<br>
				Quando o envio termina com sucesso o seu <i>browser</i> salta autom&aacute;ticamente para a sua galeria)
			</font>
		</td></tr>	
	</table>
	
	</form>
<% elseif numFotosHoje = 0 then %>
	<font color="#FFCC66" face="arial"><b>ULTIMA FOTO INSERIDA H� MENOS DE 24 HORAS</b></font><br><br>
	<font size="-1" color="white" face="arial">
	S� poder� inserir outra foto dentro de 
	<font color="#FFCC66"><b><% =hour(proximaFotoDentroDe) %> hora<% if hour(proximaFotoDentroDe) <> 1 then %>s<% end if %> e <% =minute(proximaFotoDentroDe) %> minuto<% if minute(proximaFotoDentroDe) <> 1 then %>s<% end if %></b></font>
	(depois das
	<% if minute(proximaFoto) < 10 then %>
		<% =hour(proximaFoto) %>:0<% =minute(proximaFoto) %>
	<% else %>
		<% =hour(proximaFoto) %>:<% =minute(proximaFoto) %>
	<% end if %>
	de <% =day(proximaFoto) %>/<% =month(proximaFoto) %>/<% =year(proximaFoto) %> - hora de Lisboa).
	<br><br>
	Cada membro s� pode inserir uma fotografia de 24 em 24 horas, podendo no entanto remover a �ltima e voltar a inseri-la quantas vezes for necess�rio.
	<br><br>
	Este limite foi imposto para aumentar a velocidade de navega&ccedil;&atilde;o no site e para permitir que
	os membros tenham tempo de apreciar a maior parte das fotos inseridas.<br>
	</font>
<% else %>
	<font color="#FFCC66" face="arial"><b>LIMITE M&Aacute;XIMO TOTAL DE FOTOS ATINGIDO</b></font><br><br>
	<font size="-1" color="white" face="arial">
		Atingiu o limite de fotografias que pode ter na sua galeria. Para colocar novas fotos ter&aacute; que apagar uma, ou mais, das que j&aacute; foram inseridas.
		<br><br>
		O m&aacute;ximo de fotos que pode ter na sua galeria &eacute; <font color="#FFCC66"><b><% =maxFotos %></b></font>, este valor &eacute; calculado com base na f&oacute;rmula que
		pode ver em detalhe premindo <b><a href="limite_fotos.asp">LIMITE FOTOS</a></b>.
		<br><br>
		Este limite foi imposto tanto por raz&otilde;es de ordem log&iacute;stica (espa&ccedil;o que as fotos ocupam) como para incitar cada membro a melhorar a sua galeria, substituindo as fotos antigas por outras cada vez melhores.
	</font>
<% end if %>

<% FimPagina() %>
