<!-- #include file="funcoes_principais.asp" -->
<!-- #include file="ordem_galeria.asp" -->

<%
'SQL = "SELECT distinct(autor.id), autor.nome FROM autor INNER JOIN autor_mencao_honrosa ON autor.id = autor_mencao_honrosa.autor ORDER by nome"
'Set autorRes = dbConnection.Execute(SQL)

mes = month(date())
ano = year(date())
if (mes + 1) = 13 then
	proximoMes = 1
	proximoAno = ano + 1
else
	proximoMes = mes + 1
	proximoAno = ano
end if

SQL = "SELECT distinct(autor.id), autor.nome FROM autor INNER JOIN autor_mes ON autor.id = autor_mes.autor"
SQL = SQL & " WHERE NOT (autor_mes.mes = " & proximoMes & " AND autor_mes.ano = " & proximoAno & ") ORDER by nome"
Set autorDestacadoRes = dbConnection.Execute(SQL)

num = 0
do while not autorDestacadoRes.eof
	num = num + 1
	autorDestacadoRes.MoveNext
loop
	if num > 0 then
	autorDestacadoRes.MoveFirst 
end if

if (num mod 3) = 0 then
	porColunaDestacados = num / 3
else
	porColunaDestacados = num / 3 + 1
end if


SQL = "SELECT distinct(autor.id), autor.nome FROM autor INNER JOIN autor_mencao_honrosa ON autor.id = autor_mencao_honrosa.autor ORDER by nome"
Set autorMencaoRes = dbConnection.Execute(SQL)

num = 0
do while not autorMencaoRes.eof
	num = num + 1
	autorMencaoRes.MoveNext
loop
	if num > 0 then
	autorMencaoRes.MoveFirst 
end if

if (num mod 3) = 0 then
	porColunaMencao = num / 3
else
	porColunaMencao = num / 3 + 1
end if
%>

<% 
Menu 1, 2, "GALERIAS DE MEMBROS DESTACADOS" 
%>

<font size="-1" color="white" face="arial">
	Membros antigamente escolhidos pelo <a href="arquivo/juri.asp">júri</a> que existia no site.
</font><br><br>

<table border="1" cellspacing="0" cellpadding="10">
  <tr>
    <td colspan="5">
		<font color="white" face="arial"><b>AUTORES DESTACADOS</b></font>
		<br>
		
		<table border="0" cellspacing="0" cellpadding="0"><tr>
		<% for j = 1 to 3 %>
			<td valign="top"><table border="0" cellspacing="0" cellpadding="3">
			<% 
			for i = 1 to porColunaDestacados
				if not autorDestacadoRes.eof then
			%>
					<tr><td><a href="lista_temas.asp?autor=<% =autorDestacadoRes("id") %>"><font size="-2" color="#ffcc66" face="verdana, arial"><b><% =autorDestacadoRes("nome") %></b></font></a><font size="-2">&nbsp;&nbsp;</font></td></tr>
		<% 
				autorDestacadoRes.MoveNext
				end if
			next
		%>
			</table></td>
		<% next %>
		</tr></table>
	</td>
  </tr>

  <tr>
    <td colspan="5">
		<font color="white" face="arial"><b>AUTORES COM MENÇÃO HONROSA</b></font>
		<br>
		
		<table border="0" cellspacing="0" cellpadding="0"><tr>
		<% for j = 1 to 3 %>
			<td valign="top"><table border="0" cellspacing="0" cellpadding="3">
			<% 
			for i = 1 to porColunaMencao
				if not autorMencaoRes.eof then
			%>
					<tr><td><a href="lista_temas.asp?autor=<% =autorMencaoRes("id") %>"><font size="-2" color="#ffcc66" face="verdana, arial"><b><% =autorMencaoRes("nome") %></b></font></a><font size="-2">&nbsp;&nbsp;</font></td></tr>
		<% 
				autorMencaoRes.MoveNext
				end if
			next
		%>
			</table></td>
		<% next %>
		</tr></table>
	</td>
  </tr>
</table>

<br>
<a href="direitos_autor.asp"><font size="-2" color="white" face="arial">Direitos de autor</font></a><font size="-2" color="white" face="arial">: As imagens sao propriedade do autor ou dos seus clientes, podendo ser reproduzida somente com autorização dos mesmos.</font>

<% FimPagina() %>
