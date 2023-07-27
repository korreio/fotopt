<!-- #include file="../funcoes_principais.asp" -->

<% 
Menu 4, 4, "GLOSSÁRIO" 
%>

<%
SQL = "SELECT * FROM glossario ORDER BY termo"
Set termosRes = dbConnection.Execute(SQL)
%>

<font size="-1" color="white" face="Arial">
(Texto adaptado por <a href="mailto:rscalado@yahoo.com">Ricardo Calado</a>)
</font><br><br>

<table cellpadding="10" cellspacing="0" border="1">
<% do while not termosRes.eof %>
	<tr><td>
		<font color="white" face="arial"><b><% =termosRes("termo") %></b></font><br>
		<font size="-1" color="white" face="arial"><% =termosRes("descricao") %></font>
	</td></tr>
	<% termosRes.MoveNext %>
<% loop %>
</table>

<% FimPagina() %>