<!-- #include file="funcoes_principais.asp" -->
<% 
OpcaoMenu "INSERIR LINK", "inserir_link.asp", False, True, -1, False, False
Menu 4, 3, "LINKS" 
%>

<%
SQL = "SELECT * FROM links_tipo ORDER BY nome"
Set tipoLinksRes = dbConnection.Execute(SQL)
%>

<table border="1" cellpadding="10" cellspacing="0">
<tr>
<td valign="top">
	<font color="white" face="arial"><a href="links.asp"><b>LINKS</b></a></font><br>
	<% 
	do while not tipoLinksRes.eof
	%>
		&nbsp;&nbsp;<a href="links.asp?tipo=<% =tipoLinksRes("id") %>"><font color="#FFCC66" size="-2" face="verdana, arial"><b><% =tipoLinksRes("nome") %></b></font></a><br>
		<% tipoLinksRes.MoveNext %>
	<% Loop %>
</td>	
</tr>
</table>

<% FimPagina() %>
