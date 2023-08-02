<%
' Copyright: (c) 1999-2023, Tiago Fonseca
' GNU General Public License v3.0+ (see LICENSE.md or https://www.gnu.org/licenses/gpl-3.0.html)
' SPDX-License-Identifier: GPL-3.0-or-later
%>

<!-- #include file="funcoes_principais.asp" -->
<!-- #include file="ordem_galeria.asp" -->

<%
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
nome = replace(request("nome"), " ", "%")

if nome <> "" then
	SQL = "SELECT distinct(autor.id), autor.nome FROM autor INNER JOIN foto ON autor.id = foto.autor WHERE autor.nome LIKE '%" & nome & "%' "
	if letra = "O" then
		SQL = SQL & "OR nome LIKE '�%' "
	end if
	SQL = SQL & "AND autor.id ORDER by nome"
	Set autorRes = dbConnection.Execute(SQL)
end if

if letra <> "" then
	if letra = "TODOS" then
		SQL = "SELECT distinct(autor.id), autor.nome FROM autor INNER JOIN foto ON autor.id = foto.autor ORDER by nome"
		Set autorRes = dbConnection.Execute(SQL)
	else
		SQL = "SELECT distinct(autor.id), autor.nome FROM autor INNER JOIN foto ON autor.id = foto.autor WHERE autor.nome LIKE '" & letra & "%' "
		if letra = "O" then
			SQL = SQL & "OR nome LIKE '�%' "
		end if
		SQL = SQL & "AND autor.id ORDER by nome"
		Set autorRes = dbConnection.Execute(SQL)
	end if
end if

if (letra <> "") or (nome <> "") then
	num = 0
	do while not autorRes.eof
		num = num + 1
		autorRes.MoveNext
	loop

	if num > 0 then
		autorRes.MoveFirst 
	end if
	
	if (num mod 3) = 0 then
		porColuna = num / 3
	else
		porColuna = num / 3 + 1
	end if
end if

Dim letras
letras = Array("A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z")
%>

<% 
Menu 1, 1, "GALERIAS DE MEMBROS" 
%>

<table border="1" cellspacing="0" cellpadding="10">
  <% if session("login") <> 0 then %>
	  <tr><td>
		<a href="lista_temas.asp?autor=<% =session("login") %>"><font size="-1" color="#ffcc66" face="verdana, arial"><b>IR PARA A MINHA GALERIA</b></font></a><font size="-2">&nbsp;&nbsp;</font>
	  </td></tr>
  <% end if %>

  <% if (letra <> "") or (nome <> "") then %>
  <tr>
    <td colspan="5">
		<% if letra = "TODOS" then %>
			<font color="white" face="arial"><b>AUTORES COM NOMES COME�ADOS COM</b></font> <font size="-2" color="white" face="arial">(s&oacute; quem j&aacute; enviou fotos)</font>
		<% elseif nome <> "" then %>
			<font color="white" face="arial"><b>AUTORES CUJO NOME CONTEM "<% =replace(nome, "%", " ") %>"</b></font> <font size="-2" color="white" face="arial">(s&oacute; quem j&aacute; enviou fotos)</font>
		<% else %>
			<font color="white" face="arial"><b>AUTORES COM NOMES COME�ADOS COM &quot;<% =letra %>&quot; </b></font> <font size="-2" color="white" face="arial">(s&oacute; quem j&aacute; enviou fotos)</font>
		<% end if %>
		<br>
		
		<table border="0" cellspacing="0" cellpadding="0"><tr>
		<% for j = 1 to 3 %>
			<td valign="top"><table border="0" cellspacing="0" cellpadding="3">
			<% 
			for i = 1 to porColuna
				if not autorRes.eof then
			%>
					<tr><td><a href="lista_temas.asp?autor=<% =autorRes("id") %>"><font size="-2" color="#ffcc66" face="verdana, arial"><b><% =autorRes("nome") %></b></font></a><font size="-2">&nbsp;&nbsp;</font></td></tr>
		<% 
				autorRes.MoveNext
				end if
			next
		%>
			</table></td>
		<% next %>
		</tr></table>
	</td>
  </tr>
  <% end if %>
  
  <% if letra <> "TODOS" then %>
  <tr>
    <td colspan="5">
		<font color="white" face="arial"><b>AUTORES COM NOME COME�ADO COM:</b></font><br><font size="-2" color="white" face="arial">(de um total de <% =numAutores %> autores com <% =numFotosRes("num") %> fotos inseridas)</font>
		<br><br>

		<% for i = 0 to 25 %>
			<% if letras(i) <> letra then %>
				<a href="escolha_galeria_membros.asp?letra=<% =letras(i) %>"><font color="#ffcc66" face="verdana, arial"><b><% =letras(i) %></b></font></a>
			<% end if %>
		<% next %>
	</td>
  </tr>
  <% end if %>

  <tr><td>
	<font color="white" face="arial"><b>PROCURAR MEMBROS:</b></font><br><br>
	<table border="0" cellpadding="3" cellspacing="0">
	<form action="escolha_galeria_membros.asp" method="post">
	<tr><td colspan="2"><font size="-1" color="#FFCC66" face="arial"><b>POR NOME: </b></font></td></tr>
	<tr><td><input maxlength="255" size="40" type="text" name="nome"></td><td><input type="Submit" value="Procurar"></td></tr>
	</form>
	</table>
  </td></tr>
</table>

<br>
<a href="direitos_autor.asp"><font size="-2" color="white" face="arial">Direitos de autor</font></a><font size="-2" color="white" face="arial">: As imagens sao propriedade do autor ou dos seus clientes, podendo ser reproduzida somente com autoriza��o dos mesmos.</font>

<% FimPagina() %>
