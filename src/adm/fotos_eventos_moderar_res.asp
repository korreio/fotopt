<%
' Copyright: (c) 1999-2023, Tiago Fonseca
' GNU General Public License v3.0+ (see LICENSE.md or https://www.gnu.org/licenses/gpl-3.0.html)
' SPDX-License-Identifier: GPL-3.0-or-later
%>

<!-- #include file="inicio_basedados.asp" -->
<% Server.ScriptTimeOut = 999999 %>

<!-- #include file="topo.asp" -->
<td bgcolor="gray" width="100%" align="left"><font size="-1" color="black" face="arial">&nbsp;MODERAR FOTOS EVENTOS</font></td>
<!-- #include file="fim_topo.asp" -->
<!-- #include file="autenticar_webmaster.asp" -->

<%
Set fileSystem = CreateObject("Scripting.FileSystemObject")

SQL = "SELECT * FROM eventos_fotopt_foto WHERE moderar = true ORDER BY id"
Set fotoRes = dbConnection.Execute(SQL)

do while not fotoRes.eof
	directoria = int(fotoRes("id") / 1000)

	if (request("trocar" & fotoRes("id")) = "on") or (request("trocar_todas") = 1) then
		SQL = "UPDATE eventos_fotopt_foto SET moderar = false, data = '" & date() & " " & time() & "' WHERE id = " & fotoRes("id")
		dbConnection.Execute(SQL)
	end if

	if (request("remover" & fotoRes("id")) = "on") or (request("apagar_todas") = 1) then
		if fileSystem.FileExists("c:\inetpub\wwwroot\foto\fotos\arquivo\eventos_fotopt\fotos\" & directoria & "\foto" & fotoRes("id") & ".jpg") then
			fileSystem.DeleteFile "c:\inetpub\wwwroot\foto\fotos\arquivo\eventos_fotopt\fotos\" & directoria & "\foto" & fotoRes("id") & ".jpg"
		end if
		if fileSystem.FileExists("c:\inetpub\wwwroot\foto\fotos\arquivo\eventos_fotopt\thumbs\" & directoria & "\thumbs" & fotoRes("id") & ".jpg") then
			fileSystem.DeleteFile "c:\inetpub\wwwroot\foto\fotos\arquivo\eventos_fotopt\thumbs\" & directoria & "\thumbs" & fotoRes("id") & ".jpg"
		end if

		SQL = "DELETE FROM eventos_fotopt_foto WHERE id = " & fotoRes("id")
		dbConnection.Execute(SQL)
	end if

	fotoRes.MoveNext
loop

Set fileSystem = Nothing
%>

<meta http-equiv="refresh" content="0;url=fotos_eventos_moderar.asp">
<font size="+1" color="white" face="arial"><b>Fotos eventos moderadas</b></font>

<!-- #include file="fim_autenticacao.asp" -->
<!-- #include file="fim_basedados.asp" -->