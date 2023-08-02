<%
'Response.CacheControl = "no-cache"
'Response.AddHeader "Pragma", "no-cache"
'Response.Expires = -1

url_base = "/" 
'url_base = "/foto/"
opcoesMenu = ""
refresh_url = ""
corFundoMenu = "gray"
corLinhasMenu = "silver"
scriptName = Request.ServerVariables("SCRIPT_NAME")
queryString = Request.ServerVariables("QUERY_STRING")
remoteAddr = Request.ServerVariables("REMOTE_ADDR")
httpReferer = Request.ServerVariables("HTTP_REFERER")
if (scriptName <> "inserir_foto_res.asp") and (scriptName <> "inserir_retrato_res.asp") then
	modop = request("modop")
end if

' Inicio Base de Dados
Set dbConnection = Server.CreateObject("ADODB.Connection")
dbConnection.Open "Data Source=c:\databases\foto.mdb;Provider=Microsoft.Jet.OLEDB.4.0;"

ContarVisitas()

Dim menuGaleria(7)
menuGaleria(0) = Array("MEMBROS", 					"escolha_galeria_membros.asp")
menuGaleria(1) = Array("MEMBROS DESTACADOS", 		"escolha_galeria_membros_destacados.asp")
menuGaleria(2) = Array("ASSUNTOS", 					"escolha_galeria_assuntos.asp")
menuGaleria(3) = Array("DATAS", 					"escolha_galeria_data.asp")
menuGaleria(4) = Array("PROCURAR ID'S",				"procurar_id.asp")
menuGaleria(5) = Array("PROCURAR POR DADOS",		"procurar_dados.asp")
menuGaleria(6) = Array("ESPECIAIS", 				"escolha_galeria_especiais.asp")

Dim menuDestaques(6)
menuDestaques(0) = Array("EVENTOS FOTO@PT", 		"eventos_fotopt.asp")
menuDestaques(1) = Array("ARQUIVO", 				"arquivo/arquivo.asp")
menuDestaques(2) = Array("LIVRO DE VISITAS", 		"guestbook_paises.asp")
menuDestaques(3) = Array("AGENDA DE EVENTOS", 		"eventos_tipo.asp")
menuDestaques(4) = Array("OPINI�ES SOBRE MATERIAL", "opiniao_temas.asp")
menuDestaques(5) = Array("HISTORIAL",		 		"historial.asp")

Dim menuMembros(2)
menuMembros(0) = Array("LOGIN (AUTENTICA��O)", 	"login.asp")
menuMembros(1) = Array("FICHAS DE MEMBROS", 	"membros.asp")

Dim menuInformacao(7)
menuInformacao(0) = Array("MINI CURSO DE FOTOGRAFIA", 	"tecnica/curso/indice.asp")
menuInformacao(1) = Array("BIBLIOGRAFIA", 				"livros_tipo.asp")
menuInformacao(2) = Array("LISTA DE LINKS", 			"links_tipo.asp")
menuInformacao(3) = Array("FOTOGRAFAR", 				"tecnica/fotografar.asp")
menuInformacao(4) = Array("LABORAT�RIO", 				"tecnica/laboratorio.asp")
menuInformacao(5) = Array("BIOGRAFIAS", 				"historia/biografias.asp")
menuInformacao(6) = Array("MAILING LISTS", 				"mailinglist.asp")

Dim menuUteis(6)
menuUteis(0) = Array("MAPA DO SITE", 			"sitemap.asp")
menuUteis(1) = Array("CALIBRAR MONITOR",		"tecnica/calibrar_monitor.asp")
menuUteis(2) = Array("BUSCA",					"busca.asp")

Dim menuPrincipal(7)
menuPrincipal(0) = Array("GALERIAS", 		"escolha_galeria_membros.asp",  7, menuGaleria)
menuPrincipal(1) = Array("ARQUIVO", 		"arquivo/arquivo.asp", 			6, menuDestaques)
menuPrincipal(2) = Array("MEMBROS", 		"membros.asp", 					2, menuMembros)
menuPrincipal(3) = Array("INFORMA��O", 		"tecnica/curso/indice.asp", 	7, menuInformacao)
menuPrincipal(4) = Array("�TEIS", 			"sitemap.asp", 					3, menuUteis)
%>

<% 
' Cabecalho
sub Cabecalho(titulo, semTags) 
%>
<html>
<head>
	<title>foto@pt - Fotografia em Portugu�s - <% =titulo %></title>
	<meta name"robots" content="index, follow">
	<meta name="owner" content="webmaster@fotopt.net">
	<meta name="author" content="Tiago Fonseca">
	<% if semTags = False then %>
		<meta name="description" content="Dedicado � divulga��o de trabalhos de fot�grafos, amadores e profissionais, de express�o portuguesa. Exibiting works by portuguese speeking, both amator and professional, photographers.">
		<meta name="keywords" content="portugal fotografia artistica fotografias portuguesas foto art�stica fotos art�sticas fotografo portugues fot�grafo portugu�s fot�grafos portugueses amadores profissionais fotografos brasileiros galeria nus nu n� n�s paisagem retrato galerias arte fotogr�fica tecnicas fotograficas eventos fotojornalismo portuguese photography brasilian photos landscape photo nude photographies nudes portrait photojournalism photographer gallery photographic artwork galleries">
	<% end if %>
	<% if refresh_url <> "" then %><meta http-equiv="refresh" content="0;url=<% =refresh_url %>"><% end if %>
	<link rel="stylesheet" href="<% =url_base %>style.css" TYPE="text/css">
</head>
<body bgcolor="black" link="white" vlink="white" leftmargin="0" topmargin="0" marginheight="0" marginwidth="0">
<%
end sub
' Cabecalho
%>

<%
sub ComRefresh(url)
	' Para fazer o refresh para outra pagina
	refresh_url = url
end sub
%>

<% 
sub OpcaoMenu(nome, url, seleccionado, membro, id_membro, juri, webmaster)
	if (webmaster = True) then
		if (session("login") <> 2) then
			exit sub
		else
			opcoesMenu = opcoesMenu & "<tr><td><a href=""" & url_base & url & """ class=""owi"">" & nome & "</a></td></tr>"
			exit sub
		end if
	end if

	if (juri = True) then
		if (VerificarJuri() <> True) then
			exit sub
		else
			opcoesMenu = opcoesMenu & "<tr><td><a href=""" & url_base & url & """ class=""oji"">" & nome & "</a></td></tr>"
			exit sub
		end if
	end if
	
	if (membro = True) then
		if (clng(id_membro) > -1) then
			if clng(id_membro) <> session("login") then
				if session("login") = 2 then
					opcoesMenu = opcoesMenu & "<tr><td><a href=""" & url_base & url & """ class=""owi"">" & nome & "</a></td></tr>"
				end if
				exit sub
			end if
		elseif (session("login")) = 0 then
			exit sub
		end if
	end if

	if seleccionado = True then
		opcoesMenu = opcoesMenu & "<tr><td><a href=""" & url_base & url & """ class=""oa"">" & nome & "</a></td></tr>"
	else
		opcoesMenu = opcoesMenu & "<tr><td><a href=""" & url_base & url & """ class=""oi"">" & nome & "</a></td></tr>"
	end if
end sub ' OpcaoMenu
%>

<% 
' Mini Menu
sub MiniMenu(menu_principal, menu_secundario, titulo)
	Cabecalho titulo, True
%>
<table cellpadding="0" cellspacing="0" border="0" width="100%">
<tr><td align="center">
	<table cellpadding="4" cellspacing="0" border="1" bordercolor="silver" bordercolordark="silver" bordercolorlight="silver">
	<tr>
	<% 
	' Opcoes extra inseridas com a funcao OpcoesMenu 
	if opcoesMenu <> "" then
		opcoesMenu = replace(opcoesMenu, "<tr>", "")
		opcoesMenu = replace(opcoesMenu, "</tr>", "")
	%>
		<% =opcoesMenu %>
	<% end if %>
	</tr>
	</table>
</td></tr>
<tr><td valign="top">
	<table width="100%" cellpadding="10" cellspacing="0" border="0"><tr><td>
<%
end sub 
' MiniMenu
%>

<% 
' Menu
sub Menu(menu_principal, menu_secundario, titulo)
	Cabecalho titulo, menu_principal
	if modop = "1" then exit sub end if
%>
<table cellpadding="0" cellspacing="0" border="0" width="100%" height="100%" bordercolordark="<% =corLinhasMenu %>" bordercolorlight="<% =corLinhasMenu %>" bordercolor="<% =corLinhasMenu %>">
<tr>
	<td valign="middle" align="center"><a href="<% =url_base %>index.asp"><img src="<% =url_base %>imagens/simbolo_pequeno_3.gif" width="120" height="20" border="0" alt="HOME"></a></td>
	<td rowspan="3" width="1" bgcolor="<% =corLinhasMenu %>"><img src="<% =url_base %>imagens/pixel.gif"></td>
	<td><table cellpadding="0" cellspacing="0" height="24" border="0" bgcolor="<% =corFundoMenu %>"><tr>
		<% for i = 0 to 4 %>
			<td <% if (menu_principal - 1) = i then %>bgcolor="#000000"<% end if %>><a href="<% =url_base %><% =menuPrincipal(i)(1) %>" class="<% if (menu_principal - 1) = i then %>pa<% else %>pi<% end if %>"><% =menuPrincipal(i)(0) %></a></td>
			<td width="1" bgcolor="<% =corLinhasMenu %>"><img src="<% =url_base %>imagens/pixel.gif"></td>
		<% next %>
	</tr></table></td>
</tr>

<tr><td height="1" bgcolor="<% =corLinhasMenu %>"><img src="<% =url_base %>imagens/pixel.gif"></td><td height="1" bgcolor="<% =corLinhasMenu %>"><img src="<% =url_base %>imagens/pixel.gif"></td></tr>

<tr><td valign="top">
	<table border="0" cellpadding="0" cellspacing="0" width="100%">
	<%
	' Menu lateral
	if menu_principal <> 0 then
	%>
		<% for i = 0 to (menuPrincipal(menu_principal - 1)(2) - 1) %>
			<% if (menu_secundario - 1) = i then %>
				<tr><td><table cellpadding="3">
					<tr><td colspan="2"><a href="<% =url_base %><% =menuPrincipal(menu_principal - 1)(3)(i)(1) %>" class="sa"><% =menuPrincipal(menu_principal - 1)(3)(i)(0) %></a><br></td></tr>
					<% if opcoesMenu <> "" then	%><tr><td></td><td><table cellpadding="3" cellspacing="0" border="0" width="100%"><% =opcoesMenu %></table></td></tr><% end if %>
				</table></td></tr>
			<% else %>
				<tr><td bgcolor="<% =corFundoMenu %>"><table><tr><td><a href="<% =url_base %><% =menuPrincipal(menu_principal - 1)(3)(i)(1) %>" class="si"><% =menuPrincipal(menu_principal - 1)(3)(i)(0) %></a></td></tr></table></td></tr>
			<% end if %>
			<tr><td height="1" bgcolor="<% =corLinhasMenu %>"><img src="<% =url_base %>imagens/pixel.gif"></td></tr>
		<% next %>
	
	<% end if %>

	<tr><td>
		<table cellspacing="6" width="100%">
		<%
		' Destaques
		if session("login") = 2 then
			SQL = "SELECT * FROM destaques WHERE (seccao = " & menu_principal & " OR seccao = -1) ORDER BY data DESC "
		else
			SQL = "SELECT * FROM destaques WHERE data <= #" & cdate(date() & " " & time() ) & "# AND (seccao = " & menu_principal & " OR seccao = -1) ORDER BY data DESC "
		end if
		Set destaquesRes = dbConnection.Execute(SQL)
		do while not destaquesRes.eof
			if (destaquesRes("data") >= (date() - 5)) or (menu_principal = 0) then
				classeData = "desa"
			else
				classeData = "desd"
			end if
		%>
			<tr><td>
				<% if session("login") = 2 then %>
					<a href="<% =url_base %>adm/adm_mudar_destaque.asp?destaque=<% =destaquesRes("id") %>" class="<% =classeData %>"><% =day(destaquesRes("data")) %>/<% =month(destaquesRes("data")) %>/<% =year(destaquesRes("data")) %>:</a><br>
				<% else %>
					<font class="<% =classeData %>"><% =day(destaquesRes("data")) %>/<% =month(destaquesRes("data")) %>/<% =year(destaquesRes("data")) %>:</font><br>
				<% end if %>
				<font class="des"><% =destaquesRes("texto") %></font><br>
			</td></tr>
		<%
			destaquesRes.MoveNext
		loop
		%>
		<% if session("login") = 2 then %><tr><td><a href="<% =url_base %>adm/adm_inserir_destaque.asp?principal=<% =menu_principal %>"><font face="arial" color="red" style="font-size: 10px;"><b>INSERIR DESTAQUE</b></font></a></td></tr><% end if %>
		</table>
	</td></tr>

	<%
	' Opcoes uteis
	if menu_principal <> 0 then
	%>
		<tr><td height="1" bgcolor="<% =corLinhasMenu %>"><img src="<% =url_base %>imagens/pixel.gif"></td></tr>
		<tr><td bgcolor="gray"><table width="100%" cellspacing="4"><tr><td align="center"><font class="titulo"><% =titulo %></font></td></tr></table></td></tr>
		<tr><td height="1" bgcolor="<% =corLinhasMenu %>"><img src="<% =url_base %>imagens/pixel.gif"></td></tr>
	<% end if %>
</table></td>
<td valign="top" width="100%" height="100%">
	<table width="100%" cellpadding="<% if formatacaoFotoGaleria = True then %>3<% else %>10<% end if %>" cellspacing="0" border="0"><tr><td>
<%
end sub
' Menu
%>

<% 
' Fim Pagina
sub FimPagina() 
	if (modop <> "1") then 
%>
			</td></tr></table>
		</td></tr></table>
	<% end if %>
</body></html>
<%
	if dbConnection <> "" then
		dbConnection.close
	end if
	set dbConnection = Nothing
end sub 
' FimPagina 
%>

<%
' Calcular subseccao da seccao GALERIAS
function GaleriaSubSeccao(tipo, id)
	if tipo = "assunto" then
		GaleriaSubSeccao = 3
	elseif tipo = "autor" then
		GaleriaSubSeccao = 1
	elseif (tipo = "novas") or (tipo = "novasautor") or (tipo = "data") or (tipo = "24horas") then
		GaleriaSubSeccao = 4
	elseif (tipo = "associados_sqlw") or (tipo = "fotomes_sqlw") or (tipo = "fotomes") or (tipo = "juri") or (tipo = "cronicas") or (tipo = "cronicas_mes") or (tipo = "temames") or (tipo = "temames_escolhidas") or (tipo = "galeria_mes") or (tipo = "associado") or (tipo = "cronicas_vencedoras") then
		GaleriaSubSeccao = 7
	elseif (tipo = "preferidas") or (tipo = "preferidas_mais") or (tipo = "preferidas_top") then
		GaleriaSubSeccao = 8
	elseif (tipo = "busca") or (tipo = "busca_sqlw") then
		if (id = "umid") or (id = "intervaloid") or (id = "ateid") then
			GaleriaSubSeccao = 5
		elseif (id = "umadata") or (id = "intervalodata") or (id = "atedata") or (id = "24horas") then
			GaleriaSubSeccao = 4
		elseif id = "dados" then
			GaleriaSubSeccao = 6
		end if
	else
		GaleriaSubSeccao = 1
	end if
end function ' GaleriaSubSeccao
%>

<%
' membro = -1 para qualquer
sub AutenticarMembro(membro)
	login = session("login")
	if login = "" then
		login = 0
		session("login") = 0
	end if
	
	if login = 0 then
		Menu 3, 0, "AUTENTICA��O FALHOU"
	%>
		<font size="+1" color="white" face="arial">Esta opera&ccedil;&atilde;o s&oacute; pode ser realizada por um utilizador autenticado</font>
		<br>
		<font size="+1" color="white" face="arial">prima </font><a href="login.asp"><font size="+1" color="white" face="arial"><b>login</b></font></a><font size="+1" color="white" face="arial"> no menu esquerdo</font>
		<br><br>
		<font size="+1" color="white" face="arial">Nota: se estive muito tempo inactivo, o sistema pode ter feito<br>logout autom&aacute;tico e neste caso tem que fazer novamente login.</font>
	<%
		FimPagina()
		response.end
	elseif (membro <> -1) and (clng(membro) <> clng(login)) and (session("login") <> 2) then
		Menu 3, 0, "AUTENTICA��O FALHOU"
	%>
		<font size="+1" color="white" face="arial">Esta opera&ccedil;&atilde;o s&oacute; pode ser realizada pelo pr&oacute;prio autor</font>
		<br>
		<font size="+1" color="white" face="arial">prima <b>back</b> no browser para voltar &agrave; p&aacute;gina anterior</font>	
		<br><br>
		<font size="+1" color="white" face="arial">Nota: se estive muito tempo inactivo, o sistema pode ter feito<br>logout autom&aacute;tico e neste caso tem que fazer novamente login</font>
		<br>
		<font size="+1" color="white" face="arial">para tal, prima </font><a href="login.asp"><font size="+1" color="white" face="arial"><b>login</b></font></a><font size="+1" color="white" face="arial"> no menu esquerdo.</font>
	<%
		FimPagina()
		response.end
	else
		session("login") = clng(login)
	end if
end sub ' AutenticarMembro
%>

<%
sub AutenticarJuri()
	if VerificarJuri() = False then
		Menu 3, 0, "AUTENTICA��O FALHOU"
	%>
		<font size="+1" color="white" face="arial">Esta opera&ccedil;&atilde;o s&oacute; pode ser realizada por membro do j�ri!</font>
	<%
		FimPagina()
		response.end
	end if
end sub ' AutenticarJuri
%>

<%
sub AutenticarWebmaster()
	if session("login") <> 2 then
		Menu 3, 0, "AUTENTICA��O FALHOU"
	%>
		<font size="+1" color="white" face="arial">Esta opera&ccedil;&atilde;o s&oacute; pode ser realizada pelo webmaster!</font>
	<%
		FimPagina()
		response.end
	end if
end sub ' AutenticarWebmaster
%>

<%
function VerificarJuri()
	if (session("login") <> "") and (session("login") <> 0) then
		SQL = "SELECT juri FROM autor WHERE id = " & session("login")
		Set juriRes = dbConnection.Execute(SQL)

		if juriRes("juri") = true then
			VerificarJuri = true
		else
			VerificarJuri = false
		end if
	else
		VerificarJuri = false
	end if
end function ' VerificarJuri
%>

<%
sub ContarVisitas()
	' Testar se se vem do foto@pt
	if instr(httpReferer, "fotopt.net") = 0 then
		Randomize
		SSUID = cstr(clng(Rnd * 1000000)) & cstr(clng(Rnd * 1000000))
	
		' Cookie "eterno"
		if Request.Cookies("SSUID") = "" then
			Response.Cookies("SSUID") = SSUID
			Response.Cookies("SSUID").Expires = #January 1, 2038#
		else
			SSUID = Request.Cookies("SSUID")
		end if
		
		' Calcular numero de utilizadores
		if session("SSUID") = "" then
			session("SSUID") = SSUID
			
			SQL = "SELECT visitas, ultimo_ip FROM contador WHERE tipo = 1"
			Set contadorRes = dbConnection.Execute(SQL)
			
			SQL = "SELECT visitas, ultimo_ip FROM contador WHERE tipo = 2 AND data = #" & date() & "#"
			Set contadorDiarioRes = dbConnection.Execute(SQL)
			
			if contadorDiarioRes.eof then
				SQL = "INSERT INTO contador (visitas, tipo, ultimo_ip, data) VALUES ("
				SQL = SQL & "'1', '2', '" & remoteAddr & "', '" & date() & "')"
				dbConnection.Execute(SQL)
			end if
			
			if contadorRes("ultimo_ip") <> remoteAddr then
				SQL = "UPDATE contador SET visitas = '" & contadorRes("visitas") + 1 & "'"
				SQL = SQL & ", ultimo_ip = '" & remoteAddr & "'"
				SQL = SQL & " WHERE tipo = 1"
				dbConnection.Execute(SQL)
				
				if not contadorDiarioRes.eof then
					SQL = "UPDATE contador SET visitas = '" & contadorDiarioRes("visitas") + 1 & "'"
					SQL = SQL & ", ultimo_ip = '" & remoteAddr & "'"
					SQL = SQL & " WHERE tipo = 2 AND data = #" & date() & "#"
					dbConnection.Execute(SQL)
				end if
			end if
		end if
	end if
end sub ' ContarVisitas
%>

<%
function Cifrar(texto, data, ip)
	Set ObjCast = Server.CreateObject("cast.cipher")

	clearText = texto
	tkey = cstr(month(cdate(data))) & cstr(ip) & cstr(data)
	encodedText = ObjCast.cast128encode(tkey, clearText)

	Set ObjCast = Nothing
	Cifrar = encodedText
end function ' Cifrar
%>

<%
function DeCifrar(texto, data, ip)
	Set ObjCast = Server.CreateObject("cast.cipher")
	
	encodedText = texto
	tkey = cstr(month(cdate(data))) & cstr(ip) & cstr(data)
	decodedText = ObjCast.cast128decode(tkey, encodedText)

	Set ObjCast = Nothing
	DeCifrar = decodedText
end function ' DeCifrar
%>	
