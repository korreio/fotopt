<%
' Copyright: (c) 1999-2023, Tiago Fonseca
' GNU General Public License v3.0+ (see LICENSE.md or https://www.gnu.org/licenses/gpl-3.0.html)
' SPDX-License-Identifier: GPL-3.0-or-later
%>

<!-- #include file="funcoes_principais.asp" -->

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

<%
Menu 0, 0, "HOME"
%>

<table border="0" cellpadding="0" cellspacing="0" width="100%">
<tr><td valign="top" width="100%">

<table border="0" cellpadding="5" cellspacing="8" height="100%"><tr>
<td valign="top">
	<img src="imagens/simbolo14.gif" width="339" border="0" alt="" height="114">
	<table border="0">
		<tr><td height="60"></td></tr>
		<tr>
			<td width="10"></td>
			<td align="left"><font color="silver" face="arial"><b>Arquivo do antigo site<br>dedicado &agrave; divulga&ccedil;&atilde;o<br>de trabalhos de fot&oacute;grafos,<br>amadores e profissionais,<br>de express&atilde;o portuguesa.<br></b></font></td>
		</tr>
		<tr><td height="60"></td></tr>
	</table>
	<font size="-1" color="white" face="arial">Criado a 23 Junho 1999<br>e desde ent&atilde;o j&aacute; visitado <b><% =contadorRes("visitas") %></b> vezes</font><br>
	<font size="-2" color="white" face="arial">Desenvolvido e administrado por </font><a href="autor.asp?autor=2"><font size="-2" color="white" face="arial">Tiago Fonseca</font></a>
</td>
<td valign="top" width="100%">
	<table border="0" cellpadding="0" cellspacing="5" width="160" height="170">
	<tr><td valign="middle">
		<font size="-2" color="silver" face="verdana, arial"><b><% =titulo1 %></b></font><br>
		<a href="<% =url1 %>"><img border="1" vspace="2" src="/fotos/thumbs/<% =directoria1 %>/thumbs<% =foto1Res("id") %>.jpg" alt=""></a><br>
 	</td></tr>
 	</table>

	<table border="0" cellpadding="0" cellspacing="5" width="160" height="170">
	<tr><td valign="middle">
		<font size="-2" color="silver" face="verdana, arial"><b><% =titulo2 %></b></font><br>
		<a href="<% =url2 %>"><img border="1" vspace="2" src="/fotos/thumbs/<% =directoria2 %>/thumbs<% =foto2Res("id") %>.jpg" alt=""></a><br>
 	</td></tr>
 	</table>
</td>
</tr></table>

</td>
<td align="middle" valign="top">
	<div align="right">
		<a target="_top" href="uk/"><img src="Imagens/ingles5.gif" width=19 height=95 border=0 alt="English Version"></a><br><br>
	</div>
</td>

</tr>
</table>

<% FimPagina() %>
