<%
' Copyright: (c) 1999-2023, Tiago Fonseca
' GNU General Public License v3.0+ (see LICENSE.md or https://www.gnu.org/licenses/gpl-3.0.html)
' SPDX-License-Identifier: GPL-3.0-or-later
%>

<!-- #include file="funcoes_principais.asp" -->
<!-- #include file="ordem_galeria.asp" -->
<!-- #include file="galeria_seleccao.asp" -->
<!-- #include file="nome_galeria.asp" -->

<%
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

if tipo = "assunto" then
	SQL = "SELECT nome FROM assunto WHERE id = " & id
	tituloRes = dbConnection.Execute(SQL)
elseif tipo = "autor" then
	SQL = "SELECT id, nome FROM autor WHERE id = " & id
	tituloRes = dbConnection.Execute(SQL)
end if

if primeira <> "" then
	if session("ordem") = "c" then
		SQL = "SELECT TOP " & numFotos & " foto.id, titulo, foto.autor, anonima, foto.data FROM foto " & SQLW & " AND foto.id >= " & primeira & " ORDER BY foto.id"
		Set fotoRes = dbConnection.Execute(SQL)
		SQL = "SELECT count(*) AS num FROM foto " & SQLW & " AND foto.id < " & primeira
		Set numOutrasFotoRes = dbConnection.Execute(SQL)
	else
		SQL = "SELECT TOP " & numFotos & " foto.id, titulo, foto.autor, anonima, foto.data FROM foto " & SQLW & " AND foto.id <= " & primeira & " ORDER BY foto.id DESC"
		Set fotoRes = dbConnection.Execute(SQL)
		SQL = "SELECT count(*) AS num FROM foto " & SQLW & " AND foto.id > " & primeira
		Set numOutrasFotoRes = dbConnection.Execute(SQL)
	end if
else
	if session("ordem") = "c" then
		SQL = "SELECT TOP " & numFotos & " foto.id, titulo, foto.autor, anonima, foto.data FROM foto " & SQLW & " ORDER BY foto.id"
		Set fotoRes = dbConnection.Execute(SQL)
	else
		SQL = "SELECT TOP " & numFotos & " foto.id, titulo, foto.autor, anonima, foto.data FROM foto " & SQLW & " ORDER BY foto.id DESC"
		Set fotoRes = dbConnection.Execute(SQL)
	end if
end if
if not fotoRes.eof then
	' Contar fotos para calcular numero de pagina
	SQL = "SELECT count(*) AS num FROM foto " & SQLW
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
		SQL = "SELECT TOP 1 foto.id FROM foto " & SQLW & " AND foto.id > " & ultimoId & " ORDER BY foto.id"
		Set proximaFotoRes = dbConnection.Execute(SQL)
		SQL = "SELECT TOP  " & numFotos & " foto.id FROM foto " & SQLW & " AND foto.id < " & fotoRes("id") & " ORDER BY foto.id DESC"
		Set anterioresFotoRes = dbConnection.Execute(SQL)
	else
		SQL = "SELECT TOP 1 foto.id FROM foto " & SQLW & " AND foto.id < " & ultimoId & " ORDER BY foto.id DESC"
		Set proximaFotoRes = dbConnection.Execute(SQL)
		SQL = "SELECT TOP " & numFotos & " foto.id FROM foto " & SQLW & " AND foto.id > " & fotoRes("id") & " ORDER BY foto.id"
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
		OpcaoMenu "<b>>> P�GINA SEGUINTE</b>", "galeria.asp?primeira=" & paginaSeguinte & "&tema=" & tema & "&tipo=" & tipo & "&id=" & id, True, False, -1, False, False
	end if
	if paginaAnterior <> 0 then
		OpcaoMenu "<b><< P�GINA ANTERIOR</b>", "galeria.asp?primeira=" & paginaAnterior & "&tema=" & tema & "&tipo=" & tipo & "&id=" & id, True, False, -1, False, False
	end if
	OpcaoMenu "LISTA DE P�GINAS", "lista.asp?tipo=" & tipo & "&primeira=" & primeira & "&id=" & id & "&tema=" & tema, False, False, -1, False, False
end if

if tipo = "autor" then 
	OpcaoMenu "VER OUTROS TEMAS DESTE AUTOR", "lista_temas.asp?autor=" & id, False, False, -1, False, False
end if

if (tipo = "autor") or tipo = ("preferidas") then
	OpcaoMenu "VER FICHA DESTE MEMBRO ", "autor.asp?autor=" & id, False, False, -1, False, False
end if

if tipo = "autor" then
	OpcaoMenu "EDITAR TEMAS DA GALERIA", "editar_temas.asp?autor=" & id, False, True, id, False, False
end if

if session("ordem") = "c" then
	OpcaoMenu "FOTOS MAIS RECENTES PRIMEIRO", "galeria.asp?letra=" & letra & "&ordem=dec&primeira=&tema=" & tema & "&tipo=" & tipo & "&id=" & id, False, False, -1, False, False
else
	OpcaoMenu "FOTOS MAIS ANTIGAS PRIMEIRO", "galeria.asp?letra=" & letra & "&ordem=cre&primeira=&tema=" & tema & "&tipo=" & tipo & "&id=" & id, False, False, -1, False, False
end if

if tipo = "juri" then
	SQL = "SELECT autor, tema_mes FROM juri_folder WHERE id = " & id
	Set criadorRes = dbConnection.Execute(SQL)
	
	if (clng(criadorRes("autor")) = session("login")) or (session("login") = 2) then
		if criadorRes("tema_mes") = False then
			OpcaoMenu "MUDAR OU APAGAR ESTA GALERIA DE J�RI", "juri/juri_mudar_tema.asp?tema=" & id, False, False, -1, True, False
		end if
	end if
end if

if paginas > 0 then
	Menu 1, GaleriaSubSeccao(tipo, id), nomeGaleria & " - " & estaPagina & "/" & paginas
else
	Menu 1, GaleriaSubSeccao(tipo, id), nomeGaleria
end if
%>

<% if (paginaAnterior <> 0) or (paginaSeguinte <> 0) then %>
	<div align="right">
		<% if paginaAnterior <> 0 then %>
			<a class="oa" href="galeria.asp?primeira=<% =paginaAnterior %>&tema=<% =tema %>&tipo=<% =tipo %>&id=<% =id %>"><<</a>
		<% end if %>
		<% if paginaSeguinte <> 0 then %>
			<a class="oa" href="galeria.asp?primeira=<% =paginaSeguinte %>&tema=<% =tema %>&tipo=<% =tipo %>&id=<% =id %>">>></a>
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

		SQL = "SELECT count(*) AS num FROM comentario WHERE foto = " & fotoRes("id")
		Set comentarioRes = dbConnection.Execute(SQL)

		if (i MOD (numFotos / numLinhas)) = 0 then
	%>
		<tr>
	<% end if %>
		<% directoria = int(fotoRes("id") / 1000) %>
		
		<td align="center" width="210">
			<a href="foto.asp?foto=<% =fotoRes("id") %>&primeira=<% =primeira %>&tema=<% =tema %>&tipo=<% =tipo %>&id=<% =id %>&num=<% =i + 1 %>"><img vspace="2" src="/fotos/thumbs/<% =directoria %>/thumbs<% =fotoRes("id") %>.jpg" border=0 alt=""></a>
			<% if fotoRes("titulo") <> "" then %>
				<% if (fotoRes("anonima") = 2) and (fotoRes("data") > (cdate(date() & " " & time()) - 7)) and (session("login") = 2) then %>
					<br><font color="red" face="arial" size="-2"><% =fotoRes("id") %> - </font><font color="white" face="arial" size="-1"><b><% =fotoRes("titulo") %></b></font>
				<% else %>
					<br><font color="silver" face="arial" size="-2"><% =fotoRes("id") %> - </font><font color="white" face="arial" size="-1"><b><% =fotoRes("titulo") %></b></font>
				<% end if %>
			<% else %>
				<% if (fotoRes("anonima") = 2) and (fotoRes("data") > (cdate(date() & " " & time()) - 7)) and (session("login") = 2) then %>
					<br><font color="red" face="arial" size="-2"><% =fotoRes("id") %> - </font><font color="white" face="arial" size="-1"><b><i>sem titulo</i></b></font>
				<% else %>
					<br><font color="silver" face="arial" size="-2"><% =fotoRes("id") %> - </font><font color="white" face="arial" size="-1"><b><i>sem titulo</i></b></font>
				<% end if %>
			<% end if %>
			<% if (fotoRes("anonima") <> 0) and (fotoRes("data") > (cdate(date() & " " & time()) - 7)) then %>
				<% if session("login") = 2 then %>
					<br><font color="silver" face="arial" size="-2">(de </font><a href="autor.asp?autor=<% =autorRes("id") %>"><font color="red" face="arial" size="-2"><% =autorRes("nome") %></font></a><font color="silver" face="arial" size="-2"><% if (comentarioRes("num") > 0) and ((session("login") = 2) or (session("login") = fotoRes("autor"))) then %>, <a href="comentarios.asp?foto=<% =fotoRes("id") %>&primeira=<% =primeira %>&tema=<% =tema %>&tipo=<% =tipo %>&id=<% =id %>&num=<% =i + 1 %>"><font color="silver" face="arial" size="-2"><% =comentarioRes("num") %></font></a><% end if %>)</font>
				<% else %>
					<br><font color="silver" face="arial" size="-2">(de <i>an�nimo</i><% if (comentarioRes("num") > 0) and ((session("login") = 2) or (session("login") = fotoRes("autor"))) then %>, <a href="comentarios.asp?foto=<% =fotoRes("id") %>&primeira=<% =primeira %>&tema=<% =tema %>&tipo=<% =tipo %>&id=<% =id %>&num=<% =i + 1 %>"><font color="silver" face="arial" size="-2"><% =comentarioRes("num") %></font></a><% end if %>)</font>
				<% end if %>
			<% else %>
				<br><font color="silver" face="arial" size="-2">(de </font><a href="autor.asp?autor=<% =autorRes("id") %>"><font color="silver" face="arial" size="-2"><% =autorRes("nome") %></font></a><font color="silver" face="arial" size="-2"><% if (comentarioRes("num") > 0) and ((session("login") = 2) or (session("login") = fotoRes("autor"))) then %>, <a href="comentarios.asp?foto=<% =fotoRes("id") %>&primeira=<% =primeira %>&tema=<% =tema %>&tipo=<% =tipo %>&id=<% =id %>&num=<% =i + 1 %>"><font color="silver" face="arial" size="-2"><% =comentarioRes("num") %></font></a><% end if %>)</font>
			<% end if %>
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
