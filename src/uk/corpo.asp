<!-- #include file="inicio_basedados.asp" -->
<!-- #include file="topo.asp" --></tr></table>

<%
Randomize
minimoVisitas = 100
dataMinima = date() - 10

' Visitas
SQL = "SELECT visitas FROM contador WHERE tipo = 1"
Set contadorRes = dbConnection.Execute(SQL)

' Fotos com mais de 100, nao nus, aprovadas e mais de n dias
SQL = "SELECT count(*) AS num FROM foto WHERE contador >= " & minimoVisitas & " AND assunto <> 4 AND moderar = False AND data <= #" & dataMinima & "#"
Set numFotoRes = dbConnection.Execute(SQL)

random1 = Int((numFotoRes("num") - 1) * Rnd)
random2 = Int((numFotoRes("num") - 2) * Rnd)

SQL = "SELECT TOP " & random1 & " id, autor FROM foto WHERE contador >= " & minimoVisitas & " AND assunto <> 4 AND moderar = False AND data <= #" & dataMinima & "#"
Set foto1Res = dbConnection.Execute(SQL)
for i = 1 to random1 - 1
	foto1Res.MoveNext 
next
SQL = "SELECT TOP " & random2 & " id, autor FROM foto WHERE contador >= " & minimoVisitas & " AND assunto <> 4 AND moderar = False AND data <= #" & dataMinima & "# AND id <> " & foto1Res("id")
Set foto2Res = dbConnection.Execute(SQL)
for i = 1 to random2 - 1
	foto2Res.MoveNext 
next

SQL = "SELECT nome FROM autor WHERE id = " & foto1Res("autor")
Set autor1Res = dbConnection.Execute(SQL)
SQL = "SELECT nome FROM autor WHERE id = " & foto2Res("autor")
Set autor2Res = dbConnection.Execute(SQL)

titulo1 = autor1Res("nome")
url1 = "foto.asp?foto=" & foto1Res("id")
directoria1 = int(foto1Res("id") / 1000)

titulo2 = autor2Res("nome")
url2 = "foto.asp?foto=" & foto2Res("id")
directoria2 = int(foto2Res("id") / 1000)
%>

<div align="left">
<table border="0" cellpadding="0" cellspacing="0" width="100%">
<tr><td valign="top" width="100%">

<table border="0" cellpadding="0" cellspacing="8">
<tr>
<td valign="top">
	<img src="../Imagens/en_simbolo9.gif" width="339" height="114" border="0" alt="">
	<table border="0">
		<tr><td height="50"></td></tr>
		<tr>
			<td width="10"></td>
			<td align="left">
				<font color="silver" face="arial"><b>Exhibiting works<br>by portuguese speaking,<br>both amateur and professional,<br>photographers.</b></font>
			</td>
		</tr>
		<tr><td height="50"></td></tr>
	</table>
	<font size="-1" color="white" face="arial">Created on the 23rd June 1999<br>and since then visited <b><a href="estatisticas.asp"><% =contadorRes("visitas") %></a></b> times</font><br>
	<font size="-2" color="white" face="arial">Development and maintenance by </font><a href="mailto:info@fotopt.net"><font size="-2" color="white" face="arial">Tiago Fonseca</font></a>
</td>
<td valign="top" width="100%">
	<table border="0" cellpadding="0" cellspacing="5" width="160" height="170">
	<tr><td valign="middle">
		<font size="-2" color="silver" face="verdana, arial"><b><% =titulo1 %></b></font><br>
		<a href="foto.asp?foto=<% =foto1Res("id") %>"><img border="1" vspace="2" src="/fotos/thumbs/<% =directoria1 %>/thumbs<% =foto1Res("id") %>.jpg" alt=""></a><br>
 	</td></tr>
 	</table>

	<table border="0" cellpadding="0" cellspacing="5" width="160" height="170">
	<tr><td valign="middle">
		<font size="-2" color="silver" face="verdana, arial"><b><% =titulo2 %></b></font><br>
		<a href="foto.asp?foto=<% =foto2Res("id") %>"><img border="1" vspace="2" src="/fotos/thumbs/<% =directoria2 %>/thumbs<% =foto2Res("id") %>.jpg" alt=""></a><br>
 	</td></tr>
 	</table>
</td>

</tr>
</table>

</td>
<td align="right" valign="top">
	<div align="center">
		<a target="_top" href="../"><img src="../Imagens/portugues.gif" width=19 height=125 border=0 alt="Versão Portuguesa"></a>
		<br>
	</div>
</td>

</tr>
</table>
</div>

<!-- #include file="fim.asp" -->
<!-- #include file="fim_basedados.asp" -->