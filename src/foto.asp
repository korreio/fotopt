<%
' Copyright: (c) 1999-2023, Tiago Fonseca
' GNU General Public License v3.0+ (see LICENSE.md or https://www.gnu.org/licenses/gpl-3.0.html)
' SPDX-License-Identifier: GPL-3.0-or-later
%>

<!-- #include file="funcoes_principais.asp" -->
<!-- #include file="galeria_seleccao.asp" -->

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

SQL = "SELECT * FROM foto WHERE id = " & foto
Set fotoRes = dbConnection.Execute(SQL)

' Contar visitas
if (session("SSUID") <> "") and (IsNull(fotoRes("ultima_visita")) or (fotoRes("ultima_visita") <> session("SSUID"))) then
	if session("login") <> fotoRes("autor") then
		SQL = "UPDATE foto SET contador = '" & fotoRes("contador") + 1 & "', ultima_visita = '" & session("SSUID") & "' WHERE id = " & foto
		dbConnection.Execute(SQL)
	end if
end if

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

Menu 1, GaleriaSubSeccao(tipo, id), "FOTO N�O EXISTE"
%>
	<font size="+1" color="white" face="arial">A fotografia com esse ID deixou de existir h&aacute; instantes.</font>
	<br>
	<font size="+1" color="white" face="arial">O mais provavel &eacute; que tenha sido apagado pelo seu autor.</font>
<%
else
	' Proxima e anterior
	if tipo <> "" then
	num = request("num")
	
		' Proxima e anterior e numero de ordem na galeria
		if session("ordem") = "c" then
			SQL = "SELECT TOP 1 foto.id FROM foto " & SQLW & " AND foto.id < " & foto & " ORDER BY foto.id DESC"
			Set anteriorFotoRes = dbConnection.Execute(SQL)
			SQL = "SELECT TOP 1 foto.id FROM foto " & SQLW & " AND foto.id > " & foto & " ORDER BY foto.id"
			Set proximaFotoRes = dbConnection.Execute(SQL)
			SQL = "SELECT count(*) AS num FROM foto " & SQLW & " AND foto.id < " & foto
			Set numOutrasFotoRes = dbConnection.Execute(SQL)
		else
			SQL = "SELECT TOP 1 foto.id FROM foto " & SQLW & " AND foto.id > " & foto & " ORDER BY foto.id"
			Set anteriorFotoRes = dbConnection.Execute(SQL)
			SQL = "SELECT TOP 1 foto.id FROM foto " & SQLW & " AND foto.id < " & foto & " ORDER BY foto.id DESC"
			Set proximaFotoRes = dbConnection.Execute(SQL)
			SQL = "SELECT count(*) AS num FROM foto " & SQLW & " AND foto.id > " & foto
			Set numOutrasFotoRes = dbConnection.Execute(SQL)
		end if
		if not anteriorFotoRes.eof then fotoAnterior = anteriorFotoRes("id") else fotoAnterior = 0 end if
		if not proximaFotoRes.eof  then fotoSeguinte = proximaFotoRes("id")  else fotoSeguinte = 0 end if
			
		' Num fotos total na galeria
		SQL = "SELECT count(*) AS num FROM foto " & SQLW
		Set numFotoRes = dbConnection.Execute(SQL)
		
		' Mudar Galerias
		if clng(num) = 0 then
			num = numFotos
	
			' Descobrir ID da primeira foto na pagina de galeria anterior
			if not anteriorFotoRes.eof then
				if session("ordem") = "c" then
					SQL = "SELECT TOP " & numFotos & " foto.id FROM foto " & SQLW & " AND foto.id <= " & fotoRes("id") & " ORDER BY foto.id DESC"
					Set anteriorGaleriaRes = dbConnection.Execute(SQL)
				else
					SQL = "SELECT TOP " & numFotos & " foto.id FROM foto " & SQLW & " AND foto.id >= " & fotoRes("id") & " ORDER BY foto.id"
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
	else
		fotoAnterior = 0
		fotoSeguinte = 0
	end if
	
	SQL = "SELECT * FROM autor WHERE id = " & fotoRes("autor")
	Set autorRes = dbConnection.Execute(SQL)
	
	SQL = "SELECT nome_minusculas FROM assunto WHERE id = " & fotoRes("assunto")
	Set assuntoRes = dbConnection.Execute(SQL)
	
	SQL = "SELECT nome FROM folder WHERE id = " & fotoRes("tema")
	Set temaRes = dbConnection.Execute(SQL)
	
	SQL = "SELECT * FROM fotomes_votos WHERE foto = " & fotoRes("id") & " AND NOT (mes = " & month(date()) & " AND ano = " & year(date()) & ") ORDER BY id DESC"
	Set fotomesDadosRes = dbConnection.Execute(SQL)
	
	SQL = "SELECT * FROM tema_mes_foto WHERE foto = " & fotoRes("id") & " AND vencedora = true AND data < #" & month(date()) & "/1/" & year(date()) & "#"
	Set temamesRes = dbConnection.Execute(SQL)

	SQL = "SELECT * FROM destaque_galeria_foto WHERE foto = " & fotoRes("id") & " AND galeria_destaque <= (SELECT id FROM destaque_galeria WHERE mes = " & month(date()) & " AND ano = " & year(date()) & ")"
	Set galeriaMesRes = dbConnection.Execute(SQL)

	SQL = "SELECT aprovacao FROM autor_opcoes WHERE autor = " & fotoRes("autor")
	Set autorOpcoesRes = dbConnection.Execute(SQL)
	
	if (session("login") = fotoRes("autor")) or (session("login") = 2) or (autorOpcoesRes("aprovacao") = 1) then
		SQL = "SELECT count(*) AS num FROM comentario WHERE foto = " & fotoRes("id")
		Set comentarioRes = dbConnection.Execute(SQL)
	elseif session("login") then
		SQL = "SELECT count(*) AS num FROM comentario WHERE foto = " & fotoRes("id") & " AND (moderar = false OR autor = " & session("login") & ")"
		Set comentarioRes = dbConnection.Execute(SQL)
	else
		SQL = "SELECT count(*) AS num FROM comentario WHERE foto = " & fotoRes("id") & " AND moderar = false"
		Set comentarioRes = dbConnection.Execute(SQL)
	end if

	SQL = "SELECT count(*) AS num FROM preferidas_fotos WHERE foto = " & fotoRes("id")
	Set preferidaRes = dbConnection.Execute(SQL)
	
	SQL = "SELECT id FROM cronicas WHERE foto = " & fotoRes("id")
	Set cronicasRes = dbConnection.Execute(SQL)

	SQL = "SELECT id FROM cronicas WHERE foto = " & fotoRes("id")
	Set cronicaRes = dbConnection.Execute(SQL)

	if not cronicaRes.eof then 
		SQL = "SELECT mes, ano FROM destaque_cronica WHERE foto = " & fotoRes("id")
		Set cronicaDestaqueRes = dbConnection.Execute(SQL)
		
		if not cronicaDestaqueRes.eof then
			cronicaEmDestaque = True
		else
			cronicaEmDestaque = False
		end if
	end if

	directoria = int(fotoRes("id") / 1000)

	if session("menus") = "esc" then
		if fotoAnterior <> 0 then
			OpcaoMenu "<< ANTERIOR", "foto.asp?foto=" & fotoAnterior & "&primeira=" & primeira & "&tema=" & tema & "&tipo=" & tipo & "&id=" & id & "&num=" & num - 1, True, False, -1, False, False
		end if
		if tipo <> "" then
			OpcaoMenu int(numOutrasFotoRes("num")) + 1 & "/" & int(numFotoRes("num")), "lista.asp?foto=" & fotoSeguinte & "&primeira=" & primeira & "&tema=" & tema & "&tipo=" & tipo & "&id=" & id & "&num=" & num + 1, True, False, -1, False, False
		end if
		if fotoSeguinte <> 0 then
			OpcaoMenu "SEGUINTE >>", "foto.asp?foto=" & fotoSeguinte & "&primeira=" & primeira & "&tema=" & tema & "&tipo=" & tipo & "&id=" & id & "&num=" & num + 1, True, False, -1, False, False
		end if

		if fotoRes("moderar") <> True then
			OpcaoMenu "COMENTAR", "inserir_comentario.asp?onde=foto&foto=" & foto & "&primeira=" & primeira & "&tema=" & tema & "&tipo=" & tipo & "&id=" & id & "&num=" & num, False, True, -1, False, False
			OpcaoMenu "LER COMENT�RIOS", "comentarios.asp?foto=" & foto & "&primeira=" & primeira & "&tema=" & tema & "&tipo=" & tipo & "&id=" & id & "&num=" & num, False, False, -1, False, False
		end if

		if tipo = "" then
			OpcaoMenu "GALERIA", "galeria.asp?tipo=autor&id=" & autorRes("id") & "&tema=" & fotoRes("tema"), False, False, -1, False, False
		else
			OpcaoMenu "GALERIA", "galeria.asp?primeira=" & primeira & "&tema=" & tema & "&tipo=" & tipo & "&id=" & id, False, False, -1, False, False
		end if

		OpcaoMenu "MOSTRAR MEN�S", "foto.asp?menus=mos&foto=" & foto & "&primeira=" & primeira & "&tema=" & tema & "&tipo=" & tipo & "&id=" & id & "&num=" & num, False, False, -1, False, False
	else
		if fotoSeguinte <> 0 then
			OpcaoMenu "<b>>> FOTO SEGUINTE</b>", "foto.asp?foto=" & fotoSeguinte & "&primeira=" & primeira & "&tema=" & tema & "&tipo=" & tipo & "&id=" & id & "&num=" & num + 1, True, False, -1, False, False
		end if
		if fotoAnterior <> 0 then
			OpcaoMenu "<b><< FOTO ANTERIOR</b>", "foto.asp?foto=" & fotoAnterior & "&primeira=" & primeira & "&tema=" & tema & "&tipo=" & tipo & "&id=" & id & "&num=" & num - 1, True, False, -1, False, False
		end if

		if fotoRes("moderar") <> True then
			OpcaoMenu "COMENTAR FOTO", "inserir_comentario.asp?onde=foto&foto=" & foto & "&primeira=" & primeira & "&tema=" & tema & "&tipo=" & tipo & "&id=" & id & "&num=" & num, False, True, -1, False, False
			OpcaoMenu "LER COMENT�RIOS", "comentarios.asp?foto=" & foto & "&primeira=" & primeira & "&tema=" & tema & "&tipo=" & tipo & "&id=" & id & "&num=" & num, False, False, -1, False, False
		end if

		if not cronicasRes.eof then
			OpcaoMenu "LER CR�NICA", "cronica.asp?foto=" & foto & "&primeira=" & primeira & "&tema=" & tema & "&tipo=" & tipo & "&id=" & id & "&num=" & num, False, False, -1, False, False
		end if
	
		if fotoRes("moderar") <> True then
	'		OpcaoMenu "INSERIR OU ALTERAR CR�NICA", "inserir_cronica.asp?foto=" & foto & "&primeira=" & primeira & "&tema=" & tema & "&tipo=" & tipo & "&id=" & id & "&num=" & num, False, True, fotoRes("autor"), False, False

			if (session("login") <> 0) then
				SQL = "SELECT id FROM preferidas_fotos WHERE foto = " & foto & " AND autor = " & session("login")
				Set ePreferidaRes = dbConnection.Execute(SQL)
				if ePreferidaRes.eof then
					OpcaoMenu "INSERIR NAS MINHAS PREFERIDAS", "inserir_preferidas.asp?foto=" & foto & "&primeira=" & primeira & "&tema=" & tema & "&tipo=" & tipo & "&id=" & id & "&num=" & num, False, True, -1, False, False
				else
					OpcaoMenu "REMOVER DAS MINHAS PREFERIDAS", "remover_preferidas.asp?foto=" & foto & "&primeira=" & primeira & "&tema=" & tema & "&tipo=" & tipo & "&id=" & id & "&num=" & num, False, True, session("login"), False, False
				end if
			end if
	
			' Os proprios autores nao podem votar, ou preferir
			if (session("login") <> 0) and (session("login") <> clng(fotoRes("autor"))) then
				SQL = "SELECT foto FROM foto_mes_proposta WHERE foto = " & foto & " AND mes = " & mes & " AND ano = " & ano
				Set fotomesRes = dbConnection.Execute(SQL)
				if not fotomesRes.eof then
	'				OpcaoMenu "VOTAR COMO FOTO DO M�S", "votar_fotomes.asp?foto=" & foto, False, True, -1, False, False
				end if
			end if
		end if
	
		if tipo = "" then
			if (session("login") <> 2) and (fotoRes("anonima") <> 0) and (fotoRes("data") > (cdate(date() & " " & time()) - 7)) then
			else
				OpcaoMenu "VER GALERIA DESTE AUTOR", "lista_temas.asp?autor=" & autorRes("id"), False, False, -1, False, False
			end if
		else
			OpcaoMenu "VOLTAR � GALERIA", "galeria.asp?primeira=" & primeira & "&tema=" & tema & "&tipo=" & tipo & "&id=" & id, False, False, -1, False, False
		end if

		OpcaoMenu "ESCONDER MEN�S", "foto.asp?menus=esc&foto=" & foto & "&primeira=" & primeira & "&tema=" & tema & "&tipo=" & tipo & "&id=" & id & "&num=" & num, False, False, -1, False, False

		if session("ficha") <> "com" then
			OpcaoMenu "FICHA DE FOTO COMPLETA", "foto.asp?ficha=com&foto=" & foto & "&primeira=" & primeira & "&tema=" & tema & "&tipo=" & tipo & "&id=" & id & "&num=" & num, False, False, -1, False, False
		else
			OpcaoMenu "FICHA DE FOTO RESUMIDA", "foto.asp?ficha=res&foto=" & foto & "&primeira=" & primeira & "&tema=" & tema & "&tipo=" & tipo & "&id=" & id & "&num=" & num, False, False, -1, False, False
		end if

		OpcaoMenu "MUDAR DADOS OU APAGAR FOTO", "mudar_foto.asp?foto=" & foto & "&primeira=" & primeira & "&tema=" & tema & "&tipo=" & tipo & "&id=" & id & "&num=" & num, False, True, fotoRes("autor"), False, False
		OpcaoMenu "MUDAR IMAGEM", "mudar_imagem.asp?foto=" & foto & "&primeira=" & primeira & "&tema=" & tema & "&tipo=" & tipo & "&id=" & id & "&num=" & num, False, True, fotoRes("autor"), False, False
		OpcaoMenu "REFAZER THUMBNAIL", "adm/refazer_thumb.asp?foto=" & foto & "&primeira=" & primeira & "&tema=" & tema & "&tipo=" & tipo & "&id=" & id & "&num=" & num, False, False, -1, False, True
		OpcaoMenu "INSERIR EM GALERIA DE J�RI", "juri/inserir_juri.asp?foto=" & foto, False, False, -1, True, False
		
		if tipo = "juri" then
			OpcaoMenu "REMOVER DA GALERIA DE J�RI", "juri/apagar_juri.asp?foto=" & foto & "&tema=" & id, False, False, -1, True, False
		end if
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
		MiniMenu 1, GaleriaSubSeccao(tipo, id), titulo
	else
		Menu 1, GaleriaSubSeccao(tipo, id), titulo
	end if
	%>

	<% if ((fotoAnterior <> 0) or (fotoSeguinte <> 0)) and (session("menus") <> "esc") then %>
	<div align="right">
		<% if fotoAnterior <> 0 then %>
			<a class="oa" href="foto.asp?foto=<% =fotoAnterior %>&primeira=<% =primeira %>&tema=<% =tema %>&tipo=<% =tipo %>&id=<% =id %>&num=<% =num - 1 %>"><<</a>
		<% end if %>
		<% if fotoSeguinte <> 0 then %>
			<a class="oa" href="foto.asp?foto=<% =fotoSeguinte %>&primeira=<% =primeira %>&tema=<% =tema %>&tipo=<% =tipo %>&id=<% =id %>&num=<% =num + 1 %>">>></a>
		<% end if %>
	</div>
	<% else %>
		<font size="-3"><br></font>
	<% end if %>
	
	<div align="center">
	<a href="so_foto.asp?foto=<% =foto %>&primeira=<% =primeira %>&tema=<% =tema %>&tipo=<% =tipo %>&id=<% =id %>&num=<% =num %>">
		<% if request("nova") = 1 then %>
			<img src="/fotos/trocar/foto<% =fotoRes("id") %>.jpg" border=0 alt="Prima para ver s&oacute; a fotografia"></a>
		<% else %>
			<img src="/fotos/fotos/<% =directoria %>/foto<% =fotoRes("id") %>.jpg" border=0 alt="Prima para ver s&oacute; a fotografia"></a>
		<% end if %>
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
						Para evitar abusos, as fotos de membros novos, (com 7 ou menos fotos na sua galeria),<br>
						s� ser�o vis�veis pelos outros membros depois de aprovadas, o que poder� levar at� 3 dias.
					</font>
				</td></tr>
			<% end if %>
			<tr><td><font color="white" size="-1" face="arial"><b>AUTOR: </b></font></td>
			<% if (fotoRes("anonima") <> 0) and (fotoRes("data") > (cdate(date() & " " & time()) - 7)) then %>
				<% if session("login") = 2 then %>
					<td><a href="autor.asp?autor=<% =fotoRes("autor") %>"><font color="red" size="-1" face="arial"><% =autorRes("nome") %></font></a></td></tr>
				<% else %>
					<td><font color="white" size="-1" face="arial"><i>an�nimo</i> (at� <% =day(fotoRes("data") + 7) & "/" & month(fotoRes("data") + 7) & "/" & year(fotoRes("data") + 7) & " �s " & hour(fotoRes("data") + 7) & ":" & minute(fotoRes("data") + 7) %>)</font></td></tr>
				<% end if %>
			<% else %>
				<td><a href="autor.asp?autor=<% =fotoRes("autor") %>"><font color="white" size="-1" face="arial"><% =autorRes("nome") %></font></a></td></tr>
			<% end if %>
			<tr><td><font color="white" size="-1" face="arial"><b>ASSUNTO: </b></font></td><td><font size="-1" color="white" face="arial"><% =assuntoRes("nome_minusculas") %></font></td></tr>
			<% if fotoRes("tema") <> "0" then %>
				<tr><td><font color="white" size="-1" face="arial"><b>TEMA: </b></font></td><td><font size="-1" color="white" face="arial"><% =temaRes("nome") %></font></td></tr>
			<% end if %>
			<tr><td colspan="2" height="4"></td></tr>
			
			<% if (fotoRes("data_tipo") <> 0) and (fotoRes("data_tipo") <> "") then %>
				<% if fotoRes("data_tipo") = 3 then %>
					<tr><td><font color="white" size="-1" face="arial"><b>TIRADA&nbsp;EM: </b></font></td><td><font size="-1" color="white" face="arial"><% =day(fotoRes("data_foto")) %>&nbsp;<% =meses(month(fotoRes("data_foto")) - 1) %>&nbsp;<% =year(fotoRes("data_foto")) %></font></td></tr>
				<% elseif fotoRes("data_tipo") = 2 then %>
					<tr><td><font color="white" size="-1" face="arial"><b>TIRADA&nbsp;EM: </b></font></td><td><font size="-1" color="white" face="arial"><% =meses(month(fotoRes("data_foto")) - 1) %>&nbsp;<% =year(fotoRes("data_foto")) %></font></td></tr>
				<% else %>
					<tr><td><font color="white" size="-1" face="arial"><b>TIRADA&nbsp;EM: </b></font></td><td><font size="-1" color="white" face="arial"><% =year(fotoRes("data_foto")) %></font></td></tr>
				<% end if %>
			<% end if %>
			<% if fotoRes("lugar") <> "" then %>
				<tr><td><font color="white" size="-1" face="arial"><b>LUGAR: </b></font></td><td><font size="-1" color="white" face="arial"><% =fotoRes("lugar") %></font></td></tr>
			<% end if %>
			<% if fotoRes("descricao") <> "" then %>
				<tr><td><font color="white" size="-1" face="arial"><b>DESCRI&Ccedil;&Atilde;O: </b></font></td><td><font size="-1" color="white" face="arial"><% =fotoRes("descricao") %></font></td></tr>
			<% end if %>
			<tr><td colspan="2" height="4"></td></tr>
			<% if fotoRes("maquina") <> "" then %>
				<tr><td><font size="-1" color="white" face="arial"><b>M&Aacute;QUINA: </b></font></td><td><font size="-1" color="white" face="arial"><% =fotoRes("maquina") %></font></td></tr>
			<% end if %>
			<% if fotoRes("Lente") <> "" then %>
				<tr><td><font size="-1" color="white" face="arial"><b>OBJECTIVA: </b></font></td><td><font size="-1" color="white" face="arial"><% =fotoRes("lente") %></font></td></tr>
			<% end if %>
			<% if fotoRes("filme") <> "" then %>
				<tr><td><font size="-1" color="white" face="arial"><b>FILME: </b></font></td><td><font size="-1" color="white" face="arial"><% =fotoRes("filme") %></font></td></tr>
			<% end if %>
			<% if fotoRes("filtros") <> "" then %>
				<tr><td><font size="-1" color="white" face="arial"><b>FILTROS: </b></font></td><td><font size="-1" color="white" face="arial"><% =fotoRes("filtros") %></font></td></tr>
			<% end if %>
			<% if fotoRes("flash") <> "" then %>
				<tr><td><font size="-1" color="white" face="arial"><b>ILUMINA��O: </b></font></td><td><font size="-1" color="white" face="arial"><% =fotoRes("flash") %></font></td></tr>
			<% end if %>
			<tr><td colspan="2" height="4"></td></tr>
			<% if fotoRes("abertura") <> "" then %>
				<tr><td><font size="-1" color="white" face="arial"><b>ABERTURA: </b></font></td><td><font size="-1" color="white" face="arial"><% =fotoRes("abertura") %></font></td></tr>
			<% end if %>
			<% if fotoRes("velocidade") <> "" then %>
				<tr><td><font size="-1" color="white" face="arial"><b>TEMPO&nbsp;DE<br>EXPOSI&Ccedil;&Atilde;O: </b></font></td><td><font size="-1" color="white" face="arial"><% =fotoRes("velocidade") %></font></td></tr>
			<% end if %>
			<% if fotoRes("tratamento_digital") <> "" then %>
				<tr><td><font size="-1" color="white" face="arial"><b>TRATAMENTO<br>DIGITAL: </b></font></td><td><font size="-1" color="white" face="arial"><% =fotoRes("tratamento_digital") %></font></td></tr>
			<% end if %>
			<% if fotoRes("outros") <> "" then %>
				<tr><td><font size="-1" color="white" face="arial"><b>OUTROS: </b></font></td><td><font size="-1" color="white" face="arial"><% =fotoRes("outros") %></font></td></tr>
			<% end if %>
		</table>
	</td></tr>
	<% if session("ficha") <> "com" then %>
		<tr><td>
			<table border="0" cellpadding="1" cellspacing="0">
				<tr>
					<td><font size="-1" color="white" face="arial"><b>COMENT&Aacute;RIOS: </b></font></td>
					<td>
						<% if (fotoRes("autor") = session("login")) or (session("login") = 2) then %>
							<a href="comentarios.asp?foto=<% =foto %>&primeira=<% =primeira %>&tema=<% =tema %>&tipo=<% =tipo %>&id=<% =id %>&num=<% =num %>"><font size="-1" color="white" face="arial"><% =comentarioRes("num") %></font></a>
						<% else %>
							<a href="comentarios.asp?foto=<% =foto %>&primeira=<% =primeira %>&tema=<% =tema %>&tipo=<% =tipo %>&id=<% =id %>&num=<% =num %>"><font size="-1" color="white" face="arial">Ler e inserir</font></a>
						<% end if %>
					</td>
				</tr>
	
				<% if (fotoRes("autor") = session("login")) or (session("login") = 2) then %>
					<% if preferidaRes("num") = 1 then %>
						<tr><td><font size="-1" color="white" face="arial"><b>PREFERIDA DE: </b></font></td><td><font size="-1" color="white" face="arial"><% =preferidaRes("num") %> membro</font></td></tr>
					<% elseif preferidaRes("num") > 1 then %>
						<tr><td><font size="-1" color="white" face="arial"><b>PREFERIDA DE: </b></font></td><td><font size="-1" color="white" face="arial"><% =preferidaRes("num") %> membros</font></td></tr>
					<% end if %>
				<% end if %>
	
				<% if not cronicaRes.eof then %>
					<% if not cronicaDestaqueRes.eof then %>
						<tr><td><font size="-1" color="white" face="arial"><b>CR&Oacute;NICA M&Ecirc;S:</b></font></td><td><a href="cronica.asp?foto=<% =foto %>&primeira=<% =primeira %>&tema=<% =tema %>&tipo=<% =tipo %>&id=<% =id %>&num=<% =num %>"><font size="-1" color="white" face="arial"><% =meses(cronicaDestaqueRes("mes") - 1) %> de <% =cronicaDestaqueRes("ano") %></font></a></td></tr>
					<% else %>
						<tr><td><font size="-1" color="white" face="arial"><b>COM CR&Oacute;NICA:</b></font></td><td><a href="cronica.asp?foto=<% =foto %>&primeira=<% =primeira %>&tema=<% =tema %>&tipo=<% =tipo %>&id=<% =id %>&num=<% =num %>"><font size="-1" color="white" face="arial">Ler cr&oacute;nica</font></a></td></tr>
					<% end if %>
				<% end if %>
	
				<% 
				if not fotomesDadosRes.eof then 
					SQL = "SELECT votos FROM fotomes_votos WHERE mes = " & fotomesDadosRes("mes") & " AND ano = " & fotomesDadosRes("ano") & " AND votos > " & fotomesDadosRes("votos") & " GROUP BY votos"
					Set posRes = dbConnection.Execute(SQL)
	
					pos = 1
					do while not posRes.eof
						pos = pos + 1
						posRes.MoveNext
					loop
				%>
					<tr><td><font size="-1" color="white" face="arial"><b>FOTO DO M&Ecirc;S: </b></font></td><td><font size="-1" color="white" face="arial"><% =pos %>&#186; lugar em <a href="arquivo/fotomes.asp?mes=<% =fotomesDadosRes("mes") %>&ano=<% =fotomesDadosRes("ano") %>"><% =meses(fotomesDadosRes("mes") - 1) %> de <% =fotomesDadosRes("ano") %></a></font></td></tr>
				<% end if %>
				<%
				if not temamesRes.eof then 
					SQL = "SELECT nome, mes, ano FROM tema_mes WHERE id = " & temamesRes("tema_mes")
					Set temamesDadosRes = dbConnection.Execute(SQL)
				%>
					<tr><td><font size="-1" color="white" face="arial"><b>TEMA DO M&Ecirc;S: </b></font></td><td><font size="-1" color="white" face="arial">vencedora em <a href="galeria.asp?tipo=temames_escolhidas&id=<% =temamesRes("tema_mes") %>"><% =meses(temamesDadosRes("mes") - 1) %> de <% =temamesDadosRes("ano") %></a></font></td></tr>
				<% end if %>
				<%
				if not galeriaMesRes.eof then 
					SQL = "SELECT mes, ano FROM destaque_galeria WHERE id = " & galeriaMesRes("galeria_destaque")
					Set destaqueDadosRes = dbConnection.Execute(SQL)
				%>
					<tr><td><font size="-1" color="white" face="arial"><b>DESTAQUE EM: </b></font></td><td><font size="-1" color="white" face="arial"><a href="galeria.asp?tipo=galeria_mes&id=<% =galeriaMesRes("galeria_destaque") %>"><% =meses(destaqueDadosRes("mes") - 1) %> de <% =destaqueDadosRes("ano") %></a></font></td></tr>
				<% end if %>
				<% if (session("login") = 2) or (session("login") = fotoRes("autor")) then %>
					<tr><td><font size="-1" color="white" face="arial"><b>NUM. VISITAS: </b></font></td><td><font size="-1" color="white" face="arial"><% =fotoRes("contador") %></font></td></tr>
				<% end if %>
			</table>
		</td></tr>
	<% else %>
		<% if (session("login") = 2) or (session("login") = fotoRes("autor")) then %>
			<tr><td>
				<font size="-1" color="#FFCC66" face="arial"><b>FOTOGRAFIA VISITADA <% =fotoRes("contador") %> VEZ<% if fotoRes("contador") <> 1 then %>ES<% end if %></b></font>
			</td></tr>
		<% end if %>
		<% if not cronicaRes.eof then %>
			<tr><td>
				<%
				SQL = "SELECT * FROM cronicas WHERE foto = " & foto
				Set cronicaRes = dbConnection.Execute(SQL)
				%>
				<table border="0" cellpadding="1" cellspacing="0" bordercolor="gray" width="700">
				<tr><td><font size="-1" color="#FFCC66" face="arial"><b>CR�NICA: </b></font>&nbsp;&nbsp;<font size="-2" color="silver" face="arial">(escrita a <% =day(cronicaRes("data")) %>/<% =month(cronicaRes("data")) %>/<% =year(cronicaRes("data")) %>)</font></td></tr>
				<tr><td></td></tr>
				<tr><td><font size="-1" color="white" face="arial"><% =Enter2Br(cronicaRes("texto")) %></font></td></tr>
				</table>
			</td></tr>
		<% end if %>
		<% if (cronicaEmDestaque = True) or (not fotomesDadosRes.eof) or (not temamesRes.eof) or (not galeriaMesRes.eof) then %>
			<tr><td>
				<table border="0" cellpadding="1" cellspacing="0">
				<tr><td><font size="-1" color="#FFCC66" face="arial"><b>PR�MIOS: </b></font></td></tr>
					<% if not cronicaRes.eof then %>
						<% if not cronicaDestaqueRes.eof then %>
							<tr><td><font size="-1" color="white" face="arial"><b>CR&Oacute;NICA M&Ecirc;S:</b></font></td><td><a href="cronica.asp?foto=<% =foto %>&primeira=<% =primeira %>&tema=<% =tema %>&tipo=<% =tipo %>&id=<% =id %>&num=<% =num %>"><font size="-1" color="white" face="arial"><% =meses(cronicaDestaqueRes("mes") - 1) %> de <% =cronicaDestaqueRes("ano") %></font></a></td></tr>
						<% end if %>
					<% end if %>
		
					<% 
					if not fotomesDadosRes.eof then 
						SQL = "SELECT votos FROM fotomes_votos WHERE mes = " & fotomesDadosRes("mes") & " AND ano = " & fotomesDadosRes("ano") & " AND votos > " & fotomesDadosRes("votos") & " GROUP BY votos"
						Set posRes = dbConnection.Execute(SQL)
		
						pos = 1
						do while not posRes.eof
							pos = pos + 1
							posRes.MoveNext
						loop
					%>
						<tr><td><font size="-1" color="white" face="arial"><b>FOTO DO M&Ecirc;S: </b></font></td><td><font size="-1" color="white" face="arial"><% =pos %>&#186; lugar em <a href="arquivo/fotomes.asp?mes=<% =fotomesDadosRes("mes") %>&ano=<% =fotomesDadosRes("ano") %>"><% =meses(fotomesDadosRes("mes") - 1) %> de <% =fotomesDadosRes("ano") %></a></font></td></tr>
					<% end if %>
					<%
					if not temamesRes.eof then 
						SQL = "SELECT nome, mes, ano FROM tema_mes WHERE id = " & temamesRes("tema_mes")
						Set temamesDadosRes = dbConnection.Execute(SQL)
					%>
						<tr><td><font size="-1" color="white" face="arial"><b>TEMA DO M&Ecirc;S: </b></font></td><td><font size="-1" color="white" face="arial">vencedora em <a href="galeria.asp?tipo=temames_escolhidas&id=<% =temamesRes("tema_mes") %>"><% =meses(temamesDadosRes("mes") - 1) %> de <% =temamesDadosRes("ano") %></a></font></td></tr>
					<% end if %>
					<%
					if not galeriaMesRes.eof then 
						SQL = "SELECT mes, ano FROM destaque_galeria WHERE id = " & galeriaMesRes("galeria_destaque")
						Set destaqueDadosRes = dbConnection.Execute(SQL)
					%>
						<tr><td><font size="-1" color="white" face="arial"><b>DESTAQUE EM: </b></font></td><td><font size="-1" color="white" face="arial"><a href="galeria.asp?tipo=galeria_mes&id=<% =galeriaMesRes("galeria_destaque") %>"><% =meses(destaqueDadosRes("mes") - 1) %> de <% =destaqueDadosRes("ano") %></a></font></td></tr>
					<% end if %>
				</table>
			</td></tr>
		<% end if %>
		<% if (fotoRes("autor") = session("login")) or (session("login") = 2) then %>
			<% if preferidaRes("num") > 0 then %>
				<tr><td>
					<table border="0" cellpadding="1" cellspacing="0" bordercolor="gray" width="700">
					<tr><td><font size="-1" color="#FFCC66" face="arial"><b>PREFERIDA DE <% =preferidaRes("num") %> MEMBRO<% if preferidaRes("num") <> 1 then %>S<% end if %>:</b></font></td></tr>
					<% 
					' PREFERIDOS
					SQL = "SELECT distinct(autor.id), autor.nome FROM autor INNER JOIN preferidas_fotos ON autor.id = preferidas_fotos.autor WHERE preferidas_fotos.foto = " & foto & " ORDER by nome"
					Set autorRes = dbConnection.Execute(SQL)
			
					num = 0
					do while not autorRes.eof
						num = num + 1
						autorRes.MoveNext
					loop
				
					if num > 0 then
						autorRes.MoveFirst 
					end if
					
					if (num mod 3) = 0 then
						porColuna = num / 3
					else
						porColuna = num / 3 + 1
					end if
					%>
					<tr>
					<% for j = 1 to 3 %>
						<td valign="top"><table border="0" cellspacing="0" cellpadding="3">
						<% 
						for i = 1 to porColuna
							if not autorRes.eof then
						%>
								<tr><td><a href="autor.asp?autor=<% =autorRes("id") %>"><font size="-2" color="silver" face="verdana, arial"><b><% =autorRes("nome") %></b></font></a><font size="-2">&nbsp;&nbsp;</font></td></tr>
						<%
							autorRes.MoveNext
							end if
						next
						%>
						</table></td>
					<% next %>
					</tr>
					</table>
				</td></tr>
			<% end if %>
		<% end if %>
		<% if comentarioRes("num") > 0 then %>
			<tr><td>
				<table border="0" cellpadding="1" cellspacing="0" bordercolor="gray" width="700">
				<tr><td>
					<font size="-1" color="#FFCC66" face="arial"><b><% if (fotoRes("autor") = session("login")) or (session("login") = 2) then %><% =comentarioRes("num") %>&nbsp;<% end if %>COMENT&Aacute;RIO<% if comentarioRes("num") <> 1 then %>S<% end if %>: </b></font>
				</td></tr>
				<% 
				' COMENTARIOS
				if (session("login") = fotoRes("autor")) or (session("login") = 2) or (autorOpcoesRes("aprovacao") = 1) then
					SQL = "SELECT * FROM comentario WHERE foto = " & foto & " ORDER BY data, id"
					Set comentarioRes = dbConnection.Execute(SQL)
				elseif session("login") then
					SQL = "SELECT * FROM comentario WHERE foto = " & foto & " AND (moderar = false OR autor = " & session("login") & ") ORDER BY data, id"
					Set comentarioRes = dbConnection.Execute(SQL)
				else
					SQL = "SELECT * FROM comentario WHERE foto = " & foto & " AND moderar = false ORDER BY data, id"
					Set comentarioRes = dbConnection.Execute(SQL)
				end if

				do while not comentarioRes.eof
					SQL = "SELECT nome FROM autor WHERE id = " & comentarioRes("autor")
					Set comentadorRes = dbConnection.Execute(SQL)
				%>
					<tr><td valign="top">
						<a href="autor.asp?autor=<% =comentarioRes("autor") %>"><font size="-2" color="silver" face="arial"><% =comentadorRes("nome") %></font></a>
						<font size="-2" color="silver" face="arial">(<% =day(comentarioRes("data")) %>/<% =month(comentarioRes("data")) %>/<% =right(year(comentarioRes("data")),2) %>)</font>
						<br>
						<font size="-1" color="<% if (comentarioRes("moderar") = True) and (autorOpcoesRes("aprovacao") = 0) then %>red<% elseif comentarioRes("moderar") = True then %>#ffcc33<% else %>white<% end if %>" face="arial"><% =Enter2Br(comentarioRes("comentario")) %></font>
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
			<a class="oa" href="foto.asp?foto=<% =fotoAnterior %>&primeira=<% =primeira %>&tema=<% =tema %>&tipo=<% =tipo %>&id=<% =id %>&num=<% =num - 1 %>"><<</a>
		<% end if %>
		<% if fotoSeguinte <> 0 then %>
			<a class="oa" href="foto.asp?foto=<% =fotoSeguinte %>&primeira=<% =primeira %>&tema=<% =tema %>&tipo=<% =tipo %>&id=<% =id %>&num=<% =num + 1 %>">>></a>
		<% end if %>
	</div>
	<% else %>
		<br>
	<% end if %>
<% end if %>

<% FimPagina() %>
