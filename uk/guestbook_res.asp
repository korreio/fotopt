<!-- #include file="../sqltext.asp" -->
<!-- #include file="inicio_basedados.asp" -->

<%
nome = SqlText(request("nome"))
email = SqlText(request("email"))
pais = request("pais")
comentario = SqlText(request("comentario"))
como_chegou_ca = SqlText(request("como_chegou_ca"))
%>

<!-- #include file="topo.asp" -->
<td bgcolor="gray" width="100%" align="left"><font size="-1" color="black" face="arial">&nbsp;SIGN GUESTBOOK</font></td>
<!-- #include file="fim_topo.asp" -->

<%
if (nome = "") or (pais = "0") then
%>
	<font size="+1" color="white" face="arial">You must fill the following fields: <b>your name</b> and <b>country</b></font>
	<br>
	<font size="+1" color="white" face="arial">please press <b>back</b> on your browser and complete the information.</font>	
<%
else
	SQL = "INSERT INTO guestbook ( nome, email, pais, comentario, como_chegou_ca, data) VALUES "
	SQL = SQL & "('" & nome & "','" & email & "','" & pais & "','" & comentario & "','" & como_chegou_ca & "','" & date() & " " & time() & "')"
	dbConnection.Execute(SQL)
%>
	<font size="+1" color="white" face="arial"><b>Thank you very much for your input!</b></font>
<% end if %>

<% if (nome <> "") and (pais <> "0") then %>
	<br><br>
	<a href="guestbook_paises.asp"><font size="-1" color="white" face="arial"><b>VIEW THE GUESTBOOK</b></font></a>
<% end if %>

<!-- #include file="fim.asp" -->
<!-- #include file="fim_basedados.asp" -->