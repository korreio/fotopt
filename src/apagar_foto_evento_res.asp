<%
' Copyright: (c) 1999-2023, Tiago Fonseca
' GNU General Public License v3.0+ (see LICENSE.md or https://www.gnu.org/licenses/gpl-3.0.html)
' SPDX-License-Identifier: GPL-3.0-or-later
%>

<!-- #include file="funcoes_principais.asp" -->

<%
evento = request("evento")
foto = request("foto")

SQL = "SELECT id, autor FROM eventos_fotopt_foto WHERE id = " & foto
Set fotoRes = dbConnection.Execute(SQL)

autor = fotoRes("autor")
apagar = request("apagar")
directoria = int(foto / 1000)
%>

<% AutenticarMembro(autor) %>

<%
if apagar = "on" then
	SQL = "DELETE FROM eventos_fotopt_comentarios WHERE foto = " & foto
	dbConnection.Execute(SQL)

	SQL = "DELETE FROM eventos_fotopt_foto WHERE id = " & foto
	dbConnection.Execute(SQL)
	
	Set fileSystem = CreateObject("Scripting.FileSystemObject")

	if fileSystem.FileExists("c:\inetpub\wwwroot\foto\fotos\arquivo\eventos_fotopt\fotos\" & directoria & "\foto" & foto & ".jpg") then
		fileSystem.DeleteFile "c:\inetpub\wwwroot\foto\fotos\arquivo\eventos_fotopt\fotos\" & directoria & "\foto" & foto & ".jpg"
	end if
	if fileSystem.FileExists("c:\inetpub\wwwroot\foto\fotos\arquivo\eventos_fotopt\thumbs\" & directoria & "\thumbs" & foto & ".jpg") then
		fileSystem.DeleteFile "c:\inetpub\wwwroot\foto\fotos\arquivo\eventos_fotopt\thumbs\" & directoria & "\thumbs" & foto & ".jpg"
	end if
	
	set fileSystem = Nothing

	ComRefresh "galeria_evento.asp?evento=" & evento
	Menu 2, 4, "APAGAR FOTO"
	%>
	<font size="+1" color="white" face="arial"><b>Foto apagada com sucesso</b></font>
<%
else
	Menu 2, 4, "APAGAR FOTO"
%>
	<font size="+1" color="white" face="arial">Para apagar tem que confirmar na &quot;check box&quot;</font>
	<br>
	<font size="+1" color="white" face="arial">prima o botao <b>back</b> no browser e corrija</font>	
<% end if %>

<% FimPagina() %>
