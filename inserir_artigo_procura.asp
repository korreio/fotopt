<!-- #include file="funcoes_principais.asp" -->

<% 
AutenticarMembro(autor)
Menu 6, 2, "INSERIR ARTIGO PROCURADO"
%>

<%
SQL = "SELECT nome FROM autor WHERE id = " & session("login")
Set autorRes = dbConnection.Execute(SQL)

SQL = "SELECT * FROM venda_estado"
Set estadoRes = dbConnection.Execute(SQL)

SQL = "SELECT * FROM venda_tipo"
Set tipoRes = dbConnection.Execute(SQL)

SQL = "SELECT * FROM venda_moeda"
Set moedaRes = dbConnection.Execute(SQL)
%>

<form action="inserir_artigo_procura_res.asp" method="post">

<table border="0" cellpadding="3" cellspacing="0">
	<tr>
		<td><font size="-1" color="#FFCC66" face="arial"><b>ATEN&Ccedil;&Atilde;O: </b></font></td>
		<td><font color="white" face="arial">
			Para que esta sec&ccedil;&atilde;o n&atilde;o fique carregada de an&uacute;ncios desactualizados, por favor apague este registo assim
			que j&aacute; n&atilde;o estiver interessado em comprar o artigo referido. Todos os artigos ser�o removidos autom�ticamente 
			ao fim de um m�s, podendo voltar a inseri-los quantas vezes for necess�rio.
		</font></td>
	</tr>
	<tr><td><font size="-1" color="#FFCC66" face="arial"><b>QUEM<br>PROCURA: </b></font></td><td><font color="white" face="arial"><% =autorRes("nome") %></font></td></tr>
	<tr><td><br></td><td></td></tr>	
	<tr>
		<td><font size="-1" color="#FFCC66" face="arial"><b>CATEGORIA: </b></font></td>
		<td><select name="tipo">
			<% do while not tipoRes.eof %>
				<option value="<% =tipoRes("id") %>"><% =tipoRes("nome") %></option>
				<% tipoRes.MoveNext %>
			<% loop %>
		</select> <font size="-1" color="white" face="arial">(obrig)</font></td>
	</tr>
	<tr><td><font size="-1" color="#FFCC66" face="arial"><b>ARTIGO: </b></font></td><td><input maxlength="255" type="Text" size="40" name="nome"> <font size="-1" color="white" face="arial">(obrig)</font></td></tr>
	<tr><td><font size="-1" color="#FFCC66" face="arial"><b>OBSERVA&Ccedil;&Otilde;ES: </b></font><font size="-1" color="white" face="arial"><br>(se ultrapassar<br>estas 6 linhas<br>o texto ser&aacute;<br>cortado)</font></td><td><textarea name="observacoes" cols="38" rows="6" wrap="VIRTUAL"></textarea></td></tr>
	<tr><td></td><td><input type="Submit" value="Inserir artigo"></td></tr>
</table>

</form>

<% FimPagina() %>
