<!-- #include file="funcoes_principais.asp" -->

<%
AutenticarMembro(autor)
Menu 7, 2, "INSERIR ITEM NUMA VOTA��O"
%>

<%
votacao = request("votacao")

SQL = "SELECT nome FROM autor WHERE id = " & session("login")
Set autorRes = dbConnection.Execute(SQL)

SQL = "SELECT nome FROM votacao_topico WHERE id = " & votacao
Set votacaoRes = dbConnection.Execute(SQL)
%>

<form action="inserir_item_res.asp?votacao=<% =votacao %>" method=post>

<table border="0" cellpadding="3" cellspacing="0">
	<tr><td><font size="-1" color="#FFCC66" face="arial"><b>VOTA&Ccedil;&Atilde;O: </b></font></td><td><font color="white" face="arial"><% =votacaoRes("nome") %></font></td></tr>
	<tr><td><font size="-1" color="#FFCC66" face="arial"><b>CRIADOR: </b></font></td><td><font color="white" face="arial"><% =autorRes("nome") %></font></td></tr>
	<tr><td></td><td></td></tr>
	<tr><td><font size="-1" color="#FFCC66" face="arial"><b>ITEM<br>A INSERIR: </b></font></td><td><input maxlength="100" type="Text" name="nome" size="40"> <font size="-1" color="white" face="arial">(obrig)</font></td></tr>
	<tr><td></td><td><input type="Submit" value="Inserir item"></td></tr>
</table>

</form>

<% FimPagina() %>
