<!-- #include file="funcoes_principais.asp" -->

<%
comentario = request("comentario")

SQL = "SELECT * FROM comentario_autor WHERE id = " & comentario
Set comentarioRes = dbConnection.Execute(SQL)

SQL = "SELECT id, nome FROM autor WHERE id = " & comentarioRes("autor")
Set autorRes = dbConnection.Execute(SQL)

' Dados referentes a galeria
primeira = request("primeira")
tipo = request("tipo")
id = request("id")
tema = request("tema")
num = request("num")
autor = request("autor")
%>

<%
AutenticarMembro(autor)
Menu 3, 2, "REMOVER COMENTARIO AUTOR"
%>

<font size="-1" color="white" face="arial">
Esta op&ccedil;&atilde;o serve para remover este comentário,<br>
depois de removido, não será possivel recuperá-lo.
</font>

<form action="apagar_comentario_autor_res.asp?comentario=<% =comentario %>&autor=<% =autor %>&primeira=<% =primeira %>&tema=<% =tema %>&tipo=<% =tipo %>&id=<% =id %>&num=<% =num %>" method=post>
<table border="0" cellpadding="3" cellspacing="0">
	<tr><td><font size="-1" color="#FFCC66" face="arial"><b>AUTOR DO<br>COMENTÁRIO:</b> </font></td><td><font size="-1" color="white" face="arial"><% =autorRes("nome") %></font></td></tr>
	<tr><td></td><td><input type="Submit" value="Remover comentário"></td></tr>
</table>
</form>

<% FimPagina() %>
