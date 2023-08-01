<!-- #include file="inicio_basedados.asp" -->

<% 
faq = request("faq")

SQL = "SELECT * FROM faq_tipo"
Set tipoRes = dbConnection.Execute(SQL)

SQL = "SELECT * FROM faq WHERE id = " & faq
Set faqRes = dbConnection.Execute(SQL)
%>

<!-- #include file="topo.asp" -->
<td bgcolor="gray" width="100%" align="left"><font size="-1" color="black" face="arial">&nbsp;MUDAR FAQ</font></td>
<!-- #include file="fim_topo.asp" -->
<!-- #include file="autenticar_webmaster.asp" -->

<form action="mudar_faq_res.asp?faq=<% =faq %>" method=post>

<table border="0" cellpadding="3" cellspacing="0">
	<tr>
		<td><font size="-1" color="#FFCC66" face="arial"><b>TIPO: </b></font></td>
		<td><select name="tipo">
			<% do while not tipoRes.eof %>
				<% if faqRes("tipo") = tipoRes("id") then %>
					<option selected value="<% =tipoRes("id") %>"><% =tipoRes("nome") %></option>
				<% else %>
					<option value="<% =tipoRes("id") %>"><% =tipoRes("nome") %></option>
				<% end if %>
				<% tipoRes.MoveNext %>
			<% loop %>
		</select> 
		<font size="-1" color="white" face="arial">(obrig)</font></td>
	</tr>
	<tr><td><font size="-1" color="#FFCC66" face="arial"><b>PERGUNTA: </b></font></td><td><input type="Text" value="<% =faqRes("pergunta") %>" name="pergunta" size="40"> <font size="-1" color="white" face="arial">(obrig)</font></td></tr>
	<tr><td><font size="-1" color="#FFCC66" face="arial"><b>RESPOSTA: </b></font></td><td><textarea name="resposta" cols="38" rows="20" wrap="VIRTUAL"><% =faqRes("resposta") %></textarea> <font size="-1" color="white" face="arial">(obrig)</font></td></tr>
	<tr><td></td><td><input type="Submit" value="Mudar FAQ"></td></tr>
</table>

</form>

<form method="post" action="adm_apagar_faq_res.asp?faq=<% =faq %>">
	<font color="#FFCC66" face="arial"><b>Para apagar este FAQ corfirme aqui <input type="Checkbox" name="apagar"> e prima o bot&atilde;o - </b></font><input type="Submit" value="Apagar">
</form>

<!-- #include file="fim_autenticacao.asp" -->
<!-- #include file="fim_basedados.asp" -->