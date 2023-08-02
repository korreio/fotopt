<%
' Copyright: (c) 1999-2023, Tiago Fonseca
' GNU General Public License v3.0+ (see LICENSE.md or https://www.gnu.org/licenses/gpl-3.0.html)
' SPDX-License-Identifier: GPL-3.0-or-later
%>

<!-- #include file="funcoes_principais.asp" -->

<%
foto = request("foto")

SQL = "SELECT id, autor FROM foto WHERE id = " & foto
Set fotoRes = dbConnection.Execute(SQL)

autor = fotoRes("autor")
apagar = request("apagar")
directoria = int(foto / 1000)
%>

<% AutenticarMembro(autor) %>

<%
if apagar = "on" then
	SQL = "DELETE FROM foto_mes WHERE foto = " & foto
	dbConnection.Execute(SQL)

	SQL = "DELETE FROM fotomes_votos WHERE foto = " & foto
	dbConnection.Execute(SQL)

	SQL = "DELETE FROM foto_mes_proposta WHERE foto = " & foto
	dbConnection.Execute(SQL)
	
	SQL = "DELETE FROM comentario WHERE foto = " & foto
	dbConnection.Execute(SQL)

	SQL = "DELETE FROM comentario_apagado WHERE foto = " & foto
	dbConnection.Execute(SQL)

	SQL = "DELETE FROM tema_mes_foto WHERE foto = " & fotoRes("id")
	dbConnection.Execute(SQL)

	SQL = "DELETE FROM juri_folder_foto WHERE foto = " & fotoRes("id")
	dbConnection.Execute(SQL)

	SQL = "DELETE FROM destaque_galeria_foto WHERE foto = " & fotoRes("id")
	dbConnection.Execute(SQL)

	SQL = "DELETE FROM cronicas WHERE foto = " & fotoRes("id")
	dbConnection.Execute(SQL)

	SQL = "DELETE FROM preferidas_fotos WHERE foto = " & fotoRes("id")
	dbConnection.Execute(SQL)

	SQL = "DELETE FROM associados_galerias WHERE foto = " & fotoRes("id")
	dbConnection.Execute(SQL)

'	SQL = "DELETE FROM foto_membro WHERE foto = " & fotoRes("id")
'	dbConnection.Execute(SQL)
	
	SQL = "DELETE FROM foto WHERE id = " & foto
	dbConnection.Execute(SQL)
	
	Set fileSystem = CreateObject("Scripting.FileSystemObject")

	if fileSystem.FileExists("c:\inetpub\wwwroot\foto\fotos\fotos\" & directoria & "\foto" & foto & ".jpg") then
		fileSystem.DeleteFile "c:\inetpub\wwwroot\foto\fotos\fotos\" & directoria & "\foto" & foto & ".jpg"
	end if
	if fileSystem.FileExists("c:\inetpub\wwwroot\foto\fotos\thumbs\" & directoria & "\thumbs" & foto & ".jpg") then
		fileSystem.DeleteFile "c:\inetpub\wwwroot\foto\fotos\thumbs\" & directoria & "\thumbs" & foto & ".jpg"
	end if

	' Novas
	if fileSystem.FileExists("c:\inetpub\wwwroot\foto\fotos\trocar\foto" & foto & ".jpg") then
		fileSystem.DeleteFile "c:\inetpub\wwwroot\foto\fotos\trocar\foto" & foto & ".jpg"
	end if
	if fileSystem.FileExists("c:\inetpub\wwwroot\foto\fotos\trocar\thumbs" & foto & ".jpg") then
		fileSystem.DeleteFile "c:\inetpub\wwwroot\foto\fotos\trocar\thumbs" & foto & ".jpg"
	end if
	
	set fileSystem = Nothing
%>
	<%
	ComRefresh "lista_temas.asp?autor=" & autor
	Menu 1, 1, "APAGAR FOTO"
	%>
	<font size="+1" color="white" face="arial"><b>Foto apagada com sucesso</b></font>
<%
else
	Menu 1, 1, "APAGAR FOTO"
%>
	<font size="+1" color="white" face="arial">Para apagar tem que confirmar na &quot;check box&quot;</font>
	<br>
	<font size="+1" color="white" face="arial">prima o botao <b>back</b> no browser e corrija</font>	
<% end if %>

<% FimPagina() %>
