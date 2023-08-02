<%
' Copyright: (c) 1999-2023, Tiago Fonseca
' GNU General Public License v3.0+ (see LICENSE.md or https://www.gnu.org/licenses/gpl-3.0.html)
' SPDX-License-Identifier: GPL-3.0-or-later
%>

<!-- #include file="inicio_basedados.asp" -->
<!-- #include file="../ordem_galeria.asp" -->
<!-- #include file="../galeria_seleccao.asp" -->
<!-- #include file="nome_galeria.asp" -->

<%
if tipo = "autor" then
	SQL = "SELECT count(*) AS numTemas FROM folder WHERE autor = " & id
	Set numTemasRes = dbConnection.Execute(SQL)
end if

if tipo = "assunto" then
	SQL = "SELECT nome FROM assunto WHERE id = " & id
	tituloRes = dbConnection.Execute(SQL)
elseif tipo = "autor" then
	SQL = "SELECT id, nome FROM autor WHERE id = " & id
	tituloRes = dbConnection.Execute(SQL)
end if

if primeira <> "" then
	if session("ordem") = "c" then
		SQL = "SELECT TOP 6 foto.id, titulo, titulo_uk, foto.autor, foto.anonima, foto.data FROM foto " & SQLW & " AND foto.id >= " & primeira & " ORDER BY foto.id"
		Set fotoRes = dbConnection.Execute(SQL)
		SQL = "SELECT count(*) AS num FROM foto " & SQLW & " AND foto.id < " & primeira
		Set numOutrasFotoRes = dbConnection.Execute(SQL)
	else
		SQL = "SELECT TOP 6 foto.id, titulo, titulo_uk, foto.autor, foto.anonima, foto.data FROM foto " & SQLW & " AND foto.id <= " & primeira & " ORDER BY foto.id DESC"
		Set fotoRes = dbConnection.Execute(SQL)
		SQL = "SELECT count(*) AS num FROM foto " & SQLW & " AND foto.id > " & primeira
		Set numOutrasFotoRes = dbConnection.Execute(SQL)
	end if
else
	if session("ordem") = "c" then
		SQL = "SELECT TOP 6 foto.id, titulo, titulo_uk, foto.autor, foto.anonima, foto.data FROM foto " & SQLW & " ORDER BY foto.id"
		Set fotoRes = dbConnection.Execute(SQL)
	else
		SQL = "SELECT TOP 6 foto.id, titulo, titulo_uk, foto.autor, foto.anonima, foto.data FROM foto " & SQLW & " ORDER BY foto.id DESC"
		Set fotoRes = dbConnection.Execute(SQL)
	end if
end if

if not fotoRes.eof then
	' Contar fotos para calcular numero de pagina
	SQL = "SELECT count(*) AS num FROM foto " & SQLW
	Set numFotoRes = dbConnection.Execute(SQL)
	if (numFotoRes("num") mod 6) = 0 then
		paginas = numFotoRes("num") / 6
	else
		paginas = int(numFotoRes("num") / 6) + 1
	end if
	if (primeira <> "") then
		estaPagina = int(numOutrasFotoRes("num") / 6) + 1
	else
		estaPagina = 1
	end if

	' Ver id da ultima foto na sequencia
	do while not fotoRes.eof
		ultimoId = fotoRes("id")
		fotoRes.MoveNext
	loop
	fotoRes.MoveFirst
	
	' Anteriores e proxima
	if session("ordem") = "c" then
		SQL = "SELECT TOP 1 foto.id FROM foto " & SQLW & " AND foto.id > " & ultimoId & " ORDER BY foto.id"
		Set proximaFotoRes = dbConnection.Execute(SQL)
		SQL = "SELECT TOP 6 foto.id FROM foto " & SQLW & " AND foto.id < " & fotoRes("id") & " ORDER BY foto.id DESC"
		Set anterioresFotoRes = dbConnection.Execute(SQL)
	else
		SQL = "SELECT TOP 1 foto.id FROM foto " & SQLW & " AND foto.id < " & ultimoId & " ORDER BY foto.id DESC"
		Set proximaFotoRes = dbConnection.Execute(SQL)
		SQL = "SELECT TOP 6 foto.id FROM foto " & SQLW & " AND foto.id > " & fotoRes("id") & " ORDER BY foto.id"
		Set anterioresFotoRes = dbConnection.Execute(SQL)
	end if

	' Descobrir anterior percorrendo ID da pagina anterior ate ao fim	
	paginaAnterior = 0
	do while not anterioresFotoRes.eof
		paginaAnterior = anterioresFotoRes("id")
		anterioresFotoRes.MoveNext
	loop

	' A proxima e' directa	
	if not proximaFotoRes.eof then
		paginaSeguinte = proximaFotoRes("id")
	else
		paginaSeguinte = 0
	end if
end if
%>

<!-- #include file="topo.asp" -->
<% if not fotoRes.eof then %>
	<% if paginaAnterior <> 0 then %><td align="left"><font size="-2" color="black" face="arial">&lt;&nbsp;</font><a href="galeria.asp?primeira=<% =paginaAnterior %>&tema=<% =tema %>&tipo=<% =tipo %>&id=<% =id %>"><font size="-2" color="black" face="arial">PREVIOUS</font></a><font size="-2">&nbsp;</font></td><% end if %>
	<td align="center"><font size="-2" color="black" face="arial">&nbsp;<% =estaPagina %>/<% =paginas %>&nbsp;</font></td>
	<% if paginaSeguinte <> 0 then %><td align="right"><font size="-2">&nbsp;</font><a href="galeria.asp?primeira=<% =paginaSeguinte %>&tema=<% =tema %>&tipo=<% =tipo %>&id=<% =id %>"><font size="-2" color="black" face="arial">NEXT</font></a><font size="-2" color="black" face="arial">&nbsp;&gt;</font></td><% end if %>
	
	<td bgcolor="gray" width="100%" align="left"><font size="-2" color="black" face="arial">&nbsp;<% =nomeGaleria %></font></td>
	<td><font size="-2">&nbsp;</font><a href="lista.asp?tipo=<% =tipo %>&primeira=<% =primeira %>&id=<% =id %>&tema=<% =tema %>"><font size="-2" color="black" face="arial">#PAGE</font></a><font size="-2">&nbsp;</font></td>
<% else %>
	<td bgcolor="gray" width="100%" align="left"><font size="-2" color="black" face="arial">&nbsp;<% =nomeGaleria %>&nbsp;&nbsp;</font></td>
<% end if %>

<% if session("ordem") = "c" then %>
	<td><font size="-2">&nbsp;</font><a href="galeria.asp?letra=<% =letra %>&ordem=dec&primeira=&tema=<% =tema %>&tipo=<% =tipo %>&id=<% =id %>"><font size="-2" color="black" face="arial">NEW&nbsp;>&nbsp;OLD</font></a><font size="-2">&nbsp;</font></td>
<% else %>
	<td><font size="-2">&nbsp;</font><a href="galeria.asp?letra=<% =letra %>&ordem=cre&primeira=&tema=<% =tema %>&tipo=<% =tipo %>&id=<% =id %>"><font size="-2" color="black" face="arial">OLD&nbsp;>&nbsp;NEW</font></a><font size="-2">&nbsp;</font></td>
<% end if %>

<% if tipo = "autor" then %>
	<% if numTemasRes("numTemas") <> 0 then %>
		<td><font size="-2">&nbsp;</font><a href="lista_temas.asp?autor=<% =id %>"><font size="-2" color="black" face="arial">THEMES&nbsp;LIST</font></a><font size="-2">&nbsp;</font></td>
	<% end if %>
<% end if %>
</tr></table><!-- TABELA DE TOPO SEM BR -->

<div align="center">
<% if fotoRes.eof then %>
	<br><font color="white" face="arial" size="+1"><b>This gallery still<br>has no photographies</b></font>
<% else %>
	<table border="0" cellspacing="0" cellpadding="3">
	<% 
	i = 0
	do while (not fotoRes.eof) and (i <= 5)
		SQL = "SELECT id, nome FROM autor WHERE id = " & fotoRes("autor")
		Set autorRes = dbConnection.Execute(SQL)

		if (i MOD 3) = 0 then
	%>
		<tr>
	<% end if %>
		<% directoria = int(fotoRes("id") / 1000) %>
		
		<td align="center" width="210">
			<a href="foto.asp?foto=<% =fotoRes("id") %>&primeira=<% =primeira %>&tema=<% =tema %>&tipo=<% =tipo %>&id=<% =id %>&num=<% =i + 1 %>"><img vspace="2" src="/fotos/thumbs/<% =directoria %>/thumbs<% =fotoRes("id") %>.jpg" border=0 alt=""></a>
			<% if fotoRes("titulo_uk") <> "" then %>
				<br><font color="silver" face="arial" size="-2"><% =fotoRes("id") %> - </font><font color="white" face="arial" size="-1"><b><% =fotoRes("titulo_uk") %></b></font>
			<% elseif fotoRes("titulo") <> "" then %>
				<br><font color="silver" face="arial" size="-2"><% =fotoRes("id") %> - </font><font color="white" face="arial" size="-1"><b><% =fotoRes("titulo") %></b></font>
			<% else %>
				<br><font color="silver" face="arial" size="-2"><% =fotoRes("id") %> - </font><font color="white" face="arial" size="-1"><i><b>untitled</b></i></font>
			<% end if %>

			<% if (fotoRes("anonima") <> 0) and (fotoRes("data") > (cdate(date() & " " & time()) - 7)) then %>
				<% if session("login") = 2 then %>
					<br><font color="silver" face="arial" size="-2">(by </font><a href="autor.asp?autor=<% =autorRes("id") %>"><font color="red" face="arial" size="-2"><% =autorRes("nome") %></font></a><font color="silver" face="arial" size="-2">)</font>
				<% else %>
					<br><font color="silver" face="arial" size="-2">(by <i>anonymous</i>)</font>
				<% end if %>
			<% else %>
				<br><font color="silver" face="arial" size="-2">(by </font><a href="autor.asp?autor=<% =autorRes("id") %>"><font color="silver" face="arial" size="-2"><% =autorRes("nome") %></font></a><font color="silver" face="arial" size="-2">)</font>
			<% end if %>
		</td>
	<% if ((i + 1) MOD 3) = 0 then %>
		</tr>
	<%
		end if
		i = i + 1
		fotoRes.MoveNext
	Loop 
	%>
	</table>
<% end if %>

</div>
<!-- #include file="fim.asp" -->
<!-- #include file="fim_basedados.asp" -->