<!-- #include file="sqltext.asp" -->
<!-- #include file="funcoes_principais.asp" -->

<%
letra = request("letra")
pais = request("pais")
busca = request("busca")
tipo = request("tipo")

if tipo = "com_preferidas" then
	foto = request("foto")
	
	if foto <> "" then
		SQL = "SELECT distinct(autor.id), autor.nome FROM autor INNER JOIN preferidas_fotos ON autor.id = preferidas_fotos.autor WHERE preferidas_fotos.foto = " & foto & " ORDER by nome"
		Set autorRes = dbConnection.Execute(SQL)

		titulo = "MEMBROS QUE TÊM A FOTO &quot;" & foto & "&quot; COMO PREFERIDA"
	else
		SQL = "SELECT distinct(autor.id), autor.nome FROM autor INNER JOIN preferidas_fotos ON autor.id = preferidas_fotos.autor ORDER by nome"
		Set autorRes = dbConnection.Execute(SQL)

		titulo = "MEMBROS COM FOTOS NA GALERIA DE PREFERIDAS"
	end if
elseif tipo = "com_fotos" then
	SQL = "SELECT distinct(autor.id), autor.nome FROM autor INNER JOIN foto ON autor.id = foto.autor ORDER by nome"
	Set autorRes = dbConnection.Execute(SQL)

	titulo = "MEMBROS COM FOTOS"
elseif tipo = "com_comentarios" then
	SQL = "SELECT distinct(autor.id), autor.nome FROM autor INNER JOIN comentario_autor ON autor.id = comentario_autor.autor ORDER by nome"
	Set autorRes = dbConnection.Execute(SQL)
	
	titulo = "MEMBROS COMENTADOS"
elseif letra <> "" then
	SQL = "SELECT nome, id FROM autor WHERE nome LIKE '" & letra & "%' "
	if letra = "O" then
		SQL = SQL & "OR nome LIKE 'Ó%' "
	end if
	SQL = SQL & "ORDER by nome"
	Set autorRes = dbConnection.Execute(SQL)

	SQL = "SELECT count(*) AS num FROM autor WHERE nome LIKE '" & letra & "%' "
	if letra = "O" then
		SQL = SQL & "OR nome LIKE 'Ó%' "
	end if
	Set autorNumRes = dbConnection.Execute(SQL)
	
	titulo = "MEMBROS COM &quot;" & letra & "&quot;"
else
	if pais <> "" then
		SQL = "SELECT nome, id FROM autor WHERE pais = " & pais & " ORDER by nome"
		Set autorRes = dbConnection.Execute(SQL)

		SQL = "SELECT count(*) AS num FROM autor WHERE pais = " & pais
		Set autorNumRes = dbConnection.Execute(SQL)
		
		SQL = "SELECT nome_pt FROM paises_todos WHERE id = " & pais
		Set paisRes = dbConnection.Execute(SQL)
		
		titulo = "MEMBROS - " & paisRes("nome_pt")
	elseif busca <> "" then
		SQL2 = ""
		SQL = "SELECT nome, id FROM autor WHERE id > 0"
		SQLNUM = "SELECT count(*) AS num FROM autor WHERE id > 0"
		
		if request("id") <> "" then
			if isnumeric(request("id")) then
				SQL2 = SQL2 & " AND id = " & request("id")
			end if
		end if
		if request("nome") <> "" then
			if session("login") = 2 then
				SQL2 = SQL2 & " AND (nome_real LIKE '%" & sqltext(replace(request("nome"), " ", "%")) & "%' OR nome LIKE '%" & sqltext(replace(request("nome"), " ", "%")) & "%')"
			else
				SQL2 = SQL2 & " AND ((nome_real LIKE '%" & sqltext(replace(request("nome"), " ", "%")) & "%' AND esconder_real = False) OR nome LIKE '%" & sqltext(replace(request("nome"), " ", "%")) & "%')"
			end if
		end if
		if request("email") <> "" then
			if session("login") = 2 then
				SQL2 = SQL2 & " AND email LIKE '%" & sqltext(request("email")) & "%'"
			else
				SQL2 = SQL2 & " AND email LIKE '%" & sqltext(request("email")) & "%' AND mostrar_email = True"
			end if
		end if
		if request("regiao") <> "" then
			SQL2 = SQL2 & " AND regiao LIKE '%" & sqltext(replace(request("regiao"), " ", "%")) & "%'"
		end if
		if request("profissao") <> "" then
			SQL2 = SQL2 & " AND profissao LIKE '%" & sqltext(replace(request("profissao"), " ", "%")) & "%'"
		end if

		SQL = SQL & SQL2 & " ORDER BY nome"
		SQLNUM = SQLNUM & SQL2

		Set autorRes = dbConnection.Execute(SQL)
		Set autorNumRes = dbConnection.Execute(SQLNUM)
		
		titulo = "MEMBROS - RESULTADO DE PROCURA"
	else
		SQL = "SELECT nome, id FROM autor ORDER by nome"
		Set autorRes = dbConnection.Execute(SQL)

		SQL = "SELECT count(*) AS num FROM autor"
		Set autorNumRes = dbConnection.Execute(SQL)
		
		titulo = "TODOS OS MEMBROS"
	end if
end if

if tipo <> "" then
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
else
	if (autorNumRes("num") mod 3) = 0 then
		porColuna = autorNumRes("num") / 3
	else
		porColuna = autorNumRes("num") / 3 + 1
	end if
end if
%>

<% 
Menu 3, 2, titulo
%>

<% if autorRes.eof then %>
	<% if busca <> "" then %>
		<font size="-1" color="white" face="arial">N&atilde;o existe nenhum membro com estes dados.</font>
	<% else %>
		<font size="-1" color="white" face="arial">N&atilde;o existe nenhum membro cujo nome comece com <b><% =letra %></b>.</font>
	<% end if %>
<% else %>
	<table border="0" cellspacing="0" cellpadding="0">
	<tr>
	<% for j = 1 to 3 %>
		<td valign="top"><table border="0" cellspacing="0" cellpadding="3">
		<% 
		for i = 1 to porColuna
			if not autorRes.eof then
		%>
				<tr><td><a href="autor.asp?autor=<% =autorRes("id") %>"><font size="-2" color="#ffcc66" face="verdana, arial"><b><% =autorRes("nome") %></b></font></a><font size="-2">&nbsp;&nbsp;</font></td></tr>
		<%
			autorRes.MoveNext
			end if
		next
		%>
		</table></td>
	<% next %>
	</tr>
	</table>
<% end if %>

<% FimPagina() %>
