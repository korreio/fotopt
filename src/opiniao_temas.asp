<!-- #include file="funcoes_principais.asp" -->

<%
Menu 2, 5, "OPINIÕES SOBRE MATERIAL"
%>

<%
SQL = "SELECT * FROM opiniao_grupo ORDER BY nome"
Set grupoRes = dbConnection.Execute(SQL)

ordem = request("ordem")
if ordem = "" then
	ordem = "nome"
end if
%>

<table border="1" cellpadding="10" cellspacing="0">
<tr>
<% 
i = 1
do while not grupoRes.eof
	SQL = "SELECT * FROM opiniao_tipo WHERE grupo = " & grupoRes("id") & " ORDER BY id"
	Set tipoRes = dbConnection.Execute(SQL)
%>
	<td valign="top">
		<font color="white" face="arial"><b><% =grupoRes("nome") %></b></font><br>
		<% 
		do while not tipoRes.eof
			SQL = "SELECT count(*) AS num FROM opiniao_artigo WHERE tipo = " & tipoRes("id")
			Set numArtigosRes = dbConnection.Execute(SQL)
		%>
			<table border="0" cellpadding="2" cellspacing="0" width="100%"><tr>
				<td><a href="opiniao_tipo.asp?ordem=<% =ordem %>&tipo=<% =tipoRes("id") %>"><font color="#FFCC66" size="-2" face="verdana, arial"><b><% =tipoRes("nome") %></b></font></a></td>
				<td align="right"><% if numArtigosRes("num") > 0 then %><font color="silver" size="-2" face="arial">&nbsp;&nbsp;&nbsp;(<% =numArtigosRes("num") %>)</font><% end if %><br></td>
			</tr></table>
			
			<% tipoRes.MoveNext %>
		<% Loop %>
	</td>
	<% if i mod 3 = 0 then %></tr><tr><% end if %>
	<% i = i + 1 %>
	<% grupoRes.MoveNext %>
<% loop %>
</tr>
</table>

<% FimPagina() %>
