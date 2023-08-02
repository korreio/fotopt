<%
' Copyright: (c) 1999-2023, Tiago Fonseca
' GNU General Public License v3.0+ (see LICENSE.md or https://www.gnu.org/licenses/gpl-3.0.html)
' SPDX-License-Identifier: GPL-3.0-or-later
%>

<!-- #include file="funcoes_principais.asp" -->

<%
foto = request("foto")
onde = request("onde")

' Dados referentes a galeria
primeira = request("primeira")
tipo = request("tipo")
id = request("id")
tema = request("tema")
num = request("num")

SQL = "SELECT * FROM comentario WHERE foto = " & foto & " AND autor = " & session("login")
Set comentarioRes = dbConnection.Execute(SQL)

SQL = "SELECT * FROM foto WHERE id = " & foto
Set fotoRes = dbConnection.Execute(SQL)

SQL = "SELECT nome FROM autor WHERE id = " & fotoRes("autor")
Set autorRes = dbConnection.Execute(SQL)

SQL = "SELECT nome FROM autor WHERE id = " & session("login")
Set comentadorRes = dbConnection.Execute(SQL)

directoria = int(fotoRes("id") / 1000)
%>

<% 
AutenticarMembro(autor)
Menu 1, GaleriaSubSeccao(tipo, id), "INSERIR, ALTERAR OU APAGAR COMENT�RIO"
%>

<form action="inserir_comentario_res.asp?onde=<% =onde %>&foto=<% =foto %>&primeira=<% =primeira %>&tema=<% =tema %>&tipo=<% =tipo %>&id=<% =id %>&num=<% =num %>" method=post>

<table border="0" cellpadding="3" cellspacing="0">
	<tr>
	<td><a href="foto.asp?foto=<% =foto %>&primeira=<% =primeira %>&tema=<% =tema %>&tipo=<% =tipo %>&id=<% =id %>&num=<% =num %>">
		<img border="1" src="/fotos/thumbs/<% =directoria %>/thumbs<% =fotoRes("id") %>.jpg" alt=""></a>	</td>
	<td>
	<table border="0" cellpadding="3" cellspacing="0">
		<tr><td><font size="-1" color="#FFCC66" face="arial"><b>ID: </b></font></td><td><font size="-1" color="white" face="arial"><% =fotoRes("id") %></font></td></tr>
		<% if fotoRes("titulo") <> "" then %>
			<tr><td><font size="-1" color="#FFCC66" face="arial"><b>T&Iacute;TULO: </b></font></td><td><font size="-1" color="white" face="arial"><% =fotoRes("titulo") %></font></td></tr>
		<% else %>
			<tr><td><font size="-1" color="#FFCC66" face="arial"><b>T&Iacute;TULO: </b></font></td><td><font size="-1" color="white" face="arial"><i>sem t&iacute;tulo</i></font></td></tr>	
		<% end if %>
		<% if (fotoRes("anonima") <> 0) and (fotoRes("data") > (cdate(date() & " " & time()) - 7)) then %>
			<% if session("login") = 2 then %>
				<tr><td><font size="-1" color="#FFCC66" face="arial"><b>AUTOR: </b></font></td><td><font size="-1" color="red" face="arial"><% =autorRes("nome") %></font></td></tr>
			<% else %>
				<tr><td><font size="-1" color="#FFCC66" face="arial"><b>AUTOR: </b></font></td><td><font color="white" size="-1" face="arial"><i>an�nimo</i> (at� <% =day(fotoRes("data") + 7) & "/" & month(fotoRes("data") + 7) & "/" & year(fotoRes("data") + 7) & " �s " & hour(fotoRes("data") + 7) & ":" & minute(fotoRes("data") + 7) %>)</font></td></tr>
			<% end if %>
		<% else %>
			<tr><td><font size="-1" color="#FFCC66" face="arial"><b>AUTOR: </b></font></td><td><font size="-1" color="white" face="arial"><% =autorRes("nome") %></font></td></tr>
		<% end if %>
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
</font><br>
<font size="-1" color="white" face="arial">
	O autor da foto � o principal respons�vel por moderar o conte�do dos seus coment�rios,<br>
	sendo op��o de cada membro mostrar ou n�o aos outros membros todos os coment�rios por aprovar. O autor<br>
	comentado poder� a qualquer momento remover este coment�rio se n�o o achar apropriado.
</font>

</form>

<% FimPagina() %>
