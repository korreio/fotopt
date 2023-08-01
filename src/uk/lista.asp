<!-- #include file="inicio_basedados.asp" -->
<!-- #include file="../ordem_galeria.asp" -->
<!-- #include file="../galeria_seleccao.asp" -->
<!-- #include file="nome_galeria.asp" -->
<!-- #include file="topo.asp" -->
<td bgcolor="gray" width="100%" align="left"><font size="-1" color="black" face="arial">&nbsp;<% =nomeGaleria %> GALLERY PAGES</font></td>
<td align="center"><font size="-2">&nbsp;</font><a href="galeria.asp?tipo=<% =tipo %>&primeira=<% =primeira %>&id=<% =id %>&tema=<% =tema %>"><font size="-2" color="black" face="arial">CURRENT&nbsp;PAGE</font></a><font size="-2">&nbsp;</font></td>

<% if session("ordem") = "c" then %>
	<td><font size="-2">&nbsp;</font><a href="lista.asp?letra=<% =letra %>&ordem=dec&primeira=<% =primeira %>&tema=<% =tema %>&tipo=<% =tipo %>&id=<% =id %>"><font size="-2" color="black" face="arial">NEW&nbsp;>&nbsp;OLD</font></a><font size="-2">&nbsp;</font></td>
<% else %>
	<td><font size="-2">&nbsp;</font><a href="lista.asp?letra=<% =letra %>&ordem=cre&primeira=<% =primeira %>&tema=<% =tema %>&tipo=<% =tipo %>&id=<% =id %>"><font size="-2" color="black" face="arial">OLD&nbsp;>&nbsp;NEW</font></a><font size="-2">&nbsp;</font></td>
<% end if %>
<!-- #include file="fim_topo.asp" -->

<% 
SQL = "SELECT count(*) AS num FROM foto " & SQLW
Set numFotoRes = dbConnection.Execute(SQL)

if (numFotoRes("num") mod 6) = 0 then
	paginas = numFotoRes("num") / 6
else
	paginas = int(numFotoRes("num") / 6) + 1
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
This gallery has <b><% =numFotoRes("num") %></b> photos divided in <b><% =paginas %></b> pages, press the number of the page
you want to see (the ID's of the photos in each page is in parentesis):
<br>
<% if session("ordem") = "c" then %>
	<b>OLD->NEW</b> sort - the photos as sorted from the older ones to the most recently submited,
<% else %>
	<b>NEW->OLD</b> sort - the photos as sorted from the most recently submited to the older ones,
<% end if %>
	to invert press the link at the top bar.
</font><br><br>

<table cellspacing="0" cellpadding="5" border="1">
<%
fim = true
i = 1
j = -1
do while not fotoRes.eof
	if (((i - 7) mod 6) = 0) then
		j = j + 1
		fim = false
%>
		<% if (j MOD 8) = 0 then %><tr><% end if %>
		<td align="center"><a href="galeria.asp?tipo=<% =tipo %>&primeira=<% =fotoRes("id") %>&id=<% =id %>&tema=<% =tema %>"><font color="#FFCC66" face="arial" size="-1"><b><% =j + 1 %></b></font></a><font color="white" face="arial" size="-2"><br>(<% =fotoRes("id") %>
<% 
	end if 
	if ((i mod 6) = 0) then
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

<!-- #include file="fim.asp" -->
<!-- #include file="fim_basedados.asp" -->