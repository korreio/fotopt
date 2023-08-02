<%
' Copyright: (c) 1999-2023, Tiago Fonseca
' GNU General Public License v3.0+ (see LICENSE.md or https://www.gnu.org/licenses/gpl-3.0.html)
' SPDX-License-Identifier: GPL-3.0-or-later
%>

<!-- #include file="funcoes_principais.asp" -->

<% 
OpcaoMenu "VER A MINHA FICHA DE MEMBRO", "autor.asp?autor=" & session("login"), False, True, -1, False, False
Menu 3, 2, "MEMBROS" 
%>

<%
SQL = "SELECT count(*) AS num FROM autor"
Set autorRes = dbConnection.Execute(SQL)

Dim letra
letra = Array("A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z")
%>

<font size="-1" color="white" face="arial">Actualmente existem <b><% =autorRes("num") %></b> membros, para ver e alterar
informa&ccedil;&otilde;es referentes<br> a um membro navegue at� a sua ficha usando as op��es abaixo:</font><br><br>

<table cellpadding="10" cellspacing="0" border="1">
<tr><td>
	<font color="white" face="arial"><b>MEMBROS COM NOME COME�ADO COM:</b></font><br><br>
	<% for i = 0 to 25 %>
		<a href="ver_membros.asp?letra=<% =letra(i) %>"><font color="#FFCC66" face="verdana, arial"><b><% =letra(i) %></b></font></a>
	<% next %>
</td></tr>
<tr><td>
	<font color="white" face="arial"><b>VER TODOS OS MEMBROS:</b></font><br>
	<a href="membros_pais.asp"><font size="-2" color="#FFCC66" face="verdana, arial"><b>DIVIDIDOS POR PA&Iacute;S</b></font></a><br>
	<a href="ver_membros.asp?tipo=com_fotos"><font size="-2" color="#FFCC66" face="verdana, arial"><b>COM FOTOS</b></font></a><br>
	<a href="ver_membros.asp?tipo=com_comentarios"><font size="-2" color="#FFCC66" face="verdana, arial"><b>COMENTADOS</b></font></a><br>
</tr></td>
<tr><td>
	<font color="white" face="arial"><b>PROCURAR MEMBROS:</b></font><br>
	<table border="0" cellpadding="4" cellspacing="0">
	<form action="ver_membros.asp?busca=1" method="post">
		<tr><td><font size="-1" color="#FFCC66" face="arial"><b>ID: </b></font></td><td><input maxlength="50" size="6" type="text" name="id"></td></tr>
		<tr><td><font size="-1" color="#FFCC66" face="arial"><b>NOME: </b></font></td><td><input maxlength="50" size="40" type="text" name="nome"></td></tr>
		<tr><td><font size="-1" color="#FFCC66" face="arial"><b>E-MAIL: </b></font></td><td><input maxlength="50" size="40" type="text" name="email"></td></tr>
		<tr><td></td><td><input type="Submit" value="Procurar"></td></tr>
	</form>
	</table>
	<br><br>
	<a href="procurar_membros.asp"><font size="-1" color="#FFCC66" face="verdana, arial"><b>BUSCA AVAN�ADA</b></font></a>
	&nbsp;<font size="-2" color="silver" face="verdana, arial">(com regi�es e profiss�es)</font><br>
</td></tr>
</table>

<% FimPagina() %>
