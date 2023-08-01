<!-- #include file="sqltext.asp" -->
<!-- #include file="funcoes_principais.asp" -->

<%
destaque = request("destaque")
autor = clng(request("id"))
primeira = request("primeira")
tema = request("tema")

SQL = "SELECT nome FROM autor WHERE id = " & autor
Set autorRes = dbConnection.Execute(SQL)

SQL = "SELECT aprovacao FROM autor_opcoes WHERE autor = " & autor
Set autorOpcoesRes = dbConnection.Execute(SQL)

if (session("login") = autor) or (session("login") = 2) or (autorOpcoesRes("aprovacao") = 1) then
	SQL = "SELECT * FROM comentario_autor WHERE autor = " & autor & " ORDER BY data, id"
	Set comentarioRes = dbConnection.Execute(SQL)
elseif session("login") then
	SQL = "SELECT * FROM comentario_autor WHERE autor = " & autor & " AND (moderar = false OR comentador = " & session("login") & ") ORDER BY data, id"
	Set comentarioRes = dbConnection.Execute(SQL)
else
	SQL = "SELECT * FROM comentario_autor WHERE moderar = False AND autor = " & autor & " ORDER BY data, id"
	Set comentarioRes = dbConnection.Execute(SQL)
end if

%>

<%
OpcaoMenu "FICHA DESTE AUTOR", "autor.asp?autor=" & autor, False, False, -1, False, False
if (destaque = 1) or (tema = "") then 
	OpcaoMenu "GALERIA DESTE AUTOR", "lista_temas.asp?autor=" & autor, False, True, -1, False, False
else
	if tema <> "" then
		OpcaoMenu "GALERIA DESTE AUTOR", "galeria.asp?tipo=autor&primeira=" & primeira & "&id=" & autor & "&tema=" & tema, False, False, -1, False, False
	else
		OpcaoMenu "GALERIA DESTE AUTOR", "galeria.asp?tipo=autor&primeira=" & primeira & "&id=" & autor & "&tema=0", False, False, -1, False, False
	end if
end if
OpcaoMenu "INSERIR COMENTÁRIO A ESTE AUTOR", "inserir_comentario_autor.asp?autor=" & autor & "&primeira=" & primeira & "&tema=" & tema, False, True, -1, False, False
OpcaoMenu "APROVAR TODOS OS COMENTÁRIOS", "aprovar_comentario_autor_res.asp?comentario=-1&autor=" & autor & "&primeira=" & primeira & "&tema=" & tema & "&tipo=" & tipo & "&id=" & id & "&num=" & num, False, True, autor, False, False
Menu 3, 2, "COMENTÁRIO A AUTOR - " & autorRes("nome")
%>

<table border="1" cellpadding="4" cellspacing="0">
<tr align="center">
	<td><font color="white" face="arial"><b>COMENT&Aacute;RIO</b></font></td>
	<td><font color="white" face="arial"><b>COMENTADOR</b></font></td>
	<td><font color="white" face="arial"><b>DATA</b></font></td>
	<% if session("login") = autor then %>	
		<td><font size="-1" color="green" face="arial"><b>APROVAR</b></font></td>
		<td><font size="-1" color="red" face="arial"><b>APAGAR</b></font></td>
	<% end if %>
	<% if session("login") = 2 then %>	
		<td><font color="red" face="arial"><b>ADM</b></font></td>
	<% end if %>
</tr>
<% 
do while not comentarioRes.eof
	SQL = "SELECT nome FROM autor WHERE id = " & comentarioRes("comentador")
	Set comentadorRes = dbConnection.Execute(SQL)
%>
	<tr>
		<td><font size="-1" color="<% if (comentarioRes("moderar") = True) and (autorOpcoesRes("aprovacao") = 0) then %>red<% elseif comentarioRes("moderar") = True then %>#ffcc33<% else %>white<% end if %>" face="arial"><% =Enter2Br(comentarioRes("comentario")) %></font></td>
		<td><a href="autor.asp?autor=<% =comentarioRes("comentador") %>"><font size="-1" color="white" face="arial"><% =comentadorRes("nome") %></font></a></td>
		<td align="center"><font size="-2" color="white" face="arial"><% =day(comentarioRes("data")) %>/<% =month(comentarioRes("data")) %>/<% =year(comentarioRes("data")) %></font></td>
		<% if session("login") = autor then %>
			<% if comentarioRes("moderar") = True then %>
				<td align="center"><a href="aprovar_comentario_autor_res.asp?comentario=<% =comentarioRes("id") %>&autor=<% =autor %>&primeira=<% =primeira %>&tema=<% =tema %>&tipo=<% =tipo %>&id=<% =id %>&num=<% =num %>"><font size="-2" color="green" face="arial"><b>APROVAR</b></font></a></td>
			<% else %>
				<td align="center">&nbsp;</td>
			<% end if %>
			<td align="center"><a href="apagar_comentario_autor.asp?comentario=<% =comentarioRes("id") %>&autor=<% =autor %>&primeira=<% =primeira %>&tema=<% =tema %>&tipo=<% =tipo %>&id=<% =id %>&num=<% =num %>"><font size="-2" color="red" face="arial"><b>APAGAR</b></font></a></td>
		<% end if %>
		<% if session("login") = 2 then %>	
			<td align="center"><a href="adm/adm_del_coment_autor.asp?id=<% =autor %>&comentario=<% =comentarioRes("id") %>&primeira=<% =primeira %>&tema=<% =tema %>"><font size="-2" color="red" face="arial"><b>A</b></font></a></td>
		<% end if %>
	</tr>
	<% comentarioRes.MoveNext %>
<% Loop %>
</table>

<br>
<font size="-1" color="white" face="arial">
	Nota: o autor comentado é o principal responsável por moderar o conteúdo dos comentários à sua ficha, 
	sendo opção de cada membro mostrar ou não aos outros membros os comentários por aprovar (assinalados a
	amarelo ou vermelho, conforme se visiveis por todos ou não).
</font>
<% if session("login") = autor then %>
	<br><br>
	<font size="-1" color="white" face="arial">
	<% if autorOpcoesRes("aprovacao") = 0 then %>
		Atenção: clique na opção APAGAR para remover o comentário, sem hipótese de recuperação. Os comentários com
		a opção APROVAR só aparecerão no site depois de aprovados por si, caso contrário só o autor comentado e o
		comentador os verão. Pode aprovar todos os comentários de uma vez com a opção APROVAR TODOS OS COMENTÁRIOS.
		<br><br>
		Se preferir pode escolher a opção de mostrar aos outros membros todos os comentários ainda não aprovados, para 
		isso vá a sua ficha de membro, prima ALTERAR DADOS e mude as OPÇÕES ESPECIAIS.
	<% else %>
		Atenção: clique na opção APAGAR para remover o comentário, sem hipótese de recuperação. Pode aprovar todos os
		comentários de uma vez com a opção APROVAR TODOS OS COMENTÁRIOS.
		<br><br>
		Se preferir pode escolher a opção de esconder dos outros membros todos os comentários ainda não aprovados, para isso 
		vá a sua ficha de membro, prima ALTERAR DADOS e mude as OPÇÕES ESPECIAIS.
	<% end if %>
	</font>
<% end if %>

<% FimPagina() %>
