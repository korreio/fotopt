<%
' Copyright: (c) 1999-2023, Tiago Fonseca
' GNU General Public License v3.0+ (see LICENSE.md or https://www.gnu.org/licenses/gpl-3.0.html)
' SPDX-License-Identifier: GPL-3.0-or-later
%>

<!-- #include file="sqltext.asp" -->
<!-- #include file="funcoes_principais.asp" -->

<%
Response.Buffer = TRUE
Server.ScriptTimeOut = 999999

Set fileSystem = CreateObject("Scripting.FileSystemObject")
Set uploadform = Server.CreateObject("SiteGalaxyUpload.Form")

if session("login") = 2 then
	autor = uploadform.Item("autor")
else
	autor = session("login")
end if

%>

<% AutenticarMembro(autor) %>

<%
assunto = uploadform.Item("assunto")
tema = uploadform.Item("tema")

titulo = SqlText(uploadform.Item("titulo"))
lugar = SqlText(uploadform.Item("lugar"))
descricao = SqlText(uploadform.Item("descricao"))

titulo_uk = SqlText(uploadform.Item("titulo_uk"))

dia = uploadform.Item("dia")
mes = uploadform.Item("mes")
ano = uploadform.Item("ano")

if dia <> "" then
	data_tipo = 3
elseif clng(mes) <> 0 then
	dia = 1
	data_tipo = 2
elseif ano <> "" then
	dia = 1
	mes = 1
	data_tipo = 1
else
	dia = 1
	mes = 1
	ano = 1
	data_tipo = 0
end if

data_foto = mes & "/" & dia & "/" & ano

maquina = SqlText(uploadform.Item("maquina"))
lente = SqlText(uploadform.Item("lente"))
filme = SqlText(uploadform.Item("filme"))
filtros = SqlText(uploadform.Item("filtros"))
flash = SqlText(uploadform.Item("flash"))

velocidade = SqlText(uploadform.Item("velocidade"))
abertura = SqlText(uploadform.Item("abertura"))

tratamento_digital = SqlText(uploadform.Item("tratamento_digital"))
outros = SqlText(uploadform.Item("outros"))
anonima = uploadform.Item("anonima")

extensaoFile = fileSystem.GetExtensionName(uploadform("foto").FilePath)
tamanhoFile = uploadform.Item("foto").Size

SQL = "SELECT count(*) AS num FROM foto WHERE autor = " & autor
Set numFotosRes = dbConnection.Execute(SQL)

SQL = "SELECT max(data) AS maximo FROM foto WHERE autor = " & autor
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

' Ja foi autor do mes?
SQL = "SELECT id FROM autor_mes WHERE autor = " & autor
Set autorMesRes = dbConnection.Execute(SQL)

' Tem mencao honrosa?
SQL = "SELECT id FROM autor_mencao_honrosa WHERE autor = " & autor
Set autorMencaoRes = dbConnection.Execute(SQL)

' Momentos historicos
SQL = "SELECT count(*) AS num FROM foto WHERE autor = " & autor & " AND assunto = 22"
Set momentosRes = dbConnection.Execute(SQL)

' Contar fotos do mes
SQL = "SELECT count(*) AS num FROM foto "
SQL = SQL & "INNER JOIN fotomes_votos AS fotomes ON foto.id = fotomes.foto WHERE votos IN "
SQL = SQL & "(SELECT DISTINCT TOP 3 votos FROM fotomes_votos WHERE fotomes.mes = fotomes_votos.mes AND fotomes.ano = fotomes_votos.ano ORDER BY votos DESC) "
SQL = SQL & "AND NOT (fotomes.mes = " & month(date()) & " AND fotomes.ano = " & year(date()) & ") AND foto.autor = " & autor
Set fotomesRes = dbConnection.Execute(SQL)

' Contar fotos em destaque
SQL = "SELECT count(*) AS num FROM destaque_galeria_foto WHERE foto IN (SELECT id FROM foto WHERE autor = " & autor & ")"
Set destaqueRes = dbConnection.Execute(SQL)

' Contar cronicas em destaque
SQL = "SELECT count(*) AS num FROM destaque_cronica WHERE foto IN (SELECT id FROM foto WHERE autor = " & autor & ")"
Set cronicaMesRes = dbConnection.Execute(SQL)

' Contar fotos tema do mes
SQL = "SELECT count(*) AS num FROM tema_mes_foto WHERE autor = " & autor & " AND vencedora = true"
Set temaMesRes = dbConnection.Execute(SQL)

' Contar fotos que participaram em livros ou exposicoes do site
SQL = "SELECT count(*) AS num FROM galeria_especial_foto WHERE foto IN (SELECT id FROM foto WHERE autor = " & autor & ")"
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

if session("login") = 2 then
	maxFotos = 99999
	numFotosHoje = 99999
end if

if numFotosRes("num") >= maxFotos then 
	Menu 1, 8, "INSERIR FOTOGRAFIA"
%>
	<font color="#FFCC66" face="arial"><b>LIMITE M&Aacute;XIMO TOTAL DE FOTOS ATINGIDO</b></font><br><br>
	<font size="-1" color="white" face="arial">
		Atingiu o limite de fotografias que pode ter na sua galeria. Para colocar novas fotos ter&aacute; que apagar uma, ou mais, das que j&aacute; foram inseridas.
		<br><br>
		O m&aacute;ximo de fotos que pode ter na sua galeria &eacute; <font color="#FFCC66"><b><% =maxFotos %></b></font>, este valor &eacute; calculado com base na f&oacute;rmula que
		pode ver em detalhe premindo <b><a href="limite_fotos.asp">LIMITE FOTOS</a></b>.
		<br><br>
		Este limite foi imposto tanto por raz&otilde;es de ordem log&iacute;stica (espa&ccedil;o que as fotos ocupam) como para incitar cada membro a melhorar a sua galeria, substituindo as fotos antigas por outras cada vez melhores.
	</font>
<%
elseif numFotosHoje = 0 then
	Menu 1, 8, "INSERIR FOTOGRAFIA"
%>
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
<%
elseif not isdate(data_foto) then
	Menu 1, 8, "INSERIR FOTOGRAFIA"
%>
	<font size="+1" color="white" face="arial">A data da fotografia n&atilde;o n&atilde;o &eacute; v&aacute;lida</font>
	<br>
	<font size="+1" color="white" face="arial">prima o botao <b>back</b> no browser e corrija a informa&ccedil;&atilde;o</font>	
<%
elseif (extensaoFile <> "JPG") and (extensaoFile <> "jpg") and (extensaoFile <> "JPEG") and (extensaoFile <> "jpeg") then
	Menu 1, 8, "INSERIR FOTOGRAFIA"
%>
	<font size="+1" color="white" face="arial">S&oacute; se aceitam imagens no format &quot;JPG&quot;</font>
	<br>
	<font size="+1" color="white" face="arial">prima o botao <b>back</b> no browser e escolha outra</font>	
<%
elseif tamanhoFile > 102400 then
	Menu 1, 8, "INSERIR FOTOGRAFIA"
%>
	<font size="+1" color="white" face="arial">A foto que enviou &eacute; demasiado grande (tem <% =tamanhoFile %> bytes).<br>O tamanho m&aacute;ximo admitido &eacute; 100kb (102400 bytes).</font><br>
	<font size="+1" color="white" face="arial">Experimente reduzir o tamanho da imagem para um m&aacute;ximo de 500x500 pixeis,<br>se isto n&atilde;o bastar baixe a sua defini&ccedil;&atilde;o.</font><br>	
	<br>
	<font size="+1" color="white" face="arial">prima o botao <b>back</b> no browser e corrija.</font>	
<%
elseif uploadform.ContentDisposition <> "form-data" then
	Menu 1, 8, "INSERIR FOTOGRAFIA"
%>
	<font size="+1" color="white" face="arial">Houve um erro na transmiss&atilde;o da imagem, tente de novo ou contacte o webmaster</font><br>
	<br>
	<font size="+1" color="white" face="arial">prima o botao <b>back</b> para tentar novamente.</font>	
<%
elseif (autor = 0) or (autor = "") then
	Menu 1, 8, "INSERIR FOTOGRAFIA"
%>
	<font size="+1" color="white" face="arial">Houve um erro na transmiss&atilde;o da imagem, tente de novo ou contacte o webmaster</font><br>
	<br>
	<font size="+1" color="white" face="arial">prima o botao <b>back</b> para tentar novamente.</font>	
<%
else
	if numFotosRes("num") < 7 then
		moderar = 1
	else
		moderar = 0
	end if

	SQL = "INSERT INTO foto (autor, assunto, data, tema, titulo, lugar, descricao, maquina, lente, filme, filtros, "
	SQL = SQL & "flash, velocidade, abertura, tratamento_digital, outros, data_tipo, data_foto, titulo_uk, anonima, contador, moderar) VALUES ("
	SQL = SQL & "'" & autor & "','" & assunto & "','" & date() & " " & time() & "','" & tema & "','" & titulo & "','" & lugar
	SQL = SQL & "','" & descricao & "','" & maquina & "','" & lente & "','" & filme & "','" & filtros & "','" & flash & "','" & velocidade
	SQL = SQL & "','" & abertura & "','" & tratamento_digital & "','" & outros & "','" & data_tipo & "','" & data_foto
	SQL = SQL & "','" & titulo_uk & "','" & anonima & "', '0', '" & moderar & "')"
	
	dbConnection.Execute(SQL)

	SQL = "SELECT id FROM foto WHERE autor = " & autor & " ORDER BY id DESC"
	Set fotoRes = dbConnection.Execute(SQL)

	directoria = int(fotoRes("id") / 1000)
	uploadform("foto").SaveAs("c:\inetpub\wwwroot\foto\fotos\fotos\" & directoria & "\foto" & fotoRes("id") & ".jpg")

	' Fazer thumbnail
	Dim JPEGServer 
	Set JPEGServer = CreateObject("JPEGServer.JPEGBuilder")
	JPEGServer.Transform "c:\inetpub\wwwroot\foto\fotos\fotos\" & directoria & "\foto" & fotoRes("id") & ".jpg", "c:\inetpub\wwwroot\foto\fotos\thumbs\" & directoria & "\thumbs" & fotoRes("id") & ".jpg", 150, 90
	Set JPEGServer = Nothing

	session("ordem") = ""

	ComRefresh "galeria.asp?tipo=autor&id=" & autor & "&tema=" & tema
	Menu 1, 8, "INSERIR FOTOGRAFIA"
%>
	<font size="+1" color="white" face="arial"><b>Foto inserida com sucesso</b></font>
<% 
	Set fileSystem = Nothing
	Set uploadform = Nothing
end if 
%>

<% FimPagina() %>
