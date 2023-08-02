<%
' Copyright: (c) 1999-2023, Tiago Fonseca
' GNU General Public License v3.0+ (see LICENSE.md or https://www.gnu.org/licenses/gpl-3.0.html)
' SPDX-License-Identifier: GPL-3.0-or-later
%>

<!-- #include file="funcoes_principais.asp" -->

<%
OpcaoMenu "INSERIR HISTORIAL", "adm/inserir_historial.asp", False, False, -1, False, True
Menu 2, 6, "HISTORIAL DO SITE"
%>

<%
SQL = "SELECT * FROM historial_tipo"
Set historialTipoRes = dbConnection.Execute(SQL)

Dim meses
meses = Array("Janeiro", "Fevereiro", "Mar&ccedil;o", "Abril", "Maio", "Junho", "Julho", _
			  "Agosto", "Setembro", "Outubro", "Novembro", "Dezembro")
%>

<font color="white" size="-1" face="Arial">
Quando foi criado o foto@pt era apenas conhecido por uma m&atilde;o cheia de entusiastas
que queriam trocar algumas fotos e ideias entre si. Mas gra&ccedil;as &agrave; divulga&ccedil;&atilde;o realizada
pelos seus membros, o site j&aacute; chegou a lugares que nunca me passariam pela cabe&ccedil;a! (Quero agradecer
especialmente ao <a target="_new" href="http://dmendes.w3.to">Diamantino Mendes</a> pelo incans&aacute;vel trabalho de divulgacao que tem feito!)
<br><br>
Esta p&aacute;gina tentar&aacute; fazer o historial de todas as divulga&ccedil;&otilde;es do foto@pt nos mais
diversos meios de comunica&ccedil;&atilde;o e dos marcos mais significativos da sua evolu&ccedil;&atilde;o.
Se souber de algum que n&atilde;o esteja aqui por favor contacte o webmaster. Para ver pormenores de um item
prima o seu nome.<br><br>
</font>

<table cellpadding="10" cellspacing="0" border="1">
<% 
do while not historialTipoRes.eof 
	SQL = "SELECT * FROM historial WHERE tipo = " & historialTipoRes("id") & " ORDER BY data DESC"
	Set historialRes = dbConnection.Execute(SQL)
%>
<tr><td valign="top">
	<font color="white" face="Arial"><b><% =historialTipoRes("nome") %></b></font>
	<table cellpadding="2" cellspacing="0" border="0">
	<% do while not historialRes.eof %>
		<tr>
			<td align="right">
				<% if historialRes("tipo_data") = 3 then %>
					<font size="-2" color="white" face="Arial"><% =day(historialRes("data")) %>&nbsp;<% =meses(month(historialRes("data")) - 1) %>&nbsp;<% =year(historialRes("data")) %></font>
				<% else %>
					<font size="-2" color="white" face="Arial"><% =meses(month(historialRes("data")) - 1) %>&nbsp;<% =year(historialRes("data")) %></font>
				<% end if %>
			</td>
			<td>
				<% if historialRes("texto") <> "" then %>
					<a href="ver_historial.asp?historial=<% =historialRes("id") %>"><font size="2" color="#FFCC66" face="verdana, Arial"><b><% =historialRes("titulo") %></b></font></a>
				<% else %>
					<% if session("login") = 2 then %>
						<a href="ver_historial.asp?historial=<% =historialRes("id") %>"><font size="2" color="#FFCC66" face="verdana, Arial"><b><% =historialRes("titulo") %></b></font></a>
					<% else %>
						<font size="2" color="#FFCC66" face="verdana, Arial"><b><% =historialRes("titulo") %></b></font>
					<% end if %>
				<% end if %>
			</td>
			<td>
				<% if historialRes("tipo_meio") <> "" then %>
					<font size="-2" color="white" face="Arial">(<% =historialRes("tipo_meio") %>)</font>
				<% end if %>
			</td>
		</tr>
		<% historialRes.MoveNext %>
	<% loop %>
	</table>
</td></tr>
	<% historialTipoRes.MoveNext %>
<% loop %>
</table>

<% FimPagina() %>
