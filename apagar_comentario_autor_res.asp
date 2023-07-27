<!-- #include file="funcoes_principais.asp" -->

<%
comentario = request("comentario")

' Dados galeria
primeira = request("primeira")
tipo = request("tipo")
id = request("id")
tema = request("tema")
num = request("num")
autor = request("autor")
%>

<% AutenticarMembro(autor) %>

<%
SQL = "SELECT * FROM comentario_autor WHERE id = " & comentario
Set comentarioRes = dbConnection.Execute(SQL)

SQL = "INSERT INTO comentario_autor_apagado (comentario, autor, comentador, data) VALUES "
SQL = SQL & "('" & comentarioRes("comentario") & "','" & comentarioRes("autor") & "','" & comentarioRes("comentador") & "','" & comentarioRes("data") & "')"
dbConnection.Execute(SQL)

SQL = "DELETE FROM comentario_autor WHERE id = " & comentario
dbConnection.Execute(SQL)

ComRefresh "comentarios_autor.asp?id=" & autor & "&primeira=" & primeira & "&tema=" & tema & "&tipo=" & tipo & "&id=" & id & "&num=" & num
Menu 3, 2, "APAGAR COMENTÁRIO AUTOR"
%>

<font size="+1" color="white" face="arial"><b>Comentário apagado com sucesso</b></font>

<% FimPagina() %>
