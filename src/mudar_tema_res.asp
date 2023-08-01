<!-- #include file="sqltext.asp" -->
<!-- #include file="funcoes_principais.asp" -->

<%
id = request("id")

SQL = "SELECT autor FROM folder WHERE id = " & id
Set temaRes = dbConnection.Execute(SQL)

autor = temaRes("autor")
%>

<% AutenticarMembro(autor) %>

<%
id = request("id")
tema = SqlText(request("tema"))
descricao = SqlTextMemo(request("descricao"))
tema_uk = SqlText(request("tema_uk"))
descricao_uk = SqlTextMemo(request("descricao_uk"))

if (tema = "") then
	Menu 1, 1, "MUDAR TEMA"
%>
	<font size="+1" color="white" face="arial">O campo <b>nome do tema</b> &eacute; obrigat&oacute;rio.</font>
	<br>
	<font size="+1" color="white" face="arial">prima o botao <b>back</b> no browser e complete a informa&ccedil;&atilde;o.</font>	
<%
elseif (tema_uk = "") and (descricao_uk <> "") then
	Menu 1, 1, "MUDAR TEMA"
%>
	<font size="+1" color="white" face="arial">Quando preenche o campo <b>descri&ccedil;&atilde;o em ingl&ecirc;s</b> o campo <b>nome do tema em ingl&ecirc;s</b> &eacute; obrigat&oacute;rio.</font>
	<br>
	<font size="+1" color="white" face="arial">prima o botao <b>back</b> no browser e complete a informa&ccedil;&atilde;o.</font>	
<%
else
	SQL = "UPDATE folder SET nome = '" & tema & "', nome_uk = '" & tema_uk & "', descricao = '" & descricao & "', descricao_uk = '" & descricao_uk & "' WHERE id = " & id
	dbConnection.Execute(SQL)

	ComRefresh "editar_temas.asp?autor=" & autor
	Menu 1, 1, "MUDAR TEMA"
%>
	<font size="+1" color="white" face="arial"><b>Tema modificado com sucesso</b></font>
<% end if %>

<% FimPagina() %>
