<!-- #include file="funcoes_principais.asp" -->

<%
autor_preferido = request("autor_preferido")
autor = session("login")

SQL = "SELECT id, nome FROM autor WHERE id = " & autor_preferido
Set autorRes = dbConnection.Execute(SQL)
%>

<%
AutenticarMembro(autor)
Menu 3, 4, "INSERIR AUTOR NA MINHA LISTA DE PREFERIDOS"
%>

<font size="-1" color="white" face="arial">
Esta op&ccedil;&atilde;o serve para colocar este autor na sua lista de autores preferidos.
Pode aceder a essa lista atrav&eacute;s da op&ccedil;&atilde;o <b>AUTORES PREFERIDOS</b> na sua ficha de membro.<br>
Para remover este autor dos seus preferidos volte a ficha de membro do autor e escolha a op��o REMOVER DOS MEUS PREFERIDOS.
</font>

<form action="inserir_preferidos_autor_res.asp?autor_preferido=<% =autor_preferido %>" method=post>
<table border="0" cellpadding="3" cellspacing="0">
	<tr><td><font size="-1" color="#FFCC66" face="arial"><b>ID:</b> </font></td><td><font size="-1" color="white" face="arial"><% =autor_preferido %></font></td></tr>
	<tr><td><font size="-1" color="#FFCC66" face="arial"><b>NOME:</b> </font></td><td><font size="-1" color="white" face="arial"><% =autorRes("nome") %></font></td></tr>
	<tr><td></td><td><input type="Submit" value="Inserir nos preferidos"></td></tr>
</table>
</form>

<% FimPagina() %>
