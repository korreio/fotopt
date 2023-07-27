<!-- #include file="funcoes_principais.asp" -->

<%
ordem = request("ordem")
tipo = clng(request("tipo"))
%>

<%
AutenticarMembro(autor)
Menu 7, 3, "INSERIR ITEM PARA OPINI�O"
%>

<%
SQL = "SELECT * FROM opiniao_tipo WHERE id = " & tipo
Set tipoRes = dbConnection.Execute(SQL)

SQL = "SELECT * FROM opiniao_grupo WHERE id = " & tipoRes("grupo")
Set grupoRes = dbConnection.Execute(SQL)
%>

<form action="inserir_opiniao_artigo_res.asp?ordem=<% =ordem %>&tipo=<% =tipo %>" method="post">

<font size="-1" color="white" face="arial">
<% if tipo = 33 then %>
	<b>Aten&ccedil;&atilde;o</b>: Certifique-se que o laborat&oacute;rio ainda n&atilde;o existe neste site.<br>
	<font color="#FFCC66">Aqui s&oacute; insere o laborat&oacute;rio, a sua opini&atilde;o ter&aacute; que inseri-la depois (se desejar).</font>
	<td bgcolor="gray" width="100%" align="left"><font size="-1" color="black" face="arial">&nbsp;INSERIR LABORAT&Oacute;RIO PARA OPINI&Atilde;O</font></td>
<% elseif tipo = 34 then %>
	<b>Aten&ccedil;&atilde;o</b>: Certifique-se que a loja ainda n&atilde;o existe neste site.<br>
	<font color="#FFCC66">Aqui s&oacute; insere a loja, a sua opini&atilde;o ter&aacute; que inseri-la depois (se desejar).</font>
<% elseif tipo = 35 then %>
	<b>Aten&ccedil;&atilde;o</b>: Certifique-se que o website ainda n&atilde;o existe neste site.<br>
	<font color="#FFCC66">Aqui s&oacute; insere o website, a sua opini&atilde;o ter&aacute; que inseri-la depois (se desejar).</font>
<% elseif tipo = 40 then %>
	<b>Aten&ccedil;&atilde;o</b>: Certifique-se que o livro ainda n&atilde;o existe neste site.<br>
	<font color="#FFCC66">Aqui s&oacute; insere o livro, a sua opini&atilde;o ter&aacute; que inseri-la depois (se desejar).</font>
<% elseif tipo = 41 then %>
	<b>Aten&ccedil;&atilde;o</b>: Certifique-se que o jornal ainda n&atilde;o existe neste site.<br>
	<font color="#FFCC66">Aqui s&oacute; insere o jornal, a sua opini&atilde;o ter&aacute; que inseri-la depois (se desejar).</font>
<% elseif tipo = 42 then %>
	<b>Aten&ccedil;&atilde;o</b>: Certifique-se que a revista ainda n&atilde;o existe neste site.<br>
	<font color="#FFCC66">Aqui s&oacute; insere a revista, a sua opini&atilde;o ter&aacute; que inseri-la depois (se desejar).</font>
<% else %>	
	<b>Aten&ccedil;&atilde;o</b>: Certifique-se que o artigo ainda n&atilde;o existe neste site.<br>
	<font color="#FFCC66">Aqui s&oacute; insere o artigo, a sua opini&atilde;o ter&aacute; que inseri-la depois (se desejar).</font>
<% end if %>
</font>
<br><br>

<table border="0" cellpadding="3" cellspacing="0">
	<tr><td><font size="-1" color="#FFCC66" face="arial"><b>TIPO: </b></font></td><td><font size="-1" color="white" face="arial"><% =grupoRes("nome") %> - <% =tipoRes("nome") %></font></td></tr>
	<tr><td><br></td><td></td></tr>				
<% if tipo = 33 then %>
	<tr><td><font size="-1" color="#FFCC66" face="arial"><b>NOME LAB:</b></font></td><td><input maxlength="50" size="40" type="text" name="marca"> <font size="-1" color="white" face="arial">(obrig)</font></td></td></tr>
	<tr><td><font size="-1" color="#FFCC66" face="arial"><b>LOCALIDADE<br>OR MORADA:</b></font></td><td><input maxlength="50" size="40" type="text" name="modelo"> <font size="-1" color="white" face="arial">(obrig)</font></td></td></tr>
<% elseif tipo = 34 then %>
	<tr><td><font size="-1" color="#FFCC66" face="arial"><b>NOME LOJA:</b></font></td><td><input maxlength="50" size="40" type="text" name="marca"> <font size="-1" color="white" face="arial">(obrig)</font></td></td></tr>
	<tr><td><font size="-1" color="#FFCC66" face="arial"><b>LOCALIDADE<br>OR MORADA:</b></font></td><td><input maxlength="50" size="40" type="text" name="modelo"> <font size="-1" color="white" face="arial">(obrig)</font></td></td></tr>
<% elseif tipo = 35 then %>
	<tr><td><font size="-1" color="#FFCC66" face="arial"><b>NOME SITE:</b></font></td><td><input maxlength="50" size="40" type="text" name="marca"> <font size="-1" color="white" face="arial">(obrig)</font></td></td></tr>
	<tr><td><font size="-1" color="#FFCC66" face="arial"><b>LINK:</b></font></td><td><input value="http://" maxlength="50" size="40" type="text" name="modelo"> <font size="-1" color="white" face="arial">(obrig)</font></td></td></tr>
<% elseif tipo = 40 then %>
	<tr><td><font size="-1" color="#FFCC66" face="arial"><b>NOME LIVRO:</b></font></td><td><input maxlength="50" size="40" type="text" name="marca"> <font size="-1" color="white" face="arial">(obrig)</font></td></td></tr>
	<tr><td><font size="-1" color="#FFCC66" face="arial"><b>AUTOR(ES):</b></font></td><td><input maxlength="50" size="40" type="text" name="modelo"> <font size="-1" color="white" face="arial">(obrig)</font></td></td></tr>
<% elseif tipo = 41 then %>
	<tr><td><font size="-1" color="#FFCC66" face="arial"><b>NOME JORNAL:</b></font></td><td><input maxlength="50" size="40" type="text" name="marca"> <font size="-1" color="white" face="arial">(obrig)</font></td></td></tr>
<% elseif tipo = 42 then %>
	<tr><td><font size="-1" color="#FFCC66" face="arial"><b>NOME REVISTA:</b></font></td><td><input maxlength="50" size="40" type="text" name="marca"> <font size="-1" color="white" face="arial">(obrig)</font></td></td></tr>
<% else %>	
	<tr><td><font size="-1" color="#FFCC66" face="arial"><b>MARCA:</b></font></td><td><input maxlength="50" size="40" type="text" name="marca"> <font size="-1" color="white" face="arial">(obrig)</font></td></td></tr>
	<tr><td><font size="-1" color="#FFCC66" face="arial"><b>MODELO:</b></font></td><td><input maxlength="50" size="40" type="text" name="modelo"> <font size="-1" color="white" face="arial">(obrig)</font></td></td></tr>
<% end if %>
	<tr><td><br></td><td></td></tr>				
	<tr><td><font size="-1" color="#FFCC66" face="arial"><b>DESCRI&Ccedil;&Atilde;O<br>SEM OPINI&Atilde;O: </b></font><font size="-1" color="white" face="arial"><br>(se ultrapassar<br>estas 6 linhas<br>o texto ser&aacute;<br>cortado)</font></td><td><textarea name="descricao" cols="38" rows="6" wrap="VIRTUAL"></textarea></td></tr>
	<tr><td></td><td><input type="Submit" value="Inserir"></td></tr>	
</table>

</form>

<% FimPagina() %>
