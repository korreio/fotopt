<%
' Copyright: (c) 1999-2023, Tiago Fonseca
' GNU General Public License v3.0+ (see LICENSE.md or https://www.gnu.org/licenses/gpl-3.0.html)
' SPDX-License-Identifier: GPL-3.0-or-later
%>

<!-- #include file="sqltext.asp" -->
<!-- #include file="funcoes_principais.asp" -->

<%
inscricao = request("inscricao")
autor = request("autor")
if autor = "" then
	autor = request("membro")
end if
login = request("login")

SQL = "SELECT * FROM autor WHERE id = " & autor
Set autorRes = dbConnection.Execute(SQL)

SQL = "SELECT id, nome FROM autor WHERE ssuid = '" & autorRes("ssuid") & "' AND id <> " & autor
Set mesmoSSUIRes = dbConnection.Execute(SQL)

SQL = "SELECT count(*) AS num FROM preferido_autor WHERE autor_preferido = " & autor
Set preferidoRes = dbConnection.Execute(SQL)

SQL = "SELECT nome_pt FROM paises_todos WHERE id = " & autorRes("pais")
Set paisRes = dbConnection.Execute(SQL)

' Autor do mes?
SQL = "SELECT * FROM autor_mes WHERE autor = " & autor
Set autorMesRes = dbConnection.Execute(SQL)

' Mencao honrosa?
SQL = "SELECT * FROM autor_mencao_honrosa WHERE autor = " & autor
Set autorMencaoHonrosaRes = dbConnection.Execute(SQL)

Dim meses
meses = Array("JANEIRO", "FEVEREIRO", "MAR&Ccedil;O", "ABRIL", "MAIO", "JUNHO", "JULHO", _
			  "AGOSTO", "SETEMBRO", "OUTUBRO", "NOVEMBRO", "DEZEMBRO")
%>

<% 
OpcaoMenu "VER GALERIA DESTE AUTOR", "lista_temas.asp?autor=" & autorRes("id"), False, False, -1, False, False
OpcaoMenu "LER COMENT�RIOS AO AUTOR", "comentarios_autor.asp?primeira=&id=" & autor & "&tema=" & tema, False, False, -1, False, False
OpcaoMenu "FOTOS PREFERIDAS", "galeria.asp?tipo=preferidas&id=" & autorRes("id") & "&tema=0", False, False, -1, False, False
OpcaoMenu "AUTORES PREFERIDOS", "lista_autores_preferidos.asp?autor=" & autor, False, True, autor, False, False
OpcaoMenu "CONTRIBUI��O DO MEMBRO", "autor_pormenor.asp?autor=" & autor, False, False, -1, False, True
OpcaoMenu "LINK PARA ESTA FICHA", "link_aqui.asp?autor=" & autor, False, False, -1, False, False
OpcaoMenu "INSERIR, MUDAR OU APAGAR RETRATO", "inserir_retrato.asp?autor=" & autor, False, True, autor, False, False
if (session("login") <> 2) then
	OpcaoMenu "ALTERAR DADOS", "mudar_autor.asp?autor=" & autorRes("id"), False, True, autor, False, False
end if
if (session("login") <> 0) and (session("login") <> Clng(autor)) then
	SQL = "SELECT id FROM preferido_autor WHERE autor_preferido = " & autor & " AND autor = " & session("login")
	Set ePreferidoRes = dbConnection.Execute(SQL)
	
	if ePreferidoRes.eof then
		OpcaoMenu "INSERIR NOS MEUS PREFERIDOS", "inserir_preferidos_autor.asp?autor_preferido=" & autor, False, True, -1, False, False
	else
		OpcaoMenu "REMOVER DOS MEUS PREFERIDOS", "remover_preferidos_autor.asp?autor_preferido=" & autor, False, True, -1, False, False
	end if
end if
OpcaoMenu "RECUPERAR PASSWORD", "recuperar_password.asp?autor=" & autor, False, False, -1, False, True
OpcaoMenu "ALTERAR DADOS", "adm/adm_mudar_autor.asp?autor=" & autorRes("id"), False, False, -1, False, True
OpcaoMenu "MUDAR ESTADO OU APAGAR", "adm/adm_estado_autor.asp?autor=" & autorRes("id"), False, False, -1, False, True
OpcaoMenu "INSERIR MENSAGEM", "adm/inserir_mensagem.asp?autor=" & autorRes("id"), False, False, -1, False, True
OpcaoMenu "J�RI, CLASSIFICAR", "juri/juri_inserir_autor_mes.asp?autor=" & autor, False, False, -1, True, False
Menu 3, 2, autorRes("nome") 
%>

<table border="0" cellpadding="10" cellspacing="0" width="100%">
<tr>
	<td align="center" valign="top">
		<% if autorRes("retrato") = true then %>
			<% if (clng(autor) = session("login")) or (session("login") = 2) then %>
				<a href="inserir_retrato.asp?autor=<% =autorRes("id") %>"><img src="/fotos/retratos/retrato<% =autorRes("id") %>.jpg" border=0 alt="Retrato"></a>
			<% else %>
				<img src="/fotos/retratos/retrato<% =autorRes("id") %>.jpg" border=0 alt="Retrato">
			<% end if %>
		<% elseif (clng(autor) = session("login")) or (session("login") = 2) then %>
			<table border="1" height="200" width="200" cellpadding="0" cellspacing="0"><tr><td align="center" valign="middle">
				<br><br><br><br>
				<a href="inserir_retrato.asp?autor=<% =autorRes("id") %>"><font size="-1" color="white" face="arial">INSERIR<br>RETRATO<br>DO AUTOR</font></a>
				<br><br><br><br><br>				
			</td></tr></table>
		<% else %>			
			<img src="Imagens/semfoto.jpg" width=200 height=200 border=0 alt="">
		<% end if %>
	</td>
	<td valign="top" width="100%">
		<table border="0">
			<% if session("login") = 2 then %>
				<tr><td><font size="-1" color="red" face="arial"><b>ID: </b></font></td><td><font size="-1" color="white" face="arial"><% =autor %></font></td></tr>
				<tr><td><font size="-1" color="red" face="arial"><b>ESTADO: </b></font></td><td><font size="-1" color="white" face="arial">
					<% if autorRes("congelado") = True then %>
						CONGELADO
					<% elseif autorRes("confirmado") = False then %>
						POR CONFIRMAR
					<% else %>
						NORMAL
					<% end if %>
				</td></tr>
				<tr><td><font size="-1" color="red" face="arial"><b>�LTIMO&nbsp;LOGIN: </b></font></td><td><font size="-1" color="white" face="arial"><% =day(autorRes("ultima_data")) %>/<% =month(autorRes("ultima_data")) %>/<% =year(autorRes("ultima_data")) %>&nbsp;<% =hour(autorRes("ultima_data")) %>:<% =minute(autorRes("ultima_data")) %>:<% =second(autorRes("ultima_data")) %></font></td></tr>
				<% if not mesmoSSUIRes.eof then %>
					<tr>
						<td><font size="-1" color="red" face="arial"><b>MESMO&nbsp;SSUID: </b></font></td>
						<td><font size="-1" color="white" face="arial">
							<% do while not mesmoSSUIRes.eof %>
								<a href="autor.asp?autor=<% =mesmoSSUIRes("id") %>"><% =mesmoSSUIRes("nome") %></a>&nbsp;&nbsp;
								<% mesmoSSUIRes.MoveNext %>
							<% loop %>
						</font></td>
					</tr>
				<% end if %>
				<tr><td colspan="2" height="10"></td></tr>
				<% if autorRes("nome_inscricao") <> autorRes("nome_real") then %>
					<tr><td><font size="-1" color="red" face="arial"><b>NOME&nbsp;INSCRI&Ccedil;&Atilde;O: </b></font></td><td><font size="-1" color="white" face="arial"><% =autorRes("nome_inscricao") %></font></td></tr>
				<% end if %>
			<% end if %>
			<% if lcase(autorRes("nome_real")) <> lcase(autorRes("nome")) then %>
				<tr><td><font size="-1" color="#FFCC66" face="arial"><b>NOME&nbsp;ART&Iacute;STICO: </b></font></td><td><font size="-1" color="white" face="arial"><% =autorRes("nome") %></font></td></tr>
				<% if autorRes("esconder_real") = False then %>
					<tr><td><font size="-1" color="#FFCC66" face="arial"><b>NOME&nbsp;REAL: </b></font></td><td><font size="-1" color="white" face="arial"><% =autorRes("nome_real") %></font></td></tr>
				<% elseif session("login") = 2 then %>
					<tr><td><font size="-1" color="red" face="arial"><b>NOME&nbsp;REAL: </b></font></td><td><font size="-1" color="white" face="arial"><% =autorRes("nome_real") %></font></td></tr>
				<% end if %>
			<% else %>
				<tr><td><font size="-1" color="#FFCC66" face="arial"><b>NOME: </b></font></td><td><font size="-1" color="white" face="arial"><% =autorRes("nome_real") %></font></td></tr>
			<% end if %>

			<% if autorRes("mostrar_email") = True then %>
				<tr><td><font size="-1" color="#FFCC66" face="arial"><b>E-MAIL: </b></font></td><td><a href="mailto:<% =autorRes("email") %>"><font size="-1" color="white" face="arial"><% =autorRes("email") %></font></a></td></tr>
			<% elseif session("login") = 2 then %>
				<tr><td><font size="-1" color="red" face="arial"><b>E-MAIL: </b></font></td><td><a href="mailto:<% =autorRes("email") %>"><font size="-1" color="white" face="arial"><% =autorRes("email") %></font></a></td></tr>
			<% end if %>
			<% if autorRes("home_page") <> "" then %>
				<tr><td><font size="-1" color="#FFCC66" face="arial"><b>HOMEPAGE: </b></font></td><td><a target="_new" href="<% =autorRes("home_page") %>"><font size="-1" color="white" face="arial"><% =autorRes("home_page") %></font></a></td></tr>
			<% end if %>
			<tr><td><font size="-1" color="#FFCC66" face="arial"><b>PA&Iacute;S: </b></font></td><td><font size="-1" color="white" face="arial"><% =paisRes("nome_pt") %></font></td></tr>
			<% if (autorRes("regiao") <> "") and (autorRes("regiao") <> "") then %>
				<tr><td><font size="-1" color="#FFCC66" face="arial"><b>REGIAO: </b></font></td><td><font size="-1" color="white" face="arial"><% =autorRes("regiao") %></font></td></tr>
			<% end if %>
			<% if autorRes("profissao") <> "" then %>
				<tr><td><font size="-1" color="#FFCC66" face="arial"><b>PROFISS&Atilde;O: </b></font></td><td><font size="-1" color="white" face="arial"><% =autorRes("profissao") %></font></td></tr>
			<% end if %>
			<% if autorRes("data_nascimento") <> "" then %>
				<tr>
					<td><font size="-1" color="#FFCC66" face="arial"><b>IDADE: </b></font></td>
					<td>
						<font size="-1" color="white" face="arial"><% =int((date() - autorRes("data_nascimento")) / 365.25) %> anos</font>
						<% if autorRes("mostrar_data_nascimento") = true then %>
							&nbsp;<font size="-2" color="white" face="arial">(<% =day(autorRes("data_nascimento")) %>/<% =month(autorRes("data_nascimento")) %>/<% =year(autorRes("data_nascimento")) %>)</font>
						<% elseif session("login") = 2 then %>
							&nbsp;<font size="-2" color="red" face="arial">(<% =day(autorRes("data_nascimento")) %>/<% =month(autorRes("data_nascimento")) %>/<% =year(autorRes("data_nascimento")) %>)</font>
						<% end if %>
					</td>
				</tr>
			<% end if %>
			<tr><td><font size="-1" color="#FFCC66" face="arial"><b>INSCRI&Ccedil;&Atilde;O: </b></font></td><td width="100%"><font size="-1" color="white" face="arial"><% =day(autorRes("data")) %>/<% =month(autorRes("data")) %>/<% =year(autorRes("data")) %></font></td></tr>
			<% if (not autorMencaoHonrosaRes.eof) or (not autorMesRes.eof) or ((clng(autor) = session("login")) or (session("login") = 2) and (preferidoRes("num") > 0)) then %>
				<tr><td colspan="2" height="10"></td></tr>
			<% end if %>
			<% if not autorMencaoHonrosaRes.eof then %>
				<tr><td><font size="-1" color="#FFCC66" face="arial"><b>MEN&Ccedil;&Atilde;O&nbsp;HONROSA: </b></font></td><td><font size="-1" color="white" face="arial">atribu&iacute;da a <% =day(autorMencaoHonrosaRes("data")) %>/<% =month(autorMencaoHonrosaRes("data")) %>/<% =year(autorMencaoHonrosaRes("data")) %></font></td></tr>
			<% end if %>
			<% if not autorMesRes.eof then %>
				<tr><td><font size="-1" color="#FFCC66" face="arial"><b>AUTOR&nbsp;DO&nbsp;M&Ecirc;S: </b></font></td><td><font size="-1" color="white" face="arial">em <% =meses(autorMesRes("mes") - 1) %> de <% =autorMesRes("ano") %></font></td></tr>
			<% end if %>
			<% if (clng(autor) = session("login")) or (session("login") = 2) then %>
				<% if preferidoRes("num") > 0 then %>
					<tr><td><font size="-1" color="#FFCC66" face="arial"><b>PREFERIDO&nbsp;DE: </b></font></td><td><font size="-1" color="white" face="arial"><a href="ver_membros_preferem.asp?autor=<% =autor %>"><% =preferidoRes("num") %> membro<% if preferidoRes("num") > 1 then %>s<% end if %></a></font></td></tr>
				<% end if %>
			<% end if %>
			<% if autorRes("apresentacao") <> "" then %>
				<tr><td colspan="2" height="10"></td></tr>
				<tr><td colspan="2"><font size="-1" color="#FFCC66" face="arial"><b>APRESENTA&Ccedil;&Atilde;O: </b></font><br><font size="-1" color="white" face="arial"><% =Enter2Br(autorRes("apresentacao")) %></font></td></tr>
			<% end if %>
		</table>	
	</td>
</tr>
</table>

<% if inscricao = "1" then %>
	<table border="0" cellpadding="10" cellspacing="0">
	<tr><td colspan="2">
		<font size="-1" color="#FFCC66" face="arial">
		<b>Bem vindo! Se faz favor perca um minuto a ler as instru&ccedil;&otilde;es abaixo:</b><br><br>
		</font>
		<font size="-1" color="white" face="arial">
		Como membro inscrito do foto@pt passa a ter acesso a muitas op&ccedil;&otilde;es que at&eacute; agora
		lhe estavam vedadas. Sempre que fizer login, em cada sec&ccedil;&atilde;o aparecer&atilde;o novos <i>links</i>
		para realizar essas opera&ccedil;&otilde;es. &Eacute; o caso da op&ccedil;&atilde;o <b>ALTERAR DADOS</b> nesta mesma
		p&aacute;gina, ou a op&ccedil;&atilde;o <b>INSERIR FOTOS</b> na sec&ccedil;&atilde;o <b>GALERIAS</b>.<br><br>
		
		A op&ccedil;&atilde;o <b>INSERIR RETRATO</b>, nesta p&aacute;gina, destina-se a inserir uma foto de si mesmo para que passemos 
		a conhece-lo melhor. A se&ccedil;&atilde;o <b>DESTAQUES, NOVIDADES</b> d&aacute;-lhe uma lista com aquilo que foi modificado no
		site desde que fez login da &uacute;ltima vez (novas fotos, novos coment&aacute;rios a fotos, novos eventos, etc...)
		<br><br>

		Para descobrir tudo o que pode fazer agora sugiro que passeie pelo site novamente. Se tiver d&uacute;vidas consulte a
		sec&ccedil;&atilde;o <b>AJUDA</b> (disponivel em qualquer p&aacute;gina) ou contacte o <i>webmaster</i>. 
		Lembre-se que da pr&oacute;xima vez que	vier ao site ter&aacute; que fazer login na sec&ccedil;&atilde;o <b>MEMBROS</b>
		para ter acesso &agrave;s op&ccedil;&otilde;es
		extra.<br><br>

		Se quiser mudar qualquer dado seu ou recuperar logins/passwords esquecidas pode faze-lo nesta p&aacute;gina escolhendo as
		op&ccedil;&otilde;es acima. Para aqui chegar pode sempre faze-lo indo a sua <b>FICHA DE MEMBRO</b> atrav&eacute;s da sec&ccedil;&atilde;o
		<b>MEMBROS</b>.<br><br>
		
		Finalmente, lembre-se de responder &agrave; mensagem de confirma&ccedil;&atilde;o como membro que deve receber brevemente por
		e-mail.
		</font>
	</td></tr>
	</table>
<% end if %>
	
<% FimPagina() %>
