<!-- #include file="sqltext.asp" -->
<!-- #include file="funcoes_principais.asp" -->

<% AutenticarMembro(autor) %>

<%
autor = session("login")
ordem = request("ordem")

artigo = request("artigo")
pros = SqlText(request("pros"))
contras = SqlText(request("contras"))
opiniao = SqlTextMemo(request("opiniao"))
classificacao = request("class")

if (opiniao = "") then
	Menu 7, 3, "INSERIR OU MUDAR OPINI�O"
%>
	<font size="+1" color="white" face="arial">O campo <b>opini&atilde;o</b> &eacute; obrigat&oacute;rio</font>
	<br>
	<font size="+1" color="white" face="arial">prima o botao <b>back</b> no browser e complete a informa&ccedil;&atilde;o</font>	
<%
else
	SQL = "SELECT valor FROM opiniao_classificacao WHERE id = " & classificacao
	Set classRes = dbConnection.Execute(SQL)

	SQL = "SELECT * FROM opiniao WHERE autor = " & autor & " AND artigo = " & artigo
	Set opiniaoRes = dbConnection.Execute(SQL)

	SQL = "SELECT * FROM opiniao_artigo WHERE id = " & artigo
	Set artigoRes = dbConnection.Execute(SQL)

	if opiniaoRes.eof then
		SQL = "INSERT INTO opiniao (pros, contras, opiniao, classificacao, artigo, autor, data) VALUES "
		SQL = SQL & "('" & pros & "','" & contras & "','" & opiniao & "','" & classificacao & "','" & artigo & "','" & autor & "','" & date() & " " & time() & "')"
		dbConnection.Execute(SQL)
		
		SQL = "UPDATE opiniao_artigo SET "
		SQL = SQL & "num_opinioes = '" & artigoRes("num_opinioes") + 1
		SQL = SQL & "', soma_opinioes = '" & artigoRes("soma_opinioes") + classRes("valor")
		SQL = SQL & "', media_opinioes = '" & (artigoRes("soma_opinioes") + classRes("valor")) / (artigoRes("num_opinioes") + 1)
		SQL = SQL & "' WHERE id = " & artigo
		dbConnection.Execute(SQL)
	else
		SQL = "SELECT valor FROM opiniao_classificacao WHERE id = " & opiniaoRes("classificacao")
		Set oldClassRes = dbConnection.Execute(SQL)

		SQL = "UPDATE opiniao SET "
		SQL = SQL & "pros = '" & pros
		SQL = SQL & "', contras = '" & contras
		SQL = SQL & "', opiniao = '" & opiniao
		SQL = SQL & "', classificacao = '" & classificacao
		SQL = SQL & "' WHERE id = " & opiniaoRes("id")
		dbConnection.Execute(SQL)
		
		SQL = "UPDATE opiniao_artigo SET "
		SQL = SQL & "soma_opinioes = '" & artigoRes("soma_opinioes") - oldClassRes("valor") + classRes("valor")
		SQL = SQL & "', media_opinioes = '" & (artigoRes("soma_opinioes") - oldClassRes("valor") + classRes("valor")) / (artigoRes("num_opinioes"))
		SQL = SQL & "' WHERE id = " & artigo
		dbConnection.Execute(SQL)
	end if		

	ComRefresh "opiniao_tipo.asp?ordem=" & ordem & "&tipo=" & artigoRes("tipo")
	Menu 7, 3, "INSERIR OU MUDAR OPINI�O"
%>
	<font size="+1" color="white" face="arial"><b>Opini&atilde;o inserida com sucesso</b></font>
<% end if %>

<% FimPagina() %>
