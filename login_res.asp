<!-- #include file="funcoes_principais.asp" -->
<!-- #include file="sqltext.asp" -->

<%
login = SqlText(request("login"))
password = request("password")

if (login <> "") and (password <> "") then
	SQL = "SELECT autor.id, autor.ip_inscricao, autor.data, autor.nome, autor.data_anterior, autor.ultima_data, autor.congelado, autor_opcoes.tipo_novidades, autor_opcoes.ficha_foto, autor.en_dadop FROM autor, autor_opcoes WHERE autor.dadol = '" & login & "' AND autor.id = autor_opcoes.autor"
	Set autorRes = dbConnection.Execute(SQL)
	
	if not autorRes.eof then
		codedPassword = Cifrar(password, autorRes("data"), autorRes("ip_inscricao"))
		if codedPassword = autorRes("en_dadop") then
			autenticado = True
			data = autorRes("ultima_data")
	
			if autorRes("tipo_novidades") = "3" then
				ultima_data = cdate(month(data) & "/" & day(data) & "/" & year(data))
			elseif autorRes("tipo_novidades") = "4" then
				ultima_data = cdate(month(data) & "/" & day(data) & "/" & year(data) & " " & hour(data) & ":00:00")
			elseif autorRes("tipo_novidades") = "5" then
				ultima_data = cdate(month(data) & "/" & day(data) & "/" & year(data) & " " & hour(data) & ":" & minute(data) & ":00")
			elseif (autorRes("tipo_novidades") = "6") or (autorRes("tipo_novidades") = "") or (autorRes("tipo_novidades") = "0") then
				ultima_data = data
			end if
			
			' Tipo ficha de foto
			if autorRes("ficha_foto") = 2 then
				session("ficha") = "com"
			else
				session("ficha") = ""
			end if
		else
			autenticado = False
		end if
	else
		autenticado = False
	end if
else
	autenticado = False
end if

if autorRes("id") <> 2 then
	autenticado = False
end if
%>

<% 
if (login <> "") and (password <> "" ) then
	if not autorRes.eof then 
		OpcaoMenu "VER A MINHA FICHA DE MEMBRO", "autor.asp?autor=" & autorRes("id"), False, False, -1, False, False
		
		OpcaoMenu "IR PARA A MINHA GALERIA", "lista_temas.asp?autor=" & autorRes("id"), False, False, -1, False, False
		OpcaoMenu "NOVIDADES DETALHADAS", "novidades.asp", False, False, -1, False, False
	end if
end if
Menu 3, 1, "LOGIN" 
%>

<%
if (login = "") or (password = "" ) then
%>
	<font size="+1" color="white" face="arial">Tem que preencher os dois campos obrigatoriamente</font>
	<br>
	<font size="+1" color="white" face="arial">prima o botao <b>back</b> no browser e complete a informa&ccedil;&atilde;o</font>
<%
elseif autenticado = False then
%>
	<font size="+1" color="white" face="arial">Autentica&ccedil;&atilde;o falhou, &eacute; membro deste site?</font><br><br>
	<font size="+1" color="white" face="arial">Se n&atilde;o &eacute; 
	<a href="inscricao.asp"><font size="+1" color="white" face="arial">inscreva-se premindo aqui</font></a>.<br><br>
	Se j&aacute; est&aacute; inscrito prima o botao <b>back</b> no browser e tente de novo.<br><br>
	Se n&atilde;o se lembra da sua password v&aacute; &agrave; sua ficha de membro
	e escolha a op&ccedil;&atilde;o <b>PASSWORD</b>.</font>
<%
elseif autorRes("congelado") = True then
%>
	<font size="+1" color="red" face="arial">ATEN&Ccedil;&Atilde;O:</font><br>
	<font size="+1" color="white" face="arial">Este login est&aacute; congelado. O membro n&atilde;o poder&aacute; fazer login</font>
	<font size="+1" color="white" face="arial">enquanto n&atilde;o fizer &quot;reply&quot; &agrave; mensagem de confirma&ccedil;&atilde;o de inscri&ccedil;&atilde;o</font>
	<font size="+1" color="white" face="arial">que foi enviada para o e-mail especificado quando da sua inscri&ccedil;&atilde;o.</font>
	<font size="+1" color="#FFCC66" face="arial">Se n&atilde;o o fizer num prazo de duas semanas, a contar do dia de inscri&ccedil;&atilde;o, os seus dados ser&atilde;o removidos.</font>

	<br><br>
	<font size="+1" color="white" face="arial">Se n&atilde;o recebeu nenhuma mensagem a pedir a confirma&ccedil;&atilde;o como membro do site</font>
	<font size="+1" color="white" face="arial">contacte o administrador o mais rapidamente poss&iacute;vel usando o endere&ccedil;o:</font>
	<font size="+1" color="white" face="arial"><a href="mailto:info@fotopt.net">info@fotopt.net</a> e exponha o seu problema (diga qual o seu nome ou login e refira que est&aacute; congelado).</font>

	<br><br>
	<font size="+1" color="white" face="arial">O mais prov&aacute;vel &eacute; que o endere&ccedil;o que especificou tenha ficado mal escrito,</font>
	<font size="+1" color="white" face="arial">ou que tenha havido um problema na transmiss&atilde;o da mensagem. Todos os</font>
	<font size="+1" color="white" face="arial">membros t&ecirc;m uma semana para responder a esse email antes de serem congelados.</font>
	
	<br><br>
	<font size="+1" color="white" face="arial">Por favor n&atilde;o crie um membro novo pois mal responda ao e-mail de confirma&ccedil;&atilde;o</font>
	<font size="+1" color="white" face="arial">o seu login ser&aacute; descongelado.</font>

	<br><br>
	<font size="+1" color="white" face="arial">Pe&ccedil;o desculpa pelo inconveniente mas este m&eacute;todo serve para evitar a</font>
	<font size="+1" color="white" face="arial">cria&ccedil;&atilde;o de membros fict&iacute;cios que prejudicam o funcionamente do site.</font>
	
	<br><br>
	<font size="+1" color="white" face="arial">Obrigado pela sua compreens&atilde;o.</font>
<%
else
	SQL = "SELECT visitas, ultimo_ip FROM contador WHERE tipo = 3 AND data = #" & date() & "#"
	Set contadorDiarioRes = dbConnection.Execute(SQL)

	if contadorDiarioRes.eof then
		SQL = "INSERT INTO contador (visitas, tipo, ultimo_ip, data) VALUES ("
		SQL = SQL & "'1', '3', '" & Request.ServerVariables("REMOTE_ADDR") & "', '" & date() & "')"
		dbConnection.Execute(SQL)
	else
		if contadorDiarioRes("ultimo_ip") <> Request.ServerVariables("REMOTE_ADDR") then
			SQL = "UPDATE contador SET visitas = '" & contadorDiarioRes("visitas") + 1 & "'"
			SQL = SQL & ", ultimo_ip = '" & Request.ServerVariables("REMOTE_ADDR") & "'"
			SQL = SQL & " WHERE tipo = 3 AND data = #" & date() & "#"
			dbConnection.Execute(SQL)
		end if
	end if

	session("login") = clng(autorRes("id"))

	SQL = "UPDATE autor SET ip = '" & Request.ServerVariables("REMOTE_ADDR")
	SQL = SQL & "', data_anterior = '" & autorRes("ultima_data")
	SQL = SQL & "', ultima_data = '" & date() & " " & time()
	SQL = SQL & "', ultima_sessao = '" & session.sessionID
	SQL = SQL & "', ssuid = '" & Request.Cookies("SSUID")
	SQL = SQL & "' WHERE id = " & autorRes("id")
	dbConnection.Execute(SQL)

	' Descobrir clones (2 horas de intervalo)
	SQL = "SELECT id, ultima_sessao FROM autor WHERE id <> " & autorRes("id") & " AND ip = '" & Request.ServerVariables("REMOTE_ADDR") & "' AND ultima_sessao = '" & session.sessionID & "' AND ((#" & date() & " " & time() & "# - ultima_data) <= (1/24))"
	Set clonesRes = dbConnection.Execute(SQL)

	do while not clonesRes.eof
		SQL = "SELECT id, ultima_data, repeticao FROM clones WHERE (autor1 = " & autorRes("id") & " AND autor2 = " & clonesRes("id") & ") OR (autor2 = " & autorRes("id") & " AND autor1 = " & clonesRes("id") & ")"
		Set cloneRes = dbConnection.Execute(SQL)

		if cloneRes.eof then
			SQL = "INSERT INTO clones (autor1, autor2, ultima_data, repeticao, ip) VALUES ('" & autorRes("id") & "','" & clonesRes("id") & "','" & date() & "','1','" & Request.ServerVariables("REMOTE_ADDR") & "')"
			dbConnection.Execute(SQL)
		else
			if cloneRes("ultima_data") <> date() then
				SQL = "UPDATE clones SET repeticao = '" & cloneRes("repeticao") + 1 & "', ultima_data = '" & date() & "', ip = '" & Request.ServerVariables("REMOTE_ADDR") & "' WHERE id = " & cloneRes("id")
				dbConnection.Execute(SQL)
			end if
		end if

		clonesRes.MoveNext
	loop
	' Fim descobrir clones

	SQL = "SELECT * FROM avisos_webmaster WHERE autor = " & autorRes("id") & " AND lido = false ORDER BY data DESC"
	Set avisosRes = dbConnection.Execute(SQL)

	SQL = "SELECT * FROM novidade WHERE data >= #" & ultima_data & "# ORDER BY data DESC"
	Set novidadesRes = dbConnection.Execute(SQL)

	SQL = "SELECT count(*) AS num FROM novidade WHERE data >= #" & ultima_data & "#"
	Set numNovidadesRes = dbConnection.Execute(SQL)

	SQL = "SELECT count(*) AS num FROM foto WHERE moderar = False AND data >= #" & ultima_data & "#"
	Set numFotosRes = dbConnection.Execute(SQL)
	
	SQL = "SELECT count(*) AS num FROM comentario WHERE data >= #" & ultima_data & "#"
	Set numComentFotosRes = dbConnection.Execute(SQL)

	SQL = "SELECT count(*) AS num FROM comentario_autor WHERE data >= #" & ultima_data & "#"
	Set numComentAutorRes = dbConnection.Execute(SQL)

	SQL = "SELECT id AS num FROM comentario_autor WHERE autor = " & autorRes("id") & " AND moderar = True"
	Set numComentEsteAutorRes = dbConnection.Execute(SQL)

	SQL = "SELECT distinct(foto.id) FROM foto, comentario WHERE foto.moderar = False AND foto.autor = " & autorRes("id") & " AND foto.id = comentario.foto AND comentario.moderar = True"
	Set fotoRes = dbConnection.Execute(SQL)
	
	SQL = "SELECT count(*) AS num FROM autor WHERE data >= #" & ultima_data & "#"
	Set numAutorRes = dbConnection.Execute(SQL)
	
	SQL = "SELECT count(*) AS num FROM evento WHERE data >= #" & ultima_data & "#"
	Set numEventosRes = dbConnection.Execute(SQL)
	
	SQL = "SELECT count(*) AS num FROM debate_mensagem WHERE mostrar <> 0 AND data >= #" & ultima_data & "#"
	Set numMensagensRes = dbConnection.Execute(SQL)

	SQL = "SELECT count(*) AS num FROM votacao_topico WHERE mostrar <> 0 AND data >= #" & ultima_data & "#"
	Set numVotacoesRes = dbConnection.Execute(SQL)

	SQL = "SELECT count(*) AS num FROM cronicas WHERE data >= #" & ultima_data & "#"
	Set numCronicasRes = dbConnection.Execute(SQL)

	SQL = "SELECT * FROM cronicas WHERE data >= #" & ultima_data & "# ORDER BY foto"
	Set cronicaRes = dbConnection.Execute(SQL)
%>
	<font color="#FFCC66" face="arial"><b>BEM VINDO/A <% =autorRes("nome") %><br>AGORA J&Aacute; PODE ACEDER AO SITE COMPLETO.</b></font>	
	<br><br>
	
	<table cellpadding="10" cellspacing="0" border="1">
	<tr><td>
	<font color="white" face="arial">
	<b>RESUMO DAS NOVIDADES</b><br>
	</font>
	<font size="-1" color="white" face="arial">
	<% if minute(data) < 10 then %>
		(desde a &uacute;ltima vez que fez login no site, &agrave;s <% =hour(data) %>:0<% =minute(data) %> de <% =day(data) %>/<% =month(data) %>/<% =year(data) %>,
	<% else %>
		(desde a &uacute;ltima vez que fez login no site, &agrave;s <% =hour(data) %>:<% =minute(data) %> de <% =day(data) %>/<% =month(data) %>/<% =year(data) %>,
	<% end if %>
	para mais pormenores visite a sec&ccedil;&atilde;o de <a href="novidades.asp">novidades</a>).
	</font>
	</td></tr>
	<% if not avisosRes.eof then %>
		<tr><td>
			<font color="#FFCC66" face="arial"><b>MENSAGENS DO <a href="mailto:info@fotopt.net"><font color="#FFCC66" face="arial"><b>WEBMASTER</b></font></a> PARA SI</b></font><br>
			<table cellpadding="3" cellspacing="0" border="0">
			<% do while not avisosRes.eof %>
				<tr>
					<td align="right" valign="top"><font size="-2" color="white" face="Arial"><% =day(avisosRes("data")) %>/<% =month(avisosRes("data")) %>/<% =year(avisosRes("data")) %></font></td>
					<td>
						<font size="-1" color="#FFCC66" face="Arial"><% =avisosRes("texto") %></font><br>
						<a href="apagar_aviso.asp?aviso=<% =avisosRes("id") %>"><font size="-2" color="white" face="Arial"><b>APAGAR MENSAGEM</b></font></a>
					</td>
				</tr>
				<% avisosRes.MoveNext %>
			<% loop %>
			</table>
		</td></tr>
	<% end if %>
	<% if numNovidadesRes("num") > 0 then %>
		<tr><td>
			<font color="white" face="arial"><b>ALTERA&Ccedil;&Otilde;ES AO SITE</b></font><br>
			<table cellpadding="3" cellspacing="0" border="0">
			<% do while not novidadesRes.eof %>
				<tr>
					<td align="right" valign="top"><font size="-2" color="white" face="Arial"><% =day(novidadesRes("data")) %>/<% =month(novidadesRes("data")) %>/<% =year(novidadesRes("data")) %></font></td>
					<td><font size="-1" color="#FFCC66" face="Arial"><% =novidadesRes("texto") %></font></td>
				</tr>
				<% novidadesRes.MoveNext %>
			<% loop %>
			</table>
		</td></tr>
	<% end if %>
	<tr><td>
		<font color="white" face="arial"><% =numFotosRes("num") %> <b><a href="galeria.asp?tipo=novas&id=0">FOTO<% if numFotosRes("num") <> 1 then %>S<% end if %> NOVA<% if numFotosRes("num") <> 1 then %>S<% end if %></a></b></font><br>
		<font color="white" face="arial"><% =numComentFotosRes("num") %> <b><a href="novidades_comentarios.asp">NOVO<% if numComentFotosRes("num") <> 1 then %>S<% end if %> COMENT&Aacute;RIO<% if numComentFotosRes("num") <> 1 then %>S<% end if %> A FOTOS</a></b></font><br>
		<% if not fotoRes.eof then %>
			<font size="-1" color="#FFCC66" face="arial">&nbsp;&nbsp;Comentários a fotos suas, por moderar:</font>
			<% do while not fotoRes.eof %>
				<font size="-2" color="white" face="arial">&nbsp;<a href="comentarios.asp?foto=<% =fotoRes("id") %>"><% =fotoRes("id") %></a></font>
				<% fotoRes.MoveNext %>
			<% loop %>
			<br>
		<% end if %>
		<font color="white" face="arial"><% =numComentAutorRes("num") %> <b><a href="novidades_comentarios.asp">NOVO<% if numComentAutorRes("num") <> 1 then %>S<% end if %> COMENT&Aacute;RIO<% if numComentAutorRes("num") <> 1 then %>S<% end if %> A AUTORES</a></b></font><br>
		<% if not numComentEsteAutorRes.eof then %>
			&nbsp;&nbsp;<a href="comentarios_autor.asp?id=<% =autorRes("id") %>"><font size="-1" color="#FFCC66" face="arial">Tem comentários de autor por moderar</font></a><br>
		<% end if %>
		<font color="white" face="arial"><% =numCronicasRes("num") %> <b>CR&Oacute;NICA<% if numCronicasRes("num") <> 1 then %>S<% end if %> NOVA<% if numCronicasRes("num") <> 1 then %>S<% end if %></b></font><br>
		<% do while not cronicaRes.eof %>
			&nbsp;&nbsp;<a href="foto.asp?foto=<% =cronicaRes("foto") %>"><font size="-2" face="arial" color="#FFCC66"><% =cronicaRes("foto") %></font></a>
			<% cronicaRes.MoveNext %>
		<% loop %>
		<% if numCronicasRes("num") > 0 then %><br><% end if %>
		<font color="white" face="arial"><% =numVotacoesRes("num") %> <b><a href="votacoes.asp">VOTA&Ccedil;<% if numVotacoesRes("num") <> 1 then %>&Otilde;ES<% else %>&Atilde;O<% end if %></a> NOVA<% if numVotacoesRes("num") <> 1 then %>S<% end if %></b></font><br>
		<%
		if numVotacoesRes("num") > 0 then
			SQL = "SELECT id, nome FROM votacao_topico WHERE mostrar <> 0 AND data >= #" & ultima_data & "# ORDER BY nome"
			Set votacaoRes = dbConnection.Execute(SQL)
		%>
			<font size="-1" color="#FFCC66" face="arial">&nbsp;&nbsp;</font>
			<% do while not votacaoRes.eof %>
				<a href="votacao_items.asp?votacao=<% =votacaoRes("id") %>"><font size="-2" color="#FFCC66" face="verdana, arial"><b><% =votacaoRes("nome") %></b></font></a>&nbsp;&nbsp;
			<%
				votacaoRes.MoveNext
			Loop 
			%>
		<br>
		<% end if %>
		<font color="white" face="arial"><% =numAutorRes("num") %> <b>MEMBRO<% if numAutorRes("num") <> 1 then %>S<% end if %> NOVO<% if numAutorRes("num") <> 1 then %>S<% end if %></b></font><br>
		<font color="white" face="arial"><% =numEventosRes("num") %> <b><a href="eventos_tipo.asp">EVENTO<% if numEventosRes("num") <> 1 then %>S<% end if %></a> NOVO<% if numEventosRes("num") <> 1 then %>S<% end if %></b></font><br>
		<font color="white" face="arial"><% =numMensagensRes("num") %> <b>NOVA<% if numMensagensRes("num") <> 1 then %>S<% end if %> MENSAGE<% if numMensagensRes("num") <> 1 then %>NS<% else %>M<% end if %> DE <a href="debates.asp">DEBATE<% if numMensagensRes("num") <> 1 then %>S<% end if %></a></b></font><br>
	</td></tr>
	</table>
	<br>
	<font size="-1" color="white" face="arial">
	<b>Nota</b>:
	Quando j&aacute; n&atilde;o precisar de aceder &agrave;s op&ccedil;&otilde;es exclusivas dos membros pode
	fazer <i>logout</i> (sair) voltando &agrave; sec&ccedil;&atilde;o <b>MEMBROS</b>. Assim ningu&eacute;m poder&aacute; utilizar a sua conta
	de membro indevidamente se deixar o computador. Se n&atilde;o o fizer o sistema faz
	automaticamente ao fim de 20 minutos de inactividade ou ao fechar o seu
	browser (ou computador).
	</font>
<% end if %>

<% FimPagina() %>
