<%
' Copyright: (c) 1999-2023, Tiago Fonseca
' GNU General Public License v3.0+ (see LICENSE.md or https://www.gnu.org/licenses/gpl-3.0.html)
' SPDX-License-Identifier: GPL-3.0-or-later
%>

<!-- #include file="funcoes_principais.asp" -->

<%
autor = request("autor")

SQL = "SELECT nome FROM autor WHERE id = " & autor
Set autorRes = dbConnection.Execute(SQL)
%>

<%
Menu 3, 2, "LINK DIRECTO PARA FICHA PESSOAL"
%>

<form>
<font color="#ffffff" size="-1" face="Arial">
Criei esta sec&ccedil;&atilde;o para todos aqueles que t�m p&aacute;ginas e 
querem colocar um link directo para a sua ficha pessoal no foto@pt.
<br><br>
O link para aceder directamente &agrave; ficha de &quot;<% =autorRes("nome") %>&quot; &eacute;:<br>
&nbsp;&nbsp;&nbsp;<a target="_top" href="directo.asp?membro=<% =autor %>"><font color="#FFCC66"><b>http://www.fotopt.net/directo.asp?membro=<% =autor %></b></font></a>
<br><br>
O link directo para a ficha deste membro, mas na vers&atilde;o internacional do site (em ingl&ecirc;s) &eacute;:<br>
&nbsp;&nbsp;&nbsp;<a target="_top" href="uk/directo.asp?membro=<% =autor %>"><font color="#FFCC66"><b>http://www.fotopt.net/uk/directo.asp?membro=<% =autor %></b></font></a>

<br><br>
Abaixo est&atilde;o tr&ecirc;s imagens que sugiro que usem no vosso site para indicar o link:
<br><br><br>
<img src="Imagens/outros/fotopt_animado.gif" width=317 height=45 border=0 alt="">
<br><br><br>
<img src="Imagens/outros/fotopt_animado_pequeno.gif" width=150 height=30 border=0 alt="">
<br><br><br>
&nbsp;<img src="Imagens/outros/fotopt.gif" width=90 height=30 border=0 alt="">
</font>
</form>

<% FimPagina() %>
