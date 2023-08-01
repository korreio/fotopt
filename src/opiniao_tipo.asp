<!-- #include file="funcoes_principais.asp" -->

<%
ordem = request("ordem")
tipo = clng(request("tipo"))

SQL = "SELECT * FROM opiniao_tipo WHERE id = " & tipo
Set tipoRes = dbConnection.Execute(SQL)

SQL = "SELECT * FROM opiniao_grupo WHERE id = " & tipoRes("grupo")
Set grupoRes = dbConnection.Execute(SQL)

if ordem = "nome" then
	SQL = "SELECT * FROM opiniao_artigo WHERE tipo = " & tipo & " ORDER BY marca, modelo"
	Set artigosRes = dbConnection.Execute(SQL)
else
	SQL = "SELECT * FROM opiniao_artigo WHERE tipo = " & tipo & " ORDER BY media_opinioes DESC, num_opinioes DESC, marca, modelo"
	Set artigosRes = dbConnection.Execute(SQL)
end if
%>

<%
if ordem = "nome" then
	OpcaoMenu "ORDENAR POR CLASSIFICAÇÃO", "opiniao_tipo.asp?ordem=class&tipo=" & tipo, False, False, -1, False, False
else
	OpcaoMenu "ORDENAR POR NOMES", "opiniao_tipo.asp?ordem=nome&tipo=" & tipo, False, False, -1, False, False
end if
OpcaoMenu "VER OUTROS ITEMS", "opiniao_temas.asp?ordem=" & ordem & "&tipo=" & tipo, False, False, -1, False, False
OpcaoMenu "INSERIR ITEM", "inserir_opiniao_artigo.asp?ordem=" & ordem & "&tipo=" & tipo, False, True, -1, False, False
Menu 2, 5, "OPINIÕES SOBRE MATERIAL - " & grupoRes("nome") & " - " & tipoRes("nome")
%>

<table border="1" cellpadding="5" cellspacing="0">
<tr>
	<% if tipo = 33 then %>
		<td width="200" align="center"><font color="white" face="arial"><b>NOME DO<br>LABORAT&Oacute;RIO</b></font></td>
	<% elseif tipo = 34 then %>
		<td width="200" align="center"><font color="white" face="arial"><b>NOME DA<br>LOJA</b></font></td>
	<% elseif tipo = 35 then %>
		<td width="200" align="center"><font color="white" face="arial"><b>NOME DO<br>WEBSITE</b></font></td>
	<% elseif tipo = 40 then %>
		<td width="200" align="center"><font color="white" face="arial"><b>NOME DO<br>LIVRO</b></font></td>
	<% elseif tipo = 41 then %>
		<td width="200" align="center"><font color="white" face="arial"><b>NOME DO<br>JORNAL</b></font></td>
	<% elseif tipo = 42 then %>
		<td width="200" align="center"><font color="white" face="arial"><b>NOME DA<br>REVISTA</b></font></td>
	<% else %>	
		<td width="200" align="center"><font color="white" face="arial"><b>NOME DO<br>ARTIGO</b></font></td>
	<% end if %>
	<td align="center"><font color="white" face="arial"><b>N&#186; DE <br>OPINI&Otilde;ES</b></font></td>
	<td align="center"><font color="white" face="arial"><b>CLASSIFICA&Ccedil;&Atilde;O<br>M&Eacute;DIA</b></font></td>
</tr>
<% 
do while not artigosRes.eof
%>
	<tr>
		<% if tipo = 33 then %>
			<td><a href="opiniao_artigo.asp?ordem=<% =ordem %>&artigo=<% =artigosRes("id") %>"><font size="-1" color="#FFCC66" face="verdana, arial"><b><% =artigosRes("marca") %></b>&nbsp;(<% =artigosRes("modelo") %>)</font></a></td>
		<% elseif tipo = 34 then %>
			<td><a href="opiniao_artigo.asp?ordem=<% =ordem %>&artigo=<% =artigosRes("id") %>"><font size="-1" color="#FFCC66" face="verdana, arial"><b><% =artigosRes("marca") %></b>&nbsp;(<% =artigosRes("modelo") %>)</font></a></td>
		<% elseif tipo = 35 then %>
			<td><a href="opiniao_artigo.asp?ordem=<% =ordem %>&artigo=<% =artigosRes("id") %>"><font size="-1" color="#FFCC66" face="verdana, arial"><b><% =artigosRes("marca") %></b></font></a></td>
		<% elseif tipo = 40 then %>
			<td><a href="opiniao_artigo.asp?ordem=<% =ordem %>&artigo=<% =artigosRes("id") %>"><font size="-1" color="#FFCC66" face="verdana, arial"><b><% =artigosRes("marca") %></b>&nbsp;(<% =artigosRes("modelo") %>)</font></a></td>
		<% elseif tipo = 41 then %>
			<td><a href="opiniao_artigo.asp?ordem=<% =ordem %>&artigo=<% =artigosRes("id") %>"><font size="-1" color="#FFCC66" face="verdana, arial"><b><% =artigosRes("marca") %></b></font></a></td>
		<% elseif tipo = 42 then %>
			<td><a href="opiniao_artigo.asp?ordem=<% =ordem %>&artigo=<% =artigosRes("id") %>"><font size="-1" color="#FFCC66" face="verdana, arial"><b><% =artigosRes("marca") %></b></font></a></td>
		<% else %>	
			<td><a href="opiniao_artigo.asp?ordem=<% =ordem %>&artigo=<% =artigosRes("id") %>"><font size="-1" color="#FFCC66" face="verdana, arial"><b><% =artigosRes("marca") %>&nbsp;<% =artigosRes("modelo") %></b></font></a></td>
		<% end if %>
		
		<td align="center"><font size="-1" color="white" face="arial"><% =artigosRes("num_opinioes") %></font></td>
		<% if artigosRes("num_opinioes") > 0 then %>
			<td align="left">
				<table border="0" cellpadding="0" cellspacing="0">
				<tr>
				<% if artigosRes("media_opinioes") <> 0 then %>
					<td><img hspace="0" border="0" src="Imagens/ClassVerde.gif" width=<% =clng(100 / 5 * artigosRes("media_opinioes")) %> height=12 border=0 alt=""></td>
				<% end if %>
				<% if artigosRes("media_opinioes") <> 5 then %>
					<td><img hspace="0" border="0" src="Imagens/ClassCinza.gif" width=<% =clng(100 - (100 / 5 * artigosRes("media_opinioes"))) %> height=12 border=0 alt=""></td>
				<% end if %>
				<td>&nbsp;<font size="-1" color="white" face="arial">(<% =round(artigosRes("media_opinioes"), 2) %>)</font></td>
				</tr>
				</table>
			</td>
		<% else %>
			<td>&nbsp;</td>
		<% end if %>
	</tr>
	<% artigosRes.MoveNext %>
<% loop %>
</table>

<% FimPagina() %>
