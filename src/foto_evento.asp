<%
' Copyright: (c) 1999-2023, Tiago Fonseca
' GNU General Public License v3.0+ (see LICENSE.md or https://www.gnu.org/licenses/gpl-3.0.html)
' SPDX-License-Identifier: GPL-3.0-or-later
%>

<!-- #include file="funcoes_principais.asp" -->
<!-- #include file="galeria_seleccao_evento.asp" -->

<%
formatacaoFotoGaleria = True

foto = request("foto")

menus = request("menus")
if (menus = "esc") then
	session("menus") = "esc"
elseif (menus = "mos") then
	session("menus") = ""
end if

ficha = request("ficha")
if (ficha = "com") then
	session("ficha") = "com"
elseif (ficha = "res") then
	session("ficha") = ""
end if

mes = month(date()) - 1
if mes = 0 then
	mes = 12
	ano = year(date()) - 1
else
	ano = year(date())
end if
data = cdate(mes & "/1/" & ano)

SQL = "SELECT * FROM eventos_fotopt_foto WHERE id = " & foto
Set fotoRes = dbConnection.Execute(SQL)

' Contar visitas
if (session("SSUID") <> "") and (IsNull(fotoRes("ultima_visita")) or (fotoRes("ultima_visita") <> session("SSUID"))) then
	if session("login") <> fotoRes("autor") then
		SQL = "UPDATE eventos_fotopt_foto SET contador = '" & fotoRes("contador") + 1 & "', ultima_visita = '" & session("SSUID") & "' WHERE id = " & foto
		dbConnection.Execute(SQL)
	end if
end if

SQL = "SELECT * FROM eventos_fotopt WHERE id = " & evento
Set eventoRes = dbConnection.Execute(SQL)

if session("login") <> 0 then
	SQL = "SELECT fotos_por_galeria FROM autor_opcoes WHERE autor = " & session("login")
	Set confAutorRes = dbConnection.Execute(SQL)

	SQL = "SELECT fotos FROM fotos_por_galeria WHERE id = " & confAutorRes("fotos_por_galeria")
	Set fotosGaleriaRes = dbConnection.Execute(SQL)

	numFotos = fotosGaleriaRes("fotos")
else
	numFotos = 6
end if

Dim meses
meses = Array("Janeiro", "Fevereiro", "Mar&ccedil;o", "Abril", "Maio", "Junho", "Julho", _
			  "Agosto", "Setembro", "Outubro", "Novembro", "Dezembro")
%>

<% 
if fotoRes.eof then 

Menu 2, 1, "FOTO N�O EXISTE"
%>
	<font size="+1" color="white" face="arial">A fotografia com esse ID deixou de existir h&aacute; instantes.</font>
	<br>
	<font size="+1" color="white" face="arial">O mais provavel &eacute; que tenha sido apagado pelo seu autor.</font>
<%
else
	' Proxima e anterior
	num = request("num")

	' Proxima e anterior e numero de ordem na galeria
	if session("ordem") = "c" then
		SQL = "SELECT TOP 1 foto.id FROM eventos_fotopt_foto foto " & SQLW & " AND foto.id < " & foto & " ORDER BY foto.id DESC"
		Set anteriorFotoRes = dbConnection.Execute(SQL)
		SQL = "SELECT TOP 1 foto.id FROM eventos_fotopt_foto foto " & SQLW & " AND foto.id > " & foto & " ORDER BY foto.id"
		Set proximaFotoRes = dbConnection.Execute(SQL)
		SQL = "SELECT count(*) AS num FROM eventos_fotopt_foto foto " & SQLW & " AND foto.id < " & foto
		Set numOutrasFotoRes = dbConnection.Execute(SQL)
	else
		SQL = "SELECT TOP 1 foto.id FROM eventos_fotopt_foto foto " & SQLW & " AND foto.id > " & foto & " ORDER BY foto.id"
		Set anteriorFotoRes = dbConnection.Execute(SQL)
		SQL = "SELECT TOP 1 foto.id FROM eventos_fotopt_foto foto " & SQLW & " AND foto.id < " & foto & " ORDER BY foto.id DESC"
		Set proximaFotoRes = dbConnection.Execute(SQL)
		SQL = "SELECT count(*) AS num FROM eventos_fotopt_foto foto " & SQLW & " AND foto.id > " & foto
		Set numOutrasFotoRes = dbConnection.Execute(SQL)
	end if
	if not anteriorFotoRes.eof then fotoAnterior = anteriorFotoRes("id") else fotoAnterior = 0 end if
	if not proximaFotoRes.eof  then fotoSeguinte = proximaFotoRes("id")  else fotoSeguinte = 0 end if
		
	' Num fotos total na galeria
	SQL = "SELECT count(*) AS num FROM eventos_fotopt_foto foto " & SQLW
	Set numFotoRes = dbConnection.Execute(SQL)
	
	' Mudar Galerias
	if clng(num) = 0 then
		num = numFotos

		' Descobrir ID da primeira foto na pagina de galeria anterior
		if not anteriorFotoRes.eof then
			if session("ordem") = "c" then
				SQL = "SELECT TOP " & numFotos & " foto.id FROM eventos_fotopt_foto foto " & SQLW & " AND foto.id <= " & fotoRes("id") & " ORDER BY foto.id DESC"
				Set anteriorGaleriaRes = dbConnection.Execute(SQL)
			else
				SQL = "SELECT TOP " & numFotos & " foto.id FROM eventos_fotopt_foto foto " & SQLW & " AND foto.id >= " & fotoRes("id") & " ORDER BY foto.id"
				Set anteriorGaleriaRes = dbConnection.Execute(SQL)
			end if
			do while not anteriorGaleriaRes.eof
				primeira = anteriorGaleriaRes("id")
				anteriorGaleriaRes.MoveNext
			loop
		end if
	elseif clng(num) = (numFotos + 1) then
		num = 1
		primeira = fotoRes("id")
	end if
	
	SQL = "SELECT * FROM autor WHERE id = " & fotoRes("autor")
	Set autorRes = dbConnection.Execute(SQL)
	
	SQL = "SELECT count(*) AS num FROM eventos_fotopt_comentarios WHERE foto = " & fotoRes("id")
	Set comentarioRes = dbConnection.Execute(SQL)

	directoria = int(fotoRes("id") / 1000)

	if session("menus") = "esc" then
		if fotoAnterior <> 0 then
			OpcaoMenu "<< ANTERIOR", "foto_evento.asp?foto=" & fotoAnterior & "&primeira=" & primeira & "&evento=" & evento & "&num=" & num - 1, True, False, -1, False, False
		end if
		if tipo <> "" then
			OpcaoMenu int(numOutrasFotoRes("num")) + 1 & "/" & int(numFotoRes("num")), "lista.asp?foto=" & fotoSeguinte & "&primeira=" & primeira & "&tema=" & tema & "&tipo=" & tipo & "&id=" & id & "&num=" & num + 1, True, False, -1, False, False
		end if
		if fotoSeguinte <> 0 then
			OpcaoMenu "SEGUINTE >>", "foto_evento.asp?foto=" & fotoSeguinte & "&primeira=" & primeira & "&evento=" & evento & "&num=" & num + 1, True, False, -1, False, False
		end if

		if fotoRes("moderar") <> True then
	'		OpcaoMenu "COMENTAR", "inserir_comentario_evento.asp?onde=foto&foto=" & foto & "&primeira=" & primeira & "&evento=" & evento & "&num=" & num, False, True, -1, False, False
		end if
		OpcaoMenu "LER COMENT�RIOS", "comentarios_evento.asp?foto=" & foto & "&primeira=" & primeira & "&evento=" & evento & "&num=" & num, False, False, -1, False, False

		OpcaoMenu "GALERIA", "galeria_evento.asp?primeira=" & primeira & "&evento=" & evento, False, False, -1, False, False

		OpcaoMenu "MOSTRAR MEN�S", "foto_evento.asp?menus=mos&foto=" & foto & "&primeira=" & primeira & "&evento=" & evento & "&num=" & num, False, False, -1, False, False
	else
		if fotoSeguinte <> 0 then
			OpcaoMenu "<b>>> FOTO SEGUINTE</b>", "foto_evento.asp?foto=" & fotoSeguinte & "&primeira=" & primeira & "&evento=" & evento & "&num=" & num + 1, True, False, -1, False, False
		end if
		if fotoAnterior <> 0 then
			OpcaoMenu "<b><< FOTO ANTERIOR</b>", "foto_evento.asp?foto=" & fotoAnterior & "&primeira=" & primeira & "&evento=" & evento & "&num=" & num - 1, True, False, -1, False, False
		end if

		if fotoRes("moderar") <> True then
	'		OpcaoMenu "COMENTAR FOTO", "inserir_comentario_evento.asp?onde=foto&foto=" & foto & "&primeira=" & primeira & "&evento=" & evento & "&num=" & num, False, True, -1, False, False
		end if
		OpcaoMenu "LER COMENT�RIOS", "comentarios_evento.asp?foto=" & foto & "&primeira=" & primeira & "&evento=" & evento & "&num=" & num, False, False, -1, False, False

		OpcaoMenu "VOLTAR � GALERIA", "galeria_evento.asp?primeira=" & primeira & "&evento=" & evento, False, False, -1, False, False

		OpcaoMenu "ESCONDER MEN�S", "foto_evento.asp?menus=esc&foto=" & foto & "&primeira=" & primeira & "&evento=" & evento & "&num=" & num, False, False, -1, False, False

		if session("ficha") <> "com" then
			OpcaoMenu "FICHA DE FOTO COMPLETA", "foto_evento.asp?ficha=com&foto=" & foto & "&primeira=" & primeira & "&evento=" & evento & "&num=" & num, False, False, -1, False, False
		else
			OpcaoMenu "FICHA DE FOTO RESUMIDA", "foto_evento.asp?ficha=res&foto=" & foto & "&primeira=" & primeira & "&evento=" & evento & "&num=" & num, False, False, -1, False, False
		end if

		OpcaoMenu "MUDAR DADOS OU APAGAR FOTO", "mudar_foto_evento.asp?foto=" & foto & "&primeira=" & primeira & "&evento=" & evento & "&num=" & num, False, True, fotoRes("autor"), False, False
		OpcaoMenu "REFAZER THUMBNAIL", "adm/refazer_thumb_evento.asp?foto=" & foto & "&primeira=" & primeira & "&evento=" & evento & "&num=" & num, False, False, -1, False, True
	end if

	if fotoRes("titulo") <> "" then
		if tipo <> "" then
			titulo = fotoRes("titulo") & " (" & int(numOutrasFotoRes("num")) + 1 & "/" & int(numFotoRes("num")) & ")"
		else
			titulo = fotoRes("titulo")
		end if
	else
		if tipo <> "" then
			titulo = "sem t�tulo" & " (" & int(numOutrasFotoRes("num")) + 1 & "/" & int(numFotoRes("num")) & ")"
		else
			titulo = "sem t�tulo"
		end if
	end if

	if session("menus") = "esc" then
		MiniMenu 2, 1, titulo
	else
		Menu 2, 1, titulo
	end if
	%>

	<% if ((fotoAnterior <> 0) or (fotoSeguinte <> 0)) and (session("menus") <> "esc") then %>
	<div align="right">
		<% if fotoAnterior <> 0 then %>
			<a class="oa" href="foto_evento.asp?foto=<% =fotoAnterior %>&primeira=<% =primeira %>&evento=<% =evento %>&num=<% =num - 1 %>"><<</a>
		<% end if %>
		<% if fotoSeguinte <> 0 then %>
			<a class="oa" href="foto_evento.asp?foto=<% =fotoSeguinte %>&primeira=<% =primeira %>&evento=<% =evento %>&num=<% =num + 1 %>">>></a>
		<% end if %>
	</div>
	<% else %>
		<font size="-3"><br></font>
	<% end if %>
	
	<div align="center">
	<a href="so_foto_evento.asp?foto=<% =foto %>&primeira=<% =primeira %>&evento=<% =evento %>&num=<% =num %>">
		<img src="/fotos/arquivo/eventos_fotopt/fotos/<% =directoria %>/foto<% =fotoRes("id") %>.jpg" border=0 alt="Prima para ver s&oacute; a fotografia"></a>
	<br><br>
	
	<table border="1" cellpadding="10" cellspacing="0">
	<tr><td align="center">
		<% if fotoRes("titulo") <> "" then %>
			<font color="white" face="arial">&nbsp;<b><% =fotoRes("titulo") %></b></font>
		<% else %>
			<font color="white" face="arial">&nbsp;<i><b>sem t&iacute;tulo</b></i></font>
		<% end if %>
	</td></tr>
	<tr><td>
		<table border="0" cellpadding="2" cellspacing="0" width="700">
			<tr><td><font color="white" size="-1" face="arial"><b>ID: </b></font></td><td width="100%"><font size="-1" color="white" face="arial"><% =fotoRes("id") %></font>&nbsp;&nbsp;<font size="-2" color="white" face="arial">(<% =day(fotoRes("data")) %>/<% =month(fotoRes("data")) %>/<% =year(fotoRes("data")) %>)</font></td></tr>
			<% if fotoRes("moderar") = True then %>
				<tr><td><font color="white" size="-1" face="arial"><b>ESTADO<br>PENDENTE: </b></font></td>
				<td>
					<font color="red" size="-1" face="arial"><b>FOTO � ESPERA DE APROVA��O PELO WEBMASTER.</b></font><br>
					<font color="white" size="-1" face="arial">
						Para evitar abusos, as fotos de membros novos, (com menos de 7 fotos na sua galeria principal),	<br>
						s� ser�o vis�veis pelos outros membros depois de aprovadas, o que poder� levar at� 3 dias.
					</font>
				</td></tr>
			<% end if %>
			<tr><td><font color="white" size="-1" face="arial"><b>EVENTO: </b></font></td><td><font color="white" size="-1" face="arial"><% =eventoRes("nome") %></font></td></tr>
			<tr><td><font color="white" size="-1" face="arial"><b>AUTOR: </b></font></td>
			<td><a href="autor.asp?autor=<% =fotoRes("autor") %>"><font color="white" size="-1" face="arial"><% =autorRes("nome") %></font></a></td></tr>
			<tr><td colspan="2" height="4"></td></tr>
			
			<% if fotoRes("descricao") <> "" then %>
				<tr><td><font color="white" size="-1" face="arial"><b>DESCRI&Ccedil;&Atilde;O: </b></font></td><td><font size="-1" color="white" face="arial"><% =fotoRes("descricao") %></font></td></tr>
			<% end if %>
		</table>
	</td></tr>
	<% if session("ficha") <> "com" then %>
		<tr><td>
			<table border="0" cellpadding="1" cellspacing="0">
				<% if (session("login") = 2) or (session("login") = fotoRes("autor")) then %>
					<tr><td><font size="-1" color="white" face="arial"><b>NUM. VISITAS: </b></font></td><td><font size="-1" color="white" face="arial"><% =fotoRes("contador") %></font></td></tr>
				<% end if %>
				<tr>
					<td><font size="-1" color="white" face="arial"><b>COMENT&Aacute;RIOS: </b></font></td>
					<td>
						<a href="comentarios_evento.asp?foto=<% =foto %>&primeira=<% =primeira %>&evento=<% =evento %>&num=<% =num %>"><font size="-1" color="white" face="arial"><% =comentarioRes("num") %></font></a>
					</td>
				</tr>
			</table>
		</td></tr>
	<% else %>
		<% if (session("login") = 2) or (session("login") = fotoRes("autor")) then %>
			<tr><td>
				<font size="-1" color="#FFCC66" face="arial"><b>FOTOGRAFIA VISITADA <% =fotoRes("contador") %> VEZ<% if fotoRes("contador") <> 1 then %>ES<% end if %></b></font>
			</td></tr>
		<% end if %>
		<% if comentarioRes("num") > 0 then %>
			<tr><td>
				<table border="0" cellpadding="1" cellspacing="0" bordercolor="gray" width="700">
				<tr><td><font size="-1" color="#FFCC66" face="arial"><b><% =comentarioRes("num") %> COMENT&Aacute;RIO<% if comentarioRes("num") <> 1 then %>S<% end if %>: </b></font></td></tr>
				<% 
				' COMENTARIOS
				SQL = "SELECT * FROM eventos_fotopt_comentarios WHERE moderar = False AND foto = " & foto & " ORDER BY data, id"
				Set comentarioRes = dbConnection.Execute(SQL)
		
				do while not comentarioRes.eof
					SQL = "SELECT nome FROM autor WHERE id = " & comentarioRes("autor")
					Set comentadorRes = dbConnection.Execute(SQL)
				%>
					<tr><td valign="top">
						<a href="autor.asp?autor=<% =comentarioRes("autor") %>"><font size="-2" color="silver" face="arial"><% =comentadorRes("nome") %></font></a>
						<font size="-2" color="silver" face="arial">(<% =day(comentarioRes("data")) %>/<% =month(comentarioRes("data")) %>/<% =right(year(comentarioRes("data")),2) %>)</font>
						<br>
						<font size="-1" color="white" face="arial"><% =Enter2Br(comentarioRes("comentario")) %></font>
					</td></tr>
					<% comentarioRes.MoveNext %>
				<% Loop %>
				</table>
			</td></tr>
		<% end if %>
	<% end if %>
	</table>

	<br>
	<a href="direitos_autor.asp"><font size="-2" color="white" face="arial">Direitos de autor</font></a><font size="-2" color="white" face="arial">: As imagens sao propriedade do autor ou dos seus clientes, podendo ser reproduzida somente com autoriza��o dos mesmos.</font>
	</div>

	<% if ((fotoAnterior <> 0) or (fotoSeguinte <> 0)) and (session("menus") <> "esc") then %>
	<div align="right">
		<% if fotoAnterior <> 0 then %>
			<a class="oa" href="foto_evento.asp?foto=<% =fotoAnterior %>&primeira=<% =primeira %>&evento=<% =evento %>&num=<% =num - 1 %>"><<</a>
		<% end if %>
		<% if fotoSeguinte <> 0 then %>
			<a class="oa" href="foto_evento.asp?foto=<% =fotoSeguinte %>&primeira=<% =primeira %>&evento=<% =evento %>&num=<% =num + 1 %>">>></a>
		<% end if %>
	</div>
	<% else %>
		<font size="-3"><br></font>
	<% end if %>
<% end if %>

<% FimPagina() %>
