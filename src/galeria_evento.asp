<%
' Copyright: (c) 1999-2023, Tiago Fonseca
' GNU General Public License v3.0+ (see LICENSE.md or https://www.gnu.org/licenses/gpl-3.0.html)
' SPDX-License-Identifier: GPL-3.0-or-later
%>

<!-- #include file="funcoes_principais.asp" -->
<!-- #include file="galeria_seleccao_evento.asp" -->
<!-- #include file="ordem_galeria.asp" -->

<%
SQL = "SELECT * FROM eventos_fotopt WHERE id = " & evento
Set eventoRes = dbConnection.Execute(SQL)

formatacaoFotoGaleria = True

' Numero de fotos por pagina da galeria
if session("login") <> 0 then
	SQL = "SELECT fotos_por_galeria FROM autor_opcoes WHERE autor = " & session("login")
	Set confAutorRes = dbConnection.Execute(SQL)

	SQL = "SELECT * FROM fotos_por_galeria WHERE id = " & confAutorRes("fotos_por_galeria")
	Set fotosGaleriaRes = dbConnection.Execute(SQL)

	numFotos = fotosGaleriaRes("fotos")
	numLinhas = fotosGaleriaRes("linhas")
else
	numFotos = 6
	numLinhas = 2
end if

if primeira <> "" then
	if session("ordem") = "c" then
		SQL = "SELECT TOP " & numFotos & " foto.id, titulo, foto.autor FROM eventos_fotopt_foto foto " & SQLW & " AND foto.id >= " & primeira & " ORDER BY foto.id"
		Set fotoRes = dbConnection.Execute(SQL)
		SQL = "SELECT count(*) AS num FROM eventos_fotopt_foto foto " & SQLW & " AND foto.id < " & primeira
		Set numOutrasFotoRes = dbConnection.Execute(SQL)
	else
		SQL = "SELECT TOP " & numFotos & " foto.id, titulo, foto.autor FROM eventos_fotopt_foto foto " & SQLW & " AND foto.id <= " & primeira & " ORDER BY foto.id DESC"
		Set fotoRes = dbConnection.Execute(SQL)
		SQL = "SELECT count(*) AS num FROM eventos_fotopt_foto foto " & SQLW & " AND foto.id > " & primeira
		Set numOutrasFotoRes = dbConnection.Execute(SQL)
	end if
else
	if session("ordem") = "c" then
		SQL = "SELECT TOP " & numFotos & " foto.id, titulo, foto.autor FROM eventos_fotopt_foto foto " & SQLW & " ORDER BY foto.id"
		Set fotoRes = dbConnection.Execute(SQL)
	else
		SQL = "SELECT TOP " & numFotos & " foto.id, titulo, foto.autor FROM eventos_fotopt_foto foto " & SQLW & " ORDER BY foto.id DESC"
		Set fotoRes = dbConnection.Execute(SQL)
	end if
end if
if not fotoRes.eof then
	' Contar fotos para calcular numero de pagina
	SQL = "SELECT count(*) AS num FROM eventos_fotopt_foto WHERE evento_fotopt = " & evento
	Set numFotoRes = dbConnection.Execute(SQL)
	if (numFotoRes("num") mod numFotos) = 0 then
		paginas = numFotoRes("num") / numFotos
	else
		paginas = int(numFotoRes("num") / numfotos) + 1
	end if
	if (primeira <> "") then
		estaPagina = int(numOutrasFotoRes("num") / numFotos) + 1
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
		SQL = "SELECT TOP 1 foto.id FROM eventos_fotopt_foto foto " & SQLW & " AND foto.id > " & ultimoId & " ORDER BY foto.id"
		Set proximaFotoRes = dbConnection.Execute(SQL)
		SQL = "SELECT TOP  " & numFotos & " foto.id FROM eventos_fotopt_foto foto " & SQLW & " AND foto.id < " & fotoRes("id") & " ORDER BY foto.id DESC"
		Set anterioresFotoRes = dbConnection.Execute(SQL)
	else
		SQL = "SELECT TOP 1 foto.id FROM eventos_fotopt_foto foto " & SQLW & " AND foto.id < " & ultimoId & " ORDER BY foto.id DESC"
		Set proximaFotoRes = dbConnection.Execute(SQL)
		SQL = "SELECT TOP  " & numFotos & " foto.id FROM eventos_fotopt_foto foto " & SQLW & " AND foto.id > " & fotoRes("id") & " ORDER BY foto.id"
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

<% 
if not fotoRes.eof then
	if paginaSeguinte <> 0 then
		OpcaoMenu "<b>>> P�GINA SEGUINTE</b>", "galeria_evento.asp?primeira=" & paginaSeguinte & "&evento=" & evento, True, False, -1, False, False
	end if
	if paginaAnterior <> 0 then
		OpcaoMenu "<b><< P�GINA ANTERIOR</b>", "galeria_evento.asp?primeira=" & paginaAnterior & "&evento=" & evento, True, False, -1, False, False
	end if
end if

if session("ordem") = "c" then
	OpcaoMenu "FOTOS MAIS RECENTES PRIMEIRO", "galeria_evento.asp?ordem=dec&primeira=&evento=" & evento, False, False, -1, False, False
else
	OpcaoMenu "FOTOS MAIS ANTIGAS PRIMEIRO", "galeria_evento.asp?ordem=cre&primeira=&evento=" & evento, False, False, -1, False, False
end if

OpcaoMenu "INSERIR FOTO", "inserir_foto_evento_fotopt.asp?evento=" & evento, False, True, -1, False, False

OpcaoMenu "MUDAR OU APAGAR EVENTO FOTOPT", "adm/mudar_evento_fotopt.asp?evento=" & evento, False, False, -1, False, True

if paginas > 0 then
	Menu 2, 1, eventoRes("nome") & " - " & estaPagina & "/" & paginas
else
	Menu 2, 1, eventoRes("nome")
end if
%>

<% if (paginaAnterior <> 0) or (paginaSeguinte <> 0) then %>
	<div align="right">
		<% if paginaAnterior <> 0 then %>
			<a class="oa" href="galeria_evento.asp?primeira=<% =paginaAnterior %>&evento=<% =evento %>"><<</a>
		<% end if %>
		<% if paginaSeguinte <> 0 then %>
			<a class="oa" href="galeria_evento.asp?primeira=<% =paginaSeguinte %>&evento=<% =evento %>">>></a>
		<% end if %>
	</div>
<% end if %>

<div align="center">
<% if fotoRes.eof then %>
	<br><font color="white" face="arial" size="+1"><b>Ainda n&atilde;o foi submetida nenhuma<br>fotografia nesta categoria</b></font>
<% else %>
	<table border="0" cellspacing="0" cellpadding="3">
	<% 
	i = 0
	do while (not fotoRes.eof) and (i <= (numFotos - 1))
		SQL = "SELECT id, nome FROM autor WHERE id = " & fotoRes("autor")
		Set autorRes = dbConnection.Execute(SQL)

		SQL = "SELECT count(*) AS num FROM eventos_fotopt_comentarios WHERE foto = " & fotoRes("id")
		Set comentarioRes = dbConnection.Execute(SQL)

		if (i MOD (numFotos / numLinhas)) = 0 then
	%>
		<tr>
	<% end if %>
		<% directoria = int(fotoRes("id") / 1000) %>
		
		<td align="center" width="210">
			<a href="foto_evento.asp?foto=<% =fotoRes("id") %>&primeira=<% =primeira %>&evento=<% =evento %>&num=<% =i + 1 %>"><img vspace="2" src="/fotos/arquivo/eventos_fotopt/thumbs/<% =directoria %>/thumbs<% =fotoRes("id") %>.jpg" border=0 alt=""></a>
			<% if fotoRes("titulo") <> "" then %>
				<br><font color="silver" face="arial" size="-2"><% =fotoRes("id") %> - </font><font color="white" face="arial" size="-1"><b><% =fotoRes("titulo") %></b></font>
			<% else %>
				<br><font color="silver" face="arial" size="-2"><% =fotoRes("id") %> - </font><font color="white" face="arial" size="-1"><b><i>sem titulo</i></b></font>
			<% end if %>
			<br><font color="silver" face="arial" size="-2">(de </font><a href="autor.asp?autor=<% =autorRes("id") %>"><font color="silver" face="arial" size="-2"><% =autorRes("nome") %></font></a><font color="silver" face="arial" size="-2"><% if comentarioRes("num") > 0 then %>, <a href="comentarios_evento.asp?foto=<% =fotoRes("id") %>&primeira=<% =primeira %>&evento=<% =evento %>&num=<% =i + 1 %>"><font color="silver" face="arial" size="-2"><% =comentarioRes("num") %></font></a><% end if %>)</font>
		</td>
	<% if ((i + 1) MOD (numFotos / numLinhas)) = 0 then %>
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

<% FimPagina() %>
