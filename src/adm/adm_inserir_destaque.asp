<!-- #include file="topo.asp" -->
<td bgcolor="gray" width="100%" align="left"><font size="-1" color="black" face="arial">&nbsp;MUDAR OU APAGAR DESTAQUE</font></td>
<!-- #include file="fim_topo.asp" -->
<!-- #include file="autenticar_webmaster.asp" -->
<!-- #include file="inicio_basedados.asp" -->

<%
seccao = clng(request("principal"))
%>

<form action="adm_inserir_destaque_res.asp?destaque=<% =destaque %>" method=post>

<table border="0" cellpadding="3" cellspacing="0">
	<tr>
		<td><font size="-1" color="#FFCC66" face="arial"><b>SECÇÃO: </b></font></td>
		<td>
			<select name="seccao">
			<option <% if seccao = -1 then %>selected<% end if %> value="-1">TODAS</option>
			<option <% if seccao = 0 then %>selected<% end if %> value="0">Home</option>
			<option <% if seccao = 1 then %>selected<% end if %> value="1">Galerias</option>
			<option <% if seccao = 2 then %>selected<% end if %> value="2">Destaques</option>
			<option <% if seccao = 3 then %>selected<% end if %> value="3">Membros</option>
			<option <% if seccao = 4 then %>selected<% end if %> value="4">Concursos</option>
			<option <% if seccao = 5 then %>selected<% end if %> value="5">Informação</option>
			<option <% if seccao = 6 then %>selected<% end if %> value="6">Classificados</option>
			<option <% if seccao = 7 then %>selected<% end if %> value="7">Opinião</option>
			<option <% if seccao = 8 then %>selected<% end if %> value="8">Úteis</option>
			</select>
		</td>
	</tr>
	<tr>
		<td><font size="-1" color="#FFCC66" face="arial"><b>TEXTO: </b></font></td>
		<td><textarea cols="40" rows="5" name="texto"></textarea> <font size="-1" color="white" face="arial">(obrig)</font></td>
	</tr>
	<tr>
		<td><font size="-1" color="#FFCC66" face="arial"><b>DATA: </b></font></td>
		<td><input size="22" type="text" name="data" value="<% =(date() & " " & time()) %>"> <font size="-1" color="white" face="arial">(obrig)</font></td>
	</tr>
	<tr><td></td><td><input type="Submit" value="Inserir destaque"></td></tr>
</table>

</form>

<!-- #include file="fim_autenticacao.asp" -->
<!-- #include file="fim_basedados.asp" -->