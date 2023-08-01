<!-- #include file="funcoes_principais.asp" -->

<%
Server.ScriptTimeOut = 999999
autor = request("autor")

SQL = "SELECT * FROM autor WHERE id = " & autor
Set autorRes = dbConnection.Execute(SQL)

SQL = "SELECT count(*) AS num FROM comentario WHERE moderar = False AND autor = " & autor
Set numComentFotosRes = dbConnection.Execute(SQL)

SQL = "SELECT count(*) AS num FROM eventos_fotopt_comentarios WHERE autor = " & autor
Set numComentEventosRes = dbConnection.Execute(SQL)

SQL = "SELECT count(*) AS num FROM comentario_autor WHERE moderar = False AND comentador = " & autor
Set numComentAutorRes = dbConnection.Execute(SQL)
%>

<% 
OpcaoMenu "TODA A CONTRIBUIÇÃO DESTE AUTOR", "autor_pormenor.asp?autor=" & autor, False, False, -1, False, False
Menu 3, 2, "CONTRIBUIÇÃO, COMENTÁRIOS - " & autorRes("nome")
%>

<table cellpadding="10" cellspacing="0" border="1">
<%
if numComentFotosRes("num") > 0 then 
	SQL = "SELECT distinct(id), nome FROM autor WHERE id IN (SELECT autor FROM foto WHERE id IN (SELECT foto FROM comentario WHERE moderar = False AND autor = " & autor & ") AND (anonima = 0 OR (anonima <> 0 AND data < #" & cdate(date() & " " & time()) - 7 & "#))) ORDER BY nome"
	Set autorRes = dbConnection.Execute(SQL)
%>
<tr><td>
	<font color="white" face="arial"><% =numComentFotosRes("num") %> <b> COMENT&Aacute;RIO<% if numComentFotosRes("num") <> 1 then %>S<% end if %> A FOTOS</b></font><br>
	<table border="0" cellspacing="2" cellpadding="0">
	<% 
	SQL = "SELECT distinct(id) FROM foto WHERE anonima <> 0 AND data > #" & cdate(date() & " " & time()) - 7 & "# AND id IN (SELECT foto FROM comentario WHERE moderar = False AND autor = " & autor & ")"
	Set fotoRes = dbConnection.Execute(SQL)
	%>
	<% if not fotoRes.eof then %>
		<tr>
			<td valign="top"><font size="-1" color="#FFCC66" face="arial">&nbsp;&nbsp;<i>ANÓNIMOS</i></font>&nbsp;&nbsp;</td>
			<td valign="top"><font size="-2" face="arial">
			<% do while not fotoRes.eof %>
				<a href="comentarios.asp?foto=<% =fotoRes("id") %>"><% =fotoRes("id") %></a>&nbsp;
				<% fotoRes.MoveNext %>
			<% loop %>
			</font></td>
		</tr>
	<% end if %>
	<% 
	do while not autorRes.eof 
		SQL = "SELECT distinct(id) FROM foto WHERE (anonima = 0 OR (anonima <> 0 AND data < #" & cdate(date() & " " & time()) - 7 & "#)) AND autor = " & autorRes("id") & " AND id IN (SELECT foto FROM comentario WHERE moderar = False AND autor = " & autor & " )"
		Set fotoRes = dbConnection.Execute(SQL)
	%>
		<tr>
			<td valign="top"><font size="-1" color="#FFCC66" face="arial">&nbsp;&nbsp;<% =autorRes("nome") %>&nbsp;&nbsp;</font></td>
			<td valign="top"><font size="-2" color="white" face="arial">
			<% do while not fotoRes.eof %>
				<a href="comentarios.asp?foto=<% =fotoRes("id") %>"><% =fotoRes("id") %></a>&nbsp;
				<% fotoRes.MoveNext %>
			<% loop %>
			</font></td>
		</tr>
	<%
		autorRes.MoveNext
	Loop 
	%>
	</table>
</td></tr>
<% end if %>

<%
if numComentEventosRes("num") > 0 then 
	SQL = "SELECT distinct(id), nome FROM autor WHERE id IN (SELECT autor FROM eventos_fotopt_foto WHERE id IN (SELECT foto FROM eventos_fotopt_comentarios WHERE autor = " & autor & ")) ORDER BY nome"
	Set autorRes = dbConnection.Execute(SQL)
%>
<tr><td>
	<font color="white" face="arial"><% =numComentEventosRes("num") %> <b> COMENT&Aacute;RIO<% if numComentEventosRes("num") <> 1 then %>S<% end if %> A FOTOS DE EVENTOS FOTO@PT</b></font><br>
	<table border="0" cellspacing="2" cellpadding="0">
	<% 
	do while not autorRes.eof 
		SQL = "SELECT distinct(id), evento_fotopt FROM eventos_fotopt_foto WHERE autor = " & autorRes("id") & " AND id IN (SELECT foto FROM eventos_fotopt_comentarios WHERE autor = " & autor & " )"
		Set fotoRes = dbConnection.Execute(SQL)
	%>
		<tr>
			<td valign="top"><font size="-1" color="#FFCC66" face="arial">&nbsp;&nbsp;<% =autorRes("nome") %>&nbsp;&nbsp;</font></td>
			<td valign="top"><font size="-2" color="white" face="arial">
			<% do while not fotoRes.eof %>
				<a href="comentarios_evento.asp?foto=<% =fotoRes("id") %>&evento=<% =fotoRes("evento_fotopt") %>&num=0"><% =fotoRes("id") %></a>&nbsp;
				<% fotoRes.MoveNext %>
			<% loop %>
			</font></td>
		</tr>
	<%
		autorRes.MoveNext
	Loop 
	%>
	</table>
</td></tr>
<% end if %>

<%
if numComentAutorRes("num") > 0 then 
	SQL = "SELECT distinct(autor) AS autores FROM comentario_autor WHERE moderar = False AND comentador = " & autor & " ORDER BY autor"
	Set autoresRes = dbConnection.Execute(SQL)
%>
<tr><td>
	<font color="white" face="arial"><% =numComentAutorRes("num") %> <b> COMENT&Aacute;RIO<% if numComentAutorRes("num") <> 1 then %>S<% end if %> A AUTORES</b></font><br>
	<table border="0" cellspacing="7" cellpadding="0">
	<% 
	i = 0
	do while not autoresRes.eof 
		SQL = "SELECT nome FROM autor WHERE id = " & autoresRes("autores")
		Set autorRes = dbConnection.Execute(SQL)
	%>
		<% if (i MOD 3) = 0 then %><tr><% end if %>
		<td><a href="comentarios_autor.asp?id=<% =autoresRes("autores") %>"><font size="-1" color="#FFCC66" face="arial"><% =autorRes("nome") %></font></a></td>
		<% if ((i + 1) MOD 3) = 0 then %></tr><% end if %>
	<%
		i = i + 1
		autoresRes.MoveNext
	Loop 
	%>
	</table>
</td></tr>
<% end if %>

</table>

<% FimPagina() %>
