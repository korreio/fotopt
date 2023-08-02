<%
' Copyright: (c) 1999-2023, Tiago Fonseca
' GNU General Public License v3.0+ (see LICENSE.md or https://www.gnu.org/licenses/gpl-3.0.html)
' SPDX-License-Identifier: GPL-3.0-or-later
%>

<!-- #include file="funcoes_principais.asp" -->

<% 
AutenticarMembro(autor)
Menu 6, 3, "INSERIR OPORTUNIDADE DE EMPREGO"
%>

<form action="inserir_emprego_opor_res.asp" method="post">

<table border="0" cellpadding="3" cellspacing="0">
	<tr>
		<td><font size="-1" color="#FFCC66" face="arial"><b>ATEN&Ccedil;&Atilde;O: </b></font></td>
		<td><font color="white" face="arial">
			Para que esta sec&ccedil;&atilde;o n&atilde;o fique carregada de an&uacute;ncios desactualizados, 
			por favor apague este registo assim que j� n�o tiver interesse. Todos as entredas ser�o removidas autom�ticamente 
			ao fim de dois meses, podendo voltar a inseri-las quantas vezes for necess�rio.
		</font></td>
	</tr>
	<tr><td><br></td><td></td></tr>
	<tr><td><font size="-1" color="#FFCC66" face="arial"><b>CARGO: </b></font></td><td><input maxlength="255" type="Text" size="40" name="cargo"> <font size="-1" color="white" face="arial">(obrig)</font></td></tr>
	<tr><td><font size="-1" color="#FFCC66" face="arial"><b>EMPREGADOR: </b></font></td><td><input maxlength="255" type="Text" size="40" name="empresa"> <font size="-1" color="white" face="arial">(obrig)</font></td></tr>
	<tr><td><font size="-1" color="#FFCC66" face="arial"><b>ZONA DO PA&Iacute;S: </b></font></td><td><input maxlength="255" type="Text" size="40" name="zona"> <font size="-1" color="white" face="arial">(obrig)</font></td></tr>
	<tr><td><br></td><td></td></tr>
	<tr><td><font size="-1" color="#FFCC66" face="arial"><b>PRETENDE: </b></font><font size="-1" color="white" face="arial"><br>(se ultrapassar<br>estas 6 linhas<br>o texto ser&aacute;<br>cortado)</font></td><td><textarea name="pretende" cols="38" rows="6" wrap="VIRTUAL"></textarea></td></tr>
	<tr><td><font size="-1" color="#FFCC66" face="arial"><b>OFERECE: </b></font><font size="-1" color="white" face="arial"><br>(se ultrapassar<br>estas 6 linhas<br>o texto ser&aacute;<br>cortado)</font></td><td><textarea name="oferece" cols="38" rows="6" wrap="VIRTUAL"></textarea></td></tr>
	<tr><td><br></td><td></td></tr>
	<tr><td><font size="-1" color="#FFCC66" face="arial"><b>HOR&Aacute;RIO/<br>DURA&Ccedil;&Atilde;O: </b></font></td><td><input maxlength="255" type="Text" size="40" name="horario"></td></tr>
	<tr><td><font size="-1" color="#FFCC66" face="arial"><b>OBSERVA&Ccedil;&Otilde;ES: </b></font><font size="-1" color="white" face="arial"><br>(se ultrapassar<br>estas 6 linhas<br>o texto ser&aacute;<br>cortado)</font></td><td><textarea name="observacoes" cols="38" rows="6" wrap="VIRTUAL"></textarea></td></tr>
	<tr><td><br></td><td></td></tr>	
	<tr><td><font size="-1" color="#FFCC66" face="arial"><b>CONTACTO: </b></font></td><td><input maxlength="255" type="Text" size="40" name="contacto"> <font size="-1" color="white" face="arial">(obrig)</font></td></tr>

	<tr><td></td><td><input type="Submit" value="Inserir oportunidade"></td></tr>
</table>

</form>

<% FimPagina() %>
