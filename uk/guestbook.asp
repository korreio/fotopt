<!-- #include file="inicio_basedados.asp" -->

<%
SQL = "SELECT id, nome FROM Paises_todos WHERE id > 0"
Set paisRes = dbConnection.Execute(SQL)
%>

<!-- #include file="topo.asp" -->
<td bgcolor="gray" width="100%" align="left"><font size="-1" color="black" face="arial">&nbsp;GUESTBOOK</font></td>
<td><font size="-2">&nbsp;</font><a href="guestbook_paises.asp"><font size="-2" color="black" face="arial"><b>VIEW&nbsp;GUESTBOOK</b></font></a><font size="-2">&nbsp;</font></td>
<!-- #include file="fim_topo.asp" -->

<font size="-1" color="white" face="arial">Here you can</font>
<a href="guestbook_paises.asp"><font size="-1" color="#FFCC66" face="arial"><b>VIEW OUR GUESTBOOK</b></font></a>
<font size="-1" color="white" face="arial">or sign it.</font><br><br>

<font color="white" size="-1" face="Arial">
Please help us improve this website by signing our guestbook.<br>
Any suggestion or complain is always welcome. The only compulsory<br>
fields are <b>your name</b> and the <b>country</b>.
</font>

<form action="guestbook_res.asp" method=post>

<table border="0" cellpadding="3" cellspacing="0">
	<tr><td><font color="#FFCC66" size="-1" face="arial"><b>YOUR NAME: </b></font></td><td><input maxlength="255" size="40" type="Text" name="nome"></td></tr>
	<tr><td><br></td><td></td></tr>	
	<tr>
		<td><font color="#FFCC66" size="-1" face="arial"><b>COUNTRY: </b></font></td>
		<td>
			<select name="pais">
				<option value="0">Please select a country</option>
			<% do while not paisRes.eof %>
				<option value="<% =paisRes("id") %>"><% =paisRes("nome") %></option>
				<% paisRes.MoveNext %>
			<% loop %>
			</select>
		</td>
	</tr>
	<tr><td><font color="#FFCC66" size="-1" face="arial"><b>E-MAIL: </b></font></td><td><input maxlength="255" size="40" type="Text" name="email"></td></tr>
	<tr><td><br></td><td></td></tr>		
	<tr><td><font color="#FFCC66" size="-1" face="arial"><b>COMMENT: </b></font><font size="-1" color="white" face="arial"><br>(please do not write<br>more than this 6<br>lines, otherwise the<br>text will be cut)</font></td><td><textarea name="comentario" cols="38" rows="6" wrap="VIRTUAL"></textarea></td></tr>
	<tr><td><br></td><td></td></tr>	
	<tr><td><font color="#FFCC66" size="-1" face="arial"><b>HOW DID YOU<br>FIND OUT ABOUT<br>THIS WEBSITE?: </b></font></td><td><input maxlength="255" size="40" type="Text" name="como_chegou_ca"></td></tr>
	<tr><td></td><td><input type="Submit" value="Submit"></td></tr>
</table>
</form>

<!-- #include file="fim.asp" -->
<!-- #include file="fim_basedados.asp" -->