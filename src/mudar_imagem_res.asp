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

foto = uploadform.Item("foto")

' Dados referentes a galeria
primeira = uploadform.Item("primeira")
tipo = uploadform.Item("tipo")
id = uploadform.Item("id")
temaid = uploadform.Item("temaid")
num = uploadform.Item("num")

SQL = "SELECT * FROM foto WHERE id = " & foto
Set fotoRes = dbConnection.Execute(SQL)

autor = fotoRes("autor")
%>

<% AutenticarMembro(autor) %>

<%
extensaoFile = fileSystem.GetExtensionName(uploadform("imagem").FilePath)
tamanhoFile = uploadform.Item("imagem").Size

if (extensaoFile <> "JPG") and (extensaoFile <> "jpg") and (extensaoFile <> "JPEG") and (extensaoFile <> "jpeg") then
	Menu 1, GaleriaSubSeccao(tipo, id), "MUDAR IMAGEM"
%>
	<font size="+1" color="white" face="arial">S&oacute; se aceitam imagens no format &quot;JPG&quot;</font>
	<br>
	<font size="+1" color="white" face="arial">prima o botao <b>back</b> no browser e escolha outra</font>	
<%
elseif tamanhoFile > 102400 then
	Menu 1, GaleriaSubSeccao(tipo, id), "MUDAR IMAGEM"
%>
	<font size="+1" color="white" face="arial">A foto que enviou &eacute; demasiado grande (tem <% =tamanhoFile %> bytes).<br>O tamanho m&aacute;ximo admitido &eacute; 100kb (102400 bytes).</font><br>
	<font size="+1" color="white" face="arial">Experimente reduzir o tamanho da imagem para um m&aacute;ximo de 500x500 pixeis,<br>se isto n&atilde;o bastar baixe a sua defini&ccedil;&atilde;o.</font><br>	
	<br>
	<font size="+1" color="white" face="arial">prima o botao <b>back</b> no browser e corrija.</font>	
<%
elseif uploadform.ContentDisposition <> "form-data" then
	Menu 1, GaleriaSubSeccao(tipo, id), "MUDAR IMAGEM"
%>
	<font size="+1" color="white" face="arial">Houve um erro na transmiss&atilde;o da imagem, tente de novo ou contacte o webmaster</font><br>
	<br>
	<font size="+1" color="white" face="arial">prima o botao <b>back</b> para tentar novamente.</font>	
<%
elseif (autor = 0) or (autor = "") then
	Menu 1, GaleriaSubSeccao(tipo, id), "MUDAR IMAGEM"
%>
	<font size="+1" color="white" face="arial">Houve um erro na transmiss&atilde;o da imagem, tente de novo ou contacte o webmaster</font><br>
	<br>
	<font size="+1" color="white" face="arial">prima o botao <b>back</b> para tentar novamente.</font>	
<%
else
	SQL = "UPDATE foto SET nova = True WHERE id = " & foto
	dbConnection.Execute(SQL)

	uploadform("imagem").SaveAs("c:\inetpub\wwwroot\foto\fotos\trocar\foto" & fotoRes("id") & ".jpg")

	' Fazer thumbnail
	Dim JPEGServer 
	Set JPEGServer = CreateObject("JPEGServer.JPEGBuilder")
	JPEGServer.Transform "c:\inetpub\wwwroot\foto\fotos\trocar\foto" & fotoRes("id") & ".jpg", "c:\inetpub\wwwroot\foto\fotos\trocar\thumbs" & fotoRes("id") & ".jpg", 150, 90
	Set JPEGServer = Nothing

	session("ordem") = ""

	ComRefresh "foto.asp?foto=" & foto & "&primeira=" & primeira & "&tema=" & temaid & "&tipo=" & tipo & "&id=" & id & "&num=" & num
	Menu 1, GaleriaSubSeccao(tipo, id), "MUDAR IMAGEM"
%>
	<font size="+1" color="white" face="arial"><b>Imagem modificada com sucesso</b></font>
<% 
	Set fileSystem = Nothing
	Set uploadform = Nothing
end if 
%>

<% FimPagina() %>
