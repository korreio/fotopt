<!-- #include file="../sqltext.asp" -->
<!-- #include file="inicio_basedados.asp" -->

<%
tipo = request("tipo")
tema = request("tema")
mes = request("mes")
ano = request("ano")
nome = sqltext(request("nome"))
descricao = sqltextMemo(request("descricao"))
%>

<!-- #include file="topo.asp" -->
<td bgcolor="gray" width="100%" align="left"><font size="-1" color="black" face="arial">&nbsp;TRANSFERIR FOTOS PARA GALERIA DESTAQUE</font></td>
<!-- #include file="fim_topo.asp" -->
<!-- #include file="autenticar_webmaster.asp" -->

<%
if tipo = 0 then
	SQL = "INSERT INTO destaque_galeria (nome, descricao, mes, ano) VALUES ('" & nome & "','" & descricao & "','" & mes & "','" & ano & "')"
	dbConnection.Execute(SQL)

	SQL = "SELECT id FROM destaque_galeria WHERE mes = " & mes & " AND ano = " & ano & " ORDER BY id DESC"
	Set galeriaRes = dbConnection.Execute(SQL)

	SQL = "SELECT * FROM juri_folder_foto WHERE folder = " & tema
	Set fotoRes = dbConnection.Execute(SQL)

	do while not fotoRes.eof
		SQL = "INSERT INTO destaque_galeria_foto (foto, galeria_destaque) VALUES ('" & fotoRes("foto") & "','" & galeriaRes("id") & "')"
		dbConnection.Execute(SQL)

		SQL = "DELETE FROM juri_folder_foto WHERE id = " & fotoRes("id")
		dbConnection.Execute(SQL)
	
		fotoRes.MoveNext
	loop
else
	SQL = "SELECT * FROM juri_folder_foto WHERE folder = " & tema
	Set fotoRes = dbConnection.Execute(SQL)

	do while not fotoRes.eof
		SQL = "INSERT INTO associados_galerias (foto, mes, ano, associado) VALUES ('" & fotoRes("foto") & "','" & mes & "','" & ano & "','" & tipo & "')"
		dbConnection.Execute(SQL)

		SQL = "DELETE FROM juri_folder_foto WHERE id = " & fotoRes("id")
		dbConnection.Execute(SQL)
	
		fotoRes.MoveNext
	loop
end if

SQL = "DELETE FROM juri_folder WHERE id = " & tema
dbConnection.Execute(SQL)
%>

<meta http-equiv="refresh" content="0;url=../destaque.asp?mes=<% =mes %>&ano=<% =ano %>">
<font size="+1" color="white" face="arial"><b>Fotos inseridas com sucesso</b></font>

<!-- #include file="fim_autenticacao.asp" -->
<!-- #include file="fim_basedados.asp" -->