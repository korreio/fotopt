<%
' Copyright: (c) 1999-2023, Tiago Fonseca
' GNU General Public License v3.0+ (see LICENSE.md or https://www.gnu.org/licenses/gpl-3.0.html)
' SPDX-License-Identifier: GPL-3.0-or-later
%>

<!-- #include file="funcoes_principais.asp" -->

<% autor = request("autor") %>

<%
AutenticarMembro(autor)
Menu 3, 2, "INSERIR, MUDAR OU APAGAR RETRATO" 
%>

<%
SQL = "SELECT nome, retrato FROM autor WHERE id = " & autor
Set autorRes = dbConnection.Execute(SQL)
%>

<font size="-1" color="white" face="arial">
Este lugar &eacute; apenas para inserir o seu <b>retrato pessoal</b>,
para inserir fotos volte atr&aacute;s e escolha a op&ccedil;&atilde;o <b>INSERIR FOTOS</b><br>
<br>
Por favor consulte a AJUDA para saber pormenores sobre o envio de fotografias (s&oacute; tem que ler a parte <b>INSERIR RETRATO</b>)
</font>
<br>

<form enctype="multipart/form-data" action="inserir_retrato_res.asp" method=post>

<table border="0" cellpadding="3" cellspacing="0">
	<tr><td><font size="-1" color="#FFCC66" face="arial"><b>AUTOR: </b></font></td><td><font size="-1" color="white" face="arial"><% =autorRes("nome") %></font></td></tr>
	<tr><td><font size="-1" color="#FFCC66" face="arial"><b>RETRATO: </b></font></td><td><input type="file" size="30" name="retrato"><br><font size="-1" color="white" face="arial">(imagem no formato &quot;jpg&quot; com um tamanho m&aacute;ximo de 50 kbytes)</font></td></tr>
	<tr><td><br></td><td></td></tr>	
	<tr><td></td><td>
		<input type="Submit" value="Inserir retrato"><br>
		<font size="-1" color="white" face="arial">
			(logo a seguir a premir este bot&atilde;o &eacute; normal que pare&ccedil;a que	nada acontece.<br>
			Tem que	esperar uns momentos enquanto o seu retrato &eacute; enviado.<br>
			Quando o envio termina com sucesso o seu <i>browser</i> volta autom&aacute;ticamente para sua ficha pessoal)
		</font>
		<% if session("login") = 2 then %>
			<input type="hidden" name="autor" value="<% =autor %>">
		<% end if %>
	</td></tr>
</table>

</form>

<% if autorRes("retrato") = True then %>
	<form method="post" action="apagar_retrato_res.asp?autor=<% =autor %>">
		<font color="#FFCC66" face="arial"><b>Para apagar o retrato actual confirme aqui <input type="Checkbox" name="apagar"> e prima o bot&atilde;o - </b></font><input type="Submit" value="Apagar">
	</form>
<% end if %>

<% FimPagina() %>
