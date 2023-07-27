<!-- #include file="sqltext.asp" -->
<!-- #include file="funcoes_principais.asp" -->

<% AutenticarMembro(autor) %>

<%
tipo = request("tipo")
nome = SqlText(request("nome"))
descricao = SqlText(request("descricao"))
estado = request("estado")
desc_estado = SqlText(request("desc_estado"))

if request("valor") <> "" then
	valor = request("valor")
else
	valor = "-1"
end if

moeda = request("moeda")

if request("troca") = "on" then
	troca = "1"
else
	troca = "0"
end if

if nome = "" then
	Menu 6, 2, "INSERIR ARTIGO PARA VENDA"
%>
	<font size="+1" color="white" face="arial">O campo <b>nome</b> &eacute; obrigat&oacute;rio</font>
	<br>
	<font size="+1" color="white" face="arial">prima o botao <b>back</b> no browser e complete a informa&ccedil;&atilde;o</font>	
<%
elseif not isnumeric(valor) then
	Menu 6, 2, "INSERIR ARTIGO PARA VENDA"
%>
	<font size="+1" color="white" face="arial">O campo <b>valor</b> tem que ser num&eacute;rico</font>
	<br>
	<font size="+1" color="white" face="arial">prima o botao <b>back</b> no browser e corrija a informa&ccedil;&atilde;o</font>	
<%
else
	SQL = "INSERT INTO venda_artigo (nome, descricao, estado, desc_estado, valor_minimo, moeda, autor, data, tipo, troca)"
	SQL = SQL & " VALUES ('" & nome & "','" & descricao & "','" & estado & "','" & desc_estado & "','" & valor
	SQL = SQL & "','" & moeda & "','" & session("login") & "','" & date() & " " & time() & "','" & tipo & "','" & troca & "')"
	dbConnection.Execute(SQL)

	SQL = "SELECT id FROM venda_artigo WHERE autor = " & session("login") & " ORDER BY id DESC"
	Set artigoRes = dbConnection.Execute(SQL)

	ComRefresh "venda_artigo.asp?artigo=" & artigoRes("id")
	Menu 6, 2, "INSERIR ARTIGO PARA VENDA"
%>
	<font size="+1" color="white" face="arial"><b>Artigo para venda inserido com sucesso</b></font>
<% end if %>

<% FimPagina() %>
