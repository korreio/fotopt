<%
' Copyright: (c) 1999-2023, Tiago Fonseca
' GNU General Public License v3.0+ (see LICENSE.md or https://www.gnu.org/licenses/gpl-3.0.html)
' SPDX-License-Identifier: GPL-3.0-or-later
%>

<!-- #include file="sqltext.asp" -->
<!-- #include file="funcoes_principais.asp" -->

<%
ordem = request("ordem")
tipo = clng(request("tipo"))
marca = SqlText(request("marca"))
modelo = SqlText(request("modelo"))
descricao = SqlText(request("descricao"))

if (tipo = 41) or (tipo = 42) then
	modelo = "-1"
end if
%>

<% AutenticarMembro(autor) %>

<%
if (marca = "") or (modelo = "") or (modelo = "http://") then
	Menu 7, 3, "INSERIR ITEM PARA OPINI�O"
%>
<% if tipo = 33 then %>
	<font size="+1" color="white" face="arial">Os campos <b>nome</b> e <b>localidade</b> s&atilde;o obrigat&oacute;rios</font>
<% elseif tipo = 34 then %>
	<font size="+1" color="white" face="arial">Os campos <b>nome</b> e <b>localidade</b> s&atilde;o obrigat&oacute;rios</font>
<% elseif tipo = 35 then %>
	<font size="+1" color="white" face="arial">Os campos <b>nome</b> e <b>link</b> s&atilde;o obrigat&oacute;rios</font>
<% elseif tipo = 40 then %>
	<font size="+1" color="white" face="arial">Os campos <b>nome</b> e <b>autor</b> s&atilde;o obrigat&oacute;rios</font>
<% elseif tipo = 41 then %>
	<font size="+1" color="white" face="arial">O campo <b>nome</b> &eacute; obrigat&oacute;rio</font>
<% elseif tipo = 42 then %>
	<font size="+1" color="white" face="arial">O campo <b>nome</b> &eacute; obrigat&oacute;rio</font>
<% else %>	
	<font size="+1" color="white" face="arial">Os campos <b>marca</b> e <b>modelo</b> s&atilde;o obrigat&oacute;rios</font>
<% end if %>
	<br>
	<font size="+1" color="white" face="arial">prima o botao <b>back</b> no browser e complete a informa&ccedil;&atilde;o</font>	
<%
else
	SQL = "INSERT INTO opiniao_artigo (marca, modelo, descricao, soma_opinioes, num_opinioes, media_opinioes, autor, data, tipo)"
	SQL = SQL & " VALUES ('" & marca & "','" & modelo & "','" & descricao & "','" & 0 & "','" & 0 & "','" & 0
	SQL = SQL & "','" & session("login") & "','" & date() & " " & time() & "','" & tipo & "')"
	dbConnection.Execute(SQL)

	ComRefresh "opiniao_tipo.asp?ordem=" & ordem & "&tipo=" & tipo
	Menu 7, 3, "INSERIR ITEM PARA OPINI�O"
%>
	<font size="+1" color="white" face="arial"><b>Inserido com sucesso</b></font>
<% end if %>

<% FimPagina() %>
