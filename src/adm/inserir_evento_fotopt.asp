<!-- #include file="inicio_basedados.asp" -->

<!-- #include file="topo.asp" -->
<td bgcolor="gray" width="100%" align="left"><font size="-1" color="black" face="arial">&nbsp;INSERIR EVENTO FOTOPT</font></td>
<!-- #include file="fim_topo.asp" -->
<!-- #include file="autenticar_webmaster.asp" -->

<form action="inserir_evento_fotopt_res.asp" method=post>

<table border="0" cellpadding="3" cellspacing="0">
	<tr><td><font size="-1" color="#FFCC66" face="arial"><b>NOME: </b></font></td><td><input type="Text" name="nome" size="40" maxlength="255"> <font size="-1" color="white" face="arial">(obrig)</font></td></td></tr>
	<tr><td><font size="-1" color="#FFCC66" face="arial"><b>DESCRIÇÃO: </b></font></td><td><textarea name="descricao" cols="38" rows="10" wrap="VIRTUAL"></textarea></td></tr>
	<tr><td><font size="-1" color="#FFCC66" face="arial"><b>DATA:</b></font><br><font size="-1" color="white" face="arial">(MM/DD/AAAA)</b></font></td><td><input type="Text" name="data" size="10" maxlength="10"> <font size="-1" color="white" face="arial">(obrig)</font></td></td></tr>
	<tr><td><font size="-1" color="#FFCC66" face="arial"><b>OFICIAL:</b></font></td><td><input type="checkbox" name="oficial" value="1"> <font size="-1" color="white" face="arial">(obrig)</font></td></td></tr>
	<tr><td></td><td><input type="Submit" value="Inserir evento fotopt"></td></tr>
</table>

</form>

<!-- #include file="fim_autenticacao.asp" -->
<!-- #include file="fim_basedados.asp" -->