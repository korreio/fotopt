<!-- #include file="funcoes_principais.asp" -->
<% 
AutenticarMembro(autor)
Menu 5, 3, "INSERIR LINK"
%>

<%
SQL = "SELECT nome FROM autor WHERE id = " & session("login")
Set autorRes = dbConnection.Execute(SQL)

SQL = "SELECT * FROM links_tipo ORDER BY nome"
Set tipoRes = dbConnection.Execute(SQL)
%>

<form action="inserir_link_res.asp" method="post">

<font size="-1" color="white" face="arial">
<b>Aten&ccedil;&atilde;o</b>: Certifique-se que o link ainda n&atilde;o existe neste site e que o URL est&aacute; correcto.
</font>
<br><br>

<table border="0" cellpadding="3" cellspacing="0">
	<tr>
		<td><font size="-1" color="#FFCC66" face="arial"><b>TIPO: </b></font></td>
		<td><select name="tipo">
			<% do while not tipoRes.eof %>
				<option value="<% =tipoRes("id") %>"><% =tipoRes("nome") %></option>
				<% tipoRes.MoveNext %>
			<% loop %>
		</select> <font size="-1" color="white" face="arial">(obrig)</font></td>
	</tr>
	<tr><td><font size="-1" color="#FFCC66" face="arial"><b>LINK</b> (url)<b>:</b></font></td><td><input value="http://" maxlength="255" size="40" type="text" name="link"> <font size="-1" color="white" face="arial">(obrig)</font></td></tr>
	<tr><td><br></td><td></td></tr>				
	<tr><td><font size="-1" color="#FFCC66" face="arial"><b>NOME DO SITE: </b></font></td><td><input maxlength="255" size="40" type="text" name="nome"></td></tr>
	<tr><td><font size="-1" color="#FFCC66" face="arial"><b>DESCRI&Ccedil;&Atilde;O: </b></font><font size="-1" color="white" face="arial"><br>(se ultrapassar<br>estas 6 linhas<br>o texto ser&aacute;<br>cortado)</font></td><td><textarea name="descricao" cols="38" rows="6" wrap="VIRTUAL"></textarea></td></tr>
	<tr><td></td><td><input type="Submit" value="Inserir Link"></td></tr>	
</table>

</form>

<% FimPagina() %>
