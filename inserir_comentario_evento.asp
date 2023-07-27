<!-- #include file="funcoes_principais.asp" -->

<%
foto = request("foto")
onde = request("onde")

' Dados referentes a galeria
primeira = request("primeira")
evento = request("evento")
num = request("num")

SQL = "SELECT * FROM eventos_fotopt_comentarios WHERE foto = " & foto & " AND autor = " & session("login")
Set comentarioRes = dbConnection.Execute(SQL)

SQL = "SELECT id, titulo, autor FROM eventos_fotopt_foto WHERE id = " & foto
Set fotoRes = dbConnection.Execute(SQL)

SQL = "SELECT nome FROM autor WHERE id = " & fotoRes("autor")
Set autorRes = dbConnection.Execute(SQL)

SQL = "SELECT nome FROM autor WHERE id = " & session("login")
Set comentadorRes = dbConnection.Execute(SQL)

directoria = int(fotoRes("id") / 1000)
%>

<% 
AutenticarMembro(autor)
Menu 2, 4, "INSERIR, ALTERAR OU APAGAR COMENT�RIO"
%>

<form action="inserir_comentario_evento_res.asp?onde=<% =onde %>&foto=<% =foto %>&primeira=<% =primeira %>&evento=<% =evento %>&num=<% =num %>" method=post>

<table border="0" cellpadding="3" cellspacing="0">
	<tr>
	<td><a href="foto_evento.asp?foto=<% =foto %>&primeira=<% =primeira %>&evento=<% =evento %>&num=<% =num %>">
		<img border="1" src="/fotos/arquivo/eventos_fotopt/thumbs/<% =directoria %>/thumbs<% =fotoRes("id") %>.jpg" alt=""></a>	</td>
	<td>
	<table border="0" cellpadding="3" cellspacing="0">
		<tr><td><font size="-1" color="#FFCC66" face="arial"><b>ID: </b></font></td><td><font size="-1" color="white" face="arial"><% =fotoRes("id") %></font></td></tr>
		<% if fotoRes("titulo") <> "" then %>
			<tr><td><font size="-1" color="#FFCC66" face="arial"><b>T&Iacute;TULO: </b></font></td><td><font size="-1" color="white" face="arial"><% =fotoRes("titulo") %></font></td></tr>
		<% else %>
			<tr><td><font size="-1" color="#FFCC66" face="arial"><b>T&Iacute;TULO: </b></font></td><td><font size="-1" color="white" face="arial"><i>sem t&iacute;tulo</i></font></td></tr>	
		<% end if %>
		<tr><td><font size="-1" color="#FFCC66" face="arial"><b>AUTOR: </b></font></td><td><font size="-1" color="white" face="arial"><% =autorRes("nome") %></font></td></tr>
		<tr><td><font size="-1" color="#FFCC66" face="arial"><b>COMENTADOR: </b></font></td><td><font size="-1" color="white" face="arial"><% =comentadorRes("nome") %></font></td></tr>
	</table>
	</td></tr>
</table>

<br>
<table border="0" cellpadding="3" cellspacing="0">
	<% if comentarioRes.eof then %>
		<tr><td valign="top"><font size="-1" color="#FFCC66" face="arial"><b>COMENT&Aacute;RIO: </b></font><font size="-1" color="white" face="arial"><br>(se escrever<br>mais do que 20<br>linhas o texto<br>ser&aacute; cortado)</font></td><td><textarea name="comentario" cols="60" rows="10" wrap="VIRTUAL"></textarea></td></tr>
	<% else %>
		<tr><td valign="top"><font size="-1" color="#FFCC66" face="arial"><b>COMENT&Aacute;RIO: </b></font><font size="-1" color="white" face="arial"><br>(se escrever<br>mais do que 20<br>linhas o texto<br>ser&aacute; cortado)</font></td><td><textarea name="comentario" cols="60" rows="10" wrap="VIRTUAL"><% =comentarioRes("comentario") %></textarea></td></tr>
	<% end if %>
	<tr><td></td><td><input type="Submit" value="Inserir, mudar ou apagar coment&aacute;rio"></td></tr>
</table>

<br>
<font size="-1" color="#FFCC66" face="arial">
	<b>Nota</b>: para apagar o seu coment&aacute;rio a esta foto deixe o campo &quot;COMENT&Aacute;RIO&quot; vazio antes de premir o bot&atilde;o.
</font><br>
<font size="-1" color="white" face="arial">
	Por favor restrinja o seu coment&aacute;rio a assuntos e opini&otilde;es relacionados com a fotografia em quest&atilde;o.<br>
</font>

</form>

<% FimPagina() %>
