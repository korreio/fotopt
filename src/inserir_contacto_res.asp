<%
' Copyright: (c) 1999-2023, Tiago Fonseca
' GNU General Public License v3.0+ (see LICENSE.md or https://www.gnu.org/licenses/gpl-3.0.html)
' SPDX-License-Identifier: GPL-3.0-or-later
%>

<!-- #include file="sqltext.asp" -->
<!-- #include file="funcoes_principais.asp" -->

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
if homepage = "http://" then 
	homepage = "" 
end if

if nome = "" then
	Menu 6, 4, "INSERIR CONTACTO"
%>
	<font size="+1" color="white" face="arial">Os campo <b>nome empresa</b> &eacute; obrigat&oacute;rio</font>
	<br>
	<font size="+1" color="white" face="arial">prima o bot&atilde;o <b>back</b> no browser e complete a informa&ccedil;&atilde;o</font>	
<%
elseif (telefone = "") and (fax = "") and (morada = "") and (email = "") and (homepage = "") then
	Menu 6, 4, "INSERIR CONTACTO"
%>
	<font size="+1" color="white" face="arial">Tem que preencher pelo menos um dos campos: <b>email</b>, <b>homepage</b>, <b>telefone</b>, <b>fax</b> ou <b>morada</b>.</font>
	<br>
	<font size="+1" color="white" face="arial">prima o bot&atilde;o <b>back</b> no browser e complete a informa&ccedil;&atilde;o</font>	
<%
else
	SQL = "INSERT INTO contactos (nome, tipo, telefone, fax, email, morada, representante, oferta, outros, homepage, autor, data)"
	SQL = SQL & " VALUES ('" & nome & "','" & tipo & "','" & telefone & "','" & fax & "','" & email & "','" & morada
	SQL = SQL & "','" & representante & "','" & oferta & "','" & outros & "','" & homepage & "','" & session("login") & "','" & date() & " " & time() & "')"
	dbConnection.Execute(SQL)

	SQL = "SELECT id FROM contactos WHERE autor = " & session("login") & " ORDER BY id DESC"
	Set contactoRes = dbConnection.Execute(SQL)

	ComRefresh "ver_contacto.asp?contacto=" & contactoRes("id")
	Menu 6, 4, "INSERIR CONTACTO"
%>
	<font size="+1" color="white" face="arial"><b>Contacto inserido com sucesso</b></font>
<% end if %>

<% FimPagina() %>
