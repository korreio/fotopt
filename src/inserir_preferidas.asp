<!-- #include file="funcoes_principais.asp" -->

<%
foto = request("foto")
autor = session("login")

' Dados referentes a galeria
primeira = request("primeira")
tipo = request("tipo")
id = request("id")
tema = request("tema")
num = request("num")

maxPreferidas = 10
SQL = "SELECT count(*) as numPreferidas FROM preferidas_fotos, foto WHERE preferidas_fotos.autor = " & autor & "  AND foto.autor = " & autor & " AND preferidas_fotos.foto = foto.id"
Set numFotoRes = dbConnection.Execute(SQL)

SQL = "SELECT * FROM foto WHERE id = " & foto
Set fotoRes = dbConnection.Execute(SQL)

SQL = "SELECT id, nome FROM autor WHERE id = " & fotoRes("autor")
Set autorRes = dbConnection.Execute(SQL)
%>

<%
AutenticarMembro(autor)
Menu 1, GaleriaSubSeccao(tipo, id), "INSERIR FOTO NA MINHA GALERIA DE PREFERIDAS"
%>

<font size="-1" color="white" face="arial">
Cada autor tem duas galerias de fotos preferidas:<br><br>

<font color="#FFCC66"><b>A SELEC��O DO PR�PRIO AUTOR</b></font>:<br>
Aqui poder� colocar at� <font color="#FFCC66"><b>10 fotos</b></font> que acha serem as melhores, <font color="#FFCC66"><b>de sua autoria</b></font>, entre as que est�o na sua galeria.<br>
Estas fotos estar�o destacadas sempre que alguem visita a sua galeria.<br><br>

<font color="#FFCC66"><b>FOTOS PREFERIDAS</b></font>:<br>
Esta � a sua galeria de fotos preferidas <font color="#FFCC66"><b>de outros autores</b></font>, acess�vel atrav�s da op��o, com o mesmo nome, presente na sua ficha de membro.<br><br>
Para remover esta foto da sua galeria de preferidas prima REMOVER DAS MINHAS 
PREFERIDAS quando estiver a ver novamente a fotografia.
</font>
<br><br>

<% if (fotoRes("autor") = autor) and (numFotoRes("numPreferidas") >= maxPreferidas) then %>
	<font size="-1" color="#FFCC66" face="arial"><b>
		ATEN��O:<br>
		Atingiu o limite de fotos suas que pode ter na galeria de fotos preferidas,
		ter� que remover alguma para poder colocar outra.
	</b></font>
<% else %>
	<form action="inserir_preferidas_res.asp?foto=<% =foto %>&primeira=<% =primeira %>&tema=<% =tema %>&tipo=<% =tipo %>&id=<% =id %>&num=<% =num %>" method=post>
	<table border="0" cellpadding="3" cellspacing="0">
		<tr><td><font size="-1" color="#FFCC66" face="arial"><b>ID:</b> </font></td><td><font size="-1" color="white" face="arial"><% =foto %></font></td></tr>
		<% if fotoRes("titulo") <> "" then %>
			<tr><td><font size="-1" color="#FFCC66" face="arial"><b>T&Iacute;TULO:</b> </font></td><td><font size="-1" color="white" face="arial"><% =fotoRes("titulo") %></font></td></tr>
		<% else %>
			<tr><td><font size="-1" color="#FFCC66" face="arial"><b>T&Iacute;TULO:</b> </font></td><td><font size="-1" color="white" face="arial"><i>sem t&iacute;tulo</i></font></td></tr>
		<% end if %>
		<% if (fotoRes("anonima") <> 0) and (fotoRes("data") > (cdate(date() & " " & time()) - 7)) then %>
			<% if session("login") = 2 then %>
				<tr><td><font size="-1" color="#FFCC66" face="arial"><b>AUTOR:</b> </font></td><td><font size="-1" color="red" face="arial"><% =autorRes("nome") %></font></td></tr>
			<% else %>
				<tr><td><font size="-1" color="#FFCC66" face="arial"><b>AUTOR:</b> </font></td><td><font color="white" size="-1" face="arial"><i>an�nimo</i> (at� <% =day(fotoRes("data") + 7) & "/" & month(fotoRes("data") + 7) & "/" & year(fotoRes("data") + 7) & " �s " & hour(fotoRes("data") + 7) & ":" & minute(fotoRes("data") + 7) %>)</font></td></tr>
			<% end if %>
		<% else %>
			<tr><td><font size="-1" color="#FFCC66" face="arial"><b>AUTOR:</b> </font></td><td><font size="-1" color="white" face="arial"><% =autorRes("nome") %></font></td></tr>
		<% end if %>
		<tr><td></td><td><input type="Submit" value="Inserir nas preferidas"></td></tr>
	</table>
	</form>
<% end if %>

<% FimPagina() %>
