<!-- #include file="sqltext.asp" -->
<!-- #include file="funcoes_principais.asp" -->

<%
if session("login") = 2 then
	autor = request("autor")
else
	autor = session("login")
end if
%>

<% AutenticarMembro(autor) %>

<%
tema = SqlText(request("tema"))
descricao = SqlTextMemo(request("descricao"))
tema_uk = SqlText(request("tema_uk"))
descricao_uk = SqlTextMemo(request("descricao_uk"))

if (tema = "") then
	Menu 1, 1, "CRIAR TEMA"
%>
	<font size="+1" color="white" face="arial">O campo <b>nome do tema</b> &eacute; obrigat&oacute;rio.</font>
	<br>
	<font size="+1" color="white" face="arial">prima o botao <b>back</b> no browser e complete a informa&ccedil;&atilde;o.</font>	
<%
elseif (tema_uk = "") and (descricao_uk <> "") then
	Menu 1, 1, "CRIAR TEMA"
%>
	<font size="+1" color="white" face="arial">Quando preenche o campo <b>descri&ccedil;&atilde;o em ingl&ecirc;s</b> o campo <b>nome do tema em ingl&ecirc;s</b> &eacute; obrigat&oacute;rio.</font>
	<br>
	<font size="+1" color="white" face="arial">prima o botao <b>back</b> no browser e complete a informa&ccedil;&atilde;o.</font>	
<%
else
	SQL = "INSERT INTO folder (autor, nome, descricao, nome_uk, descricao_uk) VALUES "
	SQL = SQL & "('" & autor & "','" & tema & "','" & descricao & "','" & tema_uk & "','" & descricao_uk & "')"
	dbConnection.Execute(SQL)

	ComRefresh "editar_temas.asp?autor=" & autor
	Menu 1, 1, "CRIAR TEMA"
%>
	<font size="+1" color="white" face="arial"><b>Tema inserido com sucesso</b></font>
<% end if %>

<% FimPagina() %>
