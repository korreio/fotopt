<!-- #include file="sqltext.asp" -->
<!-- #include file="funcoes_principais.asp" -->

<%
foto = request("foto")

' Dados referentes a galeria
primeira = request("primeira")
tipo = request("tipo")
id = request("id")
tema = request("tema")
num = request("num")

Dim meses
meses = Array("Janeiro", "Fevereiro", "Mar&ccedil;o", "Abril", "Maio", "Junho", "Julho", _
			  "Agosto", "Setembro", "Outubro", "Novembro", "Dezembro")

SQL = "SELECT * FROM foto WHERE id = " & foto
Set fotoRes = dbConnection.Execute(SQL)

SQL = "SELECT id, nome FROM autor WHERE id = " & fotoRes("autor")
Set autorRes = dbConnection.Execute(SQL)

SQL = "SELECT nome FROM assunto WHERE id = " & fotoRes("assunto")
Set assuntoRes = dbConnection.Execute(SQL)

SQL = "SELECT * FROM cronicas WHERE foto = " & foto
Set cronicaRes = dbConnection.Execute(SQL)

SQL = "SELECT mes, ano FROM destaque_cronica WHERE foto = " & foto
Set cronicaDestaqueRes = dbConnection.Execute(SQL)

directoria = int(fotoRes("id") / 1000)
%>

<%
if tipo <> "" then
	OpcaoMenu "VOLTAR À GALERIA", "galeria.asp?primeira=" & primeira & "&tema=" & tema & "&tipo=" & tipo & "&id=" & id & "&num=" & num, False, False, -1, False, False
end if
OpcaoMenu "VER A FOTO", "foto.asp?foto=" & foto & "&primeira=" & primeira & "&tema=" & tema & "&tipo=" & tipo & "&id=" & id & "&num=" & num, False, False, -1, False, False
OpcaoMenu "LER OU INSERIR COMENTÁRIOS", "comentarios.asp?foto=" & foto & "&primeira=" & primeira & "&tema=" & tema & "&tipo=" & tipo & "&id=" & id & "&num=" & num, False, False, -1, False, False
'OpcaoMenu "ALTERAR OU APAGAR CRÓNICA", "inserir_cronica.asp?foto=" & foto & "&primeira=" & primeira & "&tema=" & tema & "&tipo=" & tipo & "&id=" & id & "&num=" & num, False, True, fotoRes("autor"), False, False
Menu 1, GaleriaSubSeccao(tipo, id), "CRÓNICA"
%>

<table border="0" cellpadding="0" cellspacing="10">
<tr>
<td>
	<a href="foto.asp?foto=<% =foto %>&primeira=<% =primeira %>&tema=<% =tema %>&tipo=<% =tipo %>&id=<% =id %>&num=<% =num %>">
		<img src="/fotos/thumbs/<% =directoria %>/thumbs<% =fotoRes("id") %>.jpg" border="1" alt=""></a>
</td>
<td>
	<table border="0" cellpadding="2" cellspacing="0">
		<tr><td><font size="-1" color="#FFCC66" face="arial"><b>ID: </b></font></td><td><font size="-1" color="white" face="arial"><% =fotoRes("id") %></font></td></tr>
		<% if fotoRes("titulo") <> "" then %>
			<tr><td><font size="-1" color="#FFCC66" face="arial"><b>T&Iacute;TULO: </b></font></td><td><font size="-1" color="white" face="arial"><% =fotoRes("titulo") %></font></td></tr>
		<% else %>
			<tr><td><font size="-1" color="#FFCC66" face="arial"><b>T&Iacute;TULO: </b></font></td><td><font size="-1" color="white" face="arial"><i>sem t&iacute;tulo</i></font></td></tr>		
		<% end if %>
		<% if (fotoRes("anonima") <> 0) and (fotoRes("data") > (cdate(date() & " " & time()) - 7)) then %>
			<% if session("login") = 2 then %>
				<tr><td><font size="-1" color="#FFCC66" face="arial"><b>AUTOR: </b></font></td><td><a href="autor.asp?autor=<% =fotoRes("autor") %>"><font size="-1" color="red" face="arial"><% =autorRes("nome") %></font></a></td></tr>
			<% else %>
				<tr><td><font size="-1" color="#FFCC66" face="arial"><b>AUTOR: </b></font></td><td><font color="white" size="-1" face="arial"><i>anónimo</i> (até <% =day(fotoRes("data") + 7) & "/" & month(fotoRes("data") + 7) & "/" & year(fotoRes("data") + 7) & " às " & hour(fotoRes("data") + 7) & ":" & minute(fotoRes("data") + 7) %>)</font></td></tr>
			<% end if %>
		<% else %>
			<tr><td><font size="-1" color="#FFCC66" face="arial"><b>AUTOR: </b></font></td><td><a href="autor.asp?autor=<% =fotoRes("autor") %>"><font size="-1" color="white" face="arial"><% =autorRes("nome") %></font></a></td></tr>
		<% end if %>
		<tr><td><font size="-1" color="#FFCC66" face="arial"><b>FOTO: </b></font></td><td valign="bottom"><font size="-1" color="white" face="arial">inserida a <% =day(fotoRes("data")) %>/<% =month(fotoRes("data")) %>/<% =year(fotoRes("data")) %></font></td></tr>
		<tr>
			<td>
				<font size="-1" color="#FFCC66" face="arial"><b>CRÓNICA: </b></font>
			</td>
			<td valign="bottom">
				<font size="-1" color="white" face="arial">escrita a <% =day(cronicaRes("data")) %>/<% =month(cronicaRes("data")) %>/<% =year(cronicaRes("data")) %></font>
			</td>
		</tr>
		<% if not cronicaDestaqueRes.eof then %>
			<tr>
				<td><font size="-1" color="#FFCC66" face="arial"><b>DESTAQUE: </b></font></td>
				<td>
					<font size="-1" color="white" face="arial">
						foi <a href="destaque.asp?mes=<% =cronicaDestaqueRes("mes") %>&ano=<% =cronicaDestaqueRes("ano") %>"><font color="#FFCC66"><b>CR&Oacute;NICA DO M&Ecirc;S</b></font></a> em <% =meses(cronicaDestaqueRes("mes") - 1) %> de <% =cronicaDestaqueRes("ano") %>,
						leia a cr&iacute;tica do j&uacute;ri em <a href="comentarios.asp?foto=<% =foto %>&primeira=<% =primeira %>&tema=<% =tema %>&tipo=<% =tipo %>&id=<% =id %>&num=<% =num %>"><font color="white"><b>COMENT&Aacute;RIOS</b></font></a>.
					</font>
				</td>
			</tr>
		<% end if %>
	</table>
</td>
</tr>
</table>

<font size="-1" color="white" face="arial">&nbsp;Experiencias, hist&oacute;rias e mem&oacute;rias do autor sobre esta fotografia. Use a sec&ccedil;&atilde;o
de COMENT&Aacute;RIOS para comentar o texto.
</font>

<br><br>
<table border="1" cellpadding="4" cellspacing="0">
	<tr><td><font size="-1" color="white" face="arial"><% =Enter2Br(cronicaRes("texto")) %></font></td></tr>
</table>

<br>
<font size="-2" color="white" face="arial">Direitos de autor</font><font size="-2" color="white" face="arial">: Os textos s&atilde;o propriedade do autor ou dos seus clientes, podendo ser reproduzida somente com autorização dos mesmos.</font>

<% FimPagina() %>
