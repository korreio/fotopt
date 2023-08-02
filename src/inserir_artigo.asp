<%
' Copyright: (c) 1999-2023, Tiago Fonseca
' GNU General Public License v3.0+ (see LICENSE.md or https://www.gnu.org/licenses/gpl-3.0.html)
' SPDX-License-Identifier: GPL-3.0-or-later
%>

<!-- #include file="funcoes_principais.asp" -->

<% 
AutenticarMembro(autor)
Menu 6, 2, "INSERIR ARTIGO PARA VENDA"
%>

<%
SQL = "SELECT nome FROM autor WHERE id = " & session("login")
Set autorRes = dbConnection.Execute(SQL)

SQL = "SELECT * FROM venda_estado"
Set estadoRes = dbConnection.Execute(SQL)

SQL = "SELECT * FROM venda_tipo"
Set tipoRes = dbConnection.Execute(SQL)

SQL = "SELECT * FROM venda_moeda"
Set moedaRes = dbConnection.Execute(SQL)
%>

<form action="inserir_artigo_res.asp" method="post">

<table border="0" cellpadding="3" cellspacing="0">
	<tr>
		<td><font size="-1" color="#FFCC66" face="arial"><b>ATEN&Ccedil;&Atilde;O: </b></font></td>
		<td><font color="white" face="arial">
			Para que esta sec&ccedil;&atilde;o n&atilde;o fique carregada de material que j&aacute; foi vendido, por favor n&atilde;o se 
			esque&ccedil;a de apagar este registo depois de concretizada a venda ou se perder interesse na mesma. Todos os artigos ser�o 
			removidos autom�ticamente ao fim de um m�s, podendo voltar a inseri-los quantas vezes for necess�rio.
		</font></td>
	</tr>
	<tr><td><font size="-1" color="#FFCC66" face="arial"><b>NOME<br>VENDEDOR: </b></font></td><td><font color="white" face="arial"><% =autorRes("nome") %></font></td></tr>
	<tr><td><br></td><td></td></tr>	
	<tr>
		<td><font size="-1" color="#FFCC66" face="arial"><b>CATEGORIA: </b></font></td>
		<td><select name="tipo">
			<% do while not tipoRes.eof %>
				<option value="<% =tipoRes("id") %>"><% =tipoRes("nome") %></option>
				<% tipoRes.MoveNext %>
			<% loop %>
		</select> <font size="-1" color="white" face="arial">(obrig)</font></td>
	</tr>
	<tr><td><font size="-1" color="#FFCC66" face="arial"><b>ARTIGO: </b></font></td><td><input maxlength="255" type="Text" size="40" name="nome"> <font size="-1" color="white" face="arial">(obrig)</font></td></tr>
	<tr><td><font size="-1" color="#FFCC66" face="arial"><b>DESCRI&Ccedil;&Atilde;O: </b></font><font size="-1" color="white" face="arial"><br>(se ultrapassar<br>estas 6 linhas<br>o texto ser&aacute;<br>cortado)</font></td><td><textarea name="descricao" cols="38" rows="6" wrap="VIRTUAL"></textarea></td></tr>
	<tr><td><br></td><td></td></tr>
	<tr>
		<td><font size="-1" color="#FFCC66" face="arial"><b>ESTADO: </b></font></td>
		<td><select name="estado">
			<% do while not estadoRes.eof %>
				<option value="<% =estadoRes("id") %>"><% =estadoRes("nome") %></option>
				<% estadoRes.MoveNext %>
			<% loop %>
		</select> <font size="-1" color="white" face="arial">(obrig)</font></td>
	</tr>
	<tr><td><font size="-1" color="#FFCC66" face="arial"><b>DESCRI&Ccedil;&Atilde;O<br>DETALHADA<br>DO ESTADO: </b></font><font size="-1" color="white" face="arial"><br>(se ultrapassar<br>estas 6 linhas<br>o texto ser&aacute;<br>cortado)</font></td><td><textarea name="desc_estado" cols="38" rows="6" wrap="VIRTUAL"></textarea></td></tr>
	<tr><td><br></td><td></td></tr>	
	<tr>
		<td><font size="-1" color="#FFCC66" face="arial"><b>VALOR M&Iacute;NIMO: </b></font></td>
		<td>
			<input maxlength="10" size="20" type="text" name="valor">
			<select name="moeda">
				<% do while not moedaRes.eof %>
					<option value="<% =moedaRes("id") %>"><% =moedaRes("nome") %></option>
					<% moedaRes.MoveNext %>
				<% loop %>
			</select>
		</td>
	</tr>

	<tr><td></td><td><input type="Submit" value="Inserir artigo"></td></tr>
</table>

</form>

<% FimPagina() %>
