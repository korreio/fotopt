<!-- #include file="funcoes_principais.asp" -->

<%
OpcaoMenu "GALERIA COMPLETA", "galeria.asp?tipo=assunto&id=22", False, True, -1, False, False
OpcaoMenu "VER CRÓNICAS", "cronicas.asp?tipo=22", False, True, -1, False, False
Menu 1, 7, "MOMENTOS HISTÓRICOS"
%>

<%
SQL = "SELECT TOP 4 titulo, id, data_foto, data_tipo FROM foto WHERE assunto = 22 ORDER BY id DESC"
Set fotoRes = dbConnection.Execute(SQL)

Dim meses
meses = Array("Janeiro", "Fevereiro", "Mar&ccedil;o", "Abril", "Maio", "Junho", "Julho", _
			  "Agosto", "Setembro", "Outubro", "Novembro", "Dezembro")
%>

<table border="0" cellpadding="0" cellspacing="0" width="100%"><tr>
<td valign="top" align="left" width="170">
	<table border="0" cellpadding="0" cellspacing="0">
	<tr><td height="180" valign="top">
		<a href="foto.asp?foto=<% =fotoRes("id") %>"><img border="1" vspace="2" src="/fotos/thumbs/<% =int(fotoRes("id") / 1000) %>/thumbs<% =fotoRes("id") %>.jpg" alt=""></a><br>
		<% if fotoRes("titulo") <> "" then %>
			<font size="-2" color="#ffcc66" face="verdana, arial"><b><% =fotoRes("titulo") %></b></font><br>
		<% else %>
			<font size="-2" color="#ffcc66" face="verdana, arial"><b><i>sem t&iacute;tulo</i></b></font><br>
		<% end if %>
		<% fotoRes.MoveNext %>
 	</td></tr>
	<tr><td height="180" valign="bottom">
		<% if fotoRes("titulo") <> "" then %>
			<font size="-2" color="#ffcc66" face="verdana, arial"><b><% =fotoRes("titulo") %></b></font><br>
		<% else %>
			<font size="-2" color="#ffcc66" face="verdana, arial"><b><i>sem t&iacute;tulo</i></b></font><br>
		<% end if %>
		<a href="foto.asp?foto=<% =fotoRes("id") %>"><img border="1" vspace="2" src="/fotos/thumbs/<% =int(fotoRes("id") / 1000) %>/thumbs<% =fotoRes("id") %>.jpg" alt=""></a><br>
		<% fotoRes.MoveNext %>
 	</td></tr>
	</table>
</td>

<td valign="middle" align="center">
	<font color="silver" face="arial"><b>Sec&ccedil;&atilde;o especialmente<br>dedicada a todas aquelas<br>fotografias que registaram<br>um momento hist&oacute;rico<br>para sempre.</b></font>
	<br><br><br><br>
	<a href="galeria.asp?tipo=assunto&id=22"><font size="+1" color="silver" face="arial"><b>MOMENTOS<br>HIST&Oacute;RICOS</b></font><br></a>
	<font color="silver" face="arial"><b>no</b></font><br>	
	<img src="Imagens/simbolo_pequeno_1.gif" width=72 height=19 border=0 alt="">
	
	<br><br><br><br>
	<font size="-1" color="silver" face="arial">
	Tem fotografias de acontecimentos que ficaram<br>
	para a hist&oacute;ria? E cr&oacute;nicas relacionadas com as<br>
	imagens aqui guardadas? Insira-as nesta	sec&ccedil;&atilde;o
	<br>especial, onde estar&atilde;o sempre em destaque.
	</font>
</td>

<td valign="top" align="right" width="170">
	<table border="0" cellpadding="0" cellspacing="0">
	<tr><td height="180" valign="top" align="right">
		<a href="foto.asp?foto=<% =fotoRes("id") %>"><img border="1" vspace="2" src="/fotos/thumbs/<% =int(fotoRes("id") / 1000) %>/thumbs<% =fotoRes("id") %>.jpg" alt=""></a><br>
		<% if fotoRes("titulo") <> "" then %>
			<font size="-2" color="#ffcc66" face="verdana, arial"><b><% =fotoRes("titulo") %></b></font><br>
		<% else %>
			<font size="-2" color="#ffcc66" face="verdana, arial"><b><i>sem t&iacute;tulo</i></b></font><br>
		<% end if %>
		<% fotoRes.MoveNext %>
 	</td></tr>
	<tr><td height="180" valign="bottom" align="right">
		<% if fotoRes("titulo") <> "" then %>
			<font size="-2" color="#ffcc66" face="verdana, arial"><b><% =fotoRes("titulo") %></b></font><br>
		<% else %>
			<font size="-2" color="#ffcc66" face="verdana, arial"><b><i>sem t&iacute;tulo</i></b></font><br>
		<% end if %>
		<a href="foto.asp?foto=<% =fotoRes("id") %>"><img border="1" vspace="2" src="/fotos/thumbs/<% =int(fotoRes("id") / 1000) %>/thumbs<% =fotoRes("id") %>.jpg" alt=""></a><br>
 	</td></tr>
	</table>
</td>
</tr></table>

<% FimPagina() %>
