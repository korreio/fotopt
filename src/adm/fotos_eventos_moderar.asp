<!-- #include file="inicio_basedados.asp" -->
<% Server.ScriptTimeOut = 999999 %>
<!-- #include file="autenticar_webmaster.asp" -->
<!-- #include file="../sqltext.asp" -->

<html>
<head>
  <title>Administra&ccedil;&atilde;o do foto@pt</title>
</head>
<body>

<a href="fotos_eventos_moderar_res.asp?trocar_todas=1">APROVAR TODAS</a>&nbsp;&nbsp;&nbsp;
<a href="fotos_eventos_moderar_res.asp?apagar_todas=1">APAGAR TODAS</a>&nbsp;&nbsp;&nbsp;
<form action="fotos_eventos_moderar_res.asp" method="post">
<input type="submit" value="Aprovar fotos"><br><br>

POR MODERAR:<br>
<table cellpadding="2" cellspacing="0" border="1">
	<tr>
		<td>ID</td>
		<td>SIM</td>
		<td>DEL</td>
		<td>AUTOR</td>
		<td>FOTO</td>
	</tr>
<%
SQL = "SELECT * FROM eventos_fotopt_foto WHERE moderar = true ORDER BY id"
Set fotoRes = dbConnection.Execute(SQL)

do while not fotoRes.eof
	SQL = "SELECT * FROM autor WHERE id = " & fotoRes("autor")
	Set autorRes = dbConnection.Execute(SQL)

	directoria = int(fotoRes("id") / 1000)
%>
	<tr>
		<td><% =fotoRes("id") %></td>
		<td><input type="checkbox" name="trocar<% =fotoRes("id") %>" value="on"></td>
		<td><input type="checkbox" name="remover<% =fotoRes("id") %>" value="on"></td>
		<td><a href="../autor.asp?autor=<% =autorRes("id") %>"><% =autorRes("nome") %></a></td>
		<td><a href="../foto_evento.asp?evento=<% =fotoRes("evento_fotopt") %>&foto=<% =fotoRes("id") %>"><img src="/fotos/arquivo/eventos_fotopt/thumbs/<% =directoria %>/thumbs<% =fotoRes("id") %>.jpg" border=0 alt=""></a></td>
	</tr>
<%
	fotoRes.MoveNext
loop
%>
</table>

</form>
</body>
</html>

<% end if %>
<!-- #include file="fim_basedados.asp" -->