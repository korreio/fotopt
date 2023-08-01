<!-- #include file="funcoes_principais.asp" -->

<%
comentario = clng(request("comentario"))

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
if comentario = -1 then
	SQL = "UPDATE comentario_autor SET moderar = '0'"
	SQL = SQL & "WHERE autor = " & autor
	dbConnection.Execute(SQL)
else
	SQL = "UPDATE comentario_autor SET moderar = '0'"
	SQL = SQL & "WHERE id = " & comentario
	dbConnection.Execute(SQL)
end if

ComRefresh "comentarios_autor.asp?id=" & autor & "&primeira=" & primeira & "&tema=" & tema & "&tipo=" & tipo & "&id=" & id & "&num=" & num
Menu 3, 2, "APROVAR COMENTÁRIO AUTOR"
%>

<font size="+1" color="white" face="arial"><b>Comentário aprovado com sucesso</b></font>

<% FimPagina() %>
