<!-- #include file="sqltext.asp" -->
<!-- #include file="funcoes_principais.asp" -->

<% AutenticarMembro(autor) %>

<%
tipo = request("tipo")
nome = SqlText(request("nome"))
isbn = SqlText(request("isbn"))
autores = SqlText(request("autores"))
editora = SqlText(request("editora"))
descricao = SqlText(request("descricao"))
comentario = SqlText(request("comentario"))

if (nome = "") or (descricao = "") then
	Menu 5, 2, "INSERIR LIVRO" 
%>
	<font size="+1" color="white" face="arial">Os campos <b>nome</b> e <b>descri&ccedil;&atilde;o</b> s&atilde;o obrigat&oacute;rios</font>
	<br>
	<font size="+1" color="white" face="arial">prima o botao <b>back</b> no browser e complete a informa&ccedil;&atilde;o</font>	
<%
else
	SQL = "INSERT INTO livros (nome, autores, editora, descricao, comentario, autor, data, tipo, isbn)"
	SQL = SQL & " VALUES ('" & nome & "','" & autores & "','" & editora & "','" & descricao& "','" & comentario
	SQL = SQL & "','" & session("login") & "','" & date() & " " & time() & "','" & tipo & "','" & isbn & "')"
	dbConnection.Execute(SQL)
	
	SQL = "SELECT id FROM livros WHERE autor = " & session("login") & " ORDER BY id DESC"
	Set livroRes = dbConnection.Execute(SQL)

	ComRefresh "ver_livro.asp?livro=" & livroRes("id")
	Menu 5, 2, "INSERIR LIVRO" 
%>
	<font size="+1" color="white" face="arial"><b>Livro inserido com sucesso</b></font>
<% end if %>

<% FimPagina() %>
