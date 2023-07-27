<!-- #include file="funcoes_principais.asp" -->

<% 
AutenticarMembro(autor)
OpcaoMenu "VER A MINHA GALERIA", "lista_temas.asp?autor=" & session("login"), False, True, -1, False, False
OpcaoMenu "INSERIR FOTO", "inserir_foto.asp", False, True, -1, False, False
Menu 4, 2, "PROP�R FOTOGRAFIA PARA O TEMA DESTE M�S"
%>

<%
SQL = "SELECT * FROM tema_mes WHERE mes = " & month(date()) & " AND ano = " & year(date())
Set tipoRes = dbConnection.Execute(SQL)

SQL = "SELECT id, titulo FROM foto WHERE moderar = False AND autor = " & session("login") & " ORDER BY id"
Set fotoRes = dbConnection.Execute(SQL)

Dim meses
meses = Array("JANEIRO", "FEVEREIRO", "MAR&Ccedil;O", "ABRIL", "MAIO", "JUNHO", "JULHO", _
			  "AGOSTO", "SETEMBRO", "OUTUBRO", "NOVEMBRO", "DEZEMBRO")
%>

<font size="-1" color="white" face="arial">
Esta p&aacute;gina serve para escolher as suas fotografias para o tema deste m&ecirc;s. S&oacute; pode escolher no m&aacute;ximo duas fotografias por cada tema do 
m&ecirc;s - se escolher outra, a primeira ser&aacute; substituida. No fim de cada m&ecirc;s um j&uacute;ri seleccionar&aacute; as 12 
melhores fotos entre as escolhidas pelos membros.
</font>
<% if fotoRes.eof then %>
	<br><br>
	<font size="-1" color="#FFCC66" face="arial">
	A sua galeria ainda est&aacute; vazia. Primeiro tem que inserir as fotografias (prima <b>INSERIR FOTO</b> no topo desta p&aacute;gina), s&oacute; depois pode 
	selecionar quais quer escolher para o tema deste m&ecirc;s.
	</font>
<% else %>

<br><br>
<font size="-1" color="white" face="arial">
<b>NOTA:</b> por favor proponha apenas fotos que se enquadrem no tema deste m&ecirc;s (<% =tipoRes("nome") %>).
</font>

<form action="inserir_foto_temames_res.asp?temames=<% =tipoRes("id") %>" method="post">
<table border="0" cellpadding="3" cellspacing="0">
	<tr><td><font size="-1" color="#FFCC66" face="arial"><b>TEMA: </b></font></td><td><font size="-1" color="white" face="arial"><b><% =tipoRes("nome") %></b></font><font size="-2" color="white" face="arial">&nbsp;&nbsp;(<% =meses(month(date()) - 1) %> DE <% =year(date()) %>)</font></td></tr>
	<tr>
		<td><font size="-1" color="#FFCC66" face="arial"><b>FOTOGRAFIA<br>ESCOLHIDA:</font></td>
		<td><select name="foto">
			<option value="0">Nenhuma (retirar as suas propostas)</option>
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
	<tr><td></td><td><input type="Submit" value="Escolher fotografia"></td></tr>
</table>

</form>
<% end if %>

<% FimPagina() %>
