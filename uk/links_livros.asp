<!-- #include file="inicio_basedados.asp" -->

<%
SQL = "SELECT * FROM links_tipo ORDER BY en_nome"
Set tipoLinksRes = dbConnection.Execute(SQL)
%>

<!-- #include file="topo.asp" -->
<td bgcolor="gray" width="100%" align="left"><font size="-1" color="black" face="arial">&nbsp;LINKS</font></td>
<!-- #include file="fim_topo.asp" -->

<table border="1" cellpadding="10" cellspacing="0">
<tr>
<td>
	<font color="white" face="arial"><a href="links.asp"><b>LINKS</b></a></font><br>
	<% 
	do while not tipoLinksRes.eof
	%>
		&nbsp;&nbsp;<a href="links.asp?tipo=<% =tipoLinksRes("id") %>"><font color="#FFCC66" size="-2" face="verdana, arial"><b><% =tipoLinksRes("en_nome") %></b></font></a><br>
		<% tipoLinksRes.MoveNext %>
	<% Loop %>
</td></tr>
</table>

<!-- #include file="fim.asp" -->
<!-- #include file="fim_basedados.asp" -->