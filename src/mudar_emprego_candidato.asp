<%
' Copyright: (c) 1999-2023, Tiago Fonseca
' GNU General Public License v3.0+ (see LICENSE.md or https://www.gnu.org/licenses/gpl-3.0.html)
' SPDX-License-Identifier: GPL-3.0-or-later
%>

<!-- #include file="sqltext.asp" -->
<!-- #include file="funcoes_principais.asp" -->

<%
candidato = request("candidato")

SQL = "SELECT * FROM emprego_candidato WHERE id = " & candidato
Set candidatoRes = dbConnection.Execute(SQL)

autor = candidatoRes("autor")

SQL = "SELECT nome FROM autor WHERE id = " & autor
Set autorRes = dbConnection.Execute(SQL)
%>

<% 
AutenticarMembro(autor)
Menu 6, 3, "MUDAR OU APAGAR CANDIDATO A EMPREGO"
%>

<form action="mudar_emprego_candidato_res.asp?candidato=<% =candidato %>" method="post">

<table border="0" cellpadding="3" cellspacing="0">
	<tr><td><font size="-1" color="#FFCC66" face="arial"><b>CANDIDATO: </b></font></td><td><font color="white" face="arial"><% =autorRes("nome") %></font></td></tr>
	<tr><td><font size="-1" color="#FFCC66" face="arial"><b>CARGO<br>PRETENDIDO: </b></font></td><td><input maxlength="255" type="Text" size="40" value="<% =Aspas2Quot(candidatoRes("cargo")) %>" name="cargo"> <font size="-1" color="white" face="arial">(obrig)</font></td></tr>
	<tr><td><font size="-1" color="#FFCC66" face="arial"><b>ZONA DO PA&Iacute;S: </b></font></td><td><input maxlength="255" type="Text" value="<% =Aspas2Quot(candidatoRes("zona")) %>" size="40" name="zona"> <font size="-1" color="white" face="arial">(obrig)</font></td></tr>
	<tr><td><br></td><td></td></tr>
	<tr><td><font size="-1" color="#FFCC66" face="arial"><b>PRETENDE: </b></font><font size="-1" color="white" face="arial"><br>(se ultrapassar<br>estas 6 linhas<br>o texto ser&aacute;<br>cortado)</font></td><td><textarea name="pretende" cols="38" rows="6" wrap="VIRTUAL"><% =candidatoRes("pretende") %></textarea></td></tr>
	<tr><td><font size="-1" color="#FFCC66" face="arial"><b>HOR&Aacute;RIO/<br>DURA&Ccedil;&Atilde;O: </b></font></td><td><input maxlength="255" type="Text" size="40" value="<% =Aspas2Quot(candidatoRes("horario")) %>" name="horario"></td></tr>
	<tr><td><br></td><td></td></tr>
	<tr><td><font size="-1" color="#FFCC66" face="arial"><b>HABILITA&Ccedil;&Otilde;ES<br>LITER&Aacute;RIAS: </b></font><font size="-1" color="white" face="arial"><br>(se ultrapassar<br>estas 6 linhas<br>o texto ser&aacute;<br>cortado)</font></td><td><textarea name="habilitacoes" cols="38" rows="6" wrap="VIRTUAL"><% =candidatoRes("habilitacoes") %></textarea></td></tr>
	<tr><td><font size="-1" color="#FFCC66" face="arial"><b>FORMA&Ccedil;&Atilde;O<br>COMPLEMENTAR: </b></font><font size="-1" color="white" face="arial"><br>(se ultrapassar<br>estas 6 linhas<br>o texto ser&aacute;<br>cortado)</font></td><td><textarea name="complementar" cols="38" rows="6" wrap="VIRTUAL"><% =candidatoRes("complementar") %></textarea></td></tr>
	<tr><td><font size="-1" color="#FFCC66" face="arial"><b>CONHECIMENTOS<br>DIVERSOS: </b></font><font size="-1" color="white" face="arial"><br>(se ultrapassar<br>estas 6 linhas<br>o texto ser&aacute;<br>cortado)</font></td><td><textarea name="diversos" cols="38" rows="6" wrap="VIRTUAL"><% =candidatoRes("diversos") %></textarea></td></tr>
	<tr><td><font size="-1" color="#FFCC66" face="arial"><b>EXPERI&Ecirc;NCIA<br>PROFISSIONAL: </b></font><font size="-1" color="white" face="arial"><br>(se ultrapassar<br>estas 6 linhas<br>o texto ser&aacute;<br>cortado)</font></td><td><textarea name="experiencia" cols="38" rows="6" wrap="VIRTUAL"><% =candidatoRes("experiencia") %></textarea></td></tr>
	<tr><td><font size="-1" color="#FFCC66" face="arial"><b>OBSERVA&Ccedil;&Otilde;ES: </b></font><font size="-1" color="white" face="arial"><br>(se ultrapassar<br>estas 6 linhas<br>o texto ser&aacute;<br>cortado)</font></td><td><textarea name="observacoes" cols="38" rows="6" wrap="VIRTUAL"><% =candidatoRes("observacoes") %></textarea></td></tr>
	<tr><td><br></td><td></td></tr>	
	<tr><td><font size="-1" color="#FFCC66" face="arial"><b>CONTACTO: </b></font></td><td><input maxlength="255" type="Text" size="40" value="<% =Aspas2Quot(candidatoRes("contacto")) %>" name="contacto"> <font size="-1" color="white" face="arial">(obrig)</font></td></tr>

	<tr><td></td><td><input type="Submit" value="Mudar candidato"></td></tr>
</table>

</form>

<form method="post" action="apagar_emprego_candidato_res.asp?candidato=<% =candidato %>">
	<font color="#FFCC66" face="arial"><b>Para apagar este candidato confirme aqui <input type="Checkbox" name="apagar"> e prima o bot&atilde;o - </b></font><input type="Submit" value="Apagar">
</form>

<% FimPagina() %>
