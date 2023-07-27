<!-- #include file="funcoes_principais.asp" -->

<%
if session("login") = 2 then
	autor = request("autor")
else
	autor = session("login")
end if
%>

<% 
AutenticarMembro(autor)
Menu 1, 1, "CRIAR TEMA"
%>

<form action="criar_tema_res.asp?autor=<% =autor %>" method=post>
<table border="0" cellpadding="3" cellspacing="0">
	<tr><td><font size="-1" color="#FFCC66" face="arial"><b>NOME DO TEMA: </b></font></td><td><input type="Text" name="tema" size="40"></td><td><font size="-1" color="white" face="arial"> (obrig.)</font></td></tr>
	<tr><td><font size="-1" color="#FFCC66" face="arial"><b>DESCRI&Ccedil;&Atilde;O: </b></font><font size="-1" color="white" face="arial"><br>(se ultrapassar<br>estas 6 linhas<br>o texto ser&aacute;<br>cortado)</font></td><td colspan="2"><textarea name="descricao" cols="38" rows="6" wrap="virtual"></textarea></td></tr>
	<tr><td></td><td></td></tr>		
	<tr>
		<td><font size="-2" color="#FFCC66" face="arial"><b>NOME DO TEMA<br>EM INGL&Ecirc;S: </b></font></td>
		<td><input type="Text" name="tema_uk" size="40"></td>
		<td valign="top" width="200" rowspan="2"><font size="-1" color="white" face="arial"> (Estes s&atilde;o os mesmos campos que est&atilde;o acima mas para a vers&atilde;o internacional do site. Se deixar estes campos em branco, na vers&atilde;o internacional do site, os temas aparecer&atilde;o sem nome e descri&ccedil;&atilde;o, apenas numerados)</font></td>
	</tr>
	<tr><td><font size="-2" color="#FFCC66" face="arial"><b>DESCRI&Ccedil;&Atilde;O<br>EM INGL&Ecirc;S: </b></font><font size="-1" color="white" face="arial"><br>(se ultrapassar<br>estas 6 linhas<br>o texto ser&aacute;<br>cortado)</font></td><td><textarea name="descricao_uk" cols="38" rows="6" wrap="VIRTUAL"></textarea></td></tr>
	<tr><td></td><td></td><td></td></tr>		
	<tr><td></td><td colspan="2"><input type="Submit" value="Criar tema"></td></tr>
</table>
</form>

<% FimPagina() %>
