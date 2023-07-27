<!-- #include file="sqltext.asp" -->
<!-- #include file="funcoes_principais.asp" -->

<%
ordem = request("ordem")
artigo = request("artigo")

SQL = "SELECT * FROM opiniao_artigo WHERE id = " & artigo
Set artigoRes = dbConnection.Execute(SQL)

SQL = "SELECT * FROM opiniao_tipo WHERE id = " & artigoRes("tipo")
Set tipoRes = dbConnection.Execute(SQL)

SQL = "SELECT * FROM opiniao_grupo WHERE id = " & tipoRes("grupo")
Set grupoRes = dbConnection.Execute(SQL)

SQL = "SELECT * FROM opiniao WHERE artigo = " & artigoRes("id")
Set opiniaoRes = dbConnection.Execute(SQL)

SQL = "SELECT count(*) AS num FROM opiniao WHERE artigo = " & artigoRes("id")
Set opiniaoCountRes = dbConnection.Execute(SQL)

tipo = clng(tipoRes("id"))
%>

<%
OpcaoMenu "LISTA ITEMS", "opiniao_tipo.asp?ordem=" & ordem & "&tipo=" & tipo, False, False, -1, False, False
OpcaoMenu "INSERIR OU MUDAR OPINIÃO", "inserir_opiniao.asp?ordem=" & ordem & "&artigo=" & artigo, False, True, -1, False, False
OpcaoMenu "MUDAR OU APAGAR ARTIGO", "adm/adm_mudar_opiniao.asp?ordem=" & ordem & "&artigo=" & artigo, False, False, -1, False, True
Menu 2, 5, "OPINIÕES SOBRE MATERIAL"
%>

<table border="3" cellpadding="5" cellspacing="0">
<tr>
<% if tipo = 33 then %>
	<td><font size="-1" color="#FFCC66" face="arial"><b>NOME DO LABORAT&Oacute;RIO:</b></font></td>
	<td><font size="-1" color="white" face="arial"><b><% =artigoRes("marca") %></b></font></td>
	</tr><tr>
	<td><font size="-1" color="#FFCC66" face="arial"><b>LOCALIDADE / MORADA:</b></font></td>
	<td><font size="-1" color="white" face="arial"><b><% =artigoRes("modelo") %></b></font></td>
<% elseif tipo = 34 then %>
	<td><font size="-1" color="#FFCC66" face="arial"><b>NOME DA LOJA:</b></font></td>
	<td><font size="-1" color="white" face="arial"><b><% =artigoRes("marca") %></b></font></td>
	</tr><tr>
	<td><font size="-1" color="#FFCC66" face="arial"><b>LOCALIDADE / MORADA:</b></font></td>
	<td><font size="-1" color="white" face="arial"><b><% =artigoRes("modelo") %></b></font></td>
<% elseif tipo = 35 then %>
	<td><font size="-1" color="#FFCC66" face="arial"><b>NOME DO WEBSITE:</b></font></td>
	<td><font size="-1" color="white" face="arial"><b><% =artigoRes("marca") %></b></font></td>
	</tr><tr>
	<td><font size="-1" color="#FFCC66" face="arial"><b>LINK:</b></font></td>
	<td><a target="_new" href="<% =artigoRes("modelo") %>"><font size="-1" color="white" face="arial"><b><% =artigoRes("modelo") %></b></font></a></td>
<% elseif tipo = 40 then %>
	<td><font size="-1" color="#FFCC66" face="arial"><b>NOME DO LIVRO:</b></font></td>
	<td><font size="-1" color="white" face="arial"><b><% =artigoRes("marca") %></b></font></td>
	</tr><tr>
	<td><font size="-1" color="#FFCC66" face="arial"><b>AUTOR(ES):</b></font></td>
	<td><font size="-1" color="white" face="arial"><b><% =artigoRes("modelo") %></b></font></td>
<% elseif tipo = 41 then %>
	<td><font size="-1" color="#FFCC66" face="arial"><b>NOME DO JORNAL:</b></font></td>
	<td><font size="-1" color="white" face="arial"><b><% =artigoRes("marca") %></b></font></td>
<% elseif tipo = 42 then %>
	<td><font size="-1" color="#FFCC66" face="arial"><b>NOME DA REVISTA:</b></font></td>
	<td><font size="-1" color="white" face="arial"><b><% =artigoRes("marca") %></b></font></td>
<% else %>	
	<td><font size="-1" color="#FFCC66" face="arial"><b>NOME DO ARTIGO:</b></font></td>
	<td><font size="-1" color="white" face="arial"><b><% =artigoRes("marca") %>&nbsp;<% =artigoRes("modelo") %></b></font></td>
<% end if %>
</tr>
<tr>
	<td><font size="-1" color="#FFCC66" face="arial"><b>TIPO:</b></font></td>
	<td><font size="-1" color="white" face="arial"><% =grupoRes("nome") %> - <% =tipoRes("nome") %></font></td>
</tr>
<% if (artigoRes("descricao") <> "") and (artigoRes("descricao") <> "-1") then %>
<tr>
	<td><font size="-1" color="#FFCC66" face="arial"><b>DESCRI&Ccedil;&Atilde;O:</b></font></td>
	<td><font size="-1" color="white" face="arial"><% =artigoRes("descricao") %></font></td>
</tr>
<% end if %>
<tr>
	<td><font size="-1" color="#FFCC66" face="arial"><b>NUM. DE OPINI&Otilde;ES</b></font></td>
	<td><font size="-1" color="white" face="arial"><% =opiniaoCountRes("num") %></font></td>
</tr>
<tr>
	<td>
		<font size="-1" color="#FFCC66" face="arial"><b>CLASSIFICA&Ccedil;&Atilde;O M&Eacute;DIA:</b></font>
		<br><font size="-1" color="white" face="arial">(0 - Mau, 5 - Excelente)</font>
	</td>

		<% if artigoRes("num_opinioes") > 0 then %>
			<td align="left">
				<table border="0" cellpadding="0" cellspacing="0">
				<tr>
				<% if artigoRes("media_opinioes") <> 0 then %>
					<td><img hspace="0" border="0" src="Imagens/ClassVerde.gif" width=<% =clng(100 / 5 * artigoRes("media_opinioes")) %> height=12 border=0 alt=""></td>
				<% end if %>
				<% if artigoRes("media_opinioes") <> 5 then %>
					<td><img hspace="0" border="0" src="Imagens/ClassCinza.gif" width=<% =clng(100 - (100 / 5 * artigoRes("media_opinioes"))) %> height=12 border=0 alt=""></td>
				<% end if %>
				<td>&nbsp;<font size="-1" color="white" face="arial">(<% =round(artigoRes("media_opinioes"), 2) %>)</font></td>
				</tr>
				</table>
			</td>
		<% else %>
			<td>&nbsp;</td>
		<% end if %>
</tr>
</table>
<br>

<table border="1" cellpadding="5" cellspacing="0">
<% 
do while not opiniaoRes.eof
	SQL = "SELECT id, nome FROM autor WHERE id = " & opiniaoRes("autor")
	Set autorRes = dbConnection.Execute(SQL)

	SQL = "SELECT * FROM opiniao_classificacao WHERE id = " & opiniaoRes("classificacao")
	Set classRes = dbConnection.Execute(SQL)
%>
		<tr valign="top">
			<td>
				<a href="autor.asp?autor=<% =autorRes("id") %>"><font size="-1" color="white" face="arial"><% =autorRes("nome") %></font></a>
				<br><font size="-2" color="silver" face="arial">(<% =day(opiniaoRes("data")) %>/<% =month(opiniaoRes("data")) %>/<% =year(opiniaoRes("data")) %>)</font>
			</td>
			<td>
				<font size="-1" color="#FFCC66" face="arial"><b>PROS:</b></font><br>
				<font size="-1" color="white" face="arial"><% if opiniaoRes("pros") <> "-1" then %><% =Enter2Br(opiniaoRes("pros")) %><% end if %></font>
				<br>
				<font size="-1" color="#FFCC66" face="arial"><b>CONTRAS:</b></font><br>
				<font size="-1" color="white" face="arial"><% if opiniaoRes("contras") <> "-1" then %><% =Enter2Br(opiniaoRes("contras")) %><% end if %></font>
			</td>
			<td>
				<font size="-1" color="#FFCC66" face="arial"><b>OPINIÃO:</b></font>&nbsp;&nbsp;
				<% if classRes("valor") = 0 then %>
					<img src="Imagens/errado.gif" width=18 height=15 border=0 alt="">
				<% else %>
					<% for i = 1 to classRes("valor") %><img src="Imagens/certo.gif" width=18 height=17 border=0 alt=""><% next %>
				<% end if %>
				<br>
				<font size="-1" color="white" face="arial"><% =Enter2Br(opiniaoRes("opiniao")) %><br></font>
			</td>
			<% if session("login") = 2 then %>
				<td><a href="adm/adm_apagar_opiniao.asp?ordem=<% =ordem %>&artigo=<% =artigo %>&opiniao=<% =opiniaoRes("id") %>"><font size="-1" color="red" face="arial"><b>A</b></font></a></td>
			<% end if %>
		</tr>
	<% opiniaoRes.MoveNext %>
<% loop %>
</table>

<% FimPagina() %>
