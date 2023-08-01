<!-- #include file="inicio_basedados.asp" -->

<%
autor = request("autor")
juri = request("juri")
%>

<!-- #include file="topo.asp" -->
<td bgcolor="gray" width="100%" align="left"><font size="-1" color="black" face="arial">&nbsp;REMOVER AUTOR M&Ecirc;S</font></td>
<!-- #include file="fim_topo.asp" -->
<!-- #include file="autenticar_webmaster.asp" -->

<%
SQL = "DELETE FROM juri_autor_mes WHERE juri = " & juri & " AND autor = " & autor
dbConnection.Execute(SQL)
%>

<meta http-equiv="refresh" content="0;url=../juri/juri_autor_mes.asp">
<font size="+1" color="white" face="arial"><b>Autor removido com sucesso</b></font>

<!-- #include file="fim_autenticacao.asp" -->
<!-- #include file="fim_basedados.asp" -->