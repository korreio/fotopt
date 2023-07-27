<!-- #include file="sqltext.asp" -->
<!-- #include file="funcoes_principais.asp" -->

<%
aviso = request("aviso")

SQL = "SELECT * FROM avisos_webmaster WHERE id = " & aviso
Set avisoRes = dbConnection.Execute(SQL)

autor = avisoRes("autor")
%>

<% 
AutenticarMembro(autor)
Menu 3, 1, "APAGAR MENSAGEM DO WEBMASTER"
%>

<font size="-1" color="white" face="arial">Para responder a esta mensagem pode usar o email: <a href="mailto:info@fotopt.net">info@fotopt.net</a></font><br><br>

<table border="1" cellpadding="10" cellspacing="0">
	<tr><td><font size="-1" color="#FFCC66" face="arial"><b>DATA: </b></font></td><td><font color="white" face="arial"><% =day(avisoRes("data")) %>/<% =month(avisoRes("data")) %>/<% =year(avisoRes("data")) %></font></td></tr>
	<tr><td><font size="-1" color="#FFCC66" face="arial"><b>MENSAGEM: </b></font></td><td><font color="white" face="arial"><% =avisoRes("texto") %></font></td></tr>
</table>

<form method="post" action="apagar_aviso_res.asp?aviso=<% =aviso %>">
	<font color="#FFCC66" face="arial"><b>Para apagar esta mensagem, confirme aqui <input type="Checkbox" name="apagar"> e prima o bot&atilde;o - </b></font><input type="Submit" value="Apagar">
</form>

<% FimPagina() %>
