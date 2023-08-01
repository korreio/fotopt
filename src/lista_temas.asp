<!-- #include file="sqltext.asp" -->
<!-- #include file="funcoes_principais.asp" -->

<%
autor = request("autor")

SQL = "SELECT * FROM folder WHERE autor = " & autor & " ORDER BY nome"
Set folderRes = dbConnection.Execute(SQL)

SQL = "SELECT * FROM autor WHERE id = " & autor
Set autorRes = dbConnection.Execute(SQL)

SQL = "SELECT count(*) AS numFotos FROM foto WHERE autor = " & autor & " AND tema = 0"
Set geralRes = dbConnection.Execute(SQL)

SQL = "SELECT count(*) as numPreferidas FROM preferidas_fotos, foto WHERE preferidas_fotos.autor = " & autor & "  AND foto.autor = " & autor & " AND preferidas_fotos.foto = foto.id"
Set numFotoRes = dbConnection.Execute(SQL)

SQL = "SELECT count(*) AS num "
SQL = SQL & "FROM foto "
SQL = SQL & "WHERE foto.autor = " & autor & " AND ("
SQL = SQL & "foto.id IN (SELECT foto FROM destaque_galeria_foto) OR "
SQL = SQL & "foto.id IN (SELECT foto FROM tema_mes_foto WHERE vencedora = True) OR "
SQL = SQL & "foto.id IN (SELECT foto FROM destaque_cronica) OR "
SQL = SQL & "foto.id IN (SELECT foto FROM fotomes_votos as fotomes WHERE votos IN "
SQL = SQL & "(SELECT DISTINCT TOP 3 votos FROM fotomes_votos WHERE fotomes.mes = fotomes_votos.mes AND fotomes.ano = fotomes_votos.ano ORDER BY votos DESC) AND "
SQL = SQL & "NOT (fotomes.mes = " & month(date()) & " AND fotomes.ano = " & year(date()) & ")));"
Set numFotoVencedorasRes = dbConnection.Execute(SQL)
%>

<% 
OpcaoMenu "VER FICHA DESTE MEMBRO ", "autor.asp?autor=" & autor, False, False, -1, False, False
OpcaoMenu "EDITAR TEMAS DA GALERIA", "editar_temas.asp?autor=" & autor, False, True, autor, False, False
if session("login") <> 2 then
	OpcaoMenu "INSERIR FOTO", "inserir_foto.asp", False, True, -1, False, False
end if
OpcaoMenu "INSERIR FOTO", "inserir_foto.asp?autor=" & autor, False, False, -1, False, True
'OpcaoMenu "LIMITE DE FOTOS", "limite_fotos.asp?autor=" & autor, False, False, -1, False, False
Menu 1, 1, "TEMAS DA GALERIA DE " & autorRes("nome")
%>

<table border="0" cellpadding="0" cellspacing="0">
<tr>
	<td valign="top" width="220">
		<font color="#FFCC66" face="arial"><b>Galerias de<br><a href="autor.asp?autor=<% =autor %>"><font color="#FFCC66" face="arial"><% =autorRes("nome") %></font></a></b></font><br>
		<% if autorRes("profissao") <> "" then %>
			<font size="-1" color="white" face="arial"><% =autorRes("profissao") %></font><br>
		<% end if %>
		<% if autorRes("regiao") <> "" then %>
			<font size="-1" color="white" face="arial"><% =autorRes("regiao") %></font><br>
		<% end if %>
		<% if autorRes("data_nascimento") <> "" then %>
			<font size="-1" color="white" face="arial"><% =int((date() - autorRes("data_nascimento")) / 365.25) %> anos de idade</font><br>
		<% end if %>
		<% if autorRes("apresentacao") <> "" then %>
			<br><font size="-2" color="white" face="arial">&quot;<% =Enter2Br(autorRes("apresentacao")) %>&quot;</font><br>
		<% end if %>
		<br>
	</td>
	<td rowspan="3" width="10"><img src="imagens/pixel.gif"></td>
	<td rowspan="3" width="1" bgcolor="#c0c0c0"><img src="imagens/pixel.gif"></td>
	<td rowspan="3" width="10"><img src="imagens/pixel.gif"></td>
	<td rowspan="3" valign="top">
		<font size="-1" color="white" face="arial">Ver as fotos, deste autor, divididas por temas:</font><br><br>
		
		<table border="0" cellpadding="2" cellspacing="0">
		<tr>
			<td><a href="galeria.asp?tipo=autor&id=<% =autor %>&tema=0"><font color="#FFCC66" size="-1" face="arial"><b>Geral</b></font></a></td>
			<td align="right">&nbsp;<font color="silver" size="-2" face="arial">(<% =geralRes("numFotos") %>&nbsp;foto<% if geralRes("numFotos") <> 1 then %>s<% end if %>)</font></td>
		</tr>
		<tr><td colspan="2">
			<font size="-1" color="white" face="arial">Fotos que n&atilde;o foram classificadas por temas.</font>
		</td></tr>
		</td></tr>
		
		<% 
		do while not folderRes.eof
			if (session("login") = 2) or (session("login") = clng(autor)) then
				SQL = "SELECT count(*) AS numFotos FROM foto WHERE autor = " & autor & " AND tema = " & folderRes("id")
				Set porTemaRes = dbConnection.Execute(SQL)
			else
				SQL = "SELECT count(*) AS numFotos FROM foto WHERE autor = " & autor & " AND tema = " & folderRes("id") & " AND (anonima <> 2 OR (anonima = 2 AND data < #" & cdate(date() & " " & time()) - 7 & "#))"
				Set porTemaRes = dbConnection.Execute(SQL)
			end if
		%>
			<tr>
				<td><a href="galeria.asp?tipo=autor&id=<% =autor %>&tema=<% =folderRes("id") %>"><font color="#FFCC66" size="-1" face="arial"><b><% =folderRes("nome") %></b></font></a></td>
				<td align="right">&nbsp;<font color="silver" size="-2" face="arial">(<% =porTemaRes("numFotos") %> foto<% if porTemaRes("numFotos") <> 1 then %>s<% end if %>)</font></td>
			</tr>
			<tr><td colspan="2">
				<% if folderRes("descricao") <> "" then %>
					<font size="-1" color="white" face="arial"><% =folderRes("descricao") %>&nbsp;</font>
				<% end if %>
			</td></tr>
			<% folderRes.MoveNext %>
		<% Loop %>
		</table>
	</td>
</tr>
<tr><td colspan="2" height="1" bgcolor="#c0c0c0"><img src="imagens/pixel.gif"></td></tr>
<tr>
	<td width="220" valign="top" height="300">
		<br>
		<a href="galeria.asp?tipo=autor&id=<% =autor %>&tema=-1"><font color="#FFCC66" size="-1" face="arial"><b>VER TODAS AS FOTOS DO AUTOR</b></font></a>
		<br><font size="-1" color="white" face="arial">Sem respeitar a divisão por temas do autor.</font>

		<% if numFotoRes("numPreferidas") > 0 then %>
			<br><br>
			<a href="galeria.asp?tipo=preferidas_autor&id=<% =autor %>"><font color="#FFCC66" size="-1" face="arial"><b>A SELECÇÃO DO PRÓPRIO AUTOR</b></font></a>
			<br><font size="-1" color="white" face="arial">Escolhidas pelo autor entre todas as que estão na sua galeria.</font>
		<% end if %>

		<% if numFotoVencedorasRes("num") > 0 then %>
			<br><br>
			<a href="galeria.asp?tipo=vencedoras_autor&id=<% =autor %>"><font color="#FFCC66" size="-1" face="arial"><b>DESTACADAS E VENCEDORAS</b></font></a>
			<br><font size="-1" color="white" face="arial">Destacadas pelo júri ou vencedoras de algum concurso no site.</font>
		<% end if %>
	</td>
</tr>
</table>
<% FimPagina() %>
