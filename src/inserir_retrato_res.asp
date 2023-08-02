<%
' Copyright: (c) 1999-2023, Tiago Fonseca
' GNU General Public License v3.0+ (see LICENSE.md or https://www.gnu.org/licenses/gpl-3.0.html)
' SPDX-License-Identifier: GPL-3.0-or-later
%>

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

SQL = "SELECT nome FROM autor WHERE id = " & autor
Set autorRes = dbConnection.Execute(SQL)
%>

<% AutenticarMembro(autor) %>

<% 
extensaoFile = fileSystem.GetExtensionName(uploadform("retrato").FilePath)
tamanhoFile = uploadform.Item("retrato").Size

if (extensaoFile <> "JPG") and (extensaoFile <> "jpg") and (extensaoFile <> "JPEG") and (extensaoFile <> "jpeg") then
	Menu 3, 2, "INSERIR OU MUDAR RETRATO" 
%>
	<font size="+1" color="white" face="arial">S&oacute; se aceitam imagens no format &quot;JPG&quot;</font>
	<br>
	<font size="+1" color="white" face="arial">prima o botao <b>back</b> no browser e escolha outra</font>	
<%
elseif tamanhoFile > 51200 then
	Menu 3, 2, "INSERIR OU MUDAR RETRATO" 
%>
	<font size="+1" color="white" face="arial">O retrato que enviou &eacute; demasiado grande (tem <% =tamanhoFile %> bytes).<br>O tamanho m&aacute;ximo admitido &eacute; 50kb (51200 bytes).</font><br>
	<font size="+1" color="white" face="arial">Experimente reduzir o tamanho da imagem para um m&aacute;ximo de 300x300 pixeis,<br>se isto n&atilde;o bastar baixe a sua defini&ccedil;&atilde;o.</font><br>
	<br>
	<font size="+1" color="white" face="arial">prima o botao <b>back</b> no browser e corrija.</font>	
<%
elseif uploadform.ContentDisposition <> "form-data" then
	Menu 3, 2, "INSERIR OU MUDAR RETRATO" 
%>
	<font size="+1" color="white" face="arial">Houve um erro na transmiss&atilde;o da imagem, tente de novo ou contacte o webmaster</font><br>
	<br>
	<font size="+1" color="white" face="arial">prima o botao <b>back</b> para tentar novamente.</font>	
<%
else
	uploadform("retrato").SaveAs("c:\inetpub\wwwroot\foto\fotos\retratos\retrato" & autor & ".jpg")

	SQL = "UPDATE autor SET retrato = '1' WHERE id = " & autor
	dbConnection.Execute(SQL)

	ComRefresh "autor.asp?autor=" & autor
	Menu 3, 2, "INSERIR OU MUDAR RETRATO" 
%>
	<font size="+1" color="white" face="arial"><b>Retrato inserido com sucesso</b></font>
<% 
	Set fileSystem = Nothing
	Set uploadform = Nothing	
end if 
%>

<% FimPagina() %>
