<%
' Copyright: (c) 1999-2023, Tiago Fonseca
' GNU General Public License v3.0+ (see LICENSE.md or https://www.gnu.org/licenses/gpl-3.0.html)
' SPDX-License-Identifier: GPL-3.0-or-later
%>

<!-- #include file="sqltext.asp" -->
<!-- #include file="funcoes_principais.asp" -->

<%
contactoid = request("contactoid")

SQL = "SELECT * FROM contactos WHERE id = " & contactoid
Set contactoRes = dbConnection.Execute(SQL)

autor = contactoRes("autor")
%>

<% AutenticarMembro(autor) %>

<%
nome = SqlText(request("nome"))
tipo = request("tipo")
telefone = SqlText(request("telefone"))
fax = SqlText(request("fax"))
email = SqlText(request("email"))
homepage = SqlText(request("homepage"))
morada = SqlText(request("morada"))
representante = SqlText(request("representante"))
oferta = SqlText(request("oferta"))
outros = SqlText(request("outros"))

if nome = "" then
	Menu 6, 4, "MUDAR CONTACTO"
%>
	<font size="+1" color="white" face="arial">O campo <b>nome empresa</b> &eacute; obrigat&oacute;rio</font>
	<br>
	<font size="+1" color="white" face="arial">prima o bot&atilde;o <b>back</b> no browser e complete a informa&ccedil;&atilde;o</font>	
<%
elseif (telefone = "") and (fax = "") and (morada = "") and (email = "") and (homepage = "") then
	Menu 6, 4, "MUDAR CONTACTO"
%>
	<font size="+1" color="white" face="arial">Tem que preencher pelo menos um dos campos: <b>email</b>, <b>homepage</b>, <b>telefone</b>, <b>fax</b> ou <b>morada</b>.</font>
	<br>
	<font size="+1" color="white" face="arial">prima o bot&atilde;o <b>back</b> no browser e complete a informa&ccedil;&atilde;o</font>	
<%
else
	SQL = "UPDATE contactos SET "
	SQL = SQL & "nome = '" & nome & "',"
	SQL = SQL & "tipo = '" & tipo & "',"	
	SQL = SQL & "telefone = '" & telefone & "',"	
	SQL = SQL & "fax = '" & fax & "',"
	SQL = SQL & "email = '" & email & "',"
	SQL = SQL & "homepage = '" & homepage & "',"
	SQL = SQL & "morada = '" & morada & "',"
	SQL = SQL & "oferta = '" & oferta & "',"
	SQL = SQL & "outros = '" & outros & "',"
	SQL = SQL & "representante = '" & representante & "' "
	SQL = SQL & "WHERE id = " & contactoid
	dbConnection.Execute(SQL)

	ComRefresh "ver_contacto.asp?contacto=" & contactoid
	Menu 6, 4, "MUDAR CONTACTO"
%>
	<font size="+1" color="white" face="arial"><b>Contacto modificado com sucesso</b></font>
<% end if %>

<% FimPagina() %>
