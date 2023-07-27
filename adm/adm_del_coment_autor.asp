<!-- #include file="topo.asp" -->
<td bgcolor="gray" width="100%" align="left"><font size="-1" color="black" face="arial">&nbsp;APAGAR COMENT&Aacute;RIO AUTOR</font></td>
<!-- #include file="fim_topo.asp" -->
<!-- #include file="autenticar_webmaster.asp" -->
<!-- #include file="inicio_basedados.asp" -->

<%
comentario = request("comentario")
autor = request("id")

' Dados galeria
primeira = request("primeira")
tema = request("tema")

SQL = "DELETE FROM comentario_autor WHERE id = " & comentario
dbConnection.Execute(SQL)
%>

<meta http-equiv="refresh" content="0;url=../comentarios_autor.asp?id=<% =autor %>&primeira=<% =primeira %>&tema=<% =tema %>">
<font size="+1" color="white" face="arial"><b>Comet&aacute;rio apagado com sucesso</b></font>

<!-- #include file="fim_autenticacao.asp" -->
<!-- #include file="fim_basedados.asp" -->