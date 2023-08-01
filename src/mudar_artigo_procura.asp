<!-- #include file="sqltext.asp" -->
<!-- #include file="funcoes_principais.asp" -->

<%
artigo = request("artigo")

SQL = "SELECT * FROM procura_artigo WHERE id = " & artigo
Set artigoRes = dbConnection.Execute(SQL)

autor = artigoRes("autor")
%>

<% 
AutenticarMembro(autor)
Menu 6, 2, "MUDAR OU APAGAR ARTIGO PROCURADO"
%>

<%
SQL = "SELECT nome FROM autor WHERE id = " & autor
Set autorRes = dbConnection.Execute(SQL)

SQL = "SELECT * FROM venda_tipo"
Set tipoRes = dbConnection.Execute(SQL)
%>

<form action="mudar_artigo_procura_res.asp?artigo=<% =artigo %>" method="post">

<table border="0" cellpadding="3" cellspacing="0">
	<tr><td><font size="-1" color="#FFCC66" face="arial"><b>QUEM<br>PROCURA: </b></font></td><td><font color="white" face="arial"><% =autorRes("nome") %></font></td></tr>
	<tr><td><br></td><td></td></tr>	
	<tr>
		<td><font size="-1" color="#FFCC66" face="arial"><b>CATEGORIA: </b></font></td>
		<td><select name="tipo">
			<% do while not tipoRes.eof %>
				<% if artigoRes("tipo") = tipoRes("id") then %>
					<option selected value="<% =tipoRes("id") %>"><% =tipoRes("nome") %></option>
				<% else %>
					<option value="<% =tipoRes("id") %>"><% =tipoRes("nome") %></option>
				<% end if %>
				<% tipoRes.MoveNext %>
			<% loop %>
		</select> <font size="-1" color="white" face="arial">(obrig)</font></td>
	</tr>
	<tr><td><font size="-1" color="#FFCC66" face="arial"><b>ARTIGO: </b></font></td><td><input maxlength="255" value="<% =Aspas2Quot(artigoRes("nome")) %>" type="Text" size="40" name="nome"> <font size="-1" color="white" face="arial">(obrig)</font></td></tr>
	<tr><td><font size="-1" color="#FFCC66" face="arial"><b>OBSERVA&Ccedil;&Otilde;ES: </b></font><font size="-1" color="white" face="arial"><br>(se ultrapassar<br>estas 6 linhas<br>o texto ser&aacute;<br>cortado)</font></td><td><textarea name="observacoes" cols="38" rows="6" wrap="VIRTUAL"><% if artigoRes("observacoes") <> "-1" then %><% =artigoRes("observacoes") %><% end if %></textarea></td></tr>
	
	<tr><td></td><td><input type="Submit" value="Mudar artigo"></td></tr>
</table>

</form>

<form method="post" action="apagar_artigo_procura_res.asp?artigo=<% =artigo %>">
	<font color="#FFCC66" face="arial"><b>Para apagar este artigo confirme aqui <input type="Checkbox" name="apagar"> e prima o bot&atilde;o - </b></font><input type="Submit" value="Apagar">
</form>

<% FimPagina() %>
