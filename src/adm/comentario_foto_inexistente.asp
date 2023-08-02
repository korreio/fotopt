<%
' Copyright: (c) 1999-2023, Tiago Fonseca
' GNU General Public License v3.0+ (see LICENSE.md or https://www.gnu.org/licenses/gpl-3.0.html)
' SPDX-License-Identifier: GPL-3.0-or-later
%>

<!-- #include file="inicio_basedados.asp" -->

<%
Server.ScriptTimeOut = 999999

SQL = "SELECT id, foto FROM comentario"
Set comentRes = dbConnection.Execute(SQL)

do while not comentRes.eof
	SQL = "SELECT id FROM foto WHERE id = " & comentRes("foto")
	Set fotoRes = dbConnection.Execute(SQL)
	
	if fotoRes.eof then
%>
		<% =comentRes("id") %><br>
<%
	end if
	
	comentRes.MoveNext
loop
%>


<!-- #include file="fim_basedados.asp" -->