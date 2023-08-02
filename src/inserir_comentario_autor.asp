<%
' Copyright: (c) 1999-2023, Tiago Fonseca
' GNU General Public License v3.0+ (see LICENSE.md or https://www.gnu.org/licenses/gpl-3.0.html)
' SPDX-License-Identifier: GPL-3.0-or-later
%>

<!-- #include file="funcoes_principais.asp" -->

<%
AutenticarMembro(autor)
Menu 3, 2, "COMENTAR AUTOR"
%>

<%
autor = request("autor")
primeira = request("primeira")
tema = request("tema")

SQL = "SELECT * FROM comentario_autor WHERE autor = " & autor & " AND comentador = " & session("login")
Set comentarioRes = dbConnection.Execute(SQL)

SQL = "SELECT nome FROM autor WHERE id = " & autor
Set autorRes = dbConnection.Execute(SQL)

SQL = "SELECT nome FROM autor WHERE id = " & session("login")
Set comentadorRes = dbConnection.Execute(SQL)
%>

<font size="-1" color="white" face="arial">
<b>Nota:</b> esta &aacute;rea destina-se apenas a coment&aacute;rios ao trabalho do autor em geral
Para comentar uma foto em particular escolha essa foto e prima <b>COMENT&Aacute;RIOS</b>.
<br>
Para apagar o seu coment&aacute;rio a esta foto deixe o campo &quot;COMENT&Aacute;RIO&quot; vazio antes
de premir o bot&atilde;o.
</font>
<br><br>

<form action="inserir_comentario_autor_res.asp?autor=<% =autor %>&primeira=<% =primeira %>&tema=<% =tema %>" method=post>

<table border="0" cellpadding="3" cellspacing="0">
	<tr><td><font size="-1" color="#FFCC66" face="arial"><b>AUTOR: </b></font></td><td><font size="-1" color="white" face="arial"><% =autorRes("nome") %></font></td></tr>
	<tr><td><font size="-1" color="#FFCC66" face="arial"><b>COMENTADOR: </b></font></td><td><font size="-1" color="white" face="arial"><% =comentadorRes("nome") %></font></td></tr>
	<tr><td><br></td><td></td></tr>		
	<% if comentarioRes.eof then %>
		<tr><td valign="top"><font size="-1" color="#FFCC66" face="arial"><b>COMENT&Aacute;RIO: </b></font><font size="-1" color="white" face="arial"><br>(se escrever<br>mais do que 20<br>linhas o texto<br>ser&aacute; cortado)</font></td><td><textarea name="comentario" cols="60" rows="10" wrap="VIRTUAL"></textarea></td></tr>
	<% else %>
		<tr><td valign="top"><font size="-1" color="#FFCC66" face="arial"><b>COMENT&Aacute;RIO: </b></font><font size="-1" color="white" face="arial"><br>(se escrever<br>mais do que 20<br>linhas o texto<br>ser&aacute; cortado)</font></td><td><textarea name="comentario" cols="60" rows="20" wrap="VIRTUAL"><% =comentarioRes("comentario") %></textarea></td></tr>
	<% end if %>
	<tr><td></td><td><input type="Submit" value="Inserir, mudar ou apagar coment&aacute;rio"></td></tr>
</table>

</form>

<br>
<font size="-1" color="white" face="arial">
	<b>NOTA</b>: por favor restrinja o seu coment&aacute;rio a assuntos relacionados com fotografia.
</font><br><br>
<font size="-1" color="white" face="arial">
	O autor comentado � o principal respons�vel por moderar o conte�do dos coment�rios � sua ficha,<br>
	sendo op��o de cada membro mostrar ou n�o aos outros membros todos os coment�rios por aprovar. O autor<br>
	comentado poder� a qualquer momento remover este coment�rio se n�o o achar apropriado.
</font>

<% FimPagina() %>
