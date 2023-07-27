<!-- #include file="inicio_basedados.asp" -->

<%
SQL = "SELECT en_nome, id FROM assunto WHERE id <> 5 ORDER by en_nome"
Set assuntoRes = dbConnection.Execute(SQL)

SQL = "SELECT distinct(autor) AS difAutor FROM foto"
Set numAutorRes = dbConnection.Execute(SQL)
numAutores = 0
do while not numAutorRes.eof
	numAutores = numAutores + 1
	numAutorRes.moveNext
loop

SQL = "SELECT count(*) AS num FROM foto"
Set numFotosRes = dbConnection.Execute(SQL)

letra = request("letra")
if letra <> "" then
	if letra = "TODOS" then
		SQL = "SELECT nome, id FROM autor WHERE autor.id IN "
		SQL = SQL & "(SELECT distinct(autor) FROM foto) "
		SQL = SQL & " ORDER by nome"
		Set autorRes = dbConnection.Execute(SQL)
	else
		SQL = "SELECT nome, id FROM autor WHERE nome LIKE '" & letra & "%' AND autor.id IN "
		SQL = SQL & "(SELECT distinct(autor) FROM foto) "
		SQL = SQL & " ORDER by nome"
		Set autorRes = dbConnection.Execute(SQL)
	end if
end if

Dim letras
letras = Array("A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z")
%>

<!-- #include file="../ordem_galeria.asp" -->
<!-- #include file="topo.asp" -->
<td bgcolor="gray" width="100%" align="left"><font size="-1" color="black" face="arial">&nbsp;GALLERY</font></td>
<% if session("ordem") = "c" then %>
	<td><font size="-2">&nbsp;</font><a href="escolha_galeria.asp?letra=<% =letra %>&ordem=dec"><font size="-2" color="black" face="arial">NEW&nbsp;>&nbsp;OLD</font></a><font size="-2">&nbsp;</font></td>
<% else %>
	<td><font size="-2">&nbsp;</font><a href="escolha_galeria.asp?letra=<% =letra %>&ordem=cre"><font size="-2" color="black" face="arial">OLD&nbsp;>&nbsp;NEW</font></a><font size="-2">&nbsp;</font></td>
<% end if %>
<!-- #include file="fim_topo.asp" -->

<table border="1" cellspacing="0" cellpadding="10">
  <% if letra <> "" then %>
  <tr>
    <td>
		<% if letra <> "TODOS" then %>
			<font color="white" face="arial"><b>AUTHORS WITH &quot;<% =letra %>&quot; </b></font>
		<% else %>
			<font color="white" face="arial"><b>AUTHORS</b></font>
		<% end if %>
		<br>
		
		<table border="0" cellspacing="0" cellpadding="2">
		<% 
		i = 0
		do while not autorRes.eof 
			SQL = "SELECT count(*) AS numTemas FROM folder WHERE autor = " & autorRes("id")
			Set numTemasRes = dbConnection.Execute(SQL)

			if (i MOD 3) = 0 then
		%>
			<tr>
		<% end if %>
			<% if numTemasRes("numTemas") = 0 then %>
				<td><a href="galeria.asp?tipo=autor&id=<% =autorRes("id") %>&tema=-1"><font size="-2" color="#FFCC66" face="verdana, arial"><b><% =autorRes("nome") %></b></font></a>&nbsp;&nbsp;</td>
			<% else %>
				<td><a href="lista_temas.asp?autor=<% =autorRes("id") %>"><font size="-2" color="#ffcc66" face="verdana, arial"><b><% =autorRes("nome") %></b></font></a>&nbsp;&nbsp;</td>			
			<% end if %>
		<% if ((i + 1) MOD 3) = 0 then %>
			</tr>
		<%
			end if
			i = i + 1
			autorRes.MoveNext
		Loop 
		%>
		</table>
	</td>
  </tr>
  <% end if %>
  <% if letra <> "TODOS" then %>
  <tr>
    <td>
		<% if letra <> "" then %>
			<font color="white" face="arial"><b>OTHER AUTHORS</b></font> <font size="-2" color="white" face="arial">(from a total of <% =numAutores %> authors with <% =numFotosRes("num") %> submited photos)</font>
		<% else %>
			<font color="white" face="arial"><b>AUTHORS</b></font> <font size="-2" color="white" face="arial">(from a total of <% =numAutores %> authors with <% =numFotosRes("num") %> submited photos)</font>
		<% end if %>
		<br>

		<% for i = 0 to 25 %>
			<% if letras(i) <> letra then %>
				<a href="escolha_galeria.asp?letra=<% =letras(i) %>"><font color="#FFCC66" size="-1" face="verdana, arial"><b><% =letras(i) %></b></font></a>
			<% end if %>
		<% next %>
		&nbsp;<a href="escolha_galeria.asp?letra=TODOS"><font color="#FFCC66" size="-1" face="verdana, arial"><b>ALL</b></font></a>
	</td>
  </tr>
  <% end if %>
  <tr>
    <td>
		<font color="white" face="arial"><b>SUBJECT</b></font>
		
		<br>
		<table border="0" cellspacing="0" cellpadding="2">
		<% 
		i = 0
		do while not assuntoRes.eof 
			if (i MOD 4) = 0 then
		%>
			<tr>
		<% end if %>
			<td><a href="galeria.asp?tipo=assunto&id=<% =assuntoRes("id") %>"><font size="-2" color="#FFCC66" face="verdana, arial"><b><% =assuntoRes("en_nome") %></b></font></a>&nbsp;&nbsp;</td>
		<% if ((i + 1) MOD 4) = 0 then %>
			</tr>
		<%
			end if
			i = i + 1
			assuntoRes.MoveNext
		Loop 
		%>
			<td><a href="galeria.asp?tipo=assunto&id=5"><font size="-2" color="#FFCC66" face="verdana, arial"><b>OTHER</b></font></a>&nbsp;&nbsp;</td></tr>
		</table>
	</td>
  </tr>
</table>

<br>
<a href="direitos_autor.asp"><font size="-2" color="white" face="arial">Author rights</font></a><font size="-2" color="white" face="arial">: The pictures are propriety of it's author or his clients, any abuser can be prossecuted by law.</font>

<!-- #include file="fim.asp" -->
<!-- #include file="fim_basedados.asp" -->