<%
' Copyright: (c) 1999-2023, Tiago Fonseca
' GNU General Public License v3.0+ (see LICENSE.md or https://www.gnu.org/licenses/gpl-3.0.html)
' SPDX-License-Identifier: GPL-3.0-or-later
%>

<!-- #include file="inicio_basedados.asp" -->

<%
autor = request("autor")

SQL = "SELECT * FROM autor WHERE id = " & autor
Set autorRes = dbConnection.Execute(SQL)
%>

<!-- #include file="topo.asp" -->
<td bgcolor="gray" width="100%" align="left"><font size="-1" color="black" face="arial">&nbsp;MUDAR ESTADO DE <% =autorRes("nome_real") %> (<% =autor %>)</font></td>
<td><font size="-2">&nbsp;</font><a href="../autor_pormenor.asp?autor=<% =autor %>"><font size="-2" color="black" face="arial">CONTRIBUI&Ccedil;&Atilde;O</font></a><font size="-2">&nbsp;</font></td>
<td><font size="-2">&nbsp;</font><a href="adm_mudar_autor.asp?autor=<% =autor %>"><font size="-2" color="red" face="arial">MUDAR&nbsp;DADOS</font></a><font size="-2">&nbsp;</font></td>
<!-- #include file="fim_topo.asp" -->
<!-- #include file="autenticar_webmaster.asp" -->

<form method="post" action="adm_estado_autor_res.asp?autor=<% =autor %>">
<table cellpadding="2" cellspacing="0">
	<tr><td><font color="white" face="arial"><b>Enviar email</b></font></td><td><input type="Checkbox" name="enviar"></td></tr>
	<tr><td height="12"></td><td></td></tr>
	<tr><td><font color="white" face="arial"><b>Email enviado</b></font></td><td><input <% if autorRes("email_enviado") = True then %>checked<% end if %> type="Checkbox" name="enviado"></td></tr>
	<tr><td><font color="white" face="arial"><b>Confirmar</b></font></td><td><input <% if autorRes("confirmado") = True then %>checked<% end if %> type="Checkbox" name="confirmar"></td></tr>
	<tr><td height="12"></td><td></td></tr>
	<tr><td><font color="yellow" face="arial"><b>Congelar</b></font></td><td><input <% if autorRes("congelado") = True then %>checked<% end if %> type="Checkbox" name="congelar"></td></tr>
	<tr><td><font color="yellow" face="arial"><b>Lista negra</b></font></td><td><input type="Checkbox" name="lista_negra"></td></tr>
	<tr><td><font color="red" face="arial"><b>Apagar</b></font></td><td><input type="Checkbox" name="apagar"><input type="Checkbox" name="apagar2"></td></tr>
	<tr><td><br><input type="Submit" value="Mudar autor"></td><td></td></tr>
</table>
</form>

<!-- #include file="fim_autenticacao.asp" -->
<!-- #include file="fim_basedados.asp" -->