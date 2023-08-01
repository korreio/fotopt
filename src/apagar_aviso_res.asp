<!-- #include file="funcoes_principais.asp" -->

<%
aviso = request("aviso")

SQL = "SELECT * FROM avisos_webmaster WHERE id = " & aviso
Set avisoRes = dbConnection.Execute(SQL)

autor = avisoRes("autor")
apagar = request("apagar")
%>

<% AutenticarMembro(autor) %>

<%
if apagar = "on" then
	SQL = "UPDATE avisos_webmaster SET lido = '1' WHERE id = " & aviso
	dbConnection.Execute(SQL)

	ComRefresh "membros.asp"
	Menu 3, 1, "APAGAR MENSAGEM DO WEBMASTER"
%>
	<font size="+1" color="white" face="arial"><b>Mensagem apagada com sucesso</b></font>
<%
else
	Menu 3, 1, "APAGAR MENSAGEM DO WEBMASTER"
%>
	<font size="+1" color="white" face="arial">Para apagar tem que confirmar na &quot;check box&quot;</font>
	<br>
	<font size="+1" color="white" face="arial">prima o botao <b>back</b> no browser e corrija</font>	
<% end if %>

<% FimPagina() %>
