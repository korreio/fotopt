<!-- #include file="topo.asp" -->
<td bgcolor="gray" width="100%" align="left"><font size="-1" color="black" face="arial">&nbsp;MUDAR OU APAGAR ITEM</font></td>
<!-- #include file="fim_topo.asp" -->
<!-- #include file="autenticar_webmaster.asp" -->
<!-- #include file="inicio_basedados.asp" -->

<%
item = request("item")
votacao = request("votacao")

SQL = "SELECT nome FROM votacao_topico WHERE id = " & votacao
Set votacaoRes = dbConnection.Execute(SQL)

SQL = "SELECT nome FROM votacao_item WHERE id = " & item
Set itemRes = dbConnection.Execute(SQL)
%>

<form action="adm_mudar_item_res.asp?votacao=<% =votacao %>&item=<% =item %>" method=post>

<table border="0" cellpadding="3" cellspacing="0">
	<tr>
		<td><font size="-1" color="#FFCC66" face="arial"><b>VOTA&Ccedil;&Atilde;O: </b></font></td>
		<td><font color="white" face="arial"><% =votacaoRes("nome") %></font></td>
	</tr>
	<tr>
		<td><font size="-1" color="#FFCC66" face="arial"><b>ITEM: </b></font></td>
		<td><input value="<% =itemRes("nome") %>" maxlength="255" type="Text" name="nome" size="40"> <font size="-1" color="white" face="arial">(obrig)</font></td>
	</tr>
	<tr><td></td><td><input type="Submit" value="Mudar item"></td></tr>
</table>

</form>

<form method="post" action="adm_apagar_item.asp?item=<% =item %>&votacao=<% =votacao %>">
	<font color="#FFCC66" face="arial"><b>Para apagar este item corfirme aqui <input type="Checkbox" name="apagar"> e prima o bot&atilde;o - </b></font><input type="Submit" value="Apagar">
</form>

<!-- #include file="fim_autenticacao.asp" -->
<!-- #include file="fim_basedados.asp" -->