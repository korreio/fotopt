<!-- #include file="topo.asp" -->
<td bgcolor="gray" width="100%" align="left"><font size="-1" color="black" face="arial">&nbsp;MUDAR OU APAGAR DESTAQUE</font></td>
<!-- #include file="fim_topo.asp" -->
<!-- #include file="autenticar_webmaster.asp" -->
<!-- #include file="inicio_basedados.asp" -->

<%
destaque = clng(request("destaque"))

SQL = "SELECT * FROM destaques WHERE id = " & destaque
Set destaqueRes = dbConnection.Execute(SQL)
%>

<form action="adm_mudar_destaque_res.asp?destaque=<% =destaque %>" method=post>

<table border="0" cellpadding="3" cellspacing="0">
	<tr>
		<td><font size="-1" color="#FFCC66" face="arial"><b>SECÇÃO: </b></font></td>
		<td>
			<select name="seccao">
			<option <% if destaqueRes("seccao") = -1 then %>selected<% end if %> value="-1">TODAS</option>
			<option <% if destaqueRes("seccao") = 0 then %>selected<% end if %> value="0">Home</option>
			<option <% if destaqueRes("seccao") = 1 then %>selected<% end if %> value="1">Galerias</option>
			<option <% if destaqueRes("seccao") = 2 then %>selected<% end if %> value="2">Destaques</option>
			<option <% if destaqueRes("seccao") = 3 then %>selected<% end if %> value="3">Membros</option>
			<option <% if destaqueRes("seccao") = 4 then %>selected<% end if %> value="4">Concursos</option>
			<option <% if destaqueRes("seccao") = 5 then %>selected<% end if %> value="5">Informação</option>
			<option <% if destaqueRes("seccao") = 6 then %>selected<% end if %> value="6">Classificados</option>
			<option <% if destaqueRes("seccao") = 7 then %>selected<% end if %> value="7">Opinião</option>
			<option <% if destaqueRes("seccao") = 8 then %>selected<% end if %> value="8">Úteis</option>
			</select>
		</td>
	</tr>
	<tr>
		<td><font size="-1" color="#FFCC66" face="arial"><b>TEXTO: </b></font></td>
		<td><textarea cols="40" rows="5" name="texto"><% =destaqueRes("texto") %></textarea> <font size="-1" color="white" face="arial">(obrig)</font></td>
	</tr>
	<tr>
		<td><font size="-1" color="#FFCC66" face="arial"><b>DATA: </b></font></td>
		<td><input size="22" type="text" name="data" value="<% =destaqueRes("data") %>"> <font size="-1" color="white" face="arial">(obrig)</font></td>
	</tr>
	<tr><td></td><td><input type="Submit" value="Mudar destaque"></td></tr>
</table>

</form>

<form method="post" action="adm_apagar_destaque.asp?destaque=<% =destaque %>&seccao=<% =destaqueRes("seccao") %>">
	<font color="#FFCC66" face="arial"><b>Para apagar este destaque corfirme aqui <input type="Checkbox" name="apagar"> e prima o bot&atilde;o - </b></font><input type="Submit" value="Apagar">
</form>

<!-- #include file="fim_autenticacao.asp" -->
<!-- #include file="fim_basedados.asp" -->