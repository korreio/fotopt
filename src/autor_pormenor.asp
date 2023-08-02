<%
' Copyright: (c) 1999-2023, Tiago Fonseca
' GNU General Public License v3.0+ (see LICENSE.md or https://www.gnu.org/licenses/gpl-3.0.html)
' SPDX-License-Identifier: GPL-3.0-or-later
%>

<!-- #include file="funcoes_principais.asp" -->

<%
Server.ScriptTimeOut = 999999
autor = request("autor")

SQL = "SELECT * FROM autor WHERE id = " & autor
Set autorRes = dbConnection.Execute(SQL)

if (session("login") = 2) or (session("login") = clng(autor)) then
	SQL = "SELECT count(*) AS num FROM foto WHERE moderar = False AND autor = " & autor
	Set numFotosRes = dbConnection.Execute(SQL)
else
	SQL = "SELECT count(*) AS num FROM foto WHERE moderar = False AND autor = " & autor & " AND (anonima <> 2 OR (anonima = 2 AND data < #" & cdate(date() & " " & time()) - 7 & "#))"
	Set numFotosRes = dbConnection.Execute(SQL)
end if

SQL = "SELECT count(*) AS num FROM comentario WHERE moderar = False AND autor = " & autor
Set numComentFotosRes = dbConnection.Execute(SQL)

SQL = "SELECT count(*) AS num FROM eventos_fotopt_comentarios WHERE autor = " & autor
Set numComentEventosRes = dbConnection.Execute(SQL)

SQL = "SELECT count(*) AS num FROM comentario_autor WHERE moderar = False AND comentador = " & autor
Set numComentAutorRes = dbConnection.Execute(SQL)

SQL = "SELECT count(*) AS num FROM evento WHERE autor = " & autor
Set numEventosRes = dbConnection.Execute(SQL)

SQL = "SELECT count(*) AS num FROM venda_artigo WHERE autor = " & autor
Set numArtigosVendaRes = dbConnection.Execute(SQL)

SQL = "SELECT count(*) AS num FROM procura_artigo WHERE autor = " & autor
Set numArtigosProcuradosRes = dbConnection.Execute(SQL)

SQL = "SELECT count(*) AS num FROM emprego_candidato WHERE autor = " & autor
Set numCandidatosEmpregoRes = dbConnection.Execute(SQL)

SQL = "SELECT count(*) AS num FROM emprego_oportunidade WHERE autor = " & autor
Set numOportunidadesEmpregoRes = dbConnection.Execute(SQL)

SQL = "SELECT count(*) AS num FROM votacao_topico WHERE mostrar <> 0 AND autor = " & autor
Set numVotacoesRes = dbConnection.Execute(SQL)

SQL = "SELECT count(*) AS num FROM debate_mensagem WHERE mostrar <> 0 AND autor = " & autor
Set numMensagensRes = dbConnection.Execute(SQL)

SQL = "SELECT count(*) AS num FROM links WHERE autor = " & autor
Set numLinksRes = dbConnection.Execute(SQL)

SQL = "SELECT count(*) AS num FROM livros WHERE autor = " & autor
Set numLivrosRes = dbConnection.Execute(SQL)

SQL = "SELECT count(*) AS num FROM opiniao WHERE autor = " & autor
Set numOpinioesRes = dbConnection.Execute(SQL)

SQL = "SELECT count(*) AS num FROM eventos_fotopt_foto WHERE moderar = False AND autor = " & autor
Set fotosEventosRes = dbConnection.Execute(SQL)

SQL = "SELECT count(*) AS num FROM contactos WHERE autor = " & autor
Set numContactosRes = dbConnection.Execute(SQL)

SQL = "SELECT count(*) AS num FROM cronicas WHERE autor = " & autor
Set numCronicasRes = dbConnection.Execute(SQL)
%>

<% 
Menu 3, 2, "CONTRIBUI��O - " & autorRes("nome")
%>

<table cellpadding="10" cellspacing="0" border="1">
<% if numFotosRes("num") > 0 then %>
<tr><td>
	<font color="white" face="arial"><% =numFotosRes("num") %> <b>FOTO<% if numFotosRes("num") <> 1 then %>S<% end if %></b></font><br>
	&nbsp;&nbsp;<a href="lista_temas.asp?autor=<% =autor %>"><font size="-1" color="#FFCC66" face="arial">Ver galeria correspondente</font></a>
</td></tr>
<% end if %>


<%
if fotosEventosRes("num") > 0 then 
	novidades = novidades + 1
	SQL = "SELECT distinct(evento_fotopt) AS evento FROM eventos_fotopt_foto WHERE moderar = False AND autor = " & autor & " ORDER BY evento_fotopt"
	Set eventosRes = dbConnection.Execute(SQL)
%>
<tr><td>
	<font color="white" face="arial"><% =fotosEventosRes("num") %> <b> FOTO<% if fotosEventosRes("num") <> 1 then %>S<% end if %> NAS GALERIAS DE EVENTOS DO FOTO@PT</b></font><br>
	<table border="0" cellspacing="7" cellpadding="0">
	<% 
	i = 0
	do while not eventosRes.eof 
		SQL = "SELECT nome FROM eventos_fotopt WHERE id = " & eventosRes("evento")
		Set eventoRes = dbConnection.Execute(SQL)
	%>
		<% if (i MOD 2) = 0 then %><tr><% end if %>
		<td><a href="galeria_evento.asp?evento=<% =eventosRes("evento") %>"><font size="-2" color="#FFCC66" face="verdana, arial"><b><% =eventoRes("nome") %></b></font></a></td>
		<% if ((i + 1) MOD 2) = 0 then %></tr><% end if %>
	<%
		i = i + 1
		eventosRes.MoveNext
	Loop 
	%>
	</table>
</td></tr>
<% end if %>

<% if (numComentFotosRes("num") > 0) or (numComentEventosRes("num") > 0) then %>
<tr><td>
	<% if numComentFotosRes("num") > 0 then %>
		<font color="white" face="arial"><% =numComentFotosRes("num") %> <b> COMENT&Aacute;RIO<% if numComentFotosRes("num") <> 1 then %>S<% end if %> A FOTOS</b></font><br>
	<% end if %>
	<% if numComentEventosRes("num") > 0 then %>
		<font color="white" face="arial"><% =numComentEventosRes("num") %> <b> COMENT&Aacute;RIO<% if numComentEventosRes("num") <> 1 then %>S<% end if %> A FOTOS DE EVENTOS FOTO@PT</b></font><br>
	<% end if %>
	&nbsp;&nbsp;<a href="autor_pormenor_comentarios.asp?autor=<% =autor %>"><font size="-1" color="#FFCC66" face="arial">Ver todos os coment&aacute;rios deste autor</font></a>
</td></tr>
<% end if %>

<%
if numComentAutorRes("num") > 0 then 
	SQL = "SELECT distinct(autor) AS autores FROM comentario_autor WHERE moderar = False AND comentador = " & autor & " ORDER BY autor"
	Set autoresRes = dbConnection.Execute(SQL)
%>
<tr><td>
	<font color="white" face="arial"><% =numComentAutorRes("num") %> <b> COMENT&Aacute;RIO<% if numComentAutorRes("num") <> 1 then %>S<% end if %> A AUTORES</b></font><br>
	<table border="0" cellspacing="7" cellpadding="0">
	<% 
	i = 0
	do while not autoresRes.eof 
		SQL = "SELECT nome FROM autor WHERE id = " & autoresRes("autores")
		Set autorRes = dbConnection.Execute(SQL)
	%>
		<% if (i MOD 3) = 0 then %><tr><% end if %>
		<td><a href="comentarios_autor.asp?id=<% =autoresRes("autores") %>"><font size="-1" color="#FFCC66" face="arial"><% =autorRes("nome") %></font></a></td>
		<% if ((i + 1) MOD 3) = 0 then %></tr><% end if %>
	<%
		i = i + 1
		autoresRes.MoveNext
	Loop 
	%>
	</table>
</td></tr>
<% end if %>

<%
if numCronicasRes("num") > 0 then 
	SQL = "SELECT id, nome FROM autor WHERE id = " & autor
	Set autorRes = dbConnection.Execute(SQL)
%>
<tr><td>
	<font color="white" face="arial"><% =numCronicasRes("num") %> <b>CR&Oacute;NICA<% if numCronicasRes("num") <> 1 then %>S<% end if %></b></font><br>
	<table border="0" cellspacing="2" cellpadding="0">
	<% 
	do while not autorRes.eof 
		SQL = "SELECT id, foto FROM cronicas WHERE autor = " & autorRes("id")
		Set cronicaRes = dbConnection.Execute(SQL)
	%>
		<tr>
			<td valign="top"><font size="-1" color="#FFCC66" face="arial">&nbsp;&nbsp;<% =autorRes("nome") %>&nbsp;&nbsp;</font></td>
			<td><font size="-2" color="white" face="arial">
			<% do while not cronicaRes.eof %>
				<a href="cronica.asp?foto=<% =cronicaRes("foto") %>"><% =cronicaRes("foto") %></a>&nbsp;
				<% cronicaRes.MoveNext %>
			<% loop %>
			</font></td>
		</tr>
	<%
		autorRes.MoveNext
	Loop 
	%>
	</table>
</td></tr>
<% end if %>

<%
if numEventosRes("num") > 0 then 
	SQL = "SELECT id, nome FROM evento WHERE autor = " & autor & " ORDER BY nome"
	Set eventoRes = dbConnection.Execute(SQL)
%>
<tr><td>
	<font color="white" face="arial"><% =numEventosRes("num") %> <b>EVENTO<% if numEventosRes("num") <> 1 then %>S<% end if %></b></font><br>
	<table border="0" cellspacing="7" cellpadding="0">
	<% 
	i = 0
	do while not eventoRes.eof 
	%>
		<% if (i MOD 2) = 0 then %><tr><% end if %>
		<td><a href="ver_evento.asp?evento=<% =eventoRes("id") %>"><font size="-1" color="#FFCC66" face="arial"><% =eventoRes("nome") %></font></a></td>
		<% if ((i + 1) MOD 2) = 0 then %></tr><% end if %>
	<%
		i = i + 1
		eventoRes.MoveNext
	Loop 
	%>
	</table>
</td></tr>
<% end if %>

<%
if numArtigosVendaRes("num") > 0 then 
	SQL = "SELECT id, nome FROM venda_artigo WHERE autor = " & autor & " ORDER BY nome"
	Set artigoRes = dbConnection.Execute(SQL)
%>
<tr><td>
	<font color="white" face="arial"><% =numArtigosVendaRes("num") %> <b>ARTIGO<% if numArtigosVendaRes("num") <> 1 then %>S<% end if %> PARA VENDA</b></font><br>
	<table border="0" cellspacing="7" cellpadding="0">
	<% 
	i = 0
	do while not artigoRes.eof 
	%>
		<% if (i MOD 2) = 0 then %><tr><% end if %>
		<td><a href="venda_artigo.asp?artigo=<% =artigoRes("id") %>"><font size="-1" color="#FFCC66" face="arial"><% =artigoRes("nome") %></font></a></td>
		<% if ((i + 1) MOD 2) = 0 then %></tr><% end if %>
	<%
		i = i + 1
		artigoRes.MoveNext
	Loop 
	%>
	</table>
</td></tr>
<% end if %>

<%
if numArtigosProcuradosRes("num") > 0 then 
	SQL = "SELECT id, nome FROM procura_artigo WHERE autor = " & autor & " ORDER BY nome"
	Set artigoRes = dbConnection.Execute(SQL)
%>
<tr><td>
	<font color="white" face="arial"><% =numArtigosProcuradosRes("num") %> <b>ARTIGO<% if numArtigosProcuradosRes("num") <> 1 then %>S<% end if %> PROCURADO<% if numArtigosProcuradosRes("num") <> 1 then %>S<% end if %></b></font><br>
	<table border="0" cellspacing="7" cellpadding="0">
	<% 
	i = 0
	do while not artigoRes.eof 
	%>
		<% if (i MOD 2) = 0 then %><tr><% end if %>
		<td><a href="procura_artigo.asp?artigo=<% =artigoRes("id") %>"><font size="-1" color="#FFCC66" face="arial"><% =artigoRes("nome") %></font></a></td>
		<% if ((i + 1) MOD 2) = 0 then %></tr><% end if %>
	<%
		i = i + 1
		artigoRes.MoveNext
	Loop 
	%>
	</table>
</td></tr>
<% end if %>

<%
if numVotacoesRes("num") > 0 then 
	SQL = "SELECT id, nome FROM votacao_topico WHERE mostrar <> 0 AND autor = " & autor & " ORDER BY nome"
	Set votacaoRes = dbConnection.Execute(SQL)
%>
<tr><td>
	<font color="white" face="arial"><% =numVotacoesRes("num") %> <b>VOTA&Ccedil;<% if numVotacoesRes("num") <> 1 then %>&Otilde;ES<% else %>&Atilde;O<% end if %></b></font><br>
	<table border="0" cellspacing="7" cellpadding="0">
	<% 
	i = 0
	do while not votacaoRes.eof 
	%>
		<% if (i MOD 2) = 0 then %><tr><% end if %>
		<td><a href="votacao_items.asp?votacao=<% =votacaoRes("id") %>"><font size="-1" color="#FFCC66" face="arial"><% =votacaoRes("nome") %></font></a></td>
		<% if ((i + 1) MOD 2) = 0 then %></tr><% end if %>
	<%
		i = i + 1
		votacaoRes.MoveNext
	Loop 
	%>
	</table>
</td></tr>
<% end if %>

<%
if numMensagensRes("num") > 0 then 
	SQL = "SELECT id, nome, raiz FROM debate_mensagem WHERE mostrar <> 0 AND autor = " & autor & " ORDER BY raiz"
	Set mensagemRes = dbConnection.Execute(SQL)
%>
<tr><td>
	<font color="white" face="arial"><% =numMensagensRes("num") %> <b> MENSAGE<% if numMensagensRes("num") <> 1 then %>NS<% else %>M<% end if %> DE DEBATE<% if numMensagensRes("num") <> 1 then %>S<% end if %></b></font><br>
	<table border="0" cellspacing="7" cellpadding="0">
	<% 
	i = 0
	do while not mensagemRes.eof 
		if mensagemRes("raiz") = 0 then
			raiz = mensagemRes("id")
		else
			raiz = mensagemRes("raiz")
		end if
	%>
		<% if (i MOD 2) = 0 then %><tr><% end if %>
		<td><a href="ler_mensagem.asp?mensagem=<% =mensagemRes("id") %>&raiz=<% =raiz %>"><font size="-1" color="#FFCC66" face="arial"><% =mensagemRes("nome") %></font></a></td>
		<% if ((i + 1) MOD 2) = 0 then %></tr><% end if %>
	<%
		i = i + 1
		mensagemRes.MoveNext
	Loop 
	%>
	</table>
</td></tr>
<% end if %>

<%
if numContactosRes("num") > 0 then 
	SQL = "SELECT id, nome FROM contactos WHERE autor = " & autor & " ORDER BY nome"
	Set contactoRes = dbConnection.Execute(SQL)
%>
<tr><td>
	<font color="white" face="arial"><% =numContactosRes("num") %> <b>CONTACTO<% if numContactosRes("num") <> 1 then %>S<% end if %> DE EMPRESA<% if numContactosRes("num") <> 1 then %>S<% end if %></b></font><br>
	<table border="0" cellspacing="7" cellpadding="0">
	<% 
	i = 0
	do while not contactoRes.eof 
	%>
		<% if (i MOD 3) = 0 then %><tr><% end if %>
		<td><a href="ver_contacto.asp?contacto=<% =contactoRes("id") %>"><font size="-1" color="#FFCC66" face="arial"><% =contactoRes("nome") %></font></a></td>
		<% if ((i + 1) MOD 3) = 0 then %></tr><% end if %>
	<%
		i = i + 1
		contactoRes.MoveNext
	Loop 
	%>
	</table>
</td></tr>
<% end if %>

<%
if numCandidatosEmpregoRes("num") > 0 then 
	SQL = "SELECT id, cargo FROM emprego_candidato WHERE autor = " & autor & " ORDER BY cargo"
	Set empregoRes = dbConnection.Execute(SQL)
%>
<tr><td>
	<font color="white" face="arial"><% =numCandidatosEmpregoRes("num") %> <b> CANDIDATURA<% if numCandidatosEmpregoRes("num") <> 1 then %>S<% end if %> A EMPREGO<% if numCandidatosEmpregoRes("num") <> 1 then %>S<% end if %></b></font><br>
	<table border="0" cellspacing="7" cellpadding="0">
	<% 
	i = 0
	do while not empregoRes.eof 
	%>
		<% if (i MOD 3) = 0 then %><tr><% end if %>
		<td><a href="ver_candidato.asp?candidato=<% =empregoRes("id") %>"><font size="-1" color="#FFCC66" face="arial"><% =empregoRes("cargo") %></font></a></td>
		<% if ((i + 1) MOD 3) = 0 then %></tr><% end if %>
	<%
		i = i + 1
		empregoRes.MoveNext
	Loop 
	%>
	</table>
</td></tr>
<% end if %>

<%
if numOportunidadesEmpregoRes("num") > 0 then 
	SQL = "SELECT id, cargo FROM emprego_oportunidade WHERE autor = " & autor & " ORDER BY cargo"
	Set empregoRes = dbConnection.Execute(SQL)
%>
<tr><td>
	<font color="white" face="arial"><% =numOportunidadesEmpregoRes("num") %> <b>OPORTUNIDADE<% if numOportunidadesEmpregoRes("num") <> 1 then %>S<% end if %> DE EMPREGO</b></font><br>
	<table border="0" cellspacing="7" cellpadding="0">
	<% 
	i = 0
	do while not empregoRes.eof 
	%>
		<% if (i MOD 3) = 0 then %><tr><% end if %>
		<td><a href="ver_oportunidade.asp?opor=<% =empregoRes("id") %>"><font size="-1" color="#FFCC66" face="arial"><% =empregoRes("cargo") %></font></a></td>
		<% if ((i + 1) MOD 3) = 0 then %></tr><% end if %>
	<%
		i = i + 1
		empregoRes.MoveNext
	Loop 
	%>
	</table>
</td></tr>
<% end if %>

<%
if numLinksRes("num") > 0 then 
	SQL = "SELECT link, nome FROM links WHERE autor = " & autor & " ORDER BY link"
	Set linksRes = dbConnection.Execute(SQL)
%>
<tr><td>
	<font color="white" face="arial"><% =numLinksRes("num") %> <b>LINK<% if numLinksRes("num") <> 1 then %>S<% end if %></b></font><br>
	<table border="0" cellspacing="7" cellpadding="0">
	<% 
	i = 0
	do while not linksRes.eof 
	%>
		<% if (i MOD 3) = 0 then %><tr><% end if %>

		<% if linksRes("nome") <> "" then %>
			<td><a href="<% =linksRes("link") %>" target="_blank"><font size="-1" face="Arial" color="#FFCC66"><% =linksRes("nome") %></font></a></td>
		<% else %>
			<td><a href="<% =linksRes("link") %>" target="_blank"><font size="-1" face="Arial" color="#FFCC66"><% =linksRes("link") %></font></a></td>
		<% end if %>

		<% if ((i + 1) MOD 3) = 0 then %></tr><% end if %>
	<%
		i = i + 1
		linksRes.MoveNext
	Loop 
	%>
	</table>
</td></tr>
<% end if %>

<%
if numLivrosRes("num") > 0 then 
	SQL = "SELECT id, nome FROM livros WHERE autor = " & autor & " ORDER BY nome, autores"
	Set livrosRes = dbConnection.Execute(SQL)
%>
<tr><td>
	<font color="white" face="arial"><% =numLivrosRes("num") %> <b>LIVRO<% if numLivrosRes("num") <> 1 then %>S<% end if %></b></font><br>
	<table border="0" cellspacing="7" cellpadding="0">
	<% 
	i = 0
	do while not livrosRes.eof 
	%>
		<% if (i MOD 3) = 0 then %><tr><% end if %>
		<td><a href="ver_livro.asp?livro=<% =livrosRes("id") %>"><font size="-1" color="#FFCC66" face="arial"><% =livrosRes("nome") %></font></a></td>
		<% if ((i + 1) MOD 3) = 0 then %></tr><% end if %>
	<%
		i = i + 1
		livrosRes.MoveNext
	Loop 
	%>
	</table>
</td></tr>
<% end if %>

<%
if numOpinioesRes("num") > 0 then 
	SQL = "SELECT distinct(id), marca, modelo FROM opiniao_artigo WHERE id IN (SELECT artigo FROM opiniao WHERE autor = " & autor & ") ORDER BY marca, modelo"
	Set opinioesRes = dbConnection.Execute(SQL)
%>
<tr><td>
	<font color="white" face="arial"><% =numOpinioesRes("num") %> <b>OPINI<% if numOpinioesRes("num") <> 1 then %>&Otilde;ES<% else %>&Atilde;O<% end if %></b></font><br>
	<table border="0" cellspacing="7" cellpadding="0">
	<% 
	i = 0
	do while not opinioesRes.eof 
	%>
		<% if (i MOD 3) = 0 then %><tr><% end if %>
		<td><a href="opiniao_artigo.asp?ordem=nome&artigo=<% =opinioesRes("id") %>"><font size="-1" color="#FFCC66" face="arial"><% =opinioesRes("marca") %>&nbsp;<% =opinioesRes("modelo") %></font></a></td>
		<% if ((i + 1) MOD 3) = 0 then %></tr><% end if %>
	<%
		i = i + 1
		opinioesRes.MoveNext
	Loop 
	%>
	</table>
</td></tr>
<% end if %>

</table>

<% FimPagina() %>
