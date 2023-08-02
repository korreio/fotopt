<%
' Copyright: (c) 1999-2023, Tiago Fonseca
' GNU General Public License v3.0+ (see LICENSE.md or https://www.gnu.org/licenses/gpl-3.0.html)
' SPDX-License-Identifier: GPL-3.0-or-later
%>

<!-- #include file="funcoes_principais.asp" -->

<%
AutenticarMembro(autor)
Menu 7, 3, "INSERIR OU MUDAR OPINI�O"
%>

<%
ordem = request("ordem")
artigo = request("artigo")

SQL = "SELECT * FROM opiniao WHERE artigo = " & artigo & " AND autor = " & session("login")
Set opiniaoRes = dbConnection.Execute(SQL)

SQL = "SELECT marca, modelo, tipo FROM opiniao_artigo WHERE id = " & artigo
Set artigoRes = dbConnection.Execute(SQL)

tipo = artigoRes("tipo")

SQL = "SELECT * FROM opiniao_classificacao ORDER BY id DESC"
Set classRes = dbConnection.Execute(SQL)
%>

<form action="inserir_opiniao_res.asp?ordem=<% =ordem %>&artigo=<% =artigo %>" method=post>

<table border="0" cellpadding="3" cellspacing="0">
	<% if tipo = 33 then %>
		<tr><td><font size="-1" color="#FFCC66" face="arial"><b>LABORAT&Oacute;RIO: </b></font></td><td><font color="white" face="arial"><% =artigoRes("marca") %>&nbsp;(<% =artigoRes("modelo") %>)</font></td></tr>
	<% elseif tipo = 34 then %>
		<tr><td><font size="-1" color="#FFCC66" face="arial"><b>LOJA: </b></font></td><td><font color="white" face="arial"><% =artigoRes("marca") %>&nbsp;(<% =artigoRes("modelo") %>)</font></td></tr>
	<% elseif tipo = 35 then %>
		<tr><td><font size="-1" color="#FFCC66" face="arial"><b>WEBSITE: </b></font></td><td><font color="white" face="arial"><% =artigoRes("marca") %>&nbsp;(<% =artigoRes("modelo") %>)</font></td></tr>
	<% elseif tipo = 40 then %>
		<tr><td><font size="-1" color="#FFCC66" face="arial"><b>LIVRO: </b></font></td><td><font color="white" face="arial"><% =artigoRes("marca") %>&nbsp;(<% =artigoRes("modelo") %>)</font></td></tr>
	<% elseif tipo = 41 then %>
		<tr><td><font size="-1" color="#FFCC66" face="arial"><b>JORNAL: </b></font></td><td><font color="white" face="arial"><% =artigoRes("marca") %></font></td></tr>
	<% elseif tipo = 42 then %>
		<tr><td><font size="-1" color="#FFCC66" face="arial"><b>REVISTA: </b></font></td><td><font color="white" face="arial"><% =artigoRes("marca") %></font></td></tr>
	<% else %>	
		<tr><td><font size="-1" color="#FFCC66" face="arial"><b>ARTIGO: </b></font></td><td><font color="white" face="arial"><% =artigoRes("marca") %>&nbsp;<% =artigoRes("modelo") %></font></td></tr>
	<% end if %>

	<tr><td><br></td><td></td></tr>		

	<% if opiniaoRes.eof then %>
		<tr>
			<td><font size="-1" color="#FFCC66" face="arial"><b>CLASSIFICA&Ccedil;&Atilde;O: </b></font></td>
			<td><select name="class">
				<% do while not classRes.eof %>
					<option value="<% =classRes("id") %>"><% =classRes("nome") %></option>
					<% classRes.MoveNext %>
				<% loop %>
			</select> <font size="-1" color="white" face="arial">(obrig)</font></td>
		</tr>
		<tr><td><br></td><td></td></tr>		
		<tr><td><font size="-1" color="#FFCC66" face="arial"><b>PROS: </b></font><font size="-1" color="white" face="arial"><br>(se ultrapassar<br>estas 6 linhas<br>o texto ser&aacute;<br>cortado)</font></td><td><textarea name="pros" cols="38" rows="6" wrap="VIRTUAL"></textarea></td></tr>
		<tr><td><font size="-1" color="#FFCC66" face="arial"><b>CONTRAS: </b></font><font size="-1" color="white" face="arial"><br>(se ultrapassar<br>estas 6 linhas<br>o texto ser&aacute;<br>cortado)</font></td><td><textarea name="contras" cols="38" rows="6" wrap="VIRTUAL"></textarea></td></tr>
		<tr><td><br></td><td></td></tr>		
		<tr><td><font size="-1" color="#FFCC66" face="arial"><b>OPINI&Atilde;O: </b></font></td><td><textarea name="opiniao" cols="50" rows="6" wrap="VIRTUAL"></textarea> <font size="-1" color="white" face="arial">(obrig)</font></td></tr>
	<% else %>
		<tr>
			<td><font size="-1" color="#FFCC66" face="arial"><b>CLASSIFICA&Ccedil;&Atilde;O: </b></font></td>
			<td><select name="class">
				<% do while not classRes.eof %>
					<% if classRes("id") = opiniaoRes("classificacao") then %>
						<option selected value="<% =classRes("id") %>"><% =classRes("nome") %></option>
					<% else %>
						<option value="<% =classRes("id") %>"><% =classRes("nome") %></option>
					<% end if %>
					<% classRes.MoveNext %>
				<% loop %>
			</select> <font size="-1" color="white" face="arial">(obrig)</font></td>
		</tr>
		<tr><td><br></td><td></td></tr>		
		<tr><td><font size="-1" color="#FFCC66" face="arial"><b>PROS: </b></font><font size="-1" color="white" face="arial"><br>(se ultrapassar<br>estas 6 linhas<br>o texto ser&aacute;<br>cortado)</font></td><td><textarea name="pros" cols="38" rows="6" wrap="VIRTUAL"><% if opiniaoRes("pros") <> "-1" then %><% =opiniaoRes("pros") %><% end if %></textarea></td></tr>
		<tr><td><font size="-1" color="#FFCC66" face="arial"><b>CONTRAS: </b></font><font size="-1" color="white" face="arial"><br>(se ultrapassar<br>estas 6 linhas<br>o texto ser&aacute;<br>cortado)</font></td><td><textarea name="contras" cols="38" rows="6" wrap="VIRTUAL"><% if opiniaoRes("contras") <> "-1" then %><% =opiniaoRes("contras") %><% end if %></textarea></td></tr>
		<tr><td><br></td><td></td></tr>		
		<tr><td><font size="-1" color="#FFCC66" face="arial"><b>OPINI&Atilde;O: </b></font></td><td><textarea name="opiniao" cols="50" rows="6" wrap="VIRTUAL"><% =opiniaoRes("opiniao") %></textarea> <font size="-1" color="white" face="arial">(obrig)</font></td></tr>
	<% end if %>

	<tr><td></td><td><input type="Submit" value="Inserir ou mudar opini&atilde;o"></td></tr>
</table>

</form>

<% FimPagina() %>
