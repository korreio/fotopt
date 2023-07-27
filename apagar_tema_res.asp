<!-- #include file="funcoes_principais.asp" -->

<%
tema = request("tema")

SQL = "SELECT autor FROM folder WHERE id = " & tema
Set temaRes = dbConnection.Execute(SQL)

autor = temaRes("autor")
apagar = request("apagar")
%>

<% AutenticarMembro(autor) %>

<%
if apagar = "on" then
	SQL = "UPDATE foto SET tema = '0' WHERE tema = " & tema
	dbConnection.Execute(SQL)

	SQL = "DELETE FROM folder WHERE id = " & tema
	dbConnection.Execute(SQL)

	ComRefresh "editar_temas.asp?autor=" & autor
	Menu 1, 1, "APAGAR TEMA"
%>
	<font size="+1" color="white" face="arial"><b>Tema apagado com sucesso</b></font>
<%
else
	Menu 1, 1, "APAGAR TEMA"
%>
	<font size="+1" color="white" face="arial">Para apagar tem que confirmar na &quot;check box&quot;</font>
	<br>
	<font size="+1" color="white" face="arial">prima o botao <b>back</b> no browser e corrija</font>	
<% end if %>

<% FimPagina() %>
