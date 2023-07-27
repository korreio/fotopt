<!-- #include file="inicio_basedados.asp" -->

<%
Dim meses
meses = Array("January", "February", "March", "April", "May", "June", "July", _
			  "August", "September", "October", "November", "December")
%>
<!-- #include file="../galeria_seleccao.asp" -->
<%
foto = request("foto")

SQL = "SELECT * FROM foto WHERE id = " & foto
Set fotoRes = dbConnection.Execute(SQL)

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
	if num = "0" then
		num = 6

		' Descobrir ID da primeira foto na pagina de galeria anterior
		if not anteriorFotoRes.eof then
			if session("ordem") = "c" then
				SQL = "SELECT TOP 6 foto.id FROM foto " & SQLW & " AND foto.id <= " & fotoRes("id") & " ORDER BY foto.id DESC"
				Set anteriorGaleriaRes = dbConnection.Execute(SQL)
			else
				SQL = "SELECT TOP 6 foto.id FROM foto " & SQLW & " AND foto.id >= " & fotoRes("id") & " ORDER BY foto.id"
				Set anteriorGaleriaRes = dbConnection.Execute(SQL)
			end if
			do while not anteriorGaleriaRes.eof
				primeira = anteriorGaleriaRes("id")
				anteriorGaleriaRes.MoveNext
			loop
		end if
	elseif num = "7" then
		num = 1
		primeira = fotoRes("id")
	end if
else
	fotoAnterior = 0
	fotoSeguinte = 0
end if

SQL = "SELECT * FROM autor WHERE id = " & fotoRes("autor")
Set autorRes = dbConnection.Execute(SQL)

SQL = "SELECT en_nome_minusculas FROM assunto WHERE id = " & fotoRes("assunto")
Set assuntoRes = dbConnection.Execute(SQL)

SQL = "SELECT nome FROM folder WHERE id = " & fotoRes("tema")
Set temaRes = dbConnection.Execute(SQL)

directoria = int(fotoRes("id") / 1000)
%>

<!-- #include file="topo.asp" --></tr></table>

<table cellpadding="0" cellspacing="0" width="100%"><tr>
	<td><table bgcolor="gray" border cellpadding="2" cellspacing="0"><tr>
		<% if fotoAnterior <> 0 then %><td><font size="-2" color="black" face="arial">&lt;&nbsp;</font><a href="foto.asp?foto=<% =fotoAnterior %>&primeira=<% =primeira %>&tema=<% =tema %>&tipo=<% =tipo %>&id=<% =id %>&num=<% =num - 1 %>"><font size="-2" color="black" face="arial">PREVIOUS</font></a><font size="-2">&nbsp;</font></td><% end if %>
		<% if tipo <> "" then %><td align="center"><font size="-2" color="black" face="arial">&nbsp;<% =int(numOutrasFotoRes("num")) + 1 %>/<% =int(numFotoRes("num")) %>&nbsp;</font></td><% end if %>
		<% if fotoSeguinte <> 0 then %><td><font size="-2">&nbsp;</font><a href="foto.asp?foto=<% =fotoSeguinte %>&primeira=<% =primeira %>&tema=<% =tema %>&tipo=<% =tipo %>&id=<% =id %>&num=<% =num + 1 %>"><font size="-2" color="black" face="arial">NEXT</font></a><font size="-2" color="black" face="arial">&nbsp;&gt;</font></td><% end if %>
	</tr></table></td>

	<td><table bgcolor="gray" border align="right" cellpadding="2" cellspacing="0"><tr>
		<% if tipo = "" then %>
			<% 
			if (session("login") <> 2) and (fotoRes("anonima") <> 0) and (fotoRes("data") > (cdate(date() & " " & time()) - 7)) then
			else
			%>
				<td><font size="-2">&nbsp;</font><a href="galeria.asp?tipo=autor&id=<% =autorRes("id") %>&tema=<% =fotoRes("tema") %>"><font size="-2" color="black" face="arial">THIS&nbsp;AUTHOR'S&nbsp;GALLERY</font></a><font size="-2">&nbsp;</font></td>
			<% end if %>
		<% else %>
			<td><font size="-2">&nbsp;</font><a href="galeria.asp?primeira=<% =primeira %>&tema=<% =tema %>&tipo=<% =tipo %>&id=<% =id %>"><font size="-2" color="black" face="arial">GALLERY</font></a><font size="-2">&nbsp;</font></td>
		<% end if %>
	</tr></table></td>
</tr></table>

<div align="center"><br>
<a href="so_foto.asp?foto=<% =foto %>&primeira=<% =primeira %>&tema=<% =tema %>&tipo=<% =tipo %>&id=<% =id %>&num=<% =num %>">
	<img src="/fotos/fotos/<% =directoria %>/foto<% =fotoRes("id") %>.jpg" border=0 alt="Prima para ver s&oacute; a fotografia"></a>
<br><br>

<table border="1" cellpadding="10" cellspacing="0">
<tr><td align="center">
	<% if fotoRes("titulo_uk") <> "" then %>
		<font color="white" face="arial">&nbsp;<b><% =fotoRes("titulo_uk") %></b></font>
	<% elseif fotoRes("titulo") <> "" then %>
		<font color="white" face="arial">&nbsp;<b><% =fotoRes("titulo") %></b></font>
	<% else %>
		<font color="white" face="arial">&nbsp;<i><b>untitled</b></i></font>
	<% end if %>
</td></tr>
<tr>
<td>
	<table border="0" cellpadding="1" cellspacing="0">
		<tr><td><font color="white" size="-1" face="arial"><b>ID: </b></font></td><td><font size="-1" color="white" face="arial"><% =fotoRes("id") %>&nbsp;&nbsp;<font size="-2" color="white" face="arial">(<% =day(fotoRes("data")) %>/<% =month(fotoRes("data")) %>/<% =year(fotoRes("data")) %>)</font></td></tr>
		<tr>
			<td><font color="white" size="-1" face="arial"><b>AUTHOR: </b></font></td>
			<% if (fotoRes("anonima") <> 0) and (fotoRes("data") > (cdate(date() & " " & time()) - 7)) then %>
				<% if session("login") = 2 then %>
					<td><a href="autor.asp?autor=<% =fotoRes("autor") %>"><font color="red" size="-1" face="arial"><% =autorRes("nome") %></font></a></td>
				<% else %>
					<td><font color="white" size="-1" face="arial"><i>anonymous</i> (until <% =day(fotoRes("data") + 7) & "/" & month(fotoRes("data") + 7) & "/" & year(fotoRes("data") + 7) & " at " & hour(fotoRes("data") + 7) & ":" & minute(fotoRes("data") + 7) %>)</font></td></tr>
				<% end if %>
			<% else %>
				<td><a href="autor.asp?autor=<% =fotoRes("autor") %>"><font color="white" size="-1" face="arial"><% =autorRes("nome") %></font></a></td>
			<% end if %>
		</tr>
		<tr><td><font color="white" size="-1" face="arial"><b>SUBJECT: </b></font></td><td><font size="-1" color="white" face="arial"><% =assuntoRes("en_nome_minusculas") %></font></td></tr>
		<tr><td colspan="2" height="4"></td></tr>

		<% if (fotoRes("data_tipo") <> 0) and (fotoRes("data_tipo") <> "") then %>
			<% if fotoRes("data_tipo") = 3 then %>
				<tr><td><font color="white" size="-1" face="arial"><b>TAKEN IN: </b></font></td><td><font size="-1" color="white" face="arial"><% =meses(month(fotoRes("data_foto")) - 1) %>,&nbsp;<% =day(fotoRes("data_foto")) %>&nbsp;<% =year(fotoRes("data_foto")) %></font></td></tr>
			<% elseif fotoRes("data_tipo") = 2 then %>
				<tr><td><font color="white" size="-1" face="arial"><b>TAKEN IN: </b></font></td><td><font size="-1" color="white" face="arial"><% =meses(month(fotoRes("data_foto")) - 1) %>&nbsp;<% =year(fotoRes("data_foto")) %></font></td></tr>
			<% else %>
				<tr><td><font color="white" size="-1" face="arial"><b>TAKEN IN: </b></font></td><td><font size="-1" color="white" face="arial"><% =year(fotoRes("data_foto")) %></font></td></tr>
			<% end if %>
		<% end if %>
		<% if fotoRes("lugar") <> "" then %>
			<tr><td><font color="white" size="-1" face="arial"><b>PLACE: </b></font></td><td><font size="-1" color="white" face="arial"><% =fotoRes("lugar") %></font></td></tr>
		<% end if %>
		<tr><td colspan="2" height="4"></td></tr>
		<% if fotoRes("maquina") <> "" then %>
			<tr><td><font size="-1" color="white" face="arial"><b>CAMERA: </b></font></td><td><font size="-1" color="white" face="arial"><% =fotoRes("maquina") %></font></td></tr>
		<% end if %>
		<% if fotoRes("Lente") <> "" then %>
			<tr><td><font size="-1" color="white" face="arial"><b>LENS: </b></font></td><td><font size="-1" color="white" face="arial"><% =fotoRes("lente") %></font></td></tr>
		<% end if %>
		<% if fotoRes("filme") <> "" then %>
			<tr><td><font size="-1" color="white" face="arial"><b>FILM: </b></font></td><td><font size="-1" color="white" face="arial"><% =fotoRes("filme") %></font></td></tr>
		<% end if %>
		<% if fotoRes("filtros") <> "" then %>
			<tr><td><font size="-1" color="white" face="arial"><b>FILTERS: </b></font></td><td><font size="-1" color="white" face="arial"><% =fotoRes("filtros") %></font></td></tr>
		<% end if %>
		<% if fotoRes("flash") <> "" then %>
			<tr><td><font size="-1" color="white" face="arial"><b>LIGHT: </b></font></td><td><font size="-1" color="white" face="arial"><% =fotoRes("flash") %></font></td></tr>
		<% end if %>
		<tr><td colspan="2" height="4"></td></tr>
		<% if fotoRes("abertura") <> "" then %>
			<tr><td><font size="-1" color="white" face="arial"><b>APERTURE: </b></font></td><td><font size="-1" color="white" face="arial"><% =fotoRes("abertura") %></font></td></tr>
		<% end if %>
		<% if fotoRes("velocidade") <> "" then %>
			<tr><td><font size="-1" color="white" face="arial"><b>EXPOSURE: </b></font></td><td><font size="-1" color="white" face="arial"><% =fotoRes("velocidade") %></font></td></tr>
		<% end if %>
		<tr><td colspan="2" height="4"></td></tr>
		<% if fotoRes("outros") <> "" then %>
			<tr><td><font size="-1" color="white" face="arial"><b>OTHER: </b></font></td><td><font size="-1" color="white" face="arial"><% =fotoRes("outros") %></font></td></tr>
		<% end if %>
	</table>
</td>
</tr>
</table>

<br>
<a href="direitos_autor.asp"><font size="-2" color="white" face="arial">Author rights</font></a><font size="-2" color="white" face="arial">: The pictures are propriety of it's author or his clients, any abuser can be prossecuted by law.</font>
</div>

<!-- #include file="fim.asp" -->
<!-- #include file="fim_basedados.asp" -->