<%
' Copyright: (c) 1999-2023, Tiago Fonseca
' GNU General Public License v3.0+ (see LICENSE.md or https://www.gnu.org/licenses/gpl-3.0.html)
' SPDX-License-Identifier: GPL-3.0-or-later
%>

<!-- #include file="funcoes_principais.asp" -->

<%
evento = request("evento")
tipo = request("tipo")
id = request("id")

SQL = "SELECT * FROM evento WHERE id = " & evento
Set eventoRes = dbConnection.Execute(SQL)

SQL = "SELECT id, nome FROM autor WHERE id = " & eventoRes("autor")
Set autorRes = dbConnection.Execute(SQL)

SQL = "SELECT nome FROM evento_tipo WHERE id = " & eventoRes("tipo")
Set tipoRes = dbConnection.Execute(SQL)
%>

<% 
OpcaoMenu "INSERIR EVENTO", "inserir_evento.asp", False, True, -1, False, False
OpcaoMenu "MUDAR DADOS DESTE EVENTO OU APAG�-LO", "mudar_evento.asp?evento=" & evento, False, True, autorRes("id"), False, False
Menu 2, 4, "EVENTO - " & eventoRes("nome")
%>

<table border="1" cellpadding="5" cellspacing="0">
	<tr><td><font size="-1" color="#FFCC66" face="arial"><b>TIPO: </b></font></td><td><font size="-1" color="white" face="arial"><% =tipoRes("nome") %></font></td></tr>
	<% if (eventoRes("tipo") = 1) and (eventoRes("autores_fotos") <> "") then %>
		<tr><td><font size="-1" color="#FFCC66" face="arial"><b>FOTOGRAFIAS DE: </b></font></td><td><font size="-1" color="white" face="arial"><% =eventoRes("autores_fotos") %></font></td></tr>
	<% end if %>
	<tr><td height="5" colspan="2"><font size="-2" color="white" face="arial">&nbsp;</font></td></tr>		
	<% if eventoRes("lugar") <> "" then %>
		<tr><td><font size="-1" color="#FFCC66" face="arial"><b>LUGAR: </b></font></td><td><font size="-1" color="white" face="arial"><% =eventoRes("lugar") %></font></td></tr>
	<% end if %>
	<% 
	if eventoRes("distrito") > 0 then 
		SQL = "SELECT * FROM distritos WHERE id = " & eventoRes("distrito")
		Set distritoRes = dbConnection.Execute(SQL)
	%>
		<tr><td><font size="-1" color="#FFCC66" face="arial"><b>DISTRITO: </b></font></td><td><font size="-1" color="white" face="arial"><% =distritoRes("nome") %></font></td></tr>
	<% end if %>
	<% 
	if eventoRes("pais") > 0 then 
		SQL = "SELECT id, nome_pt FROM paises_todos WHERE id = " & eventoRes("pais")
		Set paisRes = dbConnection.Execute(SQL)
	%>
		<tr><td><font size="-1" color="#FFCC66" face="arial"><b>PA&Iacute;S: </b></font></td><td><font size="-1" color="white" face="arial"><% =paisRes("nome_pt") %></font></td></tr>
	<% end if %>
	<tr><td height="5" colspan="2"><font size="-2" color="white" face="arial">&nbsp;</font></td></tr>		
	<tr>
		<td>
			<font size="-1" color="#FFCC66" face="arial"><b>DATA IN&Iacute;CIO: </b></font>
		</td>
		<td>
			<font size="-1" color="white" face="arial"><% =day(eventoRes("data_inicio")) %>/<% =month(eventoRes("data_inicio")) %>/<% =year(eventoRes("data_inicio")) %></font>
		</td>
	</tr>
	<% if (eventoRes("data_fim") <> "") then %>
		<tr><td><font size="-1" color="#FFCC66" face="arial"><b>DATA FIM: </b></font></td><td><font size="-1" color="white" face="arial"><% =day(eventoRes("data_fim")) %>/<% =month(eventoRes("data_fim")) %>/<% =year(eventoRes("data_fim")) %></font></td></tr>
	<% end if %>
	<% if eventoRes("horario") <> "" then %>
		<tr><td><font size="-1" color="#FFCC66" face="arial"><b>HOR&Aacute;RIO: </b></font></td><td><font size="-1" color="white" face="arial"><% =eventoRes("horario") %></font></td></tr>
	<% end if %>
	<% if eventoRes("custo") <> "" then %>
		<tr><td><font size="-1" color="#FFCC66" face="arial"><b>CUSTO: </b></font></td><td><font size="-1" color="white" face="arial"><% =eventoRes("custo") %></font></td></tr>
	<% end if %>
	<% if eventoRes("descricao") <> "" then %>
		<tr><td height="5" colspan="2"><font size="-2" color="white" face="arial">&nbsp;</font></td></tr>	
		<tr><td><font size="-1" color="#FFCC66" face="arial"><b>DESCRI&Ccedil;&Atilde;O: </b></font></td><td><font size="-1" color="white" face="arial"><% =eventoRes("descricao") %></font></td></tr>
	<% end if %>
	<% if (eventoRes("organizacao") <> "") or (eventoRes("contacto") <> "") then %>
		<tr><td height="5" colspan="2"><font size="-2" color="white" face="arial">&nbsp;</font></td></tr>	
	<% end if %>
	<% if eventoRes("organizacao") <> "" then %>
		<tr><td><font size="-1" color="#FFCC66" face="arial"><b>ORGANIZA&Ccedil;&Atilde;O: </b></font></td><td><font size="-1" color="white" face="arial"><% =eventoRes("organizacao") %></font></td></tr>
	<% end if %>
	<% if eventoRes("contacto") <> "" then %>
		<tr><td><font size="-1" color="#FFCC66" face="arial"><b>CONTACTO: </b></font></td><td><font size="-1" color="white" face="arial"><% =eventoRes("contacto") %></font></td></tr>
	<% end if %>
	<% if eventoRes("observacoes") <> "" then %>
		<tr><td height="5" colspan="2"><font size="-2" color="white" face="arial">&nbsp;</font></td></tr>	
		<tr><td><font size="-1" color="#FFCC66" face="arial"><b>OBSERVA&Ccedil;&Otilde;ES: </b></font></td><td><font size="-1" color="white" face="arial"><% =eventoRes("observacoes") %></font></td></tr>
	<% end if %>
	<tr><td height="5" colspan="2"><font size="-2" color="white" face="arial">&nbsp;</font></td></tr>		
	<tr><td><font size="-1" color="#FFCC66" face="arial"><b>INSERIDO POR: </b></font></td><td><font size="-1" color="white" face="arial"><% =autorRes("nome") %> a <% =day(eventoRes("data")) %>/<% =month(eventoRes("data")) %>/<% =year(eventoRes("data")) %></font></td></tr>	
</table>

<% FimPagina() %>
