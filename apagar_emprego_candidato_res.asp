<!-- #include file="funcoes_principais.asp" -->

<%
candidato = request("candidato")

SQL = "SELECT autor FROM emprego_candidato WHERE id = " & candidato
Set candidatoRes = dbConnection.Execute(SQL)

autor = candidatoRes("autor")
apagar = request("apagar")
%>

<% AutenticarMembro(autor) %>

<%
if apagar = "on" then
	SQL = "DELETE FROM emprego_candidato WHERE id = " & candidato
	dbConnection.Execute(SQL)

	ComRefresh "emprego.asp"
	Menu 6, 3, "APAGAR CANDIDATO A EMPREGO"
%>
	<font size="+1" color="white" face="arial"><b>Candidato apagado com sucesso</b></font>
<%
else
	Menu 6, 3, "APAGAR CANDIDATO A EMPREGO"
%>
	<font size="+1" color="white" face="arial">Para apagar tem que confirmar na &quot;check box&quot;</font>
	<br>
	<font size="+1" color="white" face="arial">prima o botao <b>back</b> no browser e corrija</font>	
<% end if %>

<% FimPagina() %>
