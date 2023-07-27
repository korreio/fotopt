<!-- #include file="funcoes_principais.asp" -->

<%
autor = request("autor")
apagar = request("apagar")
%>

<% AutenticarMembro(autor) %>

<%
if apagar = "on" then
	SQL = "UPDATE autor SET retrato = '0' WHERE id = " & autor
	dbConnection.Execute(SQL)
	
	Set fileSystem = CreateObject("Scripting.FileSystemObject")
	if fileSystem.FileExists("c:\inetpub\wwwroot\foto\fotos\retratos\retrato" & autor & ".jpg") then
		fileSystem.DeleteFile "c:\inetpub\wwwroot\foto\fotos\retratos\retrato" & autor & ".jpg"
	end if
	
	set fileSystem = Nothing	

	ComRefresh "autor.asp?autor=" & autor
	Menu 3, 2, "APAGAR RETRATO" 
%>
	<font size="+1" color="white" face="arial"><b>Retrato apagado com sucesso</b></font>
<%
else
	Menu 3, 2, "APAGAR RETRATO" 
%>
	<font size="+1" color="white" face="arial">Para apagar tem que confirmar na &quot;check box&quot;</font>
	<br>
	<font size="+1" color="white" face="arial">prima o botao <b>back</b> no browser e corrija</font>	
<% end if %>

<% FimPagina() %>
