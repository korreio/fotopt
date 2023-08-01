<!-- #include file="funcoes_principais.asp" -->

<%
AutenticarMembro(autor)
Menu 7, 2, "CRIAR VOTA��O"
%>

<%
SQL = "SELECT nome FROM autor WHERE id = " & session("login")
Set autorRes = dbConnection.Execute(SQL)
%>

<form action="inserir_votacao_res.asp" method=post>

<table border="0" cellpadding="3" cellspacing="0">
	<tr>
		<td><font size="-1" color="#FFCC66" face="arial"><b>NOTA: </b></font></td>
		<td><font size="-1" color="white" face="arial">
			Todas as vota��es s�o moderadas pelo webmaster, para que n�o existam abusos na sua utiliza��o.
			Isto significa que s� depois de lida e aprovada � que a vota��o ficar� disponivel para os outros membros participarem.
			Poder� levar 2 ou 3 dias para as vota��es serem aprovadas. As n�o aprovadas simplemente n�o aparecer�o para os
			outros membros. Relembro que as vota��es se dedicam unicamente a assuntos relacionados com fotografia.
		</font></td>
	</tr>
	<tr><td><font size="-1" color="#FFCC66" face="arial"><b>CRIADOR: </b></font></td><td><font color="white" face="arial"><% =autorRes("nome") %></font></td></tr>
	<tr><td></td><td></td></tr>
	<tr><td><font size="-1" color="#FFCC66" face="arial"><b>TEMA: </b></font></td><td><input maxlength="100" type="Text" name="nome" size="40"> <font size="-1" color="white" face="arial">(obrig)</font></td></tr>
	<tr><td><font size="-1" color="#FFCC66" face="arial"><b>DESCRI&Ccedil;&Atilde;O: </b></font><font size="-1" color="white" face="arial"><br>(se ultrapassar<br>estas 6 linhas<br>o texto ser&aacute;<br>cortado)</font></td><td><textarea name="descricao" cols="38" rows="6" wrap="VIRTUAL"></textarea> <font size="-1" color="white" face="arial">(obrig)</font></td></tr>
	<tr><td></td><td><input type="Submit" value="Criar vota&ccedil;&atilde;o"></td></tr>
</table>

</form>

<% FimPagina() %>
