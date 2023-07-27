<!-- #include file="funcoes_principais.asp" -->

<% 
AutenticarMembro(autor)
Menu 5, 2, "INSERIR LIVRO" 
%>

<%
SQL = "SELECT nome FROM autor WHERE id = " & session("login")
Set autorRes = dbConnection.Execute(SQL)

SQL = "SELECT * FROM livros_tipo ORDER BY nome"
Set tipoRes = dbConnection.Execute(SQL)
%>

<form action="inserir_livro_res.asp" method="post">

<font size="-1" color="white" face="arial">
<b>Aten&ccedil;&atilde;o</b>: Certifique-se que o livro ainda n&atilde;o existe neste site.
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
	<tr><td><font size="-1" color="#FFCC66" face="arial"><b>NOME DO LIVRO: </b></font><br><font size="-1" color="white" face="arial">(ou da revista)</font></td><td><input maxlength="255" size="40" type="text" name="nome"> <font size="-1" color="white" face="arial">(obrig)</font></td></tr>
	<tr><td><br></td><td></td></tr>				
	<tr><td><font size="-1" color="#FFCC66" face="arial"><b>AUTOR(ES):</b></font></td><td><input maxlength="250" size="40" type="text" name="autores"></td></tr>
	<tr><td><font size="-1" color="#FFCC66" face="arial"><b>EDITORA:</b></font></td><td><input maxlength="50" size="40" type="text" name="editora"></td></tr>
	<tr><td><font size="-1" color="#FFCC66" face="arial"><b>ISBN:</b></font></td><td><input maxlength="50" size="40" type="text" name="isbn"></td></tr>
	<tr><td><br></td><td></td></tr>	
	<tr><td><font size="-1" color="#FFCC66" face="arial"><b>DESCRI&Ccedil;&Atilde;O: </b></font><font size="-1" color="white" face="arial"><br>(se ultrapassar<br>estas 6 linhas<br>o texto ser&aacute;<br>cortado)</font></td><td><textarea name="descricao" cols="38" rows="6" wrap="VIRTUAL"></textarea> <font size="-1" color="white" face="arial">(obrig)</font></td></tr>
	<tr><td><font size="-1" color="#FFCC66" face="arial"><b>COMENT&Aacute;RIOS: </b></font><font size="-1" color="white" face="arial"><br>(se ultrapassar<br>estas 6 linhas<br>o texto ser&aacute;<br>cortado)</font></td><td><textarea name="comentario" cols="38" rows="6" wrap="VIRTUAL"></textarea></td></tr>
	<tr><td></td><td><input type="Submit" value="Inserir Livro"></td></tr>	
</table>

</form>

<% FimPagina() %>
