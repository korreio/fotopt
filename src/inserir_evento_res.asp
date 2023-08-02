<%
' Copyright: (c) 1999-2023, Tiago Fonseca
' GNU General Public License v3.0+ (see LICENSE.md or https://www.gnu.org/licenses/gpl-3.0.html)
' SPDX-License-Identifier: GPL-3.0-or-later
%>

<!-- #include file="sqltext.asp" -->
<!-- #include file="funcoes_principais.asp" -->

<% AutenticarMembro(autor) %>

<%
tipo = request("tipo")
nome = SqlText(request("nome"))
lugar = SqlText(request("lugar"))
distrito = SqlText(request("distrito"))
pais = SqlText(request("pais"))
dia_inicio = request("dia_inicio")
dia_fim = request("dia_fim")
ano_fim = request("ano_fim")
data_inicio = request("mes_inicio") & "/" & request("dia_inicio") & "/" & request("ano_inicio")
data_fim = request("mes_fim") & "/" & request("dia_fim") & "/" & request("ano_fim")
horario = SqlText(request("horario"))
custo = SqlText(request("custo"))
descricao = SqlText(request("descricao"))
organizacao = SqlText(request("organizacao"))
contacto = SqlText(request("contacto"))
observacoes = SqlText(request("observacoes"))
autores_fotos = SqlText(request("autores_fotos"))

if not isdate(data_inicio) then
	Menu 6, 1, "INSERIR EVENTO"
%>
	<font size="+1" color="white" face="arial">A data de in&iacute;cio n&atilde;o &eacute; v&aacute;lida</font>
	<br>
	<font size="+1" color="white" face="arial">prima o botao <b>back</b> no browser e corrija a informa&ccedil;&atilde;o</font>	
<%
elseif ((dia_fim <> "") or (ano_fim <> "")) and (not isdate(data_fim)) then
	Menu 6, 1, "INSERIR EVENTO"
%>
	<font size="+1" color="white" face="arial">A data de fim n&atilde;o &eacute; v&aacute;lida</font>
	<br>
	<font size="+1" color="white" face="arial">prima o botao <b>back</b> no browser e corrija a informa&ccedil;&atilde;o</font>	
<%
elseif (nome = "") or (dia_inicio = "") then
	Menu 6, 1, "INSERIR EVENTO"
%>
	<font size="+1" color="white" face="arial">Os campos <b>nome</b> e data de in&iacute;cio s&atilde;o obrigat&oacute;rios</font>
	<br>
	<font size="+1" color="white" face="arial">prima o botao <b>back</b> no browser e complete a informa&ccedil;&atilde;o</font>	
<%
else
	SQL = "INSERT INTO evento (nome, organizacao, descricao, lugar, custo, data_inicio, horario, autor, data, tipo, observacoes, contacto, autores_fotos, distrito, pais)"
	SQL = SQL & " VALUES ('" & nome & "','" & organizacao & "','" & descricao & "','" & lugar & "','" & custo & "','" & data_inicio
	SQL = SQL & "','" & horario & "','" & session("login") & "','" & date() & " " & time() & "','" & tipo & "','" & observacoes & "','" & contacto & "','" & autores_fotos
	SQL = SQL & "','" & distrito & "','" & pais & "')"
	dbConnection.Execute(SQL)

	SQL = "SELECT id FROM evento WHERE autor = " & session("login") & " ORDER BY id DESC"
	Set eventoRes = dbConnection.Execute(SQL)

	if isdate(data_fim) then	
		SQL = "UPDATE evento SET data_fim = '" & data_fim & "' WHERE id = " & eventoRes("id")
		dbConnection.Execute(SQL)
	end if

	ComRefresh "ver_evento.asp?evento=" & eventoRes("id")
	Menu 6, 1, "INSERIR EVENTO"
%>
	<font size="+1" color="white" face="arial"><b>Evento inserido com sucesso</b></font>
<% end if %>

<% FimPagina() %>
