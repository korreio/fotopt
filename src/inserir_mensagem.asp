<%
' Copyright: (c) 1999-2023, Tiago Fonseca
' GNU General Public License v3.0+ (see LICENSE.md or https://www.gnu.org/licenses/gpl-3.0.html)
' SPDX-License-Identifier: GPL-3.0-or-later
%>

<!-- #include file="funcoes_principais.asp" -->
<!-- #include file="sqltext.asp" -->

<%
assunto = request("assunto")
subid = request("subid")
raiz = request("raiz")
pagina = request("pagina")

SQL = "SELECT nome FROM autor WHERE id = " & session("login")
Set autorRes = dbConnection.Execute(SQL)

SQL = "SELECT nome FROM debate_assunto WHERE id = " & assunto
Set assuntoRes = dbConnection.Execute(SQL)

if subid <> 0 then
	SQL = "SELECT id, nome, texto FROM debate_mensagem WHERE id = " & subid
	Set mensagemRes = dbConnection.Execute(SQL)
end if
%>

<% 
AutenticarMembro(autor)
if subid <> 0 then
	Menu 7, 1, "INSERIR MENSAGEM NO F�RUM"
else
	Menu 7, 1, "CRIAR DEBATE - " & assuntoRes("nome")
end if
%>

<form action="inserir_mensagem_res.asp?pagina=<% =pagina %>&assunto=<% =assunto %>&subid=<% =subid %>&raiz=<% =raiz %>" method="post">

<table border="0" cellpadding="3" cellspacing="0">
	<% if subid <> 0 then %>
		<tr>
			<td colspan="2">
				<table border="1" cellpadding="10" cellspacing="0"><tr><td>
				<font size="-1" color="#FFCC66" face="arial"><b>RESPOSTA A:&nbsp;&nbsp;</b></font>
				<font color="white" size="-1" face="arial"><b><% =mensagemRes("nome") %></b></font><br>
				<font color="white" size="-1" face="arial"><% =Enter2Br(mensagemRes("texto")) %></font>
				</td></tr></table>
			</td>
		</tr>
		<tr><td><font size="-1" color="#FFCC66" face="arial"><b>NOME DA<br>MENSAGEM: </b></font></td><td width="100%"><input value="Re:<% =Aspas2Quot(mensagemRes("nome")) %>" maxlength="255" type="Text" size="52" name="nome"> <font size="-1" color="white" face="arial">(obrig)</font></td></tr>
	<% else %>
		<tr>
			<td><font size="-1" color="#FFCC66" face="arial"><b>NOTA: </b></font></td>
			<td><font size="-1" color="white" face="arial">
				Os debates criados no f�rum s�o moderadas pelo webmaster, para que n�o existam abusos na sua utiliza��o.
				Isto significa que s� depois de lido e aprovado � que o debate ficar� disponivel para os outros membros o lerem.
				Poder� levar 2 ou 3 dias para as mensagens serem aprovadas. As n�o aprovadas simplemente n�o aparecer�o para os
				outros membros. Relembro que este forum se dedica unicamente a assuntos relacionados com fotografia.
			</font></td></tr>
		<tr><td><font size="-1" color="#FFCC66" face="arial"><b>NOME DO<br>DEBATE: </b></font></td><td><input maxlength="255" type="Text" size="52" name="nome"> <font size="-1" color="white" face="arial">(obrig)</font></td></tr>
	<% end if %>		
	<tr><td><font size="-1" color="#FFCC66" face="arial"><b>TEXTO: </b></font></td><td><textarea name="texto" cols="50" rows="20" wrap="VIRTUAL"></textarea> <font size="-1" color="white" face="arial">(obrig)</font></td></tr>

	<tr><td></td><td><input type="Submit" value="Inserir mensagem"></td></tr>
</table>

</form>

<% FimPagina() %>
