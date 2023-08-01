<!-- #include file="sqltext.asp" -->
<!-- #include file="funcoes_principais.asp" -->

<%
foto = request("foto")

' Dados referentes a galeria
primeira = request("primeira")
tipo = request("tipo")
id = request("id")
tema = request("tema")
num = request("num")

Dim meses
meses = Array("Janeiro", "Fevereiro", "Mar&ccedil;o", "Abril", "Maio", "Junho", "Julho", _
			  "Agosto", "Setembro", "Outubro", "Novembro", "Dezembro")

SQL = "SELECT * FROM foto WHERE id = " & foto
Set fotoRes = dbConnection.Execute(SQL)

SQL = "SELECT nome FROM autor WHERE id = " & fotoRes("autor")
Set autorRes = dbConnection.Execute(SQL)

SQL = "SELECT aprovacao FROM autor_opcoes WHERE autor = " & fotoRes("autor")
Set autorOpcoesRes = dbConnection.Execute(SQL)

SQL = "SELECT nome FROM assunto WHERE id = " & fotoRes("assunto")
Set assuntoRes = dbConnection.Execute(SQL)

if (session("login") = fotoRes("autor")) or (session("login") = 2) or (autorOpcoesRes("aprovacao") = 1) then
	SQL = "SELECT * FROM comentario WHERE foto = " & foto & " ORDER BY data, id"
	Set comentarioRes = dbConnection.Execute(SQL)
elseif session("login") then
	SQL = "SELECT * FROM comentario WHERE foto = " & foto & " AND (moderar = false OR autor = " & session("login") & ") ORDER BY data, id"
	Set comentarioRes = dbConnection.Execute(SQL)
else
	SQL = "SELECT * FROM comentario WHERE foto = " & foto & " AND moderar = false ORDER BY data, id"
	Set comentarioRes = dbConnection.Execute(SQL)
end if

SQL = "SELECT count(*) AS num FROM comentario WHERE foto = " & foto
Set numComentariosRes = dbConnection.Execute(SQL)

SQL = "SELECT id FROM cronicas WHERE foto = " & foto
Set cronicasRes = dbConnection.Execute(SQL)

SQL = "SELECT * FROM destaque_cronica WHERE foto = " & foto
Set cronicaDestaqueRes = dbConnection.Execute(SQL)

directoria = int(fotoRes("id") / 1000)
%>

<%
if tipo <> "" then
	OpcaoMenu "VOLTAR À GALERIA", "galeria.asp?primeira=" & primeira & "&tema=" & tema & "&tipo=" & tipo & "&id=" & id & "&num=" & num, False, False, -1, False, False
end if
OpcaoMenu "VER A FOTO", "foto.asp?foto=" & foto & "&primeira=" & primeira & "&tema=" & tema & "&tipo=" & tipo & "&id=" & id & "&num=" & num, False, False, -1, False, False
if not cronicasRes.eof then
	OpcaoMenu "LER CRÓNICA", "cronica.asp?foto=" & foto & "&primeira=" & primeira & "&tema=" & tema & "&tipo=" & tipo & "&id=" & id & "&num=" & num, False, False, -1, False, False
end if
OpcaoMenu "INSERIR, ALTERAR OU APAGAR COMENTÁRIO", "inserir_comentario.asp?foto=" & foto & "&primeira=" & primeira & "&tema=" & tema & "&tipo=" & tipo & "&id=" & id & "&num=" & num, False, True, -1, False, False
OpcaoMenu "APROVAR TODOS OS COMENTÁRIOS", "aprovar_comentario_res.asp?comentario=-1&foto=" & foto & "&primeira=" & primeira & "&tema=" & tema & "&tipo=" & tipo & "&id=" & id & "&num=" & num, False, True, fotoRes("autor"), False, False
Menu 1, GaleriaSubSeccao(tipo, id), "COMENTÁRIOS"
%>

<table border="0" cellpadding="0" cellspacing="10">
<tr>
<td>
	<a href="foto.asp?foto=<% =foto %>&primeira=<% =primeira %>&tema=<% =tema %>&tipo=<% =tipo %>&id=<% =id %>&num=<% =num %>">
		<img src="/fotos/thumbs/<% =directoria %>/thumbs<% =fotoRes("id") %>.jpg" border="1" alt=""></a>
</td>
<td>
	<table border="0" cellpadding="2" cellspacing="0">
		<tr><td><font size="-1" color="#FFCC66" face="arial"><b>ID: </b></font></td><td><font size="-1" color="white" face="arial"><% =fotoRes("id") %></font></td></tr>
		<% if fotoRes("titulo") <> "" then %>
			<tr><td><font size="-1" color="#FFCC66" face="arial"><b>T&Iacute;TULO: </b></font></td><td><font size="-1" color="white" face="arial"><% =fotoRes("titulo") %></font></td></tr>
		<% else %>
			<tr><td><font size="-1" color="#FFCC66" face="arial"><b>T&Iacute;TULO: </b></font></td><td><font size="-1" color="white" face="arial"><i>sem t&iacute;tulo</i></font></td></tr>		
		<% end if %>
		<% if (fotoRes("anonima") <> 0) and (fotoRes("data") > (cdate(date() & " " & time()) - 7)) then %>
			<% if session("login") = 2 then %>
				<tr><td><font size="-1" color="#FFCC66" face="arial"><b>AUTOR: </b></font></td><td><a href="autor.asp?autor=<% =fotoRes("autor") %>"><font size="-1" color="red" face="arial"><% =autorRes("nome") %></font></a></td></tr>
			<% else %>
				<tr><td><font size="-1" color="#FFCC66" face="arial"><b>AUTOR: </b></font></td><td><font color="white" size="-1" face="arial"><i>anónimo</i> (até <% =day(fotoRes("data") + 7) & "/" & month(fotoRes("data") + 7) & "/" & year(fotoRes("data") + 7) & " às " & hour(fotoRes("data") + 7) & ":" & minute(fotoRes("data") + 7) %>)</font></td></tr>
			<% end if %>
		<% else %>
			<tr><td><font size="-1" color="#FFCC66" face="arial"><b>AUTOR: </b></font></td><td><a href="autor.asp?autor=<% =fotoRes("autor") %>"><font size="-1" color="white" face="arial"><% =autorRes("nome") %></font></a></td></tr>
		<% end if %>
		<tr><td><font size="-1" color="#FFCC66" face="arial"><b>DATA INTR: </b></font></td><td><font size="-1" color="white" face="arial"><% =day(fotoRes("data")) %>/<% =month(fotoRes("data")) %>/<% =year(fotoRes("data")) %></font></td></tr>
		<% if (fotoRes("autor") = session("login")) or (session("login") = 2) then %>
			<tr>
				<td><font size="-1" color="#FFCC66" face="arial"><b>N&#186; COMENT: </b></font></td>
				<td>
					<font size="-1" color="white" face="arial"><% =numComentariosRes("num") %></font>
				</td>
			</tr>
		<% end if %>
	</table>
</td>
</tr>
</table>

<% if not cronicaDestaqueRes.eof then %>
	<% if cronicaDestaqueRes("comentario") <> "" then %>
		<br>
		<table border="1" cellpadding="4" cellspacing="0" bordercolor="gray">
		<tr align="left"><td><font size="-1" color="#FFCC66" face="arial"><b>CR&Iacute;TICA DO J&Uacute;RI DA </b></font><a href="destaque.asp?mes=<% =cronicaDestaqueRes("mes") %>&ano=<% =cronicaDestaqueRes("ano") %>"><font size="-1" color="#FFCC66" face="arial"><b>CR&Oacute;NICA DO M&Ecirc;S</b></font></a> <font size="-1" color="white" face="arial">(destaque em <% =meses(cronicaDestaqueRes("mes") - 1) %> de <% =cronicaDestaqueRes("ano") %>)</font></td></tr>
		<tr><td valign="top"><p align="left"><font size="-1" color="white" face="arial"><% =Enter2Br(cronicaDestaqueRes("comentario")) %></font></p></td></tr>
		</table>
	<% end if %>
<% end if %>

<br>
<table border="1" cellpadding="4" cellspacing="0" bordercolor="gray">
<tr align="left">
	<td><font size="-1" color="#FFCC66" face="arial"><b>COMENT&Aacute;RIO</b></font></td>
	<td><font size="-1" color="#FFCC66" face="arial"><b>COMENTADOR</b></font></td>
	<td><font size="-1" color="#FFCC66" face="arial"><b>DATA</b></font></td>
	<% if session("login") = fotoRes("autor") then %>	
		<td><font size="-1" color="green" face="arial"><b>APROVAR</b></font></td>
		<td><font size="-1" color="red" face="arial"><b>APAGAR</b></font></td>
	<% end if %>
	<% if session("login") = 2 then %>	
		<td><font size="-1" color="red" face="arial"><b>ADM</b></font></td>
	<% end if %>
</tr>
<% 
do while not comentarioRes.eof
	SQL = "SELECT nome FROM autor WHERE id = " & comentarioRes("autor")
	Set comentadorRes = dbConnection.Execute(SQL)
%>
	<tr>
		<td valign="top"><p align="left"><font size="-1" color="<% if (comentarioRes("moderar") = True) and (autorOpcoesRes("aprovacao") = 0) then %>red<% elseif comentarioRes("moderar") = True then %>#ffcc33<% else %>white<% end if %>" face="arial"><% =Enter2Br(comentarioRes("comentario")) %></font></p></td>
		<td valign="top"><a href="autor.asp?autor=<% =comentarioRes("autor") %>"><font size="-2" color="silver" face="arial"><% =comentadorRes("nome") %></font></a></td>
		<td valign="top" align="center"><font size="-2" color="silver" face="arial"><% =day(comentarioRes("data")) %>/<% =month(comentarioRes("data")) %>/<% =right(year(comentarioRes("data")),2) %></font></td>
		<% if session("login") = fotoRes("autor") then %>
			<% if comentarioRes("moderar") = True then %>
				<td align="center"><a href="aprovar_comentario_res.asp?comentario=<% =comentarioRes("id") %>&foto=<% =foto %>&primeira=<% =primeira %>&tema=<% =tema %>&tipo=<% =tipo %>&id=<% =id %>&num=<% =num %>"><font size="-2" color="green" face="arial"><b>APROVAR</b></font></a></td>
			<% else %>
				<td align="center">&nbsp;</td>
			<% end if %>
			<td align="center"><a href="apagar_comentario.asp?comentario=<% =comentarioRes("id") %>&foto=<% =foto %>&primeira=<% =primeira %>&tema=<% =tema %>&tipo=<% =tipo %>&id=<% =id %>&num=<% =num %>"><font size="-2" color="red" face="arial"><b>APAGAR</b></font></a></td>
		<% end if %>
		<% if session("login") = 2 then %>	
			<td align="center"><a href="adm/adm_del_coment.asp?comentario=<% =comentarioRes("id") %>&foto=<% =foto %>&primeira=<% =primeira %>&tema=<% =tema %>&tipo=<% =tipo %>&id=<% =id %>&num=<% =num %>"><font size="-2" color="red" face="arial"><b>A</b></font></a></td>
		<% end if %>
	</tr>
	<% comentarioRes.MoveNext %>
<% Loop %>
</table>

<br>
<font size="-1" color="white" face="arial">
	Nota: o autor da foto é o principal responsável por moderar o conteúdo dos comentários às suas fotos,
	sendo opção de cada membro mostrar ou não, aos outros membros, os comentários por aprovar (assinalados a
	amarelo ou vermelho, conforme se visiveis por todos ou não).
</font>
<% if session("login") = fotoRes("autor") then %>
	<br><br>
	<font size="-1" color="white" face="arial">
	<% if autorOpcoesRes("aprovacao") = 0 then %>
		Atenção: clique na opção APAGAR para remover o comentário, sem hipótese de recuperação. Os comentários com
		a opção APROVAR só aparecerão no site depois de aprovados por si, caso contrário só o autor da foto e o
		comentador os verão. Pode aprovar todos os comentários de uma vez com a opção APROVAR TODOS OS COMENTÁRIOS.
		<br><br>
		Se preferir pode escolher a opção de mostrar aos outros membros todos os comentários ainda não aprovados, para isso
		vá a sua ficha de membro, prima ALTERAR DADOS e mude as OPÇÕES ESPECIAIS.
	<% else %>
		Atenção: clique na opção APAGAR para remover o comentário, sem hipótese de recuperação. Pode aprovar todos os
		comentários de uma vez com a opção APROVAR TODOS OS COMENTÁRIOS. 
		<br><br>
		Se preferir pode escolher a opção de esconder dos outros membros todos os comentários ainda não aprovados, para isso 
		vá a sua ficha de membro, prima ALTERAR DADOS e mude as OPÇÕES ESPECIAIS.
	<% end if %>
	</font>
<% end if %>

<% FimPagina() %>
