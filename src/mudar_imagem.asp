<%
' Copyright: (c) 1999-2023, Tiago Fonseca
' GNU General Public License v3.0+ (see LICENSE.md or https://www.gnu.org/licenses/gpl-3.0.html)
' SPDX-License-Identifier: GPL-3.0-or-later
%>

<!-- #include file="funcoes_principais.asp" -->

<% 
foto = request("foto")

' Dados referentes a galeria
primeira = request("primeira")
tipo = request("tipo")
id = request("id")
temaid = request("tema")
num = request("num")

SQL = "SELECT * FROM foto WHERE id = " & foto
Set fotoRes = dbConnection.Execute(SQL)

autor = fotoRes("autor")

AutenticarMembro(autor)
Menu 1, GaleriaSubSeccao(tipo, id), "MUDAR IMAGEM"
%>

<%
SQL = "SELECT nome FROM autor WHERE id = " & fotoRes("autor")
Set autorRes = dbConnection.Execute(SQL)
%>

<form enctype="multipart/form-data" action="mudar_imagem_res.asp" method="post">

<font size="-1" color="white" face="arial">
Esta op��o serve para trocar uma imagem por outra semelhante, mantendo todos os dados relativos � fotografia.<br>
Serve por exemplo quando resolve mudar ligeiramente o tamanho ou a resolu��o da foto, ou alterar o contraste 
da foto, meter margens, ou porque fez uma digitaliza��o melhor.<br>
</font>
<font size="-1" color="#FFCC66" face="arial"><b>
A troca s� ser� ter� efeito depois do webmaster confirmar a semelhan�a das imagens, para evitar 
a troca de fotografias por outras completamente diferentes. Isto poder� levar alguns dias, e at� l� continuar� a
ver a imagem anterior.</b></font>
<br><br>

<table border="0" cellpadding="3" cellspacing="0">
	<tr><td><font size="-1" color="#FFCC66" face="arial"><b>FOTO: </b></font></td><td><font size="-1" color="white" face="arial"><% =fotoRes("id") %></font></td></tr>
	<tr><td><font size="-1" color="#FFCC66" face="arial"><b>AUTOR: </b></font></td><td><font size="-1" color="white" face="arial"><% =autorRes("nome") %></font></td></tr>

	<tr><td valign="top"><font size="-1" color="#FFCC66" face="arial"><b>NOVA<br>IMAGEM: </b></font></td><td><input type="file" name="imagem"> <br><font size="-2" color="white" face="arial">(Campo obrigat&oacute;rio. Imagem no formato &quot;JPG&quot; e com um tamanho m&aacute;ximo de 100 kbytes)</font></td></tr>

	<tr><td><br></td><td></td></tr>		
	<tr><td></td><td>
		<input type="hidden" name="foto" value="<% =foto %>">
		<input type="hidden" name="primeira" value="<% =primeira %>">
		<input type="hidden" name="temaid" value="<% =temaid %>">
		<input type="hidden" name="tipo" value="<% =tipo %>">
		<input type="hidden" name="id" value="<% =id %>">
		<input type="hidden" name="num" value="<% =num %>">
		
		<input type="Submit" value="Mudar imagem"><br>
		<font size="-1" color="white" face="arial">
			(logo a seguir a premir este bot&atilde;o &eacute; normal que pare&ccedil;a que	nada acontece.<br>
			Tem que	esperar uns momentos enquanto a foto &eacute; enviada.<br>
			Quando o envio termina com sucesso o seu <i>browser</i> salta autom&aacute;ticamente para a antiga foto)
		</font>
	</td></tr>	
</table>

</form>

<% FimPagina() %>
