<%
' Copyright: (c) 1999-2023, Tiago Fonseca
' GNU General Public License v3.0+ (see LICENSE.md or https://www.gnu.org/licenses/gpl-3.0.html)
' SPDX-License-Identifier: GPL-3.0-or-later
%>

<!-- #include file="topo.asp" -->
<td bgcolor="gray" width="100%" align="left"><font size="-1" color="black" face="arial">&nbsp;MUDAR ESTADO DE MEMBRO</font></td>
<!-- #include file="fim_topo.asp" -->
<!-- #include file="autenticar_webmaster.asp" -->
<!-- #include file="inicio_basedados.asp" -->

<%
Server.ScriptTimeOut = 999999

autor = request("autor")
apagar = request("apagar")
apagar2 = request("apagar2")
congelar = request("congelar")
lista_negra = request("lista_negra")
confirmar = request("confirmar")
enviado =  request("enviado")
enviar =  request("enviar")

SQL = "SELECT id, email, nome_real FROM autor WHERE id = " & autor
Set autorRes = dbConnection.Execute(SQL)

SQL = "SELECT id, email, nome, data FROM autor WHERE id <> " & autor & " AND email = '" & autorRes("email") & "'"
Set outroAutorRes = dbConnection.Execute(SQL)

if enviar = "on" then
	' Enviar email de confirmacao
	Set Mail = Server.CreateObject("Persits.MailSender")
	Mail.Host = "193.136.120.1"	
	Mail.From = "info@fotopt.net" 
    Mail.FromName = "foto@pt - Fotografia em Portugues"
	Mail.AddAddress autorRes("email"), autorRes("nome_real")
	Mail.Subject = "Confirmacao de inscricao no foto@pt (" & autor & ")"

	mensagem = "Bem vindo ao foto@pt, " & chr(13) & chr(10) & _
		chr(13) & chr(10) & _
		"Esta a receber esta mensagem porque o seu endereco foi dado" & chr(13) & chr(10) & _
		"para inscricao no site de fotografia foto@pt." & chr(13) & chr(10) & _
		chr(13) & chr(10) & _
		"Este e-mail e enviado automaticamente a todos os novos membros para" & chr(13) & chr(10) & _
		"confirmar a sua real existencia e para evitar a criacao de membros" & chr(13) & chr(10) & _
		"ficticios que poderiam geram problemas na administracao do site e de" & chr(13) & chr(10) & _
		"atribuicao de direitos de autor das fotos inseridas." & chr(13) & chr(10) & _
		chr(13) & chr(10)
		
	' Ha mais do que um membro com este email
	if not outroAutorRes.eof then
		mensagem = mensagem & "Existem mais membros que deram este endereco de email na inscricao:" & chr(13) & chr(10)
			
		do while not outroAutorRes.eof
			mensagem = mensagem & "    " & outroAutorRes("id") & " - """ & outroAutorRes("nome") & """, inscrito no dia " & day(outroAutorRes("data")) & "/" & month(outroAutorRes("data")) & "/" & year(outroAutorRes("data")) & chr(13) & chr(10) & _
			outroAutorRes.MoveNext
		loop

		mensagem = mensagem & chr(13) & chr(10) & _
			"Em principio tento evitar dois membros com o mesmo endereco de" & chr(13) & chr(10) & _
			"email, mas uma pequena justificacao para isso acontecer basta-me" & chr(13) & chr(10) & _
			"quase sempre para aceitar (mais do que dois e sempre proibido)." & chr(13) & chr(10) & _
			chr(13) & chr(10) & _
			"Se algum destes membros e repetido, diga-me qual devo apagar." & chr(13) & chr(10) & _
			"(Acontece as vezes membros que se esquecem da password inscreverem-se" & chr(13) & chr(10) & _
			"novamente)." & chr(13) & chr(10) & _
			chr(13) & chr(10)
	else
		mensagem = mensagem & _
			"Para confirmar a sua inscricao apenas tera' que fazer reply a esta" & chr(13) & chr(10) & _
			"mensagem (responder sem que seja necessario escrever o que quer" & chr(13) & chr(10) & _
			"que seja)." & chr(13) & chr(10) & _
			chr(13) & chr(10)
	end if
	
	mensagem = mensagem & _
		"AVISO: Se nao responder no prazo de uma semana, a sua inscricao" & chr(13) & chr(10) & _
		"sera congelada, nao sendo permitido fazer login. Se nao responder no" & chr(13) & chr(10) & _
		"prazo de duas semanas, a contar do dia de inscricao, todas as suas" & chr(13) & chr(10) & _
		"contribuicoes para o foto@pt serao removidas" & chr(13) & chr(10) & _
		chr(13) & chr(10) & _
		"Qualquer duvida, problema ou contribuicao que tenha nao hesite em" & chr(13) & chr(10) & _
		"contactar-me, podendo aproveitar a resposta a este e-mail para faze-lo." & chr(13) & chr(10) & _
		chr(13) & chr(10) & _
		"Muito obrigado pela sua compreensao," & chr(13) & chr(10) & _
		chr(13) & chr(10) & _
		"Webmaster do foto@pt - Fotografia em Portugues" & chr(13) & chr(10) & _
		"http://www.fotopt.net"
		
    Mail.Body = mensagem
	
	On Error Resume Next
    Mail.Send 
	
	' Se nao houve erro	no envio do mail
    If Err = 0 Then 
		SQL = "UPDATE autor SET email_enviado = '1' WHERE id = " & autor
		dbConnection.Execute(SQL)
	else
	
	Set Mail = Nothing
%>
		<font size="+1" color="#FFCC66" face="arial"><b>Erro no envio do mail: <% =Err.Description %> </b></font><br><br>
<%
    End If
end if

if enviado = "on" then
	SQL = "UPDATE autor SET email_enviado = '1' WHERE id = " & autor
	dbConnection.Execute(SQL)
end if

if lista_negra = "on" then
	SQL = "SELECT * FROM lista_negra WHERE autor = " & autor
	Set listaRes = dbConnection.Execute(SQL)
	
	if listaRes.eof then
		SQL = "INSERT INTO lista_negra (autor, chamadas_atencao, ultima_data) VALUES ('" & autor & "','" & 1 & "','" & date() & " " & time() & "')"
		dbConnection.Execute(SQL)
	else
		SQL = "UPDATE lista_negra SET chamadas_atencao = '" & listaRes("chamadas_atencao") + 1 & "', ultima_data = '" & date() & " " & time() & "' WHERE autor = " & autor
		dbConnection.Execute(SQL)
	end if
end if

if congelar = "on" then
	SQL = "UPDATE autor SET congelado = '1' WHERE id = " & autor
	dbConnection.Execute(SQL)
else
	SQL = "UPDATE autor SET congelado = '0' WHERE id = " & autor
	dbConnection.Execute(SQL)
end if

if confirmar = "on" then
	SQL = "UPDATE autor SET confirmado = '1' WHERE id = " & autor
	dbConnection.Execute(SQL)
end if

if (apagar = "on") and (apagar2 = "on") then
%>
	<!-- #include file="adm_apagar_autor.asp" -->
<%
end if
%>

<font size="+1" color="white" face="arial"><b>Autor mudado com sucesso</b></font>
<meta http-equiv="refresh" content="0;url=../autor.asp?autor=<% =autor %>">

<!-- #include file="fim_autenticacao.asp" -->
<!-- #include file="fim_basedados.asp" -->

<% 
sub ApagaSubMensagens(id, assunto) 
	SQL = "SELECT id, assunto FROM debate_mensagem WHERE subid = " & id & " AND autor <> " & autor
	Set subRes = dbConnection.Execute(SQL)

	do while not subRes.eof
		ApagaSubMensagens subRes("id"), subRes("assunto")
		subRes.MoveNext
	loop

	SQL = "DELETE FROM debate_mensagem WHERE id = " & id
	dbConnection.Execute(SQL)
end sub
%>