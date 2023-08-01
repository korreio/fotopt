<!-- #include file="sqltext.asp" -->
<!-- #include file="funcoes_principais.asp" -->

<%
tema = request("tema")

SQL = "SELECT * FROM folder WHERE id = " & tema
Set temaRes = dbConnection.Execute(SQL)

autor = temaRes("autor")
%>

<% 
AutenticarMembro(autor)
Menu 1, 1, "MUDAR OU APAGAR TEMA"
%>

<form action="mudar_tema_res.asp?id=<% =tema %>&autor=<% =autor %>" method=post>
<table border="0" cellpadding="3" cellspacing="0">
	<tr><td><font size="-1" color="#FFCC66" face="arial"><b>NOME DO TEMA: </b></font></td><td><input type="Text" name="tema" value="<% =Aspas2Quot(temaRes("nome")) %>" size="40"></td><td><font size="-1" color="white" face="arial"> (obrig.)</font></td></tr>
	<tr><td><font size="-1" color="#FFCC66" face="arial"><b>DESCRI&Ccedil;&Atilde;O: </b></font><font size="-1" color="white" face="arial"><br>(se ultrapassar<br>estas 6 linhas<br>o texto ser&aacute;<br>cortado)</font></td><td colspan="2"><textarea name="descricao" cols="38" rows="6" wrap="VIRTUAL"><% =temaRes("descricao") %></textarea></td></tr>
	<tr><td></td><td></td></tr>		
	<tr>
		<td><font size="-2" color="#FFCC66" face="arial"><b>NOME DO TEMA<br>EM INGL&Ecirc;S: </b></font></td>
		<td><input type="Text" name="tema_uk" value="<% =Aspas2Quot(temaRes("nome_uk")) %>" size="40"></td>
		<td valign="top" width="200" rowspan="2"><font size="-1" color="white" face="arial"> (Estes s&atilde;o os mesmos campos que est&atilde;o acima mas para a vers&atilde;o internacional do site. Se deixar estes campos em branco, na vers&atilde;o internacional do site, os temas aparecer&atilde;o sem nome, apenas numerados)</font></td>
	</tr>
	<tr><td><font size="-2" color="#FFCC66" face="arial"><b>DESCRI&Ccedil;&Atilde;O<br>EM INGL&Ecirc;S: </b></font><font size="-1" color="white" face="arial"><br>(se ultrapassar<br>estas 6 linhas<br>o texto ser&aacute;<br>cortado)</font></td><td><textarea name="descricao_uk" cols="38" rows="6" wrap="VIRTUAL"><% =temaRes("descricao_uk") %></textarea></td></tr>
	<tr><td></td><td></td><td></td></tr>		
	<tr><td></td><td colspan="2"><input type="Submit" value="Mudar tema"></td></tr>
</table>
</form>

<form method="post" action="apagar_tema_res.asp?tema=<% =tema %>&autor=<% =autor %>">
	<font color="#FFCC66" face="arial"><b>Para apagar este tema confirme aqui <input type="Checkbox" name="apagar"> e prima o bot&atilde;o - </b></font><input type="Submit" value="Apagar">
	<br><font size="-1" color="white" face="arial">Nota: todas as fotos que estejam neste tema s&atilde;o transferida para o tema &quot;Geral&quot;.</font>
</form>

<% FimPagina() %>
