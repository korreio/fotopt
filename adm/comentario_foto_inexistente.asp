<!-- #include file="inicio_basedados.asp" -->

<%
Server.ScriptTimeOut = 999999

SQL = "SELECT id, foto FROM comentario"
Set comentRes = dbConnection.Execute(SQL)

do while not comentRes.eof
	SQL = "SELECT id FROM foto WHERE id = " & comentRes("foto")
	Set fotoRes = dbConnection.Execute(SQL)
	
	if fotoRes.eof then
%>
		<% =comentRes("id") %><br>
<%
	end if
	
	comentRes.MoveNext
loop
%>


<!-- #include file="fim_basedados.asp" -->