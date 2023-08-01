<!-- #include file="sqltext.asp" -->
<!-- #include file="funcoes_principais.asp" -->

<%
pagina = request("pagina")
assunto = request("assunto")
subid = request("subid")
nome = SqlText(request("nome"))
texto = SqlTextMemo(request("texto"))
raiz = request("raiz")
if raiz = "" then
	raiz = 0
end if

' Moderar raiz
if raiz = 0 then
	mostrar = 0
else
	mostrar = 1
end if
%>

<%
AutenticarMembro(autor)
if subid <> 0 then
	tituloMenu = "INSERIR MENSAGEM NO F�RUM"
else
	tituloMenu = "CRIAR DEBATE"
end if
%>

<%
if (nome = "") or (texto = "") then
	Menu 7, 1, tituloMenu
%>
	<font size="+1" color="white" face="arial">Os campos <b>nome</b> e <b>texto</b> s&atilde;o obrigat&oacute;rios</font>
	<br>
	<font size="+1" color="white" face="arial">prima o botao <b>back</b> no browser e complete a informa&ccedil;&atilde;o</font>	
<%
else
	SQL = "INSERT INTO debate_mensagem (nome, texto, assunto, subid, autor, data, raiz, mostrar)"
	SQL = SQL & " VALUES ('" & nome & "','" & texto & "','" & assunto & "','" & subid & "','" & session("login") & "','" & date() & " " & time() & "','" & raiz & "','" & mostrar & "')"
	dbConnection.Execute(SQL)

	SQL = "SELECT id FROM debate_mensagem WHERE autor = " & session("login") & " ORDER BY id DESC"
	Set mensagemRes = dbConnection.Execute(SQL)

	if clng(subid) = 0 then
		ComRefresh "ver_debates.asp?assunto=" & assunto
	else
		ComRefresh "expandir_mensagem.asp?pagina=" & pagina & "&mensagem=" & raiz
	end if
	Menu 7, 1, tituloMenu
%>
	<font size="+1" color="white" face="arial"><b>Mensagem inserida com sucesso</b></font>
<% end if %>

<% FimPagina() %>
