<%
' Copyright: (c) 1999-2023, Tiago Fonseca
' GNU General Public License v3.0+ (see LICENSE.md or https://www.gnu.org/licenses/gpl-3.0.html)
' SPDX-License-Identifier: GPL-3.0-or-later
%>

<!-- #include file="funcoes_principais.asp" -->

<%
tipo = request("tipo")

if tipo = "" then
	SQL = "SELECT TOP 5 cronicas.id, cronicas.autor, cronicas.foto, cronicas.texto, foto.titulo, foto.data_foto, foto.data_tipo FROM cronicas INNER JOIN foto ON cronicas.foto = foto.id ORDER by cronicas.id DESC"
	Set cronicasRes = dbConnection.Execute(SQL)
else
	SQL = "SELECT TOP 5 cronicas.id, cronicas.autor, cronicas.foto, cronicas.texto, foto.titulo, foto.data_foto, foto.data_tipo FROM cronicas INNER JOIN foto ON cronicas.foto = foto.id WHERE foto.assunto = " & tipo & " ORDER by cronicas.id DESC"
	Set cronicasRes = dbConnection.Execute(SQL)

	SQL = "SELECT nome FROM assunto WHERE id = " & tipo
	Set assuntoRes = dbConnection.Execute(SQL)
end if

Dim meses
meses = Array("Janeiro", "Fevereiro", "Mar&ccedil;o", "Abril", "Maio", "Junho", "Julho", _
			  "Agosto", "Setembro", "Outubro", "Novembro", "Dezembro")
%>

<%
OpcaoMenu "GALERIA DE FOTOS COM CR�NICAS", "galeria.asp?tipo=cronicas&id=" & tipo, False, False, -1, False, False
if tipo = "" then
	Menu 1, 1, "CR�NICAS NOVAS"
else
	Menu 1, 1, "CR�NICAS NOVAS - " & assuntoRes("nome")
end if
%>

<table border="1" cellpadding="3" cellspacing="0">
<% 
i = -1
do while not cronicasRes.eof 
	i = i + 1
	directoria = int(cronicasRes("foto") / 1000)

	SQL = "SELECT nome FROM autor WHERE id = " & cronicasRes("autor")
	Set autorRes = dbConnection.Execute(SQL)
%>
	<tr><td>
	<table border="0" cellpadding="5" cellspacing="0" width="100%"><tr>
		<% if i mod 2 = 0 then %>
			<td valign="top">
				<a href="foto.asp?foto=<% =cronicasRes("foto") %>"><img src="/fotos/thumbs/<% =directoria %>/thumbs<% =cronicasRes("foto") %>.jpg" border="1" alt=""></a>
			</td>
		<% end if %>
		<% if i mod 2 = 0 then %>
			<td valign="top">
		<% else %>
			<td valign="top" align="right">
		<% end if %>
			<% if cronicasRes("titulo") <> "" then %>
				<font color="#ffcc66" face="verdana, arial"><b><% =cronicasRes("titulo") %></b></font>
			<% else %>
				<font color="#ffcc66" face="verdana, arial"><b><i>sem t&iacute;tulo</i></b></font>
			<% end if %>
			<br>
			<a href="autor.asp?autor=<% =cronicasRes("autor") %>"><font size="-1" color="white" face="verdana, arial"><b><% =autorRes("nome") %></b></font></a>
			<% if (cronicasRes("data_tipo") <> 0) and (cronicasRes("data_tipo") <> "") then %>
				<br>
				<% if cronicasRes("data_tipo") = 3 then %>
					<font size="-2" color="white" face="arial"><% =day(cronicasRes("data_foto")) %>&nbsp;<% =meses(month(cronicasRes("data_foto")) - 1) %>&nbsp;<% =year(cronicasRes("data_foto")) %></font>
				<% elseif cronicasRes("data_tipo") = 2 then %>
					<font size="-2" color="white" face="arial"><% =meses(month(cronicasRes("data_foto")) - 1) %>&nbsp;<% =year(cronicasRes("data_foto")) %></font>
				<% else %>
					<font size="-2" color="white" face="arial"><% =year(cronicasRes("data_foto")) %></font>
				<% end if %>
			<% end if %>
			<br><br>
			<font size="-1" color="white" face="arial">"<% =left(cronicasRes("texto"), 200) %>..."</font><br>
			<a href="cronica.asp?foto=<% =cronicasRes("foto") %>"><font size="-2" color="white" face="verdana, arial"><b>LER MAIS</b></font></a>
		</td>
		<% if i mod 2 <> 0 then %>
			<td valign="top">
				<a href="foto.asp?foto=<% =cronicasRes("foto") %>"><img src="/fotos/thumbs/<% =directoria %>/thumbs<% =cronicasRes("foto") %>.jpg" border="1" alt=""></a>
			</td>
		<% end if %>
	</tr></table>
	</td></tr>
	<% cronicasRes.MoveNext %>
<% loop %>
</table>

<% FimPagina() %>
