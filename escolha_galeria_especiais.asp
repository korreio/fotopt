<!-- #include file="funcoes_principais.asp" -->
<!-- #include file="ordem_galeria.asp" -->

<%
Dim meses
meses = Array("JAN", "FEV", "MAR", "ABR", "MAI", "JUN", "JUL", "AGO", "SET", "OUT", "NOV", "DEZ")

temames = request("temames")
fotomes = request("fotomes")
destaque = request("destaque")

mes = month(date())
ano = year(date())
if (mes + 1) = 13 then
	proximoMes = 1
	proximoAno = ano + 1
else
	proximoMes = mes + 1
	proximoAno = ano
end if

%>

<% 
Menu 1, 7, "GALERIAS DE MEMBROS" 
%>

<table border="1" cellspacing="0" cellpadding="10">
  <% 
  if temames <> "" then 
	SQL = "SELECT distinct(ano) FROM tema_mes ORDER BY ano"
	Set anoRes = dbConnection.Execute(SQL)
  %>
  <tr>
    <td colspan="5">
		<% if temames = "propostas" then %>
			<font color="white" face="arial"><b>PROPOSTAS PARA O TEMA DO M&Ecirc;S</b></font>
		<% else %>
			<font color="white" face="arial"><b>VENCEDORAS DO O TEMA DO M&Ecirc;S</b></font>
		<% end if %>		
		
		<br>
		<table border="0" cellspacing="0" cellpadding="2">
		<%
		do while not anoRes.eof 
			SQL = "SELECT distinct(mes), id FROM tema_mes WHERE ano = " & anoRes("ano") & " ORDER BY mes"
			Set mesRes = dbConnection.Execute(SQL)
		%>
			<tr><td>
				<font size="-2" color="#ffcc66" face="verdana, arial"><b><% =anoRes("ano") %>: </b></font>
				<% do while not mesRes.eof %>
					<% if cdate(mesRes("mes") & "/1/" & anoRes("ano")) <= date() then %>
						<% if temames = "propostas" then %>
							&nbsp;<a href="galeria.asp?tipo=temames&id=<% =mesRes("id") %>"><font size="-2" color="#ffcc66" face="verdana, arial"><b><% =meses(mesRes("mes") - 1) %></b></font></a>
						<% else %>
							<% if (mesRes("mes") = month(date())) and (anoRes("ano") = year(date())) then %>
							<% else %>
								&nbsp;<a href="galeria.asp?tipo=temames_escolhidas&id=<% =mesRes("id") %>"><font size="-2" color="#ffcc66" face="verdana, arial"><b><% =meses(mesRes("mes") - 1) %></b></font></a>
							<% end if %>
						<% end if %>
					<% end if %>
				<%
					mesRes.MoveNext
				Loop 
				%>
			</td></tr>
		<%
			anoRes.MoveNext
		Loop 
		%>
		</table>
	</td>
  </tr>
  <% end if %>

  <% 
  if fotomes <> "" then 
	SQL = "SELECT min(ano) AS minAno FROM fotomes_votos"
	Set minAnoRes = dbConnection.Execute(SQL)

	SQL = "SELECT min(mes) AS minMes FROM fotomes_votos WHERE ano = " & minAnoRes("minAno")
	Set minMesRes = dbConnection.Execute(SQL)
  %>
  <tr>
    <td colspan="5">
		<font color="white" face="arial"><b>PROPOSTAS PARA A FOTO DO M&Ecirc;S</b></font>
		
		<br>
		<table border="0" cellspacing="0" cellpadding="2">
		<%
		for ano = minAnoRes("minAno") to year(date())
			if ano = minAnoRes("minAno") then
				mesInicio = minMesRes("minMes")
			else
				mesInicio = 1
			end if
			if ano = year(date()) then
				mesFim = month(date())
			else
				mesFim = 12
			end if
		%>
			<tr><td>
				<font size="-2" color="#ffcc66" face="verdana, arial"><b><% =ano %>: </b></font>
			<% for mes = mesInicio to mesFim %>	
				<% if (mes = month(date())) and (ano = year(date())) then %>
					&nbsp;<a href="galeria.asp?tipo=fotomes&id=propostas"><font size="-2" color="#ffcc66" face="verdana, arial"><b>ESTE M&Ecirc;S</b></font></a>
				<% else %>
					<% if mes = 1 then %>
						&nbsp;<a href="galeria.asp?tipo=fotomes&id=propostas_anteriores&mes=12&ano=<% =ano - 1 %>"><font size="-2" color="#ffcc66" face="verdana, arial"><b><% =meses(mes - 1) %></b></font></a>
					<% else %>
						&nbsp;<a href="galeria.asp?tipo=fotomes&id=propostas_anteriores&mes=<% =mes - 1 %>&ano=<% =ano %>"><font size="-2" color="#ffcc66" face="verdana, arial"><b><% =meses(mes - 1) %></b></font></a>
					<% end if %>
				<% end if %>
			<% next %>
			</td></tr>
		<% next %>
		</table>
	</td>
  </tr>
  <% end if %>

  <% 
  if destaque <> "" then 
	SQL = "SELECT distinct(ano) FROM destaque_galeria ORDER BY ano"
	Set anoRes = dbConnection.Execute(SQL)
  %>
  <tr>
    <td colspan="5">
		<font color="white" face="arial"><b>GALERIAS DESTACADAS PELO J&Uacute;RI</b></font>
		
		<br>
		<table border="0" cellspacing="0" cellpadding="2">
		<%
		do while not anoRes.eof 
			SQL = "SELECT distinct(mes), id FROM destaque_galeria WHERE ano = " & anoRes("ano")
			SQL = SQL & " AND NOT (mes = " & proximoMes & " AND ano = " & proximoAno & ") ORDER by mes"
			Set mesRes = dbConnection.Execute(SQL)
		%>
			<tr><td>
				<font size="-2" color="#ffcc66" face="verdana, arial"><b><% =anoRes("ano") %>: </b></font>
				<% do while not mesRes.eof %>
					&nbsp;<a href="galeria.asp?tipo=galeria_mes&id=<% =mesRes("id") %>"><font size="-2" color="#ffcc66" face="verdana, arial"><b><% =meses(mesRes("mes") - 1) %></b></font></a>
				<%
					mesRes.MoveNext
				Loop 
				%>
			</td></tr>
		<%
			anoRes.MoveNext
		Loop 
		%>
		</table>
	</td>
  </tr>
  <% end if %>
  
  <tr>
    <td valign="top">
		<font color="white" face="arial"><b>FOTO DO M&Ecirc;S</b></font><br>
		<font color="white" face="arial" size="-2">(concurso desactivado)</font><br>
		<table border="0" cellspacing="0" cellpadding="2">
			<tr>
			<tr><td><a href="galeria.asp?tipo=fotomes&id=vencedoras"><font size="-2" color="#ffcc66" face="verdana, arial"><b>FOTOS VENCEDORAS</b></font></a>&nbsp;</td></tr>
			<% if fotomes <> "propostas" then %>
				<tr><td><a href="escolha_galeria_especiais.asp?fotomes=propostas"><font size="-2" color="#ffcc66" face="verdana, arial"><b>FOTOS PROPOSTAS</b></font></a>&nbsp;</td></tr>
			<% end if %>
			</tr>
		</table>
	</td>
    <td valign="top">
		<font color="white" face="arial"><b>TEMA DO M&Ecirc;S</b></font><br>
		<font color="white" face="arial" size="-2">(concurso desactivado)</font><br>
		<table border="0" cellspacing="0" cellpadding="2">
			<% if temames <> "vencedoras" then %>
				<tr><td><a href="escolha_galeria_especiais.asp?temames=vencedoras"><font size="-2" color="#ffcc66" face="verdana, arial"><b>FOTOS VENCEDORAS</b></font></a>&nbsp;</td></tr>
			<% end if %>
			<% if temames <> "propostas" then %>
				<tr><td><a href="escolha_galeria_especiais.asp?temames=propostas"><font size="-2" color="#ffcc66" face="verdana, arial"><b>FOTOS PROPOSTAS</b></font></a>&nbsp;</td></tr>
			<% end if %>
		</table>
	</td>
    <td valign="top">
		<font color="white" face="arial"><b>CRÓNICAS</b></font><br>
		
		<table border="0" cellspacing="0" cellpadding="2">
		<tr><td><a href="cronicas.asp"><font size="-2" color="#ffcc66" face="verdana, arial"><b>FOTOS COM CR&Oacute;NICAS</b></font></a>&nbsp;</td></tr>
		<tr><td><a href="galeria.asp?tipo=cronicas_vencedoras"><font size="-2" color="#ffcc66" face="verdana, arial"><b>FOTOS COM CR&Oacute;NICAS VENCEDORAS</b></font></a>&nbsp;</td></tr>
		</table>
	</td>
  </tr>
  <tr>
    <td valign="top" colspan="3">
		<font color="white" face="arial"><b>EXPOSIÇÕES E LIVROS DO SITE</b></font><br>
		
		<table border="0" cellspacing="0" cellpadding="2">
			<tr><td><a href="galeria.asp?tipo=especial&id=1"><font size="-2" color="#ffcc66" face="verdana, arial"><b>1ª LIVRO FOTO@PT</b></font></a>&nbsp;</td></tr>
			<tr><td><a href="galeria.asp?tipo=especial&id=3"><font size="-2" color="#ffcc66" face="verdana, arial"><b>1ª EXPOSIÇÃO FOTO@PT (ALMADA)</b></font></a>&nbsp;</td></tr>
			<tr><td><a href="galeria.asp?tipo=especial&id=2"><font size="-2" color="#ffcc66" face="verdana, arial"><b>2ª EXPOSIÇÃO FOTO@PT (BEJA)</b></font></a>&nbsp;</td></tr>
			<tr><td><a href="galeria.asp?tipo=especial&id=4"><font size="-2" color="#ffcc66" face="verdana, arial"><b>1ª COLECTIVA DE FOTOGRAFIA FOTO@PT - BRASIL</b></font></a>&nbsp;</td></tr>
			<tr><td><a href="galeria.asp?tipo=especial&id=5"><font size="-2" color="#ffcc66" face="verdana, arial"><b>3ª EXPOSIÇÃO FOTO@PT (VIDIGUEIRA)</b></font></a>&nbsp;</td></tr>
		</table>
	</td>
  </tr>
  <tr>
    <td valign="top" colspan="3">
		<font color="white" face="arial"><b>OUTRAS GALERIAS ESPECIAIS</b></font><br>
		
		<table border="0" cellspacing="0" cellpadding="2">
			<% if destaque <> "juri" then %>
				<tr><td><a href="escolha_galeria_especiais.asp?destaque=juri"><font size="-2" color="#ffcc66" face="verdana, arial"><b>DESTAQUE MENSAL DO JÚRI</b></font></a>&nbsp;</td></tr>
			<% end if %>
			<tr><td><a href="momentos_historicos.asp"><font size="-2" color="#ffcc66" face="verdana, arial"><b>MOMENTOS HIST&Oacute;RICOS</b></font></a>&nbsp;</td></tr>
		</table>
	</td>
  </tr>
</table>

<br>
<a href="direitos_autor.asp"><font size="-2" color="white" face="arial">Direitos de autor</font></a><font size="-2" color="white" face="arial">: As imagens sao propriedade do autor ou dos seus clientes, podendo ser reproduzida somente com autorização dos mesmos.</font>

<% FimPagina() %>
