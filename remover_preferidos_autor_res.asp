<!-- #include file="funcoes_principais.asp" -->

<%
autor_preferido = request("autor_preferido")
autor = session("login")
%>

<%
AutenticarMembro(autor)
ComRefresh "autor.asp?autor=" & autor_preferido
Menu 3, 4, "REMOVER AUTOR DA MINHA LISTA DE PREFERIDOS"

SQL = "DELETE FROM preferido_autor WHERE autor_preferido = " & autor_preferido & " AND autor = " & autor
dbConnection.Execute(SQL)
%>

<font size="+1" color="white" face="arial"><b>Autor removido com sucesso</b></font>

<% FimPagina() %>
