<%
' Copyright: (c) 1999-2023, Tiago Fonseca
' GNU General Public License v3.0+ (see LICENSE.md or https://www.gnu.org/licenses/gpl-3.0.html)
' SPDX-License-Identifier: GPL-3.0-or-later
%>

<% autor = request("autor") %>

<!-- #include file="../funcoes_principais.asp" -->
<!-- #include file="../textutil.asp" -->
<!-- #include file="topo.asp" -->
<td bgcolor="gray" width="100%" align="left"><font size="-1" color="black" face="arial">&nbsp;MUDAR DADOS DE AUTOR</font></td>
<!-- #include file="fim_topo.asp" -->
<!-- #include file="autenticar_webmaster.asp" -->
<!-- #include file="../sqltext.asp" -->

<%
nome_real = SqlText(request("nome_real"))

if request("nome") <> "" then
	erro = checknick(request("nome"))
	nome = SqlText(request("nome"))

	SQL = "SELECT id FROM autor WHERE nome_limpo = '" & LimparAcentos(nome) & "' AND id <> " & autor
	Set nickRes = dbConnection.Execute(SQL)
	if not nickRes.eof then
		erro = 7
	end if
end if

nome_inscricao = SqlText(request("nome_inscricao"))

login = SqlText(request("login"))
password1 = request("password1")
password2 = request("password2")
email = SqlText(request("email"))
homepage = SqlText(request("homepage"))
profissao = SqlText(request("profissao"))
pais = request("pais")
apresentacao = SqlTextMemo(left(request("apresentacao"), 920))
como_chegou_ca = SqlText(request("como_chegou_ca"))
regiao = SqlText(request("regiao"))
mostrar = request("mostrar")
juri = request("juri")
esconder_real = request("esconder_real")
tipo_novidades = request("tipo_novidades")
fotos_por_galeria = request("fotos_por_galeria")
ficha_foto = request("ficha_foto")
mostrar_data_nascimento = request("mostrar_data_nascimento")
sensiveis = request("sensiveis")
aprovacao = request("aprovacao")

if (request("dia") <> "") and (request("ano") <> "") and (request("mes") <> 0) then
	data_nascimento = request("mes") & "/" & request("dia") & "/" & request("ano")
else
	data_nascimento = "NULL"
end if

if homepage = "http://" then
	homepage = ""
end if

if login <> "" then
	SQL = "SELECT id FROM autor WHERE dadol = '" & login & "' AND id <> " & autor
	Set autorRes = dbConnection.Execute(SQL)
end if

if erro <> 0 then
%>
	<% if erro = 2 then %>
		<font size="+1" color="white" face="arial">O primeiro caractere do <b>nome no site</b> tem que ser uma letra.</font>
	<% elseif erro = 3 then %>
		<font size="+1" color="white" face="arial">O <b>nome no site</b> s&oacute; pode conter letras.</font>
	<% elseif erro = 4 then %>
		<font size="+1" color="white" face="arial">O &uacute;ltimo caractere do <b>nome no site</b> tem que ser uma letra ou um ponto.</font>
	<% elseif erro = 5 then %>
		<font size="+1" color="white" face="arial">O <b>nome no site</b> tem que ter no m&iacute;nimo 4 caracteres.</font>
	<% elseif erro = 6 then %>
		<font size="+1" color="white" face="arial">O <b>nome no site</b> tem 2 caracteres seguidos inv&aacute;lidos.</font>
	<% elseif erro = 7 then %>
		<font size="+1" color="white" face="arial">
			O <b>nome no site</b> que escolheu j&aacute; existe - para que os membros<br>
			n�o sejam confundidos s�o proibidas inscri��es com nomes iguais.
		</font>
	<% end if %>
	<br>
	<font size="+1" color="white" face="arial">Prima o botao <b>back</b> no browser e corrija a informa&ccedil;&atilde;o</font>	
<%
elseif (nome_real = "") or (nome = "") or (login = "") or (password1 = "") or (password2 = "") or (email = "") or (nome_inscricao = "") then
%>
	<font size="+1" color="white" face="arial">Os campos <b>nome completo</b>, <b>nome no site</b>, <b>nome inscri&ccedil;&atilde;o</b>, <b>login</b>, <b>password</b> e <b>e-mail</b> s&atilde;o obrigat&oacute;rios</font>
	<br>
	<font size="+1" color="white" face="arial">prima o botao <b>back</b> no browser e complete a informa&ccedil;&atilde;o</font>	
<%
elseif not autorRes.eof then
%>
	<font size="+1" color="white" face="arial">O login &quot;<% =login %>&quot; j&aacute; est&aacute; a ser utilizado</font>
	<br>
	<font size="+1" color="white" face="arial">prima o botao <b>back</b> no browser e escolha outro</font>	
<%
elseif password1 <> password2 then
%>
	<font size="+1" color="white" face="arial">Password confirmada incorrectamente, ambas t�m que ser iguais</font>
	<br>
	<font size="+1" color="white" face="arial">prima o botao <b>back</b> no browser e corrija</font>	
<%
elseif ((request("dia") <> "") or (request("ano") <> "") or (request("mes") <> 0)) and (not isdate(data_nascimento)) then
%>
	<font size="+1" color="white" face="arial">A data de nascimento n&atilde;o &eacute; v&aacute;lida</font>
	<br>
	<font size="+1" color="white" face="arial">prima o botao <b>back</b> no browser e corrija a informa&ccedil;&atilde;o</font>	
<%
else
	if (request("dia") <> "") and (request("ano") <> "") and (request("mes") <> 0) then
		data_nascimento = "'" & data_nascimento & "'"
	end if

	SQL = "SELECT data, ip_inscricao FROM autor WHERE id = " & autor
	Set autorRes = dbConnection.Execute(SQL)

	codedPassword = Cifrar(password1, autorRes("data"), autorRes("ip_inscricao"))

	SQL = "UPDATE autor SET "
	SQL = SQL & "nome = '" & nome & "',"
	SQL = SQL & "nome_real = '" & nome_real & "',"
	SQL = SQL & "nome_inscricao = '" & nome_inscricao & "',"
	SQL = SQL & "nome_limpo = '" & LimparAcentos(nome) & "',"
	SQL = SQL & "esconder_real = '" & esconder_real & "',"
	SQL = SQL & "dadol = '" & login & "',"
	SQL = SQL & "en_dadop = '" & codedPassword & "',"
	SQL = SQL & "email = '" & email & "',"
	SQL = SQL & "home_page = '" & homepage & "',"
	SQL = SQL & "profissao = '" & profissao & "',"
	SQL = SQL & "apresentacao = '" & apresentacao & "',"
	SQL = SQL & "como_chegou_ca = '" & como_chegou_ca & "',"
	SQL = SQL & "pais = '" & pais & "',"
	SQL = SQL & "regiao = '" & regiao & "',"
	SQL = SQL & "mostrar_email = '" & mostrar & "',"
	SQL = SQL & "juri = '" & juri & "',"
	SQL = SQL & "mostrar_data_nascimento = '" & mostrar_data_nascimento & "',"
	SQL = SQL & "data_nascimento = " & data_nascimento & " "
	SQL = SQL & "WHERE id = " & autor
	dbConnection.Execute(SQL)

	SQL = "UPDATE autor_opcoes SET "
	SQL = SQL & "tipo_novidades = '" & tipo_novidades & "',"
	SQL = SQL & "ficha_foto = '" & ficha_foto & "',"
	SQL = SQL & "aprovacao = '" & aprovacao & "',"
	SQL = SQL & "sensiveis = '" & sensiveis & "',"
	SQL = SQL & "fotos_por_galeria = '" & fotos_por_galeria & "' "
	SQL = SQL & "WHERE autor = " & autor
	dbConnection.Execute(SQL)
%>
	<font size="+1" color="white" face="arial"><b>Altera&ccedil;&atilde;o feita com sucesso</b></font>
	<meta http-equiv="refresh" content="0;url=../autor.asp?autor=<% =autor %>">
<% end if %>

<!-- #include file="fim_autenticacao.asp" -->
<!-- #include file="fim_basedados.asp" -->