<!-- #include file="sqltext.asp" -->
<!-- #include file="funcoes_principais.asp" -->

<%
foto = request("foto")

' Dados referentes a galeria
primeira = request("primeira")
evento = request("evento")
num = request("num")

SQL = "SELECT * FROM eventos_fotopt_foto WHERE id = " & foto
Set fotoRes = dbConnection.Execute(SQL)

titulo = SqlText(request("titulo"))
descricao = SqlText(request("descricao"))

autor = fotoRes("autor")
%>

<% AutenticarMembro(autor) %>

<%
SQL = "UPDATE eventos_fotopt_foto SET "
SQL = SQL & "titulo = '" & titulo & "',"
SQL = SQL & "descricao = '" & descricao & "' "
SQL = SQL & "WHERE id = " & foto
dbConnection.Execute(SQL)

ComRefresh "foto_evento.asp?foto=" & foto & "&primeira=" & primeira & "&evento=" & evento & "&num=" & num
Menu 2, 4, "ALTERAR FOTO"
%>

<font size="+1" color="white" face="arial"><b>Foto modificada com sucesso</b></font>

<% FimPagina() %>
