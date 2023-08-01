<!-- #include file="sqltext.asp" -->
<!-- #include file="funcoes_principais.asp" -->

<%
opor = request("opor")

SQL = "SELECT * FROM emprego_oportunidade WHERE id = " & opor
Set oporRes = dbConnection.Execute(SQL)

autor = oporRes("autor")
%>

<% 
AutenticarMembro(autor)
Menu 6, 3, "MUDAR OU APAGAR OPORTUNIDADE DE EMPREGO"
%>

<form action="mudar_emprego_opor_res.asp?opor=<% =opor %>" method="post">

<table border="0" cellpadding="3" cellspacing="0">
	<tr><td><font size="-1" color="#FFCC66" face="arial"><b>CARGO: </b></font></td><td><input maxlength="255" type="Text" size="40" value="<% =Aspas2Quot(oporRes("cargo")) %>" name="cargo"> <font size="-1" color="white" face="arial">(obrig)</font></td></tr>
	<tr><td><font size="-1" color="#FFCC66" face="arial"><b>EMPREGADOR: </b></font></td><td><input maxlength="255" type="Text" size="40" value="<% =Aspas2Quot(oporRes("empresa")) %>" name="empresa"> <font size="-1" color="white" face="arial">(obrig)</font></td></tr>
	<tr><td><font size="-1" color="#FFCC66" face="arial"><b>ZONA DO PA&Iacute;S: </b></font></td><td><input maxlength="255" type="Text" size="40" value="<% =Aspas2Quot(oporRes("zona")) %>" name="zona"> <font size="-1" color="white" face="arial">(obrig)</font></td></tr>
	<tr><td><br></td><td></td></tr>
	<tr><td><font size="-1" color="#FFCC66" face="arial"><b>PRETENDE: </b></font><font size="-1" color="white" face="arial"><br>(se ultrapassar<br>estas 6 linhas<br>o texto ser&aacute;<br>cortado)</font></td><td><textarea name="pretende" cols="38" rows="6" wrap="VIRTUAL"><% =oporRes("pretende") %></textarea></td></tr>
	<tr><td><font size="-1" color="#FFCC66" face="arial"><b>OFERECE: </b></font><font size="-1" color="white" face="arial"><br>(se ultrapassar<br>estas 6 linhas<br>o texto ser&aacute;<br>cortado)</font></td><td><textarea name="oferece" cols="38" rows="6" wrap="VIRTUAL"><% =oporRes("oferece") %></textarea></td></tr>
	<tr><td><br></td><td></td></tr>
	<tr><td><font size="-1" color="#FFCC66" face="arial"><b>HOR&Aacute;RIO/<br>DURA&Ccedil;&Atilde;O: </b></font></td><td><input maxlength="255" type="Text" size="40" value="<% =Aspas2Quot(oporRes("horario")) %>" name="horario"></td></tr>
	<tr><td><font size="-1" color="#FFCC66" face="arial"><b>OBSERVA&Ccedil;&Otilde;ES: </b></font><font size="-1" color="white" face="arial"><br>(se ultrapassar<br>estas 6 linhas<br>o texto ser&aacute;<br>cortado)</font></td><td><textarea name="observacoes" cols="38" rows="6" wrap="VIRTUAL"><% =oporRes("observacoes") %></textarea></td></tr>
	<tr><td><br></td><td></td></tr>	
	<tr><td><font size="-1" color="#FFCC66" face="arial"><b>CONTACTO: </b></font></td><td><input maxlength="255" type="Text" size="40" value="<% =Aspas2Quot(oporRes("contacto")) %>" name="contacto"> <font size="-1" color="white" face="arial">(obrig)</font></td></tr>

	<tr><td></td><td><input type="Submit" value="Mudar oportunidade"></td></tr>
</table>

</form>

<form method="post" action="apagar_emprego_opor_res.asp?opor=<% =opor %>">
	<font color="#FFCC66" face="arial"><b>Para apagar esta oportunidade confirme aqui <input type="Checkbox" name="apagar"> e prima o bot&atilde;o - </b></font><input type="Submit" value="Apagar">
</form>

<% FimPagina() %>
