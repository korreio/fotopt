<!-- #include file="../sqltext.asp" -->
<!-- #include file="inicio_basedados.asp" -->

<%
mes = request("mes")
ano = request("ano")
nome = sqltext(request("nome"))
descricao = sqltextMemo(request("descricao"))
%>

<!-- #include file="topo.asp" -->
<td bgcolor="gray" width="100%" align="left"><font size="-1" color="black" face="arial">&nbsp;MUDAR GALERIA M&Ecirc;S</font></td>
<!-- #include file="fim_topo.asp" -->
<!-- #include file="autenticar_webmaster.asp" -->

<%
SQL = "UPDATE destaque_galeria SET nome = '" & nome & "', descricao = '" & descricao & "' WHERE mes = " & mes & " AND ano = " & ano
dbConnection.Execute(SQL)
%>

<meta http-equiv="refresh" content="0;url=../destaque.asp?mes=<% =mes %>&ano=<% =ano %>">
<font size="+1" color="white" face="arial"><b>Dados modificados com sucesso</b></font>

<!-- #include file="fim_autenticacao.asp" -->
<!-- #include file="fim_basedados.asp" -->