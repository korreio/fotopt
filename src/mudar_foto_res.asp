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
tipo = request("tipo")
id = request("id")
temaid = request("temaid")
num = request("num")

SQL = "SELECT * FROM foto WHERE id = " & foto
Set fotoRes = dbConnection.Execute(SQL)

assunto = request("assunto")
tema = request("tema")

titulo = SqlText(request("titulo"))
lugar = SqlText(request("lugar"))
descricao = SqlText(request("descricao"))

titulo_uk = SqlText(request("titulo_uk"))

dia = request("dia")
mes = request("mes")
ano = request("ano")

if dia <> "" then
	data_tipo = 3
elseif clng(mes) <> 0 then
	dia = 1
	data_tipo = 2
elseif ano <> "" then
	dia = 1
	mes = 1
	data_tipo = 1
else
	dia = 1
	mes = 1
	ano = 1
	data_tipo = 0
end if

data_foto = mes & "/" & dia & "/" & ano

maquina = SqlText(request("maquina"))
lente = SqlText(request("lente"))
filme = SqlText(request("filme"))
filtros = SqlText(request("filtros"))
flash = SqlText(request("flash"))

velocidade = SqlText(request("velocidade"))
abertura = SqlText(request("abertura"))

tratamento_digital = SqlText(request("tratamento_digital"))
outros = SqlText(request("outros"))
anonima = request("anonima")
if anonima = "" then
	anonima = 0
end if

autor = fotoRes("autor")
%>

<% AutenticarMembro(autor) %>

<%
if not isdate(data_foto) then
	Menu 1, GaleriaSubSeccao(tipo, id), "ALTERAR FOTO"
%>
	<font size="+1" color="white" face="arial">A data da fotografia n&atilde;o n&atilde;o &eacute; v&aacute;lida</font>
	<br>
	<font size="+1" color="white" face="arial">prima o botao <b>back</b> no browser e corrija a informa&ccedil;&atilde;o</font>	
<% 
else
	SQL = "UPDATE foto SET "
	SQL = SQL & "assunto = '" & assunto & "',"
	SQL = SQL & "tema = '" & tema & "',"
	SQL = SQL & "titulo = '" & titulo & "',"
	SQL = SQL & "titulo_uk = '" & titulo_uk & "',"
	SQL = SQL & "lugar = '" & lugar & "',"
	SQL = SQL & "data_foto = '" & data_foto & "',"
	SQL = SQL & "data_tipo = '" & data_tipo & "',"
	SQL = SQL & "descricao = '" & descricao & "',"
	SQL = SQL & "maquina = '" & maquina & "',"
	SQL = SQL & "lente = '" & lente & "',"
	SQL = SQL & "filme = '" & filme & "',"
	SQL = SQL & "filtros = '" & filtros & "',"
	SQL = SQL & "flash = '" & flash & "',"
	SQL = SQL & "velocidade = '" & velocidade & "',"
	SQL = SQL & "tratamento_digital = '" & tratamento_digital & "',"
	SQL = SQL & "outros = '" & outros & "',"
	SQL = SQL & "anonima = '" & anonima & "',"
	SQL = SQL & "abertura = '" & abertura & "' "
	SQL = SQL & "WHERE id = " & foto
	dbConnection.Execute(SQL)

	ComRefresh "foto.asp?foto=" & foto & "&primeira=" & primeira & "&tema=" & temaid & "&tipo=" & tipo & "&id=" & id & "&num=" & num
	Menu 1, GaleriaSubSeccao(tipo, id), "ALTERAR FOTO"
%>

<font size="+1" color="white" face="arial"><b>Foto modificada com sucesso</b></font>

<% end if %>

<% FimPagina() %>
