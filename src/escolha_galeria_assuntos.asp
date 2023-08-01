<!-- #include file="funcoes_principais.asp" -->
<!-- #include file="ordem_galeria.asp" -->

<%
SQL = "SELECT nome, id FROM assunto WHERE id <> 5 ORDER by nome"
Set assuntoRes = dbConnection.Execute(SQL)

Menu 1, 3, "GALERIAS POR ASSUNTOS" 
%>

<table border="1" cellspacing="0" cellpadding="10">
  <tr>
    <td colspan="5">
		<font color="white" face="arial"><b>ESCOLHA O ASSUNTO:</b></font>
		
		<br>
		<table border="0" cellspacing="0" cellpadding="2">
		<% 
		do while not assuntoRes.eof 
			SQL = "SELECT count(*) AS num FROM foto WHERE assunto = " & assuntoRes("id")
			Set numRes = dbConnection.Execute(SQL)
		%>
			<tr>
			<td><a href="galeria.asp?tipo=assunto&id=<% =assuntoRes("id") %>"><font size="-2" color="#ffcc66" face="verdana, arial"><b><% =assuntoRes("nome") %></b></font></a>&nbsp;&nbsp;</td>
			<td><font size="-2" color="silver" face="verdana, arial">(<% =numRes("num") %> fotos)</font></td>
			</tr>
		<%
			assuntoRes.MoveNext
		Loop 
		SQL = "SELECT count(*) AS num FROM foto WHERE assunto = 5"
		Set numRes = dbConnection.Execute(SQL)
		%>

		<tr>
		<td><br><a href="galeria.asp?tipo=assunto&id=5"><font size="-2" color="#ffcc66" face="verdana, arial"><b>OUTROS</b></font></a>&nbsp;&nbsp;</td>
		<td><br><font size="-2" color="silver" face="verdana, arial">(<% =numRes("num") %> fotos)</font></td>
		</tr>
		</table>
	</td>
  </tr>
</table>

<br>
&nbsp;&nbsp;<a href="direitos_autor.asp"><font size="-2" color="white" face="arial">Direitos de autor</font></a><font size="-2" color="white" face="arial">: As imagens sao propriedade do autor ou dos seus clientes, podendo ser reproduzida somente com autorização dos mesmos.</font>

<% FimPagina() %>
