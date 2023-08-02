<%
' Copyright: (c) 1999-2023, Tiago Fonseca
' GNU General Public License v3.0+ (see LICENSE.md or https://www.gnu.org/licenses/gpl-3.0.html)
' SPDX-License-Identifier: GPL-3.0-or-later
%>

<!-- #include file="sqltext.asp" -->
<!-- #include file="funcoes_principais.asp" -->

<%
candidato = request("candidato")

SQL = "SELECT * FROM emprego_candidato WHERE id = " & candidato
Set candidatoRes = dbConnection.Execute(SQL)

autor = candidatoRes("autor")
%>

<% AutenticarMembro(autor) %>

<%
candidato = request("candidato")
cargo = SqlText(request("cargo"))
zona = SqlText(request("zona"))
pretende = SqlText(request("pretende"))
horario = SqlText(request("horario"))
habilitacoes = SqlText(request("habilitacoes"))
complementar = SqlText(request("complementar"))
diversos = SqlText(request("diversos"))
experiencia = SqlText(request("experiencia"))
observacoes = SqlText(request("observacoes"))
contacto = SqlText(request("contacto"))

if (cargo = "") or (zona = "") or (contacto = "") then
	Menu 6, 3, "MUDAR CANDIDATO A EMPREGO"
%>
	<font size="+1" color="white" face="arial">Os campos <b>cargo pretendido</b>, <b>zona</b> e <b>contacto</b> s&atilde;o obrigat&oacute;rios</font>
	<br>
	<font size="+1" color="white" face="arial">prima o bot&atilde;o <b>back</b> no browser e complete a informa&ccedil;&atilde;o</font>	
<%
else
	SQL = "UPDATE emprego_candidato SET "
	SQL = SQL & "cargo = '" & cargo & "',"
	SQL = SQL & "zona = '" & zona & "',"
	SQL = SQL & "pretende = '" & pretende & "',"
	SQL = SQL & "habilitacoes = '" & habilitacoes & "',"
	SQL = SQL & "complementar = '" & complementar & "',"
	SQL = SQL & "diversos = '" & diversos & "',"
	SQL = SQL & "experiencia = '" & experiencia & "',"				
	SQL = SQL & "horario = '" & horario & "',"
	SQL = SQL & "contacto = '" & contacto & "',"	
	SQL = SQL & "observacoes = '" & observacoes & "' "
	SQL = SQL & "WHERE id = " & candidato
	dbConnection.Execute(SQL)

	ComRefresh "ver_candidato.asp?candidato=" & candidato
	Menu 6, 3, "MUDAR CANDIDATO A EMPREGO"
%>
	<font size="+1" color="white" face="arial"><b>Candidato a emprego mudificado com sucesso</b></font>
<% end if %>

<% FimPagina() %>
