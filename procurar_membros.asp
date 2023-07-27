<!-- #include file="funcoes_principais.asp" -->

<% 
Menu 3, 2, "PROCURAR MEMBROS" 
%>

<font size="-1" color="white" face="arial">
Preencha um ou mais campos. Quantos mais campos preencher, mais restrita ser&aacute; a busca. N&atilde;o precisa escrever 
palavras completas (por exemplo, se escrever &quot;Jo&quot; no campo nome, ser&atilde;o encontrados todos os 
membros que nesse campo tenham &quot;Jo&atilde;o&quot;, &quot;Joana&quot;, etc...).
</font><br><br>

<form action="ver_membros.asp?busca=1" method="post">
<table border="1" cellpadding="10" cellspacing="0">
<tr><td>

<font color="white" face="arial">
<b>TODOS OS MEMBROS COM:</b><br><br>
</font>
<table border="0" cellpadding="3" cellspacing="0">
	<tr><td><font size="-1" color="#FFCC66" face="arial"><b>ID: </b></font></td><td><input maxlength="50" size="6" type="text" name="id"></td></tr>
	<tr><td><font size="-1" color="#FFCC66" face="arial"><b>NOME: </b></font><br><font size="-1" color="white" face="arial">(real ou<br>de art&iacute;sta)</font></td><td><input maxlength="50" size="40" type="text" name="nome"></td></tr>
	<tr><td><font size="-1" color="#FFCC66" face="arial"><b>E-MAIL: </b></font></td><td><input maxlength="50" size="40" type="text" name="email"></td></tr>
	<tr><td><br></td><td></td></tr>		
	<tr><td><font size="-1" color="#FFCC66" face="arial"><b>REGI&Atilde;O: </b></font></td><td><input maxlength="255" size="40" type="text" name="regiao"></td></tr>
	<tr><td><font size="-1" color="#FFCC66" face="arial"><b>PROFISS&Atilde;O: </b></font></td><td><input maxlength="255" size="40" type="Text" name="profissao"></td></tr>
	<tr><td></td><td><input type="Submit" value="Procurar membros"></td></tr>
</table>
</td></tr>

</table>
</form>

<% FimPagina() %>
