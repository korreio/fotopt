<!-- #include file="funcoes_principais.asp" -->
<!-- #include file="ordem_galeria.asp" -->

<%
Dim meses
meses = Array("JAN", "FEV", "MAR", "ABR", "MAI", "JUN", "JUL", "AGO", "SET", "OUT", "NOV", "DEZ")

mes = month(date())
ano = year(date())

SQL = "SELECT max(data) AS maximo, min(data) AS minimo FROM foto"
Set anoRes = dbConnection.Execute(SQL)
%>

<% 
Menu 1, 4, "GALERIAS POR DATAS" 
%>

<table border="1" cellspacing="0" cellpadding="10">
<% if session("login") <> 0 then %>
  <tr>
    <td>
		<a href="galeria.asp?tipo=novas&id=0"><font color="#ffcc66" face="verdana, arial"><b>FOTOGRAFIAS NOVAS</b></font></a>
		&nbsp;<font size="-2" color="silver" face="verdana, arial">(inseridas desde a última vez que fez login)</font>
	</td>
  </tr>
<% end if %>

  <tr>
    <td>
		<font color="white" face="arial"><b>INSERIDAS NO MÊS:</b></font>
		<br>
		
		<table border="0" cellspacing="0" cellpadding="2">
			<% for i = year(anoRes("minimo")) to year(anoRes("maximo")) %>
				<tr><td><font size="-1" color="#ffcc66" face="verdana, arial"><b><% =i %></b></font>&nbsp;&nbsp;
			<%
				for j = 1 to 12
					if j = 12 then
						SQL = "SELECT count(*) AS num FROM foto WHERE data >= #" & j & "/1/" & i & "# AND data < #1/1/" & i + 1 & "#"
					else
						SQL = "SELECT count(*) AS num FROM foto WHERE data >= #" & j & "/1/" & i & "# AND data < #" & j + 1 & "/1/" & i & "#"
					end if
					Set fotosRes = dbConnection.Execute(SQL)
					
					if (j = 1) or (j = 3) or (j = 5) or (j = 7) or (j = 8) or (j = 10) or (j = 12) then
						dia2 = 31
					elseif (j = 2) then
						dia2 = 28
					else
						dia2 = 30
					end if
					
					if fotosRes("num") > 0 then
			%>
						<a href="galeria.asp?tipo=busca&id=intervalodata&dia1=1&mes1=<% =j %>&ano1=<% =i %>&dia2=<% =dia2 %>&mes2=<% =j %>&ano2=<% =i %>"><font size="-2" color="#ffcc66" face="verdana, arial"><b><% =meses(j - 1) %></b></font></a>&nbsp;&nbsp;
			<%
					else
			%>
						<font size="-2" color="black" face="verdana, arial"><b><% =meses(j - 1) %></b></font>&nbsp;&nbsp;
			<%
					end if
				next
			%>
				</td></tr>
			<%
			next
			%>
		</table>
	</td>
  </tr>

  <tr>
    <td>
		<font color="white" face="arial"><b>PROCURAR FOTOGRAFIAS:</b></font>
		<br><br>
		<table border="0" cellpadding="3" cellspacing="0">
		<form action="galeria.asp?tipo=busca&id=umadata" method="post">
			<tr><td>
				<font size="-1" color="#FFCC66" face="arial"><b>COM DATA </b></font>
				&nbsp;<input maxlength="2" type="Text" size="3" name="dia">
				<select name="mes">
					<% for i = 0 to 11 %>
						<option value="<% =i + 1 %>"><% =meses(i) %></option>
					<% next %>
				</select>
				<input value="<% =year(date()) %>" maxlength="4" type="Text" size="5" name="ano">&nbsp;
				<input type="Submit" value="Procurar">
			</td></tr>
		</form>
		<tr><td>
			<br><br>
			<a href="procurar_data.asp"><font size="-1" color="#FFCC66" face="arial"><b>BUSCA AVANÇADA</b></font></a>
			&nbsp;&nbsp;<font size="-2" color="silver" face="arial">(entre duas datas ou até uma data)</font>
		</td></tr>
		</table>
	</td>
  </tr>
</table>

<br>
<a href="direitos_autor.asp"><font size="-2" color="white" face="arial">Direitos de autor</font></a><font size="-2" color="white" face="arial">: As imagens sao propriedade do autor ou dos seus clientes, podendo ser reproduzida somente com autorização dos mesmos.</font>

<% FimPagina() %>
