<!-- #include file="sqltext.asp" -->
<!-- #include file="funcoes_principais.asp" -->

<%
opor = request("opor")

SQL = "SELECT * FROM emprego_oportunidade WHERE id = " & opor
Set oporRes = dbConnection.Execute(SQL)

autor = oporRes("autor")
%>

<% AutenticarMembro(autor) %>

<%
opor = request("opor")
cargo = SqlText(request("cargo"))
empresa = SqlText(request("empresa"))
zona = SqlText(request("zona"))
pretende = SqlText(request("pretende"))
oferece = SqlText(request("oferece"))
horario = SqlText(request("horario"))
observacoes = SqlText(request("observacoes"))
contacto = SqlText(request("contacto"))

if (cargo = "") or (empresa = "") or (zona = "") or (contacto = "") then
	Menu 6, 3, "MUDAR OPORTUNIDADE DE EMPREGO"
%>
	<font size="+1" color="white" face="arial">Os campos <b>cargo</b>, <b>empregador</b>, <b>zona</b> e <b>contacto</b> s&atilde;o obrigat&oacute;rios</font>
	<br>
	<font size="+1" color="white" face="arial">prima o bot&atilde;o <b>back</b> no browser e complete a informa&ccedil;&atilde;o</font>	
<%
else
	SQL = "UPDATE emprego_oportunidade SET "
	SQL = SQL & "cargo = '" & cargo & "',"
	SQL = SQL & "empresa = '" & empresa & "',"	
	SQL = SQL & "zona = '" & zona & "',"
	SQL = SQL & "pretende = '" & pretende & "',"
	SQL = SQL & "oferece = '" & oferece & "',"
	SQL = SQL & "horario = '" & horario & "',"			
	SQL = SQL & "contacto = '" & contacto & "',"		
	SQL = SQL & "observacoes = '" & observacoes & "' "
	SQL = SQL & "WHERE id = " & opor
	dbConnection.Execute(SQL)

	ComRefresh "ver_oportunidade.asp?opor=" & opor
	Menu 6, 3, "MUDAR OPORTUNIDADE DE EMPREGO"
%>
	<font size="+1" color="white" face="arial"><b>Oportunidade de emprego inserida com sucesso</b></font>
<% end if %>

<% FimPagina() %>
