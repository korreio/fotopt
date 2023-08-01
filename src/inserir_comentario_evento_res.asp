<!-- #include file="sqltext.asp" -->
<!-- #include file="funcoes_principais.asp" -->

<%
autor = session("login")
foto = request("foto")
comentario = SqlTextMemo(left(request("comentario"), 1200))
onde = request("onde")

' Dados referentes a galeria
primeira = request("primeira")
evento = request("evento")
num = request("num")
%>

<% AutenticarMembro(autor) %>

<%
SQL = "SELECT * FROM eventos_fotopt_comentarios WHERE autor = " & autor & " AND foto = " & foto
Set comentarioRes = dbConnection.Execute(SQL)

if comentarioRes.eof then
	if comentario <> "" then
		SQL = "INSERT INTO eventos_fotopt_comentarios (comentario, foto, autor, data) VALUES "
		SQL = SQL & "('" & comentario & "','" & foto & "','" & autor & "','" & date() & " " & time() & "')"
		dbConnection.Execute(SQL)
	else
		Menu 2, 4, "INSERIR, ALTERAR OU APAGAR COMENT�RIO"
%>
		<font size="+1" color="white" face="arial">O campo <b>coment&aacute;rio</b> &eacute; obrigat&oacute;rio</font>
		<br>
		<font size="+1" color="white" face="arial">prima o botao <b>back</b> no browser e complete a informa&ccedil;&atilde;o</font>	
<%
	end if
else
	if comentario <> "" then
		SQL = "UPDATE eventos_fotopt_comentarios SET comentario = '" & comentario
		SQL = SQL & "', data = '" & date() & " " & time() & "' "		
		SQL = SQL & "WHERE id = " & comentarioRes("id")
		dbConnection.Execute(SQL)
	else
		SQL = "DELETE FROM eventos_fotopt_comentarios WHERE id = " & comentarioRes("id")
		dbConnection.Execute(SQL)
	end if
end if		
%>

<%
if (not comentarioRes.eof) or (comentario <> "") then
	if session("ficha") = "com" then
		ComRefresh "foto_evento.asp?foto=" & foto & "&primeira=" & primeira & "&evento=" & evento & "&num=" & num
	else
		ComRefresh "comentarios_evento.asp?foto=" & foto & "&primeira=" & primeira & "&evento=" & evento & "&num=" & num
	end if
	Menu 2, 4, "INSERIR, ALTERAR OU APAGAR COMENT�RIO"
%>
	<font size="+1" color="white" face="arial"><b>Coment&aacute;rio inserido com sucesso</b></font>
<% end if %>

<% FimPagina() %>
