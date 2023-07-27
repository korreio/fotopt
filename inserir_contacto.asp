<!-- #include file="funcoes_principais.asp" -->

<%
SQL = "SELECT * FROM contactos_tipo ORDER BY nome"
Set tipoRes = dbConnection.Execute(SQL)
%>

<% 
AutenticarMembro(autor)
Menu 6, 4, "INSERIR CONTACTO"
%>

<font size="-1" color="white" face="arial">
<b>ATEN&Ccedil;&Atilde;O</b>: Insira apenas contactos de empresas da qual vo&ccedil;&ecirc; &eacute; dono, s&oacute;cio ou para a qual trabalha.<br>
N&atilde;o &eacute; permitida a inser&ccedil;&atilde;o de contactos sem que algum respons&aacute;vel da empresa mencionada esteja informado.<br>
Todos os dados s&atilde;o da inteira responsabilidade do membro que os inseriu.
</font>

<form action="inserir_contacto_res.asp" method="post">

<table border="0" cellpadding="3" cellspacing="0">
	<tr><td><font size="-1" color="#FFCC66" face="arial"><b>NOME EMPRESA: </b></font></td><td><input maxlength="255" type="Text" size="40" name="nome"> <font size="-1" color="white" face="arial">(obrig)</font></td></tr>
	<tr>
		<td><font size="-1" color="#FFCC66" face="arial"><b>RAMO: </b></font></td>
		<td><select name="tipo">
			<% do while not tipoRes.eof %>
				<option value="<% =tipoRes("id") %>"><% =tipoRes("nome") %></option>
				<% tipoRes.MoveNext %>
			<% loop %>
		</select> 
		<font size="-1" color="white" face="arial">(obrig)</font></td>
	</tr>
	<tr><td><br></td><td></td></tr>
	<tr><td><font size="-1" color="#FFCC66" face="arial"><b>MORADA: </b></font></td><td><input maxlength="255" type="Text" size="40" name="morada"></td></tr>
	<tr><td><font size="-1" color="#FFCC66" face="arial"><b>TELEFONE: </b></font></td><td><input maxlength="255" type="Text" size="40" name="telefone"></td></tr>
	<tr><td><font size="-1" color="#FFCC66" face="arial"><b>FAX: </b></font></td><td><input maxlength="255" type="Text" size="40" name="fax"></td></tr>
	<tr><td><br></td><td></td></tr>
	<tr><td><font size="-1" color="#FFCC66" face="arial"><b>E-MAIL: </b></font></td><td><input maxlength="255" type="Text" size="40" name="email"></td></tr>
	<tr><td><font size="-1" color="#FFCC66" face="arial"><b>HOMEPAGE: </b></font></td><td><input maxlength="255" type="Text" size="40" value="http://" name="homepage"></td></tr>
	<tr><td><br></td><td></td></tr>
	<tr><td><font size="-1" color="#FFCC66" face="arial"><b>REPRESENTANTES<br>DAS MARCAS: </b></font><font size="-1" color="white" face="arial"><br>(se ultrapassar<br>estas 6 linhas<br>o texto ser&aacute;<br>cortado)</font></td><td><textarea name="representante" cols="38" rows="6" wrap="VIRTUAL"></textarea></td></tr>
	<tr><td><font size="-1" color="#FFCC66" face="arial"><b>SERVI&Ccedil;OS<br>DISPON&Iacute;VEIS: </b></font><font size="-1" color="white" face="arial"><br>(se ultrapassar<br>estas 6 linhas<br>o texto ser&aacute;<br>cortado)</font></td><td><textarea name="oferta" cols="38" rows="6" wrap="VIRTUAL"></textarea></td></tr>
	<tr><td><br></td><td></td></tr>
	<tr><td><font size="-1" color="#FFCC66" face="arial"><b>OUTROS: </b></font><font size="-1" color="white" face="arial"><br>(se ultrapassar<br>estas 6 linhas<br>o texto ser&aacute;<br>cortado)</font></td><td><textarea name="outros" cols="38" rows="6" wrap="VIRTUAL"></textarea></td></tr>

	<tr><td></td><td><input type="Submit" value="Inserir contacto"></td></tr>
</table>

</form>

<% FimPagina() %>
