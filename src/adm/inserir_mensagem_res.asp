<%
' Copyright: (c) 1999-2023, Tiago Fonseca
' GNU General Public License v3.0+ (see LICENSE.md or https://www.gnu.org/licenses/gpl-3.0.html)
' SPDX-License-Identifier: GPL-3.0-or-later
%>

<!-- #include file="topo.asp" -->
<td bgcolor="gray" width="100%" align="left"><font size="-1" color="black" face="arial">&nbsp;INSERIR MENSAGEM</font></td>
<!-- #include file="fim_topo.asp" -->
<!-- #include file="autenticar_webmaster.asp" -->
<!-- #include file="../sqltext.asp" -->
<!-- #include file="inicio_basedados.asp" -->

<%
Server.ScriptTimeOut = 999999
broadcast = request("broadcast") 
mensagem = SqlTextMemo(request("mensagem"))
autor = request("autor") 

if (mensagem = "") then
%>
	<font size="+1" color="white" face="arial">O campo <b>mensagem</b> &eacute; obrigat&oacute;rio</font>
	<br>
	<font size="+1" color="white" face="arial">prima o botao <b>back</b> no browser e complete a informa&ccedil;&atilde;o</font>	
<%
else
	if broadcast = "on" then
		SQL = "SELECT id FROM autor"
		Set autorRes = dbConnection.Execute(SQL)

		do while not autorRes.eof
			SQL = "INSERT INTO avisos_webmaster (autor, texto, data, lido) VALUES "
			SQL = SQL & "('" & autorRes("id") & "','" & mensagem & "','" & date() & " " & time() & "','" & 0 & "')"
			dbConnection.Execute(SQL)
			
			autorRes.MoveNext
		loop
	else
		SQL = "INSERT INTO avisos_webmaster (autor, texto, data, lido) VALUES "
		SQL = SQL & "('" & autor & "','" & mensagem & "','" & date() & " " & time() & "','" & 0 & "')"
		dbConnection.Execute(SQL)
	end if
%>
	<meta http-equiv="refresh" content="0;url=adm_avisos.asp">
	<font size="+1" color="white" face="arial"><b>Mensagem inserida com sucesso</b></font>
<% end if %>

<!-- #include file="fim_autenticacao.asp" -->
<!-- #include file="fim_basedados.asp" -->