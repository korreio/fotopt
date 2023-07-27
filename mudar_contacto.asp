<!-- #include file="sqltext.asp" -->
<!-- #include file="funcoes_principais.asp" -->

<%
contacto = request("contacto")

SQL = "SELECT * FROM contactos WHERE id = " & contacto
Set contactoRes = dbConnection.Execute(SQL)

autor = contactoRes("autor")

SQL = "SELECT * FROM contactos_tipo ORDER BY nome"
Set tipoRes = dbConnection.Execute(SQL)
%>

<% 
AutenticarMembro(autor)
Menu 6, 4, "MUDAR OU APAGAR CONTACTO"
%>

<form action="mudar_contacto_res.asp?contactoid=<% =contacto %>" method="post">

<table border="0" cellpadding="3" cellspacing="0">
	<tr><td><font size="-1" color="#FFCC66" face="arial"><b>NOME EMPRESA: </b></font></td><td><input maxlength="255" type="Text" size="40" value="<% =Aspas2Quot(contactoRes("nome")) %>" name="nome"> <font size="-1" color="white" face="arial">(obrig)</font></td></tr>
	<tr>
		<td><font size="-1" color="#FFCC66" face="arial"><b>RAMO: </b></font></td>
		<td><select name="tipo">
			<% do while not tipoRes.eof %>
				<% if tipoRes("id") = contactoRes("tipo") then %>
					<option selected value="<% =tipoRes("id") %>"><% =tipoRes("nome") %></option>
				<% else %>
					<option value="<% =tipoRes("id") %>"><% =tipoRes("nome") %></option>
				<% end if %>
				<% tipoRes.MoveNext %>
			<% loop %>
		</select> 
		<font size="-1" color="white" face="arial">(obrig)</font></td>
	</tr>
	<tr><td><br></td><td></td></tr>
	<tr><td><font size="-1" color="#FFCC66" face="arial"><b>MORADA: </b></font></td><td><input maxlength="255" type="Text" size="40" value="<% =Aspas2Quot(contactoRes("morada")) %>" name="morada"></td></tr>
	<tr><td><font size="-1" color="#FFCC66" face="arial"><b>TELEFONE: </b></font></td><td><input maxlength="255" type="Text" size="40" value="<% =Aspas2Quot(contactoRes("telefone")) %>" name="telefone"></td></tr>
	<tr><td><font size="-1" color="#FFCC66" face="arial"><b>FAX: </b></font></td><td><input maxlength="255" type="Text" size="40" value="<% =Aspas2Quot(contactoRes("fax")) %>" name="fax"></td></tr>
	<tr><td><br></td><td></td></tr>
	<tr><td><font size="-1" color="#FFCC66" face="arial"><b>E-MAIL: </b></font></td><td><input maxlength="255" type="Text" size="40" value="<% =Aspas2Quot(contactoRes("email")) %>" name="email"></td></tr>
	<tr><td><font size="-1" color="#FFCC66" face="arial"><b>HOMEPAGE: </b></font></td><td><input maxlength="255" type="Text" size="40" value="<% =Aspas2Quot(contactoRes("homepage")) %>" name="homepage"></td></tr>
	<tr><td><br></td><td></td></tr>
	<tr><td><font size="-1" color="#FFCC66" face="arial"><b>REPRESENTANTES<br>DAS MARCAS: </b></font><font size="-1" color="white" face="arial"><br>(se ultrapassar<br>estas 6 linhas<br>o texto ser&aacute;<br>cortado)</font></td><td><textarea name="representante" cols="38" rows="6" wrap="VIRTUAL"><% =Aspas2Quot(contactoRes("representante")) %></textarea></td></tr>
	<tr><td><font size="-1" color="#FFCC66" face="arial"><b>SERVI&Ccedil;OS<br>DISPON&Iacute;VEIS: </b></font><font size="-1" color="white" face="arial"><br>(se ultrapassar<br>estas 6 linhas<br>o texto ser&aacute;<br>cortado)</font></td><td><textarea name="oferta" cols="38" rows="6" wrap="VIRTUAL"><% =Aspas2Quot(contactoRes("oferta")) %></textarea></td></tr>
	<tr><td><br></td><td></td></tr>
	<tr><td><font size="-1" color="#FFCC66" face="arial"><b>OUTROS: </b></font><font size="-1" color="white" face="arial"><br>(se ultrapassar<br>estas 6 linhas<br>o texto ser&aacute;<br>cortado)</font></td><td><textarea name="outros" cols="38" rows="6" wrap="VIRTUAL"><% =Aspas2Quot(contactoRes("outros")) %></textarea></td></tr>
	<tr><td></td><td><input type="Submit" value="Mudar contacto"></td></tr>
</table>

</form>

<form method="post" action="apagar_contacto_res.asp?contacto=<% =contacto %>">
	<font color="white" face="arial"><b>Para apagar este contacto confirme aqui <input type="Checkbox" name="apagar"> e prima o bot&atilde;o - </b></font><input type="Submit" value="Apagar">
</form>

<% FimPagina() %>
