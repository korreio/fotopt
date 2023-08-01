<!-- #include file="funcoes_principais.asp" -->

<%
comentario = clng(request("comentario"))
foto = clng(request("foto"))

if comentario = -1 then
	SQL = "SELECT * FROM foto WHERE id = " & foto
	Set fotoRes = dbConnection.Execute(SQL)
else
	SQL = "SELECT * FROM comentario WHERE id = " & comentario
	Set comentarioRes = dbConnection.Execute(SQL)

	SQL = "SELECT * FROM foto WHERE id = " & comentarioRes("foto")
	Set fotoRes = dbConnection.Execute(SQL)
end if

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
if comentario = -1 then
	SQL = "UPDATE comentario SET moderar = '0'"
	SQL = SQL & "WHERE foto = " & fotoRes("id")
	dbConnection.Execute(SQL)
else
	SQL = "UPDATE comentario SET moderar = '0'"
	SQL = SQL & "WHERE id = " & comentario
	dbConnection.Execute(SQL)
end if

ComRefresh "comentarios.asp?foto=" & fotoRes("id") & "&primeira=" & primeira & "&tema=" & tema & "&tipo=" & tipo & "&id=" & id & "&num=" & num
Menu 1, GaleriaSubSeccao(tipo, id), "APROVAR COMENTÁRIO"
%>

<font size="+1" color="white" face="arial"><b>Comentário aprovado com sucesso</b></font>

<% FimPagina() %>
