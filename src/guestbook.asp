<!-- #include file="funcoes_principais.asp" -->

<%
OpcaoMenu "VER LIVRO DE VISITAS", "guestbook_paises.asp", False, False, -1, False, False
Menu 2, 3, "LIVRO DE VISITAS"
%>

<%
SQL = "SELECT id, nome_pt FROM Paises_todos WHERE id > 0 ORDER BY nome_pt"
Set paisRes = dbConnection.Execute(SQL)
%>

<font color="white" size="-1" face="Arial">
Ajude-nos a melhorar este <i>site</i> assinando este livro de visitas.
Qualquer sugest&atilde;o, critica ou queixa &eacute; bem vinda. Os &uacute;nicos
campos obrigat&oacute;rios s&atilde;o o <b>pa&iacute;s</b> e <b>o seu nome</b>.
Se quiser inscrever-se v&aacute; antes &agrave; sec&ccedil;&atilde;o <b>INSCRI&Ccedil;&Atilde;O</b>.
</font>

<form action="guestbook_res.asp" method=post>

<table border="0" cellpadding="3" cellspacing="0">
	<tr><td><font color="#FFCC66" size="-1" face="arial"><b>O SEU NOME: </b></font></td><td><input maxlength="255" size="40" type="Text" name="nome"> <font size="-1" color="white" face="arial">(obrig)</font></td></tr>
	<tr><td><br></td><td></td></tr>	
	<tr>
		<td><font color="#FFCC66" size="-1" face="arial"><b>PA&Iacute;S: </b></font></td>
		<td>
			<select name="pais">
			<% do while not paisRes.eof %>
				<% if paisRes("id") = 139 then %>
					<option selected value="<% =paisRes("id") %>"><% =paisRes("nome_pt") %></option>
				<% else %>
					<option value="<% =paisRes("id") %>"><% =paisRes("nome_pt") %></option>
				<% end if %>
				<% paisRes.MoveNext %>
			<% loop %>
			</select> <font size="-1" color="white" face="arial">(obrigat&oacute;rio)</font></td>
		</td>
	</tr>
	<tr><td><font color="#FFCC66" size="-1" face="arial"><b>E-MAIL: </b></font></td><td><input maxlength="255" size="40" type="Text" name="email"></td></tr>
	<tr><td><br></td><td></td></tr>		
	<tr><td><font color="#FFCC66" size="-1" face="arial"><b>COMENT&Aacute;RIO: </b></font><font size="-1" color="white" face="arial"><br>(se ultrapassar<br>estas 6 linhas<br>o texto ser&aacute;<br>cortado)</font></td><td><textarea name="comentario" cols="38" rows="6" wrap="VIRTUAL"></textarea></td></tr>
	<tr><td><br></td><td></td></tr>	
	<tr><td><font color="#FFCC66" size="-1" face="arial"><b>COMO DESCOBRIU<br>ESTE SITE?: </b></font></td><td><input maxlength="255" size="40" type="Text" name="como_chegou_ca"></td></tr>
	<tr><td></td><td><input type="Submit" value="Submeter"></td></tr>
</table>
</form>

<% FimPagina() %>
