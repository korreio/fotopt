<%
' Copyright: (c) 1999-2023, Tiago Fonseca
' GNU General Public License v3.0+ (see LICENSE.md or https://www.gnu.org/licenses/gpl-3.0.html)
' SPDX-License-Identifier: GPL-3.0-or-later
%>

<!-- #include file="sqltext.asp" -->
<!-- #include file="funcoes_principais.asp" -->

<%
artigo = request("artigo")

SQL = "SELECT * FROM venda_artigo WHERE id = " & artigo
Set artigoRes = dbConnection.Execute(SQL)

autor = artigoRes("autor")
%>

<% 
AutenticarMembro(autor)
Menu 6, 2, "MUDAR OU APAGAR ARTIGO PARA VENDA"
%>

<%
SQL = "SELECT nome FROM autor WHERE id = " & autor
Set autorRes = dbConnection.Execute(SQL)

SQL = "SELECT * FROM venda_estado"
Set estadoRes = dbConnection.Execute(SQL)

SQL = "SELECT * FROM venda_tipo"
Set tipoRes = dbConnection.Execute(SQL)

SQL = "SELECT * FROM venda_moeda"
Set moedaRes = dbConnection.Execute(SQL)
%>

<form action="mudar_artigo_res.asp?artigo=<% =artigo %>" method="post">

<table border="0" cellpadding="3" cellspacing="0">
	<tr><td><font size="-1" color="#FFCC66" face="arial"><b>NOME<br>VENDEDOR: </b></font></td><td><font color="white" face="arial"><% =autorRes("nome") %></font></td></tr>
	<tr><td><br></td><td></td></tr>	
	<tr>
		<td><font size="-1" color="#FFCC66" face="arial"><b>CATEGORIA: </b></font></td>
		<td><select name="tipo">
			<% do while not tipoRes.eof %>
				<% if artigoRes("tipo") = tipoRes("id") then %>
					<option selected value="<% =tipoRes("id") %>"><% =tipoRes("nome") %></option>
				<% else %>
					<option value="<% =tipoRes("id") %>"><% =tipoRes("nome") %></option>
				<% end if %>
				<% tipoRes.MoveNext %>
			<% loop %>
		</select> <font size="-1" color="white" face="arial">(obrig)</font></td>
	</tr>
	<tr><td><font size="-1" color="#FFCC66" face="arial"><b>ARTIGO: </b></font></td><td><input maxlength="255" value="<% =Aspas2Quot(artigoRes("nome")) %>" type="Text" size="40" name="nome"> <font size="-1" color="white" face="arial">(obrig)</font></td></tr>
	<tr><td><font size="-1" color="#FFCC66" face="arial"><b>DESCRI&Ccedil;&Atilde;O: </b></font><font size="-1" color="white" face="arial"><br>(se ultrapassar<br>estas 6 linhas<br>o texto ser&aacute;<br>cortado)</font></td><td><textarea name="descricao" cols="38" rows="6" wrap="VIRTUAL"><% =artigoRes("descricao") %></textarea></td></tr>
	<tr><td><br></td><td></td></tr>
	<tr>
		<td><font size="-1" color="#FFCC66" face="arial"><b>ESTADO: </b></font></td>
		<td><select name="estado">
			<% do while not estadoRes.eof %>
				<% if artigoRes("estado") = estadoRes("id") then %>
					<option selected value="<% =estadoRes("id") %>"><% =estadoRes("nome") %></option>
				<% else %>
					<option value="<% =estadoRes("id") %>"><% =estadoRes("nome") %></option>
				<% end if %>
				<% estadoRes.MoveNext %>
			<% loop %>
		</select> <font size="-1" color="white" face="arial">(obrig)</font></td>
	</tr>
	<tr><td><font size="-1" color="#FFCC66" face="arial"><b>DESCRI&Ccedil;&Atilde;O<br>DETALHADA<br>DO ESTADO: </b></font><font size="-1" color="white" face="arial"><br>(se ultrapassar<br>estas 6 linhas<br>o texto ser&aacute;<br>cortado)</font></td><td><textarea name="desc_estado" cols="38" rows="6" wrap="VIRTUAL"><% =artigoRes("desc_estado") %></textarea></td></tr>
	<tr><td><br></td><td></td></tr>	
	<tr>
		<td><font size="-1" color="#FFCC66" face="arial"><b>VALOR M&Iacute;NIMO: </b></font></td>
		<td>
			<% if artigoRes("valor_minimo") <> -1 then %>
				<input maxlength="10" value="<% =artigoRes("valor_minimo") %>" size="20" type="text" name="valor">
			<% else %>
				<input maxlength="10" size="20" type="text" name="valor">
			<% end if %>
			<select name="moeda">
				<% do while not moedaRes.eof %>
					<% if artigoRes("moeda") = moedaRes("id") then %>
						<option selected value="<% =moedaRes("id") %>"><% =moedaRes("nome") %></option>
					<% else %>
						<option value="<% =moedaRes("id") %>"><% =moedaRes("nome") %></option>
					<% end if %>
					<% moedaRes.MoveNext %>
				<% loop %>
			</select>
		</td>
	</tr>
	
	<tr><td></td><td><input type="Submit" value="Mudar artigo"></td></tr>
</table>

</form>

<form method="post" action="apagar_artigo_res.asp?artigo=<% =artigo %>">
	<font color="#FFCC66" face="arial"><b>Para apagar este artigo confirme aqui <input type="Checkbox" name="apagar"> e prima o bot&atilde;o - </b></font><input type="Submit" value="Apagar">
</form>

<% FimPagina() %>
