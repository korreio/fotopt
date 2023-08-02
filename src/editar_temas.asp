<%
' Copyright: (c) 1999-2023, Tiago Fonseca
' GNU General Public License v3.0+ (see LICENSE.md or https://www.gnu.org/licenses/gpl-3.0.html)
' SPDX-License-Identifier: GPL-3.0-or-later
%>

<!-- #include file="funcoes_principais.asp" -->

<%
if session("login") = 2 then
	autor = request("autor")
else
	autor = session("login")
end if

SQL = "SELECT * FROM folder WHERE autor = " & autor & " ORDER BY nome"
Set folderRes = dbConnection.Execute(SQL)

SQL = "SELECT nome FROM autor WHERE id = " & autor
Set autorRes = dbConnection.Execute(SQL)
%>

<% 
AutenticarMembro(autor)
OpcaoMenu "CRIAR TEMA", "criar_tema.asp?autor=" & autor, False, True, autor, False, False
OpcaoMenu "VOLTAR A GALERIA", "lista_temas.asp?autor=" & autor, False, True, autor, False, False
Menu 1, 1, "EDITAR TEMAS" 
%>

<font size="-1" color="white" face="arial">Cada autor pode criar v&aacute;rios temas para sub-dividir as fotos contidas na sua galeria. Para modificar ou apagar um tema prima o seu nome.
</font>
<br><br>

<table border="1" cellpadding="4" cellspacing="0">
<tr align="center">
	<td><font color="white" face="arial"><b>NOME DO<br>TEMA</b></font></td>
	<td><font color="white" face="arial"><b>DESCRI&Ccedil;&Atilde;O</b></font></td>
	<td><font color="white" face="arial"><b>NOME DO<br>TEMA EM<br>INGL&Ecirc;S</b></font></td>
	<td><font color="white" face="arial"><b>DESCRI&Ccedil;&Atilde;O<br>EM INGL&Ecirc;S</b></font></td>
</tr>
<tr>
	<td><font color="#FFCC66" size="-1" face="arial"><b>Geral</b></font></td>
	<td><font size="-1" color="white" face="arial">Este tema n&atilde;o &eacute; edit&aacute;vel pois &eacute; onde v&atilde;o parar as fotos para as quais n&atilde;o &eacute; especificado um tema.&nbsp;</font></td>		
	<td><font color="#FFCC66" size="-1" face="arial"><b>Generic</b></font></td>
	<td><font size="-1" color="white" face="arial">Photos which do not fit in the following themes.</font></td>		
</tr>

<% 
do while not folderRes.eof
%>
	<tr>
		<td><a href="mudar_tema.asp?tema=<% =folderRes("id") %>&autor=<% =autor %>"><font color="#FFCC66" size="-1" face="arial"><b><% =folderRes("nome") %></b></font></a></td>
		<td><font size="-1" color="white" face="arial"><% =folderRes("descricao") %>&nbsp;</font></td>		
		<td><font color="#FFCC66" size="-1" face="arial"><b><% =folderRes("nome_uk") %>&nbsp;</b></font></td>
		<td><font size="-1" color="white" face="arial"><% =folderRes("descricao_uk") %>&nbsp;</font></td>		
	</tr>
	<% folderRes.MoveNext %>
<% Loop %>
</table>

<% FimPagina() %>
