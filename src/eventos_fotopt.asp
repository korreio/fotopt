<%
' Copyright: (c) 1999-2023, Tiago Fonseca
' GNU General Public License v3.0+ (see LICENSE.md or https://www.gnu.org/licenses/gpl-3.0.html)
' SPDX-License-Identifier: GPL-3.0-or-later
%>

<!-- #include file="funcoes_principais.asp" -->

<% 
SQL = "SELECT * FROM eventos_fotopt WHERE oficial = True ORDER BY data DESC"
Set eventosRes = dbConnection.Execute(SQL)

SQL = "SELECT * FROM eventos_fotopt WHERE oficial = False ORDER BY data DESC"
Set eventosNaoRes = dbConnection.Execute(SQL)

OpcaoMenu "INSERIR EVENTO FOTOPT", "adm/inserir_evento_fotopt.asp", False, False, -1, False, True
Menu 2, 1, "EVENTOS DO FOTO@PT"

%>

<font color="white" size="-1" face="arial">
Aqui encontra uma s�rie de galerias de fotografias de documentam os v�rios encontros,
almo�os, pr�mios, exposi��es, e outros eventos relacionados com o foto@pt. Para inserir 
fotos suas escolha o evento em que se enquadram e prima a op��o INSERIR FOTO.
<br><br>
As fotos aqui inseridas n�o contam para o limite de fotos da sua galeria de membro. Todas 
as fotos inseridas podem ser comentadas, mas n�o podem entrar em concursos do site.
</font>
<br><br>

<table cellpadding="10" cellspacing="0" border="0"><tr>
<td valign="top">
	<font color="#FFCC66" face="arial"><b>EVENTOS "OFICIAIS"</b></font><br><br>
	<table cellpadding="3" cellspacing="0" border="0">
	<%
	do while not eventosRes.eof
		SQL = "SELECT count(*) AS num FROM eventos_fotopt_foto WHERE evento_fotopt = " & eventosRes("id")
		Set numFotosRes = dbConnection.Execute(SQL)
	%>
		<tr><td>
			<a href="galeria_evento.asp?evento=<% =eventosRes("id") %>"><font size="-1" face="Arial" color="#FFCC66"><b><% =eventosRes("nome") %></b></font></a>
			<font size="-2" face="Arial" color="silver">(<% =day(eventosRes("data")) & "/" & month(eventosRes("data")) & "/" & year(eventosRes("data")) %>, <% =numFotosRes("num") %> foto<% if numFotosRes("num") <> 1 then %>s<% end if %>)</font><br>
			<font size="-1" face="Arial" color="white"><% =eventosRes("descricao") %></b></font><br>
		</td></tr>
	
		<% eventosRes.MoveNext %>
	<% loop %>
	</table>
</td>
<td valign="top">
	<font color="#FFCC66" face="arial"><b>OUTROS EVENTOS:</b></font><br><br>
	<font color="white" size="-1" face="arial">
	Se acha que tem fotos de algum evento relacionado com o site avise o webmaster
	para ser criada aqui uma entrada. Requisitos m�nimos do evento: ter sido divulgado
	no site ou na mailing list "Escrita com Luz", ter estado aberto a todos e terem participado
	mais de 10 membros.
	</font><br><br>
	<table cellpadding="3" cellspacing="0" border="0">
	<%
	do while not eventosNaoRes.eof
		SQL = "SELECT count(*) AS num FROM eventos_fotopt_foto WHERE evento_fotopt = " & eventosNaoRes("id")
		Set numFotosRes = dbConnection.Execute(SQL)
	%>
		<tr><td>
			<a href="galeria_evento.asp?evento=<% =eventosNaoRes("id") %>"><font size="-1" face="Arial" color="#FFCC66"><b><% =eventosNaoRes("nome") %></b></font></a>
			<font size="-2" face="Arial" color="silver">(<% =day(eventosNaoRes("data")) & "/" & month(eventosNaoRes("data")) & "/" & year(eventosNaoRes("data")) %>, <% =numFotosRes("num") %> foto<% if numFotosRes("num") <> 1 then %>s<% end if %>)</font><br>
			<font size="-1" face="Arial" color="white"><% =eventosNaoRes("descricao") %></b></font><br>
		</td></tr>
	
		<% eventosNaoRes.MoveNext %>
	<% loop %>
	</table>
</td>

</tr></table>

<% FimPagina() %>
