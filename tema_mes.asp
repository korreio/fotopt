<!-- #include file="funcoes_principais.asp" -->

<%
'mes = month(date())
'ano = year(date())
mes = 3
ano = 2002

SQL = "SELECT * FROM tema_mes WHERE mes = " & mes & " AND ano = " & ano
Set esteMesRes = dbConnection.Execute(SQL)

if not esteMesRes.eof then
	if not ((mes = 3) and (ano = 2002)) then
'		OpcaoMenu "PROPÔR FOTO FOTO PARA TÊMA DESTE MÊS", "inserir_foto_temames.asp", False, True, -1, False, False
	end if
end if
Menu 4, 2, "TEMA DO MÊS"

SQL = "SELECT * FROM tema_mes WHERE (mes < " & mes & " AND ano = " & ano & ") OR (ano < " & ano & ") ORDER BY id"
Set temasPassadosRes = dbConnection.Execute(SQL)

SQL = "SELECT * FROM tema_mes WHERE (mes > " & mes & " AND ano = " & ano & ") OR (ano > " & ano & ") ORDER BY id"
Set temasFuturosRes = dbConnection.Execute(SQL)

Dim meses
meses = Array("JANEIRO", "FEVEREIRO", "MAR&Ccedil;O", "ABRIL", "MAIO", "JUNHO", "JULHO", _
			  "AGOSTO", "SETEMBRO", "OUTUBRO", "NOVEMBRO", "DEZEMBRO")
%>

<font size="-1" color="white" face="arial">
	Nesta sec&ccedil;&atilde;o eram sugeridos diversos temas fotogr&aacute;ficos - um para cada m&ecirc;s do ano. No fim de cada 
	m&ecirc;s um j&uacute;ri destacava as melhores fotografias entre as escolhidas pelos autores. Este concurso deixou de existir,
	estando apenas pendente os resultados do mês passado - "Rostos de Mulher".<br><br>
</font>

<table border="1" cellpadding="5" cellspacing="0">
<tr>
	<td align="center"><font color="white" face="arial"><b>TEMA DESTE MÊS</b></font></td>
	<td align="center"><font color="white" face="arial"><b>AS&nbsp;FOTOS</b></font></td>
	<td align="center"><font color="white" face="arial"><b>M&Ecirc;S</b></font></td>
</tr>
<% 
if not esteMesRes.eof then
	SQL = "SELECT TOP 1 * FROM tema_mes_foto WHERE tema_mes = " & esteMesRes("id") & " ORDER BY id DESC"	
	Set ultimaFotoRes = dbConnection.Execute(SQL)

	if not ultimaFotoRes.eof then
		directoria = int(ultimaFotoRes("foto") / 1000)
	end if
%>
	<tr>
		<% if not ((mes = 3) and (ano = 2002)) then %>
			<td>
				<a href="galeria.asp?tipo=temames&id=<% =esteMesRes("id") %>"><font size="-1" color="#FFCC66" face="verdana, arial"><b><% =esteMesRes("nome") %></b></font></a>
				<br><font size="-1" color="white" face="arial"><% =esteMesRes("descricao") %></font>
			</td>
			<td align="center" valign="middle">
				<% if not ultimaFotoRes.eof then %>
					<a href="galeria.asp?tipo=temames&id=<% =esteMesRes("id") %>"><img border="1" src="/fotos/thumbs/<% =directoria %>/thumbs<% =ultimaFotoRes("foto") %>.jpg" border=0></a>
				<% else %>
					&nbsp;
				<% end if %>
			</td>
			<td align="center"><a href="galeria.asp?tipo=temames&id=<% =esteMesRes("id") %>"><font size="-2" color="#FFCC66" face="verdana, arial"><b><% =meses(clng(esteMesRes("mes")) - 1) %><br><% =esteMesRes("ano") %></b></font></a></td>
		<% else %>
			<td>
				<font size="-1" color="#FFCC66" face="verdana, arial"><b><% =esteMesRes("nome") %></b></font>
				<br><font size="-1" color="white" face="arial"><% =esteMesRes("descricao") %></font>
			</td>
			<td align="center" valign="middle"><font size="-1" color="#FFCC66" face="verdana, arial">Serão divulgados dentro de dias.</font></td>
			<td align="center"><font size="-2" color="#FFCC66" face="verdana, arial"><b><% =meses(clng(esteMesRes("mes")) - 1) %><br><% =esteMesRes("ano") %></b></font></td>
		<% end if %>
	</tr>
	</table>
<% else %>
	<tr>
		<td><font size="-1" color="#FFCC66" face="verdana, arial"><b>
			Durante este mês não haverá concurso do tema do mês (devido a vários problemas
			de ordem técnica e de re-organização). O concurso recomeçará, no seu modo normal, 
			ja para o mês que vem, altura em que serão divulgados todos os temas para este ano.
			Peço desculpa pelo inconveniente.
			</b></font></td>
		<td align="center" valign="middle">&nbsp;</td>
		<td align="center"><font size="-2" color="#FFCC66" face="verdana, arial"><b><% =meses(mes - 1) %><br><% =ano %></b></font></td>
	</tr>
	</table>
<% end if %>

<% if not temasFuturosRes.eof then %>
	<br><br>
	<table border="1" cellpadding="5" cellspacing="0">
	<tr>
		<td align="center"><font color="white" face="arial"><b>TEMAS DOS PRÓXIMOS MESES</b></font></td>
		<td align="center"><font color="white" face="arial"><b>M&Ecirc;S</b></font></td>
	</tr>
	<% do while not temasFuturosRes.eof %>
		<tr>
			<td>
				<font size="-1" color="#FFCC66" face="verdana, arial"><b><% =temasFuturosRes("nome") %></b></font>
				<br><font size="-1" color="white" face="arial"><% =temasFuturosRes("descricao") %></font>
			</td>
			<td align="center"><font size="-2" color="#FFCC66" face="verdana, arial"><b><% =meses(clng(temasFuturosRes("mes")) - 1) %><br><% =temasFuturosRes("ano") %></b></font></td>
		</tr>
		<% temasFuturosRes.MoveNext %>
	<% loop %>
	</table>
<% end if %>

<% if not temasPassadosRes.eof then %>
	<br><br>
	<table border="1" cellpadding="5" cellspacing="0">
	<tr>
		<td align="center"><font color="white" face="arial"><b>TEMAS PASSADOS</b></font></td>
		<td align="center"><font color="white" face="arial"><b>AS FOTOS</b></font></td>
		<td align="center"><font color="white" face="arial"><b>M&Ecirc;S</b></font></td>
	</tr>
	<% do while not temasPassadosRes.eof %>
		<tr>
			<td>
				<font size="-1" color="#FFCC66" face="verdana, arial"><b><% =temasPassadosRes("nome") %></b></font>
				<br><font size="-1" color="white" face="arial"><% =temasPassadosRes("descricao") %></font>
			</td>
			<td align="center">
				<% if ((temasPassadosRes("mes") < mes) and (temasPassadosRes("ano") = ano)) or (temasPassadosRes("ano") < ano) then %>
					<a href="galeria.asp?tipo=temames&id=<% =temasPassadosRes("id") %>"><font size="-2" color="silver" face="Verdana, Arial"><b>PROPOSTAS</b></font></a>
					<br><a href="galeria.asp?tipo=temames_escolhidas&id=<% =temasPassadosRes("id") %>"><font size="-2" color="white" face="Verdana, Arial"><b>VENCEDORAS</b></font></a>
				<% else %>
					&nbsp;
				<% end if %>
			</td>
			<td align="center"><font size="-2" color="#FFCC66" face="verdana, arial"><b><% =meses(clng(temasPassadosRes("mes")) - 1) %><br><% =temasPassadosRes("ano") %></b></font></td>
		</tr>
		<% temasPassadosRes.MoveNext %>
	<% loop %>
	</table>
<% end if %>

<% FimPagina() %>
