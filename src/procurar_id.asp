<%
' Copyright: (c) 1999-2023, Tiago Fonseca
' GNU General Public License v3.0+ (see LICENSE.md or https://www.gnu.org/licenses/gpl-3.0.html)
' SPDX-License-Identifier: GPL-3.0-or-later
%>

<!-- #include file="funcoes_principais.asp" -->
<!-- #include file="ordem_galeria.asp" -->

<%
Menu 1, 5, "PROCURAR FOTOGRAFIAS POR ID"
%>

<table border="1" cellpadding="10" cellspacing="0">

<tr><td>
<font color="white" face="arial">
<b>UMA FOTOGRAFIA ESPEC&Iacute;FICA</b>
</font>
<form action="galeria.asp?tipo=busca&id=umid" method="post">
<table border="0" cellpadding="3" cellspacing="0">
	<tr><td>
		<font size="-1" color="#FFCC66" face="arial"><b>COM O ID </b></font>
		&nbsp;<input size="6" type="Text" name="idprocurado">&nbsp;
		<input type="Submit" value="Procurar foto">
	</td></tr>
</table>
</form>
</td></tr>

<tr><td>
<font color="white" face="arial">
<b>UM INTERVALO DE FOTOGRAFIAS</b>
</font>
<form action="galeria.asp?tipo=busca&id=intervaloid" method="post">
<table border="0" cellpadding="3" cellspacing="0">
	<tr><td>
		<font size="-1" color="#FFCC66" face="arial"><b>DESDE O ID </b></font>
		&nbsp;<input size="6" type="Text" name="id1">&nbsp;
		<font size="-1" color="#FFCC66" face="arial"><b>AT&Eacute; AO ID </b></font>
		&nbsp;<input size="6" type="Text" name="id2">&nbsp;
		<input type="Submit" value="Procurar fotos">
	</td></tr>
</table>
</form>
</td></tr>

<tr><td>
<font color="white" face="arial">
<b>TODAS AT&Eacute; &Agrave; FOTOGRAFIA</b>
</font>
<form action="galeria.asp?tipo=busca&id=ateid" method="post">
<table border="0" cellpadding="3" cellspacing="0">
	<tr><td>
		<font size="-1" color="#FFCC66" face="arial"><b>COM O ID </b></font>
		&nbsp;<input size="6" type="Text" name="idprocurado">&nbsp;
		<font size="-1" color="#FFCC66" face="arial"><b>PARTINDO DA </b></font>
		&nbsp;<select name="desde">
			<option value="1">MAIS ANTIGA</option>
			<option value="2">MAIS RECENTE</option>
		</select>&nbsp;
		<input type="Submit" value="Procurar fotos">
	</td></tr>
</table>
</form>
</td></tr>

</table>

<% FimPagina() %>