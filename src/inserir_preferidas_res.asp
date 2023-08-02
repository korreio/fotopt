<%
' Copyright: (c) 1999-2023, Tiago Fonseca
' GNU General Public License v3.0+ (see LICENSE.md or https://www.gnu.org/licenses/gpl-3.0.html)
' SPDX-License-Identifier: GPL-3.0-or-later
%>

<!-- #include file="funcoes_principais.asp" -->

<%
foto = request("foto")
autor = session("login")

' Dados referentes a galeria
primeira = request("primeira")
tipo = request("tipo")
id = request("id")
tema = request("tema")
num = request("num")
%>

<% AutenticarMembro(autor) %>

<%
SQL = "SELECT autor FROM foto WHERE id = " & foto
Set fotoRes = dbConnection.Execute(SQL)

' se nao e' o autor da foto a preferir
if fotoRes("autor") <> autor then
	SQL = "SELECT id FROM preferidas_fotos WHERE foto = " & foto & " AND autor = " & autor
	Set preferidaRes = dbConnection.Execute(SQL)

	if preferidaRes.eof then
		SQL = "INSERT INTO preferidas_fotos (foto, folder, autor, data)"
		SQL = SQL & " VALUES ('" & foto & "','" & 0 & "','" & autor & "','" & date() & " " & time() & "')"
		dbConnection.Execute(SQL)
	end if
else
	maxPreferidas = 10
	SQL = "SELECT count(*) as numPreferidas FROM preferidas_fotos, foto WHERE preferidas_fotos.autor = " & autor & "  AND foto.autor = " & autor & " AND preferidas_fotos.foto = foto.id"
	Set numFotoRes = dbConnection.Execute(SQL)

	if numFotoRes("numPreferidas") < maxPreferidas then
		SQL = "SELECT id FROM preferidas_fotos WHERE foto = " & foto & " AND autor = " & autor
		Set preferidaRes = dbConnection.Execute(SQL)

		if preferidaRes.eof then
			SQL = "INSERT INTO preferidas_fotos (foto, folder, autor, data)"
			SQL = SQL & " VALUES ('" & foto & "','" & 0 & "','" & autor & "','" & date() & " " & time() & "')"
			dbConnection.Execute(SQL)
		end if
	end if
end if

ComRefresh "foto.asp?foto=" & foto & "&primeira=" & primeira & "&tema=" & tema & "&tipo=" & tipo & "&id=" & id & "&num=" & num
Menu 1, GaleriaSubSeccao(tipo, id), "INSERIR FOTO NA MINHA GALERIA DE PREFERIDAS"
%>
<font size="+1" color="white" face="arial"><b>Foto preferida inserida com sucesso</b></font>
<% FimPagina() %>
