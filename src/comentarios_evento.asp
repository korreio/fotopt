<!-- #include file="sqltext.asp" -->
<!-- #include file="funcoes_principais.asp" -->

<%
foto = request("foto")

' Dados referentes a galeria
primeira = request("primeira")
evento = request("evento")
num = request("num")

Dim meses
meses = Array("Janeiro", "Fevereiro", "Mar&ccedil;o", "Abril", "Maio", "Junho", "Julho", _
			  "Agosto", "Setembro", "Outubro", "Novembro", "Dezembro")

SQL = "SELECT * FROM eventos_fotopt_foto WHERE id = " & foto
Set fotoRes = dbConnection.Execute(SQL)

SQL = "SELECT nome FROM autor WHERE id = " & fotoRes("autor")
Set autorRes = dbConnection.Execute(SQL)

SQL = "SELECT * FROM eventos_fotopt_comentarios WHERE foto = " & foto & " ORDER BY data, id"
Set comentarioRes = dbConnection.Execute(SQL)

SQL = "SELECT count(*) AS num FROM eventos_fotopt_comentarios WHERE foto = " & foto
Set numComentariosRes = dbConnection.Execute(SQL)

directoria = int(fotoRes("id") / 1000)
%>

<%
OpcaoMenu "VOLTAR À GALERIA", "galeria_evento.asp?primeira=" & primeira & "&evento=" & evento & "&num=" & num, False, False, -1, False, False
OpcaoMenu "VER A FOTO", "foto_evento.asp?foto=" & foto & "&primeira=" & primeira & "&evento=" & evento & "&num=" & num, False, False, -1, False, False
'OpcaoMenu "INSERIR, ALTERAR OU APAGAR COMENTÁRIO", "inserir_comentario_evento.asp?foto=" & foto & "&primeira=" & primeira & "&evento=" & evento & "&num=" & num, False, True, -1, False, False
Menu 2, 4, "COMENTÁRIOS"
%>

<table border="0" cellpadding="0" cellspacing="10">
<tr>
<td>
	<a href="foto_evento.asp?foto=<% =foto %>&primeira=<% =primeira %>&evento=<% =evento %>&num=<% =num %>">
		<img src="/fotos/arquivo/eventos_fotopt/thumbs/<% =directoria %>/thumbs<% =fotoRes("id") %>.jpg" border="1" alt=""></a>
</td>
<td>
	<table border="0" cellpadding="2" cellspacing="0">
		<tr><td><font size="-1" color="#FFCC66" face="arial"><b>ID: </b></font></td><td><font size="-1" color="white" face="arial"><% =fotoRes("id") %></font></td></tr>
		<% if fotoRes("titulo") <> "" then %>
			<tr><td><font size="-1" color="#FFCC66" face="arial"><b>T&Iacute;TULO: </b></font></td><td><font size="-1" color="white" face="arial"><% =fotoRes("titulo") %></font></td></tr>
		<% else %>
			<tr><td><font size="-1" color="#FFCC66" face="arial"><b>T&Iacute;TULO: </b></font></td><td><font size="-1" color="white" face="arial"><i>sem t&iacute;tulo</i></font></td></tr>		
		<% end if %>
		<tr><td><font size="-1" color="#FFCC66" face="arial"><b>AUTOR: </b></font></td><td><a href="autor.asp?autor=<% =fotoRes("autor") %>"><font size="-1" color="white" face="arial"><% =autorRes("nome") %></font></a></td></tr>
		<tr><td><font size="-1" color="#FFCC66" face="arial"><b>DATA INTR: </b></font></td><td><font size="-1" color="white" face="arial"><% =day(fotoRes("data")) %>/<% =month(fotoRes("data")) %>/<% =year(fotoRes("data")) %></font></td></tr>
		<tr>
			<td><font size="-1" color="#FFCC66" face="arial"><b>N&#186; COMENT: </b></font></td>
			<td><font size="-1" color="white" face="arial"><% =numComentariosRes("num") %></font></td>
		</tr>
	</table>
</td>
</tr>
</table>

<br>
<table border="1" cellpadding="4" cellspacing="0" bordercolor="gray">
<tr align="left">
	<td><font size="-1" color="#FFCC66" face="arial"><b>COMENT&Aacute;RIO</b></font></td>
	<td><font size="-1" color="#FFCC66" face="arial"><b>COMENTADOR</b></font></td>
	<td><font size="-1" color="#FFCC66" face="arial"><b>DATA</b></font></td>
	<% if session("login") = 2 then %>	
		<td><font size="-1" color="#FFCC66" face="arial"><b>ADM</b></font></td>
	<% end if %>
</tr>
<% 
do while not comentarioRes.eof
	SQL = "SELECT nome FROM autor WHERE id = " & comentarioRes("autor")
	Set comentadorRes = dbConnection.Execute(SQL)
%>
	<tr>
		<td valign="top"><p align="left"><font size="-1" color="white" face="arial"><% =Enter2Br(comentarioRes("comentario")) %></font></p></td>
		<td valign="top"><a href="autor.asp?autor=<% =comentarioRes("autor") %>"><font size="-2" color="silver" face="arial"><% =comentadorRes("nome") %></font></a></td>
		<td valign="top" align="center"><font size="-2" color="silver" face="arial"><% =day(comentarioRes("data")) %>/<% =month(comentarioRes("data")) %>/<% =right(year(comentarioRes("data")),2) %></font></td>
		<% if session("login") = 2 then %>	
			<td align="center"><a href="adm/adm_del_coment_evento.asp?comentario=<% =comentarioRes("id") %>&foto=<% =foto %>&primeira=<% =primeira %>&evento=<% =evento %>&num=<% =num %>"><font size="-1" color="red" face="arial"><b>A</b></font></a></td>
		<% end if %>
	</tr>
	<% comentarioRes.MoveNext %>
<% Loop %>
</table>

<% FimPagina() %>
