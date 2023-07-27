<!-- #include file="funcoes_principais.asp" -->

<% 
AutenticarMembro(autor)
OpcaoMenu "VER A MINHA GALERIA", "lista_temas.asp?autor=" & session("login"), False, False, -1, False, False
OpcaoMenu "INSERIR FOTO", "inserir_foto.asp", False, True, -1, False, False
Menu 4, 1, "PROPOR PARA FOTOGRAFIA DO PR�XIMO M�S"
%>

<%
SQL = "SELECT id, titulo FROM foto WHERE moderar = False AND autor = " & session("login") & " AND id IN (SELECT foto FROM foto_mes_proposta WHERE mes = " & month(date()) & " AND ano = " & year(date()) & ")"
Set anteriorFotoRes = dbConnection.Execute(SQL)

SQL = "SELECT id, titulo FROM foto WHERE moderar = False AND autor = " & session("login") & " AND id NOT IN (SELECT foto FROM foto_mes_proposta) ORDER BY id"
Set fotoRes = dbConnection.Execute(SQL)

Dim meses
meses = Array("JANEIRO", "FEVEREIRO", "MAR&Ccedil;O", "ABRIL", "MAIO", "JUNHO", "JULHO", _
			  "AGOSTO", "SETEMBRO", "OUTUBRO", "NOVEMBRO", "DEZEMBRO")
%>

<font size="-1" color="white" face="arial">
Esta p&aacute;gina serve para escolher a foto com que quer concorrer no pr&oacute;ximo m&ecirc;s no
concurso de <b>FOTO DO M&Ecirc;S</b>. Esta fotografia &eacute; eleita por todos os membros e n&atilde;o &eacute; sujeita a nenhum tema. S&oacute; pode concorrer com uma fotografia
por m&ecirc;s, pelo que se escolher duas a primeira proposta ser&aacute; retirada. Cada fotografia s&oacute;
pode entrar a concurso uma &uacute;nica vez. A lista de fotografias em concurso aparece dispon&iacute;vel
no princ&iacute;pio de cada m&ecirc;s.
</font>

<% if fotoRes.eof then %>
	<br><br>
	<font size="-1" color="#FFCC66" face="arial">
	A sua galeria ainda est&aacute; vazia. Primeiro tem que inserir as fotografias (prima <b>INSERIR FOTO</b> no topo desta p&aacute;gina), s&oacute; depois pode 
	selecionar qual quer propor para fotografia do m&ecirc;s.
	</font>
<% else %>

<form action="inserir_foto_mes_res.asp" method="post">
<table border="0" cellpadding="3" cellspacing="0">
	<% if month(date()) = 12 then %>
		<tr><td><font size="-1" color="#FFCC66" face="arial"><b>CONCURSO DE: </b></font></td><td><font size="-1" color="white" face="arial"><% =meses(0) %> DE <% =year(date()) + 1 %></font></td></tr>
	<% else %>
		<tr><td><font size="-1" color="#FFCC66" face="arial"><b>CONCURSO DE: </b></font></td><td><font size="-1" color="white" face="arial"><% =meses(month(date())) %> DE <% =year(date()) %></font></td></tr>
	<% end if %>

	<% if not anteriorFotoRes.eof then %>
		<% if anteriorFotoRes("titulo") <> "" then %>
			<tr><td><font size="-1" color="#FFCC66" face="arial"><b>PROPOSTA<br>ACTUAL: </b></font></td><td><font size="-1" color="white" face="arial"><a href="foto.asp?foto=<% =anteriorFotoRes("id") %>"><% =anteriorFotoRes("id") %> - <% =anteriorFotoRes("titulo") %></a></font></td></tr>
		<% else %>
			<tr><td><font size="-1" color="#FFCC66" face="arial"><b>PROPOSTA<br>ACTUAL: </b></font></td><td><font size="-1" color="white" face="arial"><a href="foto.asp?foto=<% =anteriorFotoRes("id") %>"><% =anteriorFotoRes("id") %> - <i>sem t&iacute;tulo</i></a></font></td></tr>
		<% end if %>
	<tr>
		<td><font size="-1" color="#FFCC66" face="arial"><b>SUBSTITUIR POR:&nbsp;</b></font></td>
		<td><select name="foto">
			<option value="0">Nenhuma (n&atilde;o concorrer no m&ecirc;s que vem)</option>
	<% else %>
	<tr>
		<td><font size="-1" color="#FFCC66" face="arial"><b>FOTOGRAFIA<br>PROPOSTA:</b></font></td>
		<td><select name="foto">
	<% end if %>
			<% do while not fotoRes.eof %>
				<% if fotoRes("titulo") <> "" then %>
					<option value="<% =fotoRes("id") %>"><% =fotoRes("id") %> - <% =fotoRes("titulo") %></option>
				<% else %>
					<option value="<% =fotoRes("id") %>"><% =fotoRes("id") %> - sem t&iacute;tulo</option>
				<% end if %>
				<% fotoRes.MoveNext %>
			<% loop %>
		</select> 
		<font size="-1" color="white" face="arial">(obrig)</font></td>
	</tr>
	<tr><td></td><td><input type="Submit" value="Propor fotografia"></td></tr>
</table>

</form>
<% end if %>

<% FimPagina() %>
