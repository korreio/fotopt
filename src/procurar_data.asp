<!-- #include file="funcoes_principais.asp" -->
<!-- #include file="ordem_galeria.asp" -->

<%
Menu 1, 4, "PROCURAR FOTOGRAFIAS POR DATA"
%>

<%
Dim meses
meses = Array("JANEIRO", "FEVEREIRO", "MAR&Ccedil;O", "ABRIL", "MAIO", "JUNHO", _
			  "JULHO", "AGOSTO", "SETEMBRO", "OUTUBRO", "NOVEMBRO", "DEZEMBRO")
%>

<table border="1" cellpadding="10" cellspacing="0">
<tr><td>
<font color="white" face="arial">
<b>INSERIDAS NUM DIA ESPEC&Iacute;FICO</b>
</font>
<form action="galeria.asp?tipo=busca&id=umadata" method="post">
<table border="0" cellpadding="3" cellspacing="0">
	<tr><td>
		<font size="-1" color="#FFCC66" face="arial"><b>COM DATA </b></font>
		&nbsp;<input maxlength="2" type="Text" size="3" name="dia">
		<select name="mes">
			<% for i = 0 to 11 %>
				<option value="<% =i + 1 %>"><% =meses(i) %></option>
			<% next %>
		</select>
		<input value="<% =year(date()) %>" maxlength="4" type="Text" size="5" name="ano">&nbsp;
		<input type="Submit" value="Procurar fotos">
	</td></tr>
</table>
</form>
</td></tr>

<tr><td>
<font color="white" face="arial">
<b>UM INTERVALO DE FOTOGRAFIAS INSERIDAS</b>
</font>
<form action="galeria.asp?tipo=busca&id=intervalodata" method="post">
<table border="0" cellpadding="3" cellspacing="0">
	<tr><td>
		<font size="-1" color="#FFCC66" face="arial"><b>DESDE O DIA </b></font>
		&nbsp;<input maxlength="2" type="Text" size="3" name="dia1">
		<select name="mes1">
			<% for i = 0 to 11 %>
				<option value="<% =i + 1 %>"><% =meses(i) %></option>
			<% next %>
		</select>
		<input value="<% =year(date()) %>" maxlength="4" type="Text" size="5" name="ano1">&nbsp;
		<br><br>
		<font size="-1" color="#FFCC66" face="arial"><b>AT&Eacute; AO DIA </b></font>
		&nbsp;<input maxlength="2" type="Text" size="3" name="dia2">
		<select name="mes2">
			<% for i = 0 to 11 %>
				<option value="<% =i + 1 %>"><% =meses(i) %></option>
			<% next %>
		</select>
		<input value="<% =year(date()) %>" maxlength="4" type="Text" size="5" name="ano2">&nbsp;
		<input type="Submit" value="Procurar fotos">
	</td></tr>
</table>
</form>
</td></tr>

<tr><td>
<font color="white" face="arial">
<b>TODAS INSERIDAS AT&Eacute;</b>
</font>
<form action="galeria.asp?tipo=busca&id=atedata" method="post">
<table border="0" cellpadding="3" cellspacing="0">
	<tr><td>
		<font size="-1" color="#FFCC66" face="arial"><b>&Agrave; DATA </b></font>
		&nbsp;<input maxlength="2" type="Text" size="3" name="dia">
		<select name="mes">
			<% for i = 0 to 11 %>
				<option value="<% =i + 1 %>"><% =meses(i) %></option>
			<% next %>
		</select>
		<input value="<% =year(date()) %>" maxlength="4" type="Text" size="5" name="ano">&nbsp;
		<font size="-1" color="#FFCC66" face="arial"><b>DESDE A </b></font>
		&nbsp;<select name="desde">
			<option value="1">MAIS ANTIGA</option>
			<option value="2">MAIS RECENTE</option>
		</select>&nbsp;
		<input type="Submit" value="Procurar fotos">
	</td></tr>
</table>
</form>
</td></tr>

</table>

<% FimPagina() %>