<!-- #include file="sqltext.asp" -->
<!-- #include file="funcoes_principais.asp" -->

<% AutenticarMembro(autor) %>

<%
cargo = SqlText(request("cargo"))
empresa = SqlText(request("empresa"))
zona = SqlText(request("zona"))
pretende = SqlText(request("pretende"))
oferece = SqlText(request("oferece"))
horario = SqlText(request("horario"))
observacoes = SqlText(request("observacoes"))
contacto = SqlText(request("contacto"))

if (cargo = "") or (empresa = "") or (zona = "") or (contacto = "") then
	Menu 6, 3, "INSERIR OPORTUNIDADE DE EMPREGO"
%>
	<font size="+1" color="white" face="arial">Os campos <b>cargo</b>, <b>empregador</b>, <b>zona</b> e <b>contacto</b> s&atilde;o obrigat&oacute;rios</font>
	<br>
	<font size="+1" color="white" face="arial">prima o bot&atilde;o <b>back</b> no browser e complete a informa&ccedil;&atilde;o</font>	
<%
else
	SQL = "INSERT INTO emprego_oportunidade (cargo, empresa, zona, horario, contacto, pretende, oferece, observacoes, autor, data)"
	SQL = SQL & " VALUES ('" & cargo & "','" & empresa & "','" & zona & "','" & horario & "','" & contacto
	SQL = SQL & "','" & pretende & "','" & oferece & "','" & observacoes & "','" & session("login") & "','" & date() & " " & time() & "')"
	dbConnection.Execute(SQL)

	SQL = "SELECT id FROM emprego_oportunidade WHERE autor = " & session("login") & " ORDER BY id DESC"
	Set oporRes = dbConnection.Execute(SQL)

	ComRefresh "ver_oportunidade.asp?opor=" & oporRes("id")
	Menu 6, 3, "INSERIR OPORTUNIDADE DE EMPREGO"
%>
	<font size="+1" color="white" face="arial"><b>Oportunidade de emprego inserida com sucesso</b></font>
<% end if %>

<% FimPagina() %>
