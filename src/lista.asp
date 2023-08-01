<!-- #include file="funcoes_principais.asp" -->
<!-- #include file="ordem_galeria.asp" -->
<!-- #include file="galeria_seleccao.asp" -->
<!-- #include file="nome_galeria.asp" -->

<%
OpcaoMenu "VOLTAR PÁGINA ACTUAL", "galeria.asp?tipo=" & tipo & "&primeira=" & primeira & "&id=" & id & "&tema=" & tema, False, False, -1, False, False
if session("ordem") = "c" then
	OpcaoMenu "ORDENAR POR ORDEM DECRESCENTE", "lista.asp?letra=" & letra & "&ordem=dec&primeira=" & primeira & "&tema=" & tema & "&tipo=" & tipo & "&id=" & id, False, False, -1, False, False
else
	OpcaoMenu "ORDENAR POR ORDEM CRESCENTE", "lista.asp?letra=" & letra & "&ordem=cre&primeira=" & primeira & "&tema=" & tema & "&tipo=" & tipo & "&id=" & id, False, False, -1, False, False
end if
Menu 1, GaleriaSubSeccao(tipo, id), "PÁGINAS DA GALERIA DE " & nomeGaleria
%>

<% 
' Numero de fotos por pagina da galeria
if session("login") <> 0 then
	SQL = "SELECT fotos_por_galeria FROM autor_opcoes WHERE autor = " & session("login")
	Set confAutorRes = dbConnection.Execute(SQL)

	SQL = "SELECT fotos FROM fotos_por_galeria WHERE id = " & confAutorRes("fotos_por_galeria")
	Set fotosGaleriaRes = dbConnection.Execute(SQL)

	numFotos = fotosGaleriaRes("fotos")
else
	numFotos = 6
end if

SQL = "SELECT count(*) AS num FROM foto " & SQLW
Set numFotoRes = dbConnection.Execute(SQL)

if (numFotoRes("num") mod numFotos) = 0 then
	paginas = numFotoRes("num") / numFotos
else
	paginas = int(numFotoRes("num") / numFotos) + 1
end if

if session("ordem") = "c" then
	SQL = "SELECT foto.id FROM foto " & SQLW & " ORDER BY foto.id"
	Set fotoRes = dbConnection.Execute(SQL)
else
	SQL = "SELECT foto.id FROM foto " & SQLW & " ORDER BY foto.id DESC"
	Set fotoRes = dbConnection.Execute(SQL)
end if
%>
<font color="white" face="arial" size="-1">
Esta galeria tem <b><% =numFotoRes("num") %></b> fotografias distribuidas por <b><% =paginas %></b> p&aacute;ginas, prima o n&uacute;mero da p&aacute;gina
que quer ver (os ID's das fotos que est&atilde;o nessa p&aacute;gina est&atilde;o entre parentesis):
<br>
<% if session("ordem") = "c" then %>
	Ordena&ccedil;&atilde;o <b>ANTIGAS&nbsp;&gt;&nbsp;RECENTES</b> - as fotografias s&atilde;o mostradas por data de inser&ccedil;&atilde;o <b>crescente</b>,
<% else %>
	Ordena&ccedil;&atilde;o <b>RECENTES&nbsp;&gt;&nbsp;ANTIGAS</b> - as fotografias s&atilde;o mostradas por data de inser&ccedil;&atilde;o <b>decrescente</b>,
<% end if %>
	para mudar prima o bot&atilde;o no topo.
</font><br><br>

<table cellspacing="0" cellpadding="5" border="1">
<%
fim = true
i = 1
j = -1
do while not fotoRes.eof
	if (((i - (numFotos + 1)) mod numFotos) = 0) then
		j = j + 1
		fim = false
%>
		<% if (j MOD 8) = 0 then %><tr><% end if %>
		<td align="center"><a href="galeria.asp?tipo=<% =tipo %>&primeira=<% =fotoRes("id") %>&id=<% =id %>&tema=<% =tema %>"><font color="#FFCC66" face="arial" size="-1"><b><% =j + 1 %></b></font></a><font color="white" face="arial" size="-2"><br>(<% =fotoRes("id") %>
<% 
	end if 
	if ((i mod numFotos) = 0) then
		fim = true 
%>	
		</font><font color="white" face="arial" size="-2">- <% =fotoRes("id") %>)</font></td>
		<% if ((j + 1) MOD 8) = 0 then %></tr><% end if %>
<%
	end if

	ultima = fotoRes("id")
	fotoRes.MoveNext
	i = i + 1
loop

if fim = false then 
%>
	</font><font color="white" face="arial" size="-2">- <% =ultima %>)</font></td></tr>
<% end if %>
</table>

<% FimPagina() %>
