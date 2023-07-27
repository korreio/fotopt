<!-- #include file="funcoes_principais.asp" -->

<%
comentario = request("comentario")

SQL = "SELECT * FROM comentario WHERE id = " & comentario
Set comentarioRes = dbConnection.Execute(SQL)

SQL = "SELECT * FROM foto WHERE id = " & comentarioRes("foto")
Set fotoRes = dbConnection.Execute(SQL)

' Dados galeria
primeira = request("primeira")
tipo = request("tipo")
id = request("id")
tema = request("tema")
num = request("num")

autor = fotoRes("autor")
%>

<% AutenticarMembro(autor) %>

<%
SQL = "SELECT * FROM comentario WHERE id = " & comentario
Set comentarioRes = dbConnection.Execute(SQL)

SQL = "INSERT INTO comentario_apagado (comentario, foto, autor, data, autor_foto) VALUES "
SQL = SQL & "('" & comentarioRes("comentario") & "','" & comentarioRes("foto") & "','" & comentarioRes("autor") & "','" & comentarioRes("data") & "','" & autor & "')"
dbConnection.Execute(SQL)

SQL = "DELETE FROM comentario WHERE id = " & comentario
dbConnection.Execute(SQL)

ComRefresh "comentarios.asp?foto=" & fotoRes("id") & "&primeira=" & primeira & "&tema=" & tema & "&tipo=" & tipo & "&id=" & id & "&num=" & num
Menu 1, GaleriaSubSeccao(tipo, id), "APAGAR COMENTÁRIO"
%>

<font size="+1" color="white" face="arial"><b>Comentário apagado com sucesso</b></font>

<% FimPagina() %>
