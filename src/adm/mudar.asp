<%
' Copyright: (c) 1999-2023, Tiago Fonseca
' GNU General Public License v3.0+ (see LICENSE.md or https://www.gnu.org/licenses/gpl-3.0.html)
' SPDX-License-Identifier: GPL-3.0-or-later
%>

<!-- #include file="inicio_basedados.asp" -->
<!-- #include file="autenticar_webmaster.asp" -->
<!-- #include file="../textutil.asp" -->
<!-- #include file="../sqltext.asp" -->

<%
''''''''''''''''''''''''''''''''''''
' comentario - critica
' comentario (id, autor, foto, texto, data)
' classificacao (id, autor, foto, classificacao, data)
' foto (tipo_critica)
' tipo_critica (id, tipo)
''''''''''''''''''''''''''''''''''''

'SQL = "CREATE TABLE Comentario (id COUNTER, Classificacao INTEGER, Comentario TEXT(255), Foto INTEGER NOT NULL, Autor INTEGER NOT NULL)"
'dbConnection.Execute(SQL)

'SQL = "DELETE FROM autor WHERE id = 1"
'dbConnection.Execute(SQL)

'SQL = "INSERT INTO evento_tipo (nome) VALUES ('Outros')"
'dbConnection.Execute(SQL)

'SQL = "UPDATE contador SET visitas = '180' WHERE id = 1"
'dbConnection.Execute(SQL)

'SQL = "INSERT INTO debate_assunto (nome, descricao, total, hoje, data) VALUES ('t�cnica.arte', 'Temas, ...', '0', '0','" & date() & "')"
'dbConnection.Execute(SQL)

'SQL = "CREATE TABLE novidade (id COUNTER, texto MEMO, data DATE)"
'dbConnection.Execute(SQL)

'SQL = "INSERT INTO novidade (texto, data) VALUES ('Amplia��o da p�gina de <b>Novidades</b> e de <b>login</b>.', '" & date() & "')"
'dbConnection.Execute(SQL)

'SQL = "ALTER TABLE autor ADD COLUMN congelado YESNO"
'dbConnection.Execute(SQL)

'SQL = "UPDATE comentario SET data = '6/23/99' WHERE id = 1"
'dbConnection.Execute(SQL)

'SQL = "INSERT INTO links (nome, link, tipo, autor, data) VALUES ('N�Foto - N�cleo de Fotografia da FCT/UNL', 'http://students.fct.unl.pt/nufoto/', '11', '2', '" & date() & "')"
'dbConnection.Execute(SQL)

'SQL = "ALTER TABLE autor DROP COLUMN dadop_old"
'dbConnection.Execute(SQL)

'SQL = "DROP TABLE ordenacao"
'dbConnection.Execute(SQL)

'SQL = "UPDATE pam_participante SET autor = '41', nome = '' WHERE id = 8"
'dbConnection.Execute(SQL)

'SQL = "SELECT * FROM foto WHERE autor = 2240 AND id >= 82189 ORDER BY id DESC"
'Set fotoRes = dbConnection.Execute(SQL)
'data = cdate("6/17/2001")
'i = 0
'do while not fotoRes.eof
'	SQL = "UPDATE foto SET data = '" & data - i & "' WHERE id = " & fotoRes("id")
'	dbConnection.Execute(SQL)

'	i = i + 1
'	fotoRes.MoveNext
'loop
%>
feito!

<% end if %>
<!-- #include file="fim_basedados.asp" -->