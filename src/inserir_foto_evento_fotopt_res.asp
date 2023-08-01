<!-- #include file="sqltext.asp" -->
<!-- #include file="funcoes_principais.asp" -->

<%
Response.Buffer = TRUE
Server.ScriptTimeOut = 999999
%>

<%
Set fileSystem = CreateObject("Scripting.FileSystemObject")
Set uploadform = Server.CreateObject("SiteGalaxyUpload.Form")

autor = session("login")

evento = uploadform.Item("evento")

titulo = SqlText(uploadform.Item("titulo"))
descricao = SqlText(uploadform.Item("descricao"))

extensaoFile = fileSystem.GetExtensionName(uploadform("foto").FilePath)
tamanhoFile = uploadform.Item("foto").Size

SQL = "SELECT count(*) AS num FROM foto WHERE autor = " & autor
Set numFotosRes = dbConnection.Execute(SQL)

SQL = "SELECT count(*) AS num FROM eventos_fotopt_foto WHERE evento_fotopt = " & evento & " AND autor = " & autor
Set numFotosEventosRes = dbConnection.Execute(SQL)

if session("login") = 2 then
	maxFotos = 99999
else 
	maxFotos = 15
end if

if numFotosEventosRes("num") >= maxFotos then 
	Menu 1, 8, "INSERIR FOTOGRAFIA"
%>
	<font color="#FFCC66" face="arial"><b>LIMITE M&Aacute;XIMO DE FOTOS ATINGIDO PARA ESTE EVENTO</b></font><br><br>
	<font size="-1" color="white" face="arial">
		Atingiu o limite de fotografias que pode ter neste evento. Para colocar novas fotos ter&aacute; que apagar uma, ou mais, das que j&aacute; foram inseridas.
		<br><br>
		O m&aacute;ximo de fotos que pode ter por evento é <font color="#FFCC66"><b><% =maxFotos %></b></font>.
		Este limite foi imposto por raz&otilde;es de ordem log&iacute;stica (espa&ccedil;o que as fotos ocupam).
	</font>
<%
elseif (extensaoFile <> "JPG") and (extensaoFile <> "jpg") and (extensaoFile <> "JPEG") and (extensaoFile <> "jpeg") then
	Menu 2, 4, "INSERIR FOTOGRAFIA EM EVENTO FOTO@PT"
%>
	<font size="+1" color="white" face="arial">S&oacute; se aceitam imagens no format &quot;JPG&quot;</font>
	<br>
	<font size="+1" color="white" face="arial">prima o botao <b>back</b> no browser e escolha outra</font>	
<%
elseif tamanhoFile > 102400 then
	Menu 2, 4, "INSERIR FOTOGRAFIA EM EVENTO FOTO@PT"
%>
	<font size="+1" color="white" face="arial">A foto que enviou &eacute; demasiado grande (tem <% =tamanhoFile %> bytes).<br>O tamanho m&aacute;ximo admitido &eacute; 100kb (102400 bytes).</font><br>
	<font size="+1" color="white" face="arial">Experimente reduzir o tamanho da imagem para um m&aacute;ximo de 500x500 pixeis,<br>se isto n&atilde;o bastar baixe a sua defini&ccedil;&atilde;o.</font><br>	
	<br>
	<font size="+1" color="white" face="arial">prima o botao <b>back</b> no browser e corrija.</font>	
<%
elseif uploadform.ContentDisposition <> "form-data" then
	Menu 2, 4, "INSERIR FOTOGRAFIA EM EVENTO FOTO@PT"
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
	if numFotosRes("num") <= 7 then
		moderar = 1
	else
		moderar = 0
	end if

	SQL = "INSERT INTO eventos_fotopt_foto (autor, titulo, descricao, evento_fotopt, data, contador, moderar) VALUES ("
	SQL = SQL & "'" & autor & "','" & titulo & "','" & descricao & "','" & evento & "','" & date() & " " & time() & "', '0', '" & moderar & "')"
	dbConnection.Execute(SQL)

	SQL = "SELECT id FROM eventos_fotopt_foto WHERE autor = " & autor & " ORDER BY id DESC"
	Set fotoRes = dbConnection.Execute(SQL)

	directoria = int(fotoRes("id") / 1000)
	uploadform("foto").SaveAs("c:\inetpub\wwwroot\foto\fotos\arquivo\eventos_fotopt\fotos\" & directoria & "\foto" & fotoRes("id") & ".jpg")

	' Fazer thumbnail
	Dim JPEGServer 
	Set JPEGServer = CreateObject("JPEGServer.JPEGBuilder")
	JPEGServer.Transform "c:\inetpub\wwwroot\foto\fotos\arquivo\eventos_fotopt\fotos\" & directoria & "\foto" & fotoRes("id") & ".jpg", "c:\inetpub\wwwroot\foto\fotos\arquivo\eventos_fotopt\thumbs\" & directoria & "\thumbs" & fotoRes("id") & ".jpg", 150, 90
	Set JPEGServer = Nothing

	session("ordem") = ""

	ComRefresh "galeria_evento.asp?evento=" & evento
	
	Menu 2, 4, "INSERIR FOTOGRAFIA EM EVENTO FOTO@PT"
%>
	<font size="+1" color="white" face="arial"><b>Foto inserida com sucesso</b></font>
<% 
	Set fileSystem = Nothing
	Set uploadform = Nothing
end if 
%>

<% FimPagina() %>
