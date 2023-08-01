<!-- #include file="topo.asp" -->
<td bgcolor="gray" width="100%" align="left"><font size="-1" color="black" face="arial">&nbsp;MUDAR OU APAGAR ARTIGO PARA OPINIAO</font></td>
<!-- #include file="fim_topo.asp" -->
<!-- #include file="autenticar_webmaster.asp" -->
<!-- #include file="inicio_basedados.asp" -->

<%
ordem = request("ordem")
artigo = request("artigo")

SQL = "SELECT * FROM opiniao_artigo WHERE id = " & artigo
Set artigoRes = dbConnection.Execute(SQL)

SQL = "SELECT * FROM opiniao_tipo"
Set tipoRes = dbConnection.Execute(SQL)
%>

<form action="adm_mudar_opiniao_res.asp?ordem=<% =ordem %>&artigo=<% =artigo %>" method="post">

<table border="0" cellpadding="3" cellspacing="0">
	<tr>
		<td><font size="-1" color="#FFCC66" face="arial"><b>TIPO: </b></font></td>
		<td><select name="tipo">
			<%
			do while not tipoRes.eof 
				SQL = "SELECT * FROM opiniao_grupo WHERE id = " & tipoRes("grupo")
				Set grupoRes = dbConnection.Execute(SQL)
			%>
				<% if tipoRes("id") = artigoRes("tipo") then %>
					<option selected value="<% =tipoRes("id") %>"><% =grupoRes("nome") %> - <% =tipoRes("nome") %></option>
				<% else %>
					<option value="<% =tipoRes("id") %>"><% =grupoRes("nome") %> - <% =tipoRes("nome") %></option>
				<% end if %>
				<% tipoRes.MoveNext %>
			<% loop %>
		</select> <font size="-1" color="white" face="arial">(obrig)</font></td>
	</tr>
	<tr><td><br></td><td></td></tr>				
	<tr><td><font size="-1" color="#FFCC66" face="arial"><b>MARCA:</b></font></td><td><input value="<% =artigoRes("marca") %>" maxlength="50" size="40" type="text" name="marca"> <font size="-1" color="white" face="arial">(obrig)</font></td></td></tr>
	<tr><td><font size="-1" color="#FFCC66" face="arial"><b>MODELO:</b></font></td><td><input value="<% =artigoRes("modelo") %>" maxlength="50" size="40" type="text" name="modelo"> <font size="-1" color="white" face="arial">(obrig)</font></td></td></tr>
	<tr><td><br></td><td></td></tr>				
	<tr><td><font size="-1" color="#FFCC66" face="arial"><b>DESCRI&Ccedil;&Atilde;O<br>SEM OPINI&Atilde;O: </b></font><font size="-1" color="white" face="arial"><br>(se ultrapassar<br>estas 6 linhas<br>o texto ser&aacute;<br>cortado)</font></td><td><textarea name="descricao" cols="38" rows="6" wrap="VIRTUAL"><% =artigoRes("descricao") %></textarea></td></tr>
	<tr><td></td><td><input type="Submit" value="Mudar Artigo"></td></tr>	
</table>

</form>

<form method="post" action="adm_apagar_artigo_res.asp?ordem=<% =ordem %>&artigo=<% =artigo %>">
	<font color="#FFCC66" face="arial"><b>Para apagar este artigo corfirme aqui <input type="Checkbox" name="apagar"> e prima o bot&atilde;o - </b></font><input type="Submit" value="Apagar">
</form>

<!-- #include file="fim_autenticacao.asp" -->
<!-- #include file="fim_basedados.asp" -->