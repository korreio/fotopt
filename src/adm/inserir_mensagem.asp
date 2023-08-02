<%
' Copyright: (c) 1999-2023, Tiago Fonseca
' GNU General Public License v3.0+ (see LICENSE.md or https://www.gnu.org/licenses/gpl-3.0.html)
' SPDX-License-Identifier: GPL-3.0-or-later
%>

<!-- #include file="topo.asp" -->
<td bgcolor="gray" width="100%" align="left"><font size="-1" color="black" face="arial">&nbsp;INSERIR MENSAGEM</font></td>
<!-- #include file="fim_topo.asp" -->
<!-- #include file="autenticar_webmaster.asp" -->

<% autor = request("autor") %>

<form action="inserir_mensagem_res.asp?autor=<% =autor %>" method=post>

<table border="0" cellpadding="3" cellspacing="0">
	<tr><td><font size="-1" color="red" face="arial"><b>BROADCAST: </b></font></td><td><input type="Checkbox" name="broadcast"></td></tr>
	<tr><td><font size="-1" color="#FFCC66" face="arial"><b>MENSAGEM: </b></font></td><td><textarea name="mensagem" cols="38" rows="6" wrap="VIRTUAL"></textarea> <font size="-1" color="white" face="arial">(obrig)</font></td></tr>
	<tr><td></td><td><input type="Submit" value="Inserir Mensagem"></td></tr>
</table>

</form>

<!-- #include file="fim_autenticacao.asp" -->