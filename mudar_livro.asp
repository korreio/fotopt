<!-- #include file="sqltext.asp" -->
<!-- #include file="funcoes_principais.asp" -->

<%
livro = request("livro")

SQL = "SELECT * FROM livros WHERE id = " & livro
Set livroRes = dbConnection.Execute(SQL)

autor = livroRes("autor")
%>

<% 
AutenticarMembro(autor)
Menu 5, 2, "ALTERAR OU APAGAR LIVRO"
%>

<%
SQL = "SELECT nome FROM autor WHERE id = " & autor
Set autorRes = dbConnection.Execute(SQL)

SQL = "SELECT * FROM livros_tipo ORDER BY nome"
Set tipoRes = dbConnection.Execute(SQL)
%>

<form action="mudar_livro_res.asp?livro=<% =livro %>" method="post">

<table border="0" cellpadding="3" cellspacing="0">
	<tr>
		<td><font size="-1" color="#FFCC66" face="arial"><b>TIPO: </b></font></td>
		<td><select name="tipo">
			<% do while not tipoRes.eof %>
				<% if tipoRes("id") = livroRes("tipo") then %>
					<option selected value="<% =tipoRes("id") %>"><% =tipoRes("nome") %></option>
				<% else %>
					<option value="<% =tipoRes("id") %>"><% =tipoRes("nome") %></option>
				<% end if %>
				<% tipoRes.MoveNext %>
			<% loop %>
		</select> <font size="-1" color="white" face="arial">(obrig)</font></td>
	</tr>
	<tr><td><font size="-1" color="#FFCC66" face="arial"><b>NOME DO LIVRO: </b></font><br><font size="-1" color="white" face="arial">(ou da revista)</font></td><td><input value="<% =Aspas2Quot(livroRes("nome")) %>" maxlength="255" size="40" type="text" name="nome"> <font size="-1" color="white" face="arial">(obrig)</font></td></tr>
	<tr><td><br></td><td></td></tr>				
	<tr><td><font size="-1" color="#FFCC66" face="arial"><b>AUTOR(ES):</b></font></td><td><input value="<% =Aspas2Quot(livroRes("autores")) %>" maxlength="250" size="40" type="text" name="autores"></td></tr>
	<tr><td><font size="-1" color="#FFCC66" face="arial"><b>EDITORA:</b></font></td><td><input value="<% =Aspas2Quot(livroRes("editora")) %>" maxlength="50" size="40" type="text" name="editora"></td></tr>
	<tr><td><font size="-1" color="#FFCC66" face="arial"><b>ISBN:</b></font></td><td><input value="<% =Aspas2Quot(livroRes("isbn")) %>" maxlength="50" size="40" type="text" name="isbn"></td></tr>
	<tr><td><br></td><td></td></tr>				
	<tr><td><font size="-1" color="#FFCC66" face="arial"><b>DESCRI&Ccedil;&Atilde;O: </b></font><font size="-1" color="white" face="arial"><br>(se ultrapassar<br>estas 6 linhas<br>o texto ser&aacute;<br>cortado)</font></td><td><textarea name="descricao" cols="38" rows="6" wrap="VIRTUAL"><% =livroRes("descricao") %></textarea> <font size="-1" color="white" face="arial">(obrig)</font></td></tr>
	<tr><td><font size="-1" color="#FFCC66" face="arial"><b>COMENT&Aacute;RIOS: </b></font><font size="-1" color="white" face="arial"><br>(se ultrapassar<br>estas 6 linhas<br>o texto ser&aacute;<br>cortado)</font></td><td><textarea name="comentario" cols="38" rows="6" wrap="VIRTUAL"><% =livroRes("comentario") %></textarea></td></tr>
	<tr><td></td><td><input type="Submit" value="Mudar Livro"></td></tr>	
</table>

</form>

<form method="post" action="apagar_livro_res.asp?livro=<% =livro %>">
	<font color="#FFCC66" face="arial"><b>Para apagar este livro confirme aqui <input type="Checkbox" name="apagar"> e prima o bot&atilde;o - </b></font><input type="Submit" value="Apagar">
</form>

<% FimPagina() %>
