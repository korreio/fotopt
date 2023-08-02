<%
' Copyright: (c) 1999-2023, Tiago Fonseca
' GNU General Public License v3.0+ (see LICENSE.md or https://www.gnu.org/licenses/gpl-3.0.html)
' SPDX-License-Identifier: GPL-3.0-or-later
%>

<!-- #include file="funcoes_principais.asp" -->

<% 
OpcaoMenu "TERMOS DO SERVI�O", "info.asp", False, False, -1, False, False
Menu 3, 1, "LOGIN" 
%>


<% if session("login") <> 0 then %>
	<form action="logout_res.asp" method=post><table cellpadding="10" cellspacing="0" border="1">
	<tr>
		<td>
		<table border="0" cellpadding="3" cellspacing="0">
			<font size="-1" color="white" face="arial">
			<b>Neste preciso momento voc&ecirc; est&aacute; autenticado</b> como membro deste site e tem<br>
			acesso a todas as op&ccedil;&otilde;es especiais.<br><br>
			<b>Quando j&aacute; n&atilde;o precisar de aceder &agrave;s op&ccedil;&otilde;es exclusivas dos membros pode<br>
			fazer <i>logout</i> (sair) premindo o bot&atilde;o.</b> Assim ningu&eacute;m poder&aacute; utilizar a sua conta<br>
			de membro indevidamente se deixar o computador. Se n&atilde;o o fizer o sistema faz<br>
			automaticamente ao fim de 20 minutos de inactividade ou ao fechar o seu browser<br>(ou computador).
			</font>
			<br><br>
			<input type="Submit" value="Logout / Sair">
		</table>
		</td>
	</tr>
	</table>
	</form>
<% else %>
	<font size="-1" color="white" face="arial">Para ter acesso a todas as funcionalidades do site tem que fazer <i>login</i> (entrar):</font>
	<br><br>
	<font size="-1" color="#FFCC66" face="arial"><b>
		NOTA: Site em modo reduzido de funcionamento, por tempo indeterminado n�o poder� inserir cr�nicas ou usar o forum.
	</b></font><br>
	
	<form action="login_res2.asp" method=post><table cellpadding="10" cellspacing="0" border="1">
	<tr>
		<td>
		<table border="0" cellpadding="3" cellspacing="0">
			<tr><td><font size="-1" color="#FFCC66" face="arial"><b>LOGIN:</b><br><font color="white" size="-2">(NOME UTILIZADOR)</font></font></td><td><input size="15" type="Text" name="login"> <font size="-1" color="white" face="arial">&nbsp;</font></td></tr>
			<tr><td><font size="-1" color="#FFCC66" face="arial"><b>PASSWORD:</b><br><font color="white" size="-2">(PALAVRA CHAVE)</font></font></td><td><input size="15" type="password" name="password"> <font size="-1" color="white" face="arial">&nbsp;</font></td></tr>
			<tr><td></td><td></td></tr>	
			<tr><td></td><td><input type="Submit" value="Login / Entrar"></td></tr>
		</table>
		</td>
		<td>
			<font size="-1" color="white" face="arial">
			<b>N&atilde;o se lembra do seu login<br>
			e/ou da sua password?</b><br>V&aacute; &agrave; sua ficha de membro<br>
			e prima <b>PASSWORD</b> para<br>recuper&aacute;-los.
			</font>
				
		</td>
	</tr>
	</table>
	</form>
	
	<font size="-1" color="white" face="arial">
	Se ainda n&atilde;o criou um utilizador escolha a op&ccedil;&atilde;o <a href="inscricao.asp"><b>INSCRI&Ccedil;&Atilde;O</b></a> no menu esquerdo
	<br>
	<b>Quando faz login passa a poder</b>:<br>
	&nbsp;&nbsp;1 - enviar fotos e comenta-las<br>
	&nbsp;&nbsp;2 - participar nos debates e vota&ccedil;&otilde;es e elei&ccedil;&atilde;o da foto do m&ecirc;s<br>
	&nbsp;&nbsp;3 - inserir novos eventos, links, usados, etc...
	</font>
<% end if %>
	
<% FimPagina() %>
