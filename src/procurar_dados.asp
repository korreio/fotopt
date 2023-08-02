<%
' Copyright: (c) 1999-2023, Tiago Fonseca
' GNU General Public License v3.0+ (see LICENSE.md or https://www.gnu.org/licenses/gpl-3.0.html)
' SPDX-License-Identifier: GPL-3.0-or-later
%>

<!-- #include file="funcoes_principais.asp" -->
<!-- #include file="ordem_galeria.asp" -->

<%
Menu 1, 6, "PROCURAR FOTOGRAFIAS POR DADOS"
%>

<font size="-1" color="white" face="arial">
Preencha um ou mais campos. Quantos mais campos preencher, mais restrita ser&aacute; a busca. N&atilde;o precisa escreve 
palavras completas (por exemplo, se escrever &quot;Port&quot; no campo t&iacute;tulo, ser&atilde;o encontradas todas as 
fotografias que nessa campo tenham &quot;Portugal&quot;, &quot;Porto&quot;, &quot;aeroporto&quot;, etc...).
</font><br><br>

<form action="galeria.asp?tipo=busca&id=dados" method="post">
<table border="1" cellpadding="10" cellspacing="0">
<tr><td>

<font color="white" face="arial">
<b>TODAS AS FOTOGRAFIAS COM</b><br><br>
</font>
<table border="0" cellpadding="3" cellspacing="0">
	<tr><td><font size="-1" color="#FFCC66" face="arial"><b>T&Iacute;TULO: </b></font></td><td><input maxlength="50" size="40" type="text" name="titulo"></td></tr>
	<tr><td><br></td><td></td></tr>		
	<tr><td><font size="-1" color="#FFCC66" face="arial"><b>LUGAR: </b></font></td><td><input maxlength="255" size="40" type="text" name="lugar"></td></tr>
	<tr><td><br></td><td></td></tr>		
	<tr><td><font size="-1" color="#FFCC66" face="arial"><b>M&Aacute;QUINA: </b></font></td><td><input maxlength="255" size="40" type="Text" name="maquina"></td></tr>
	<tr><td><font size="-1" color="#FFCC66" face="arial"><b>OBJECTIVA: </b></font></td><td><input maxlength="255" size="40" type="Text" name="lente"></td></tr>
	<tr><td><font size="-1" color="#FFCC66" face="arial"><b>FILME: </b></font></td><td><input maxlength="255" size="40" type="Text" name="filme"></td></tr>
	<tr><td><font size="-1" color="#FFCC66" face="arial"><b>FILTROS: </b></font></td><td><input maxlength="255" size="40" type="Text" name="filtros"></td></tr>
	<tr><td><font size="-1" color="#FFCC66" face="arial"><b>ILUMINA��O: </b></font></td><td><input maxlength="255" size="40" type="Text" name="flash"></td></tr>
	<tr><td><br></td><td></td></tr>	
	<tr><td><font size="-1" color="#FFCC66" face="arial"><b>TEMPO DE<br>EXPOSI&Ccedil;&Atilde;O: </b></font></td><td><input maxlength="255" size="20" type="Text" name="velocidade"></td></tr>
	<tr><td><font size="-1" color="#FFCC66" face="arial"><b>ABERTURA: </b></font></td><td><input maxlength="255" size="20" type="Text" name="abertura"></td></tr>
	<tr><td><br></td><td></td></tr>
	<tr><td></td><td><input type="Submit" value="Procurar fotos"></td></tr>
</table>
</td></tr>

</table>
</form>

<% FimPagina() %>