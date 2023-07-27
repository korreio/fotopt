<!-- #include file="funcoes_principais.asp" -->

<%
foto = request("foto")
autor = session("login")

' Dados referentes a galeria
primeira = request("primeira")
tipo = request("tipo")
id = request("id")
tema = request("tema")
num = request("num")
%>

<%
AutenticarMembro(autor)
ComRefresh "foto.asp?foto=" & foto & "&primeira=" & primeira & "&tema=" & tema & "&tipo=" & tipo & "&id=" & id & "&num=" & num
Menu 1, GaleriaSubSeccao(tipo, id), "REMOVER FOTO DA MINHA GALERIA DE PREFERIDAS"

SQL = "DELETE FROM preferidas_fotos WHERE foto = " & foto & " AND autor = " & autor
dbConnection.Execute(SQL)
%>

<font size="+1" color="white" face="arial"><b>Foto removida com sucesso</b></font>

<% FimPagina() %>
