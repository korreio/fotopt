<%
' Copyright: (c) 1999-2023, Tiago Fonseca
' GNU General Public License v3.0+ (see LICENSE.md or https://www.gnu.org/licenses/gpl-3.0.html)
' SPDX-License-Identifier: GPL-3.0-or-later
%>

<!-- #include file="../sqltext.asp" -->
<!-- #include file="inicio_basedados.asp" -->

<%
autor = request("autor")

SQL = "SELECT * FROM autor WHERE id = " & autor
Set autorRes = dbConnection.Execute(SQL)

SQL = "SELECT * FROM paises_todos WHERE id = " & autorRes("pais")
Set paisRes = dbConnection.Execute(SQL)

SQL = "SELECT count(*) AS numTemas FROM folder WHERE autor = " & autor
Set numTemasRes = dbConnection.Execute(SQL)
%>

<!-- #include file="topo.asp" -->
<td bgcolor="gray" width="100%" align="left"><font size="-1" color="black" face="arial">&nbsp;MEMBERS</font></td>
<% if numTemasRes("numTemas") = 0 then %>
	<td><font size="-2">&nbsp;</font><a href="galeria.asp?tipo=autor&id=<% =autorRes("id") %>&tema=-1"><font size="-2" color="black" face="arial">AUTHOR'S&nbsp;GALLERY</font></a><font size="-2">&nbsp;</font></td>
<% else %>
	<td><font size="-2">&nbsp;</font><a href="lista_temas.asp?autor=<% =autorRes("id") %>"><font size="-2" color="black" face="arial">AUTHOR'S&nbsp;GALLERY</font></a><font size="-2">&nbsp;</font></td>
<% end if %>
<!-- #include file="fim_topo.asp" -->

<table border="0" cellpadding="10" cellspacing="0" width="100%">
<tr>
	<td align="center" valign="middle" width="200" height="200">
		<% if autorRes("retrato") = true then %>
			<img src="/fotos/retratos/retrato<% =autorRes("id") %>.jpg" border=0 alt="Retrato">
		<% else %>			
			<img src="../Imagens/en_semfoto.jpg" width=200 height=200 border=0 alt="">
		<% end if %>
	</td>
	<td width="100%">
		<table border="0" cl>
			<% if lcase(autorRes("nome_real")) <> lcase(autorRes("nome")) then %>
				<tr><td><font size="-1" color="#FFCC66" face="arial"><b>ARTISTIC NAME: </b></font></td><td><font size="-1" color="white" face="arial"><% =autorRes("nome") %></font></td></tr>
				<% if autorRes("esconder_real") = False then %>
					<tr><td><font size="-1" color="#FFCC66" face="arial"><b>REAL NAME: </b></font></td><td><font size="-1" color="white" face="arial"><% =autorRes("nome_real") %></font></td></tr>
				<% end if %>
			<% else %>
				<tr><td><font size="-1" color="#FFCC66" face="arial"><b>NAME: </b></font></td><td><font size="-1" color="white" face="arial"><% =autorRes("nome_real") %></font></td></tr>
			<% end if %>

			<% if autorRes("mostrar_email") = True then %>
				<tr><td><font size="-1" color="#FFCC66" face="arial"><b>E-MAIL: </b></font></td><td><a href="mailto:<% =autorRes("email") %>"><font size="-1" color="white" face="arial"><% =autorRes("email") %></font></a></td></tr>
			<% end if %>
			<% if autorRes("home_page") <> "" then %>
				<tr><td><font size="-1" color="#FFCC66" face="arial"><b>HOMEPAGE: </b></font></td><td><a href="<% =autorRes("home_page") %>"><font size="-1" color="white" face="arial"><% =autorRes("home_page") %></font></a></td></tr>
			<% end if %>
			<tr><td><font size="-1" color="#FFCC66" face="arial"><b>COUNTRY: </b></font></td><td><font size="-1" color="white" face="arial"><% =paisRes("nome") %></font></td></tr>
			<% if autorRes("data_nascimento") <> "" then %>
				<tr>
					<td><font size="-1" color="#FFCC66" face="arial"><b>AGE: </b></font></td>
					<td>
						<font size="-1" color="white" face="arial"><% =int((date() - autorRes("data_nascimento")) / 365.25) %> years old</font>
						<% if autorRes("mostrar_data_nascimento") = true then %>
							&nbsp;<font size="-2" color="white" face="arial">(<% =day(autorRes("data_nascimento")) %>/<% =month(autorRes("data_nascimento")) %>/<% =year(autorRes("data_nascimento")) %>)</font>
						<% end if %>
					</td>
				</tr>
			<% end if %>
			<tr><td><font size="-1" color="#FFCC66" face="arial"><b>DATE OF<br>SUBSCRIPTION: </b></font></td><td><font size="-1" color="white" face="arial"><% =day(autorRes("data")) %>/<% =month(autorRes("data")) %>/<% =year(autorRes("data")) %></font></td></tr>
			<% if numTemasRes("numTemas") = 0 then %>
				<tr><td colspan="2"><br><a href="galeria.asp?tipo=autor&id=<% =autorRes("id") %>&tema=-1"><font size="-1" color="#FFCC66" face="arial"><b>SEE THIS AUTHOR'S GALLERY</b></font></a></td></tr>			
			<% else %>
				<tr><td colspan="2"><br><a href="lista_temas.asp?autor=<% =autorRes("id") %>"><font size="-1" color="#FFCC66" face="arial"><b>SEE THIS AUTHOR'S GALLERY</b></font></a></td></tr>			
			<% end if %>
			<% if autorRes("apresentacao") <> "" then %>
				<tr><td colspan="2" height="10"></td></tr>
				<tr><td colspan="2"><font size="-1" color="#FFCC66" face="arial"><b>INTRODUCTION: </b></font><br><font size="-1" color="white" face="arial"><% =Enter2Br(autorRes("apresentacao")) %></font></td></tr>
			<% end if %>
		</table>	
	</td>
	<% if request("directo") = "1" then %>
		<td valign="top" align="right">
			<!-- Begin Nedstat Basic code -->
			<script language='JavaScript' src="http://m1.nedstatbasic.net/basic.js"></script>
			<script language="JavaScript">
				<!--
				  nedstatbasic("AADfbQvA2tDac5XYXWC89/a1hl9A", 0);
				// -->
			</script>
			<noscript>
				<a target="_new" href="http://v1.nedstatbasic.net/stats?AADfbQvA2tDac5XYXWC89/a1hl9A"><img src="http://m1.nedstatbasic.net/n?id=AADfbQvA2tDac5XYXWC89/a1hl9A" border="0" nosave width="18" height="18"></a>
			</noscript>
			<!-- End Nedstat Basic code -->
		</td>
	<% end if %>
</tr>
</table>

<!-- #include file="fim.asp" -->
<!-- #include file="fim_basedados.asp" -->