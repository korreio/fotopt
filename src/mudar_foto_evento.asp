<%
' Copyright: (c) 1999-2023, Tiago Fonseca
' GNU General Public License v3.0+ (see LICENSE.md or https://www.gnu.org/licenses/gpl-3.0.html)
' SPDX-License-Identifier: GPL-3.0-or-later
%>

<!-- #include file="sqltext.asp" -->
<!-- #include file="funcoes_principais.asp" -->

<%
foto = request("foto")

' Dados referentes a galeria
primeira = request("primeira")
evento = request("evento")
num = request("num")

SQL = "SELECT * FROM eventos_fotopt_foto WHERE id = " & foto
Set fotoRes = dbConnection.Execute(SQL)

autor = fotoRes("autor")

SQL = "SELECT nome FROM autor WHERE id = " & autor
Set autorRes = dbConnection.Execute(SQL)

Dim meses
meses = Array("JANEIRO", "FEVEREIRO", "MAR&Ccedil;O", "ABRIL", "MAIO", "JUNHO", _
			  "JULHO", "AGOSTO", "SETEMBRO", "OUTUBRO", "NOVEMBRO", "DEZEMBRO")
%>

<% 
AutenticarMembro(autor)
Menu 2, 4, "ALTERAR OU APAGAR FOTO DE EVENTO"
%>

<form method="post" action="mudar_foto_evento_res.asp?foto=<% =foto %>&primeira=<% =primeira %>&evento=<% =evento %>&num=<% =num %>">

<table border="0" cellpadding="3" cellspacing="0">
	<tr><td><font size="-1" color="#FFCC66" face="arial"><b>T&Iacute;TULO: </b></font></td><td><input maxlength="50" value="<% =Aspas2Quot(fotoRes("titulo")) %>" size="40" type="text" name="titulo"></td></tr>
	<tr><td><font size="-1" color="#FFCC66" face="arial"><b>DESCRI&Ccedil;&Atilde;O: </b></font><font size="-1" color="white" face="arial"><br>(se ultrapassar<br>estas 6 linhas<br>o texto ser&aacute;<br>cortado)</font></td><td><textarea name="descricao" cols="38" rows="6" wrap="VIRTUAL"><% =fotoRes("descricao") %></textarea></td></tr>
	<tr><td></td><td><input type="Submit" value="Mudar dados">&nbsp;&nbsp;<input type="Reset"></td></tr>
</table>
</form>

<form method="post" action="apagar_foto_evento_res.asp?foto=<% =foto %>&evento=<% =evento %>">
	<font color="#FFCC66" face="arial"><b>Para apagar esta foto confirme aqui <input type="Checkbox" name="apagar"> e prima o bot&atilde;o - </b></font><input type="Submit" value="Apagar">
</form>

<% FimPagina() %>
