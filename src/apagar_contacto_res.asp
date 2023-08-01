<!-- #include file="funcoes_principais.asp" -->

<%
contacto = request("contacto")

SQL = "SELECT autor FROM contactos WHERE id = " & contacto
Set contactoRes = dbConnection.Execute(SQL)

autor = contactoRes("autor")
apagar = request("apagar")
%>

<% AutenticarMembro(autor) %>

<%
if apagar = "on" then
	SQL = "DELETE FROM contactos WHERE id = " & contacto
	dbConnection.Execute(SQL)

	ComRefresh "contactos.asp"
	Menu 6, 4, "APAGAR CONTACTO"
%>
	<font size="+1" color="white" face="arial"><b>Contacto apagado com sucesso</b></font>
<%
else
	Menu 6, 4, "APAGAR CONTACTO"
%>
	<font size="+1" color="white" face="arial">Para apagar tem que confirmar na &quot;check box&quot;</font>
	<br>
	<font size="+1" color="white" face="arial">prima o botao <b>back</b> no browser e corrija</font>	
<% end if %>

<% FimPagina() %>
