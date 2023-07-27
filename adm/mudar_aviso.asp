<!-- #include file="topo.asp" -->
<td bgcolor="gray" width="100%" align="left"><font size="-1" color="black" face="arial">&nbsp;MUDAR MENSAGEM</font></td>
<!-- #include file="fim_topo.asp" -->
<!-- #include file="autenticar_webmaster.asp" -->
<!-- #include file="inicio_basedados.asp" -->

<%
aviso = request("aviso")

SQL = "SELECT * FROM avisos_webmaster WHERE id = " & aviso
Set avisoRes = dbConnection.Execute(SQL)
%>

<form action="mudar_aviso_res.asp?id=<% =aviso %>" method=post>

<table border="0" cellpadding="3" cellspacing="0">
	<tr><td><font size="-1" color="#FFCC66" face="arial"><b>MENSAGEM: </b></font></td><td><textarea name="mensagem" cols="38" rows="6" wrap="VIRTUAL"><% =avisoRes("texto") %></textarea> <font size="-1" color="white" face="arial">(obrig)</font></td></tr>
	<tr><td></td><td><input type="Submit" value="Mudar Mensagem"></td></tr>
</table>

</form>

<form method="post" action="adm_apagar_aviso_res.asp?aviso=<% =aviso %>">
	<font color="#FFCC66" face="arial"><b>Para apagar esta mensagem confirme aqui <input type="Checkbox" name="apagar"> e prima o bot&atilde;o - </b></font><input type="Submit" value="Apagar">
</form>

<!-- #include file="fim_autenticacao.asp" -->
<!-- #include file="fim_basedados.asp" -->