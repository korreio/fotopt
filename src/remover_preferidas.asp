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

SQL = "SELECT * FROM foto WHERE id = " & foto
Set fotoRes = dbConnection.Execute(SQL)

SQL = "SELECT id, nome FROM autor WHERE id = " & fotoRes("autor")
Set autorRes = dbConnection.Execute(SQL)
%>

<%
AutenticarMembro(autor)
Menu 1, GaleriaSubSeccao(tipo, id), "REMOVER FOTO DA MINHA GALERIA DE PREFERIDAS"
%>

<font size="-1" color="white" face="arial">
Esta op&ccedil;&atilde;o serve para remover esta foto na sua galeria pessoal de fotos preferidas.
</font>

<form action="remover_preferidas_res.asp?foto=<% =foto %>&primeira=<% =primeira %>&tema=<% =tema %>&tipo=<% =tipo %>&id=<% =id %>&num=<% =num %>" method=post>
<table border="0" cellpadding="3" cellspacing="0">
	<tr><td><font size="-1" color="#FFCC66" face="arial"><b>ID:</b> </font></td><td><font size="-1" color="white" face="arial"><% =foto %></font></td></tr>
	<% if fotoRes("titulo") <> "" then %>
		<tr><td><font size="-1" color="#FFCC66" face="arial"><b>T&Iacute;TULO:</b> </font></td><td><font size="-1" color="white" face="arial"><% =fotoRes("titulo") %></font></td></tr>
	<% else %>
		<tr><td><font size="-1" color="#FFCC66" face="arial"><b>T&Iacute;TULO:</b> </font></td><td><font size="-1" color="white" face="arial"><i>sem t&iacute;tulo</i></font></td></tr>
	<% end if %>
	<% if (fotoRes("anonima") <> 0) and (fotoRes("data") > (cdate(date() & " " & time()) - 7)) then %>
		<% if session("login") = 2 then %>
			<tr><td><font size="-1" color="#FFCC66" face="arial"><b>AUTOR:</b> </font></td><td><font size="-1" color="red" face="arial"><% =autorRes("nome") %></font></td></tr>
		<% else %>
			<tr><td><font size="-1" color="#FFCC66" face="arial"><b>AUTOR:</b> </font></td><td><font color="white" size="-1" face="arial"><i>an�nimo</i> (at� <% =day(fotoRes("data") + 7) & "/" & month(fotoRes("data") + 7) & "/" & year(fotoRes("data") + 7) & " �s " & hour(fotoRes("data") + 7) & ":" & minute(fotoRes("data") + 7) %>)</font></td></tr>
		<% end if %>
	<% else %>
		<tr><td><font size="-1" color="#FFCC66" face="arial"><b>AUTOR:</b> </font></td><td><font size="-1" color="white" face="arial"><% =autorRes("nome") %></font></td></tr>
	<% end if %>
	<tr><td></td><td><input type="Submit" value="Remover das preferidas"></td></tr>
</table>
</form>

<% FimPagina() %>
