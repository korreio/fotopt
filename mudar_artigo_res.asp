<!-- #include file="sqltext.asp" -->
<!-- #include file="funcoes_principais.asp" -->

<%
artigo = request("artigo")

SQL = "SELECT * FROM venda_artigo WHERE id = " & artigo
Set artigoRes = dbConnection.Execute(SQL)

autor = artigoRes("autor")
%>

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
	Menu 6, 2, "MUDAR ARTIGO PARA VENDA"
%>
	<font size="+1" color="white" face="arial">O campo <b>nome</b> &eacute; obrigat&oacute;rio</font>
	<br>
	<font size="+1" color="white" face="arial">prima o botao <b>back</b> no browser e complete a informa&ccedil;&atilde;o</font>	
<%
elseif not isnumeric(valor) then
	Menu 6, 2, "MUDAR ARTIGO PARA VENDA"
%>
	<font size="+1" color="white" face="arial">O campo <b>valor</b> tem que ser num&eacute;rico</font>
	<br>
	<font size="+1" color="white" face="arial">prima o botao <b>back</b> no browser e corrija a informa&ccedil;&atilde;o</font>	
<%
else
	SQL = "UPDATE venda_artigo SET "
	SQL = SQL & "nome = '" & nome & "',"
	SQL = SQL & "tipo = '" & tipo & "',"	
	SQL = SQL & "descricao = '" & descricao & "',"
	SQL = SQL & "estado = '" & estado & "',"
	SQL = SQL & "desc_estado = '" & desc_estado & "',"
	SQL = SQL & "valor_minimo = '" & valor & "',"
	SQL = SQL & "moeda = '" & moeda & "',"
	SQL = SQL & "troca = '" & troca & "' "
	SQL = SQL & "WHERE id = " & artigo
	dbConnection.Execute(SQL)

	ComRefresh "venda_artigo.asp?artigo=" & artigo
	Menu 6, 2, "MUDAR ARTIGO PARA VENDA"
%>
	<font size="+1" color="white" face="arial"><b>Artigo mudado com sucesso.</b></font>
<% end if %>

<% FimPagina() %>
