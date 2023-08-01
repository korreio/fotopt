<!-- #include file="inicio_basedados.asp" -->

<%
mes = request("mes")
ano = request("ano")
%>

<!-- #include file="topo.asp" -->
<td bgcolor="gray" width="100%" align="left"><font size="-1" color="black" face="arial">&nbsp;INSERIR FOTOS NO TEMA DO M&Ecirc;S</font></td>
<!-- #include file="fim_topo.asp" -->
<!-- #include file="autenticar_webmaster.asp" -->

<%
SQL = "UPDATE tema_mes_foto SET vencedora = '0' WHERE tema_mes IN (SELECT id FROM tema_mes WHERE mes = " & mes & " AND ano = " & ano & ")"
dbConnection.Execute(SQL)

SQL = "SELECT * FROM juri_folder_foto WHERE folder = 15"
Set fotoRes = dbConnection.Execute(SQL)

do while not fotoRes.eof
	SQL = "UPDATE tema_mes_foto SET vencedora = '1' WHERE foto = " & fotoRes("foto") & " AND tema_mes IN (SELECT id FROM tema_mes WHERE mes = " & mes & " AND ano = " & ano & ")"
	dbConnection.Execute(SQL)

	fotoRes.MoveNext
loop
%>

<% if mes = 12 then %>
	<meta http-equiv="refresh" content="0;url=../destaque.asp?mes=<% =1 %>&ano=<% =ano + 1%>">
<% else %>
	<meta http-equiv="refresh" content="0;url=../destaque.asp?mes=<% =mes + 1 %>&ano=<% =ano %>">
<% end if %>
<font size="+1" color="white" face="arial"><b>Fotos isneridas com sucesso</b></font>

<!-- #include file="fim_autenticacao.asp" -->
<!-- #include file="fim_basedados.asp" -->