<!-- #include file="sqltext.asp" -->
<!-- #include file="funcoes_principais.asp" -->

<% AutenticarMembro(autor) %>

<%
cargo = SqlText(request("cargo"))
zona = SqlText(request("zona"))
pretende = SqlText(request("pretende"))
horario = SqlText(request("horario"))
habilitacoes = SqlText(request("habilitacoes"))
complementar = SqlText(request("complementar"))
diversos = SqlText(request("diversos"))
experiencia = SqlText(request("experiencia"))
observacoes = SqlText(request("observacoes"))
contacto = SqlText(request("contacto"))

if (cargo = "") or (zona = "") or (contacto = "") then
	Menu 6, 3, "INSERIR CANDIDATO A EMPREGO"
%>
	<font size="+1" color="white" face="arial">Os campos <b>cargo pretendido</b>, <b>zona</b> e <b>contacto</b> s&atilde;o obrigat&oacute;rios</font>
	<br>
	<font size="+1" color="white" face="arial">prima o bot&atilde;o <b>back</b> no browser e complete a informa&ccedil;&atilde;o</font>	
<%
else
	SQL = "INSERT INTO emprego_candidato (cargo, zona, horario, contacto, pretende, habilitacoes, complementar, experiencia, diversos, observacoes, autor, data)"
	SQL = SQL & " VALUES ('" & cargo & "','" & zona & "','" & horario & "','" & contacto
	SQL = SQL & "','" & pretende & "','" & habilitacoes & "','" & complementar & "','" & experiencia & "','" & diversos & "','" & observacoes & "','" & session("login") & "','" & date() & " " & time() & "')"
	dbConnection.Execute(SQL)

	SQL = "SELECT id FROM emprego_candidato WHERE autor = " & session("login") & " ORDER BY id DESC"
	Set candidatoRes = dbConnection.Execute(SQL)

	ComRefresh "ver_candidato.asp?candidato=" & candidatoRes("id")
	Menu 6, 3, "INSERIR CANDIDATO A EMPREGO"
%>
	<font size="+1" color="white" face="arial"><b>Candidato a emprego inserido com sucesso</b></font>
<% end if %>

<% FimPagina() %>
