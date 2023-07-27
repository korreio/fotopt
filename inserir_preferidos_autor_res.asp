<!-- #include file="funcoes_principais.asp" -->

<%
autor_preferido = request("autor_preferido")
autor = session("login")
%>

<% AutenticarMembro(autor) %>

<%
' se nao e' o autor da foto a preferir
if autor_preferido <> autor then
	SQL = "SELECT id FROM preferido_autor WHERE autor_preferido = " & autor_preferido & " AND autor = " & autor
	Set preferidoRes = dbConnection.Execute(SQL)

	if preferidoRes.eof then
		SQL = "INSERT INTO preferido_autor (autor_preferido, autor, data)"
		SQL = SQL & " VALUES ('" & autor_preferido & "','" & autor & "','" & date() & " " & time() & "')"
		dbConnection.Execute(SQL)
	end if
end if

ComRefresh "autor.asp?autor=" & autor_preferido
Menu 3, 4, "INSERIR AUTOR NA MINHA LISTA DE PREFERIDOS"
%>
<font size="+1" color="white" face="arial"><b>Autor preferido inserido com sucesso</b></font>
<% FimPagina() %>
