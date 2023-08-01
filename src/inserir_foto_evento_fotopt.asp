<!-- #include file="funcoes_principais.asp" -->

<% 
AutenticarMembro(autor)
Menu 2, 4, "INSERIR FOTOGRAFIA EM EVENTO FOTO@PT"

login = session("login")
%>

<%
evento = request("evento")

SQL = "SELECT nome FROM autor WHERE id = " & login
Set autorRes = dbConnection.Execute(SQL)

SQL = "SELECT nome FROM eventos_fotopt WHERE id = " & evento
Set eventoRes = dbConnection.Execute(SQL)

SQL = "SELECT count(*) AS num FROM foto WHERE autor = " & login
Set numFotosRes = dbConnection.Execute(SQL)

SQL = "SELECT count(*) AS num FROM eventos_fotopt_foto WHERE evento_fotopt = " & evento & " AND autor = " & login
Set numFotosEventosRes = dbConnection.Execute(SQL)

if session("login") = 2 then
	maxFotos = 99999
else 
	maxFotos = 15
end if

if ((numFotosEventosRes("num") < maxFotos)) then 
%>
	<form enctype="multipart/form-data" action="inserir_foto_evento_fotopt_res.asp" method="post">
	
	<font size="-1" color="white" face="arial">
	Por favor insira s� foto relacionadas com este evento. Pode colocar at� 15 fotos por evento.
	As fotos aqui inseridas n�o contam para o limite de fotos da sua galeria de membro. Todas 
	as fotos inseridas podem ser comentadas, mas n�o podem entrar em concursos do site.
	</font>
	<br><br>
	
	<table border="0" cellpadding="3" cellspacing="0">
		<tr>
			<td><font size="-1" color="#FFCC66" face="arial"><b>LIVRE:</b></font></td>
			<td><font size="-1" color="white" face="arial">Pode inserir mais <font color="#FFCC66"><b><% =maxFotos - numFotosEventosRes("num") %></b></font> fotos neste evento.</font></td>
		</tr>
		<% if numFotosRes("num") <= 7 then %>
			<tr><td><br></td><td></td></tr>			
			<tr>
				<td><font size="-1" color="#FFCC66" face="arial"><b>AVISO NOVOS<br>UTILIZADORES<br>DAS GALERIAS:</b></font></td>
				<td><font size="-1" color="white" face="arial">
					Para evitar abusos as imagens de membros com 7 ou menos fotos na sua galeria ser�o moderadas<br>
					pelo administrador, e enquanto n�o forem aprovadas n�o ser�o vistas por niguem. A aprova��o pode<br>
					chegar a levar 2 ou 3 dias, mas entretanto pode inserir mais fotos. Pe�o desculpa pelo inc�modo.
				</font></td>
			</tr>
		<% end if %>
	
		<tr><td><br></td><td></td></tr>			
		<tr><td><font size="-1" color="#FFCC66" face="arial"><b>AUTOR: </b></font></td><td><font size="-1" color="white" face="arial"><% =autorRes("nome") %></font></td></tr>
		<tr><td><font size="-1" color="#FFCC66" face="arial"><b>EVENTO: </b></font></td><td><font size="-1" color="white" face="arial"><% =eventoRes("nome") %></font></td></tr>
		<tr><td><br></td><td></td></tr>			
	
		<tr><td valign="top"><font size="-1" color="#FFCC66" face="arial"><b>FOTOGRAFIA<br>A INSERIR: </b></font></td><td><input type="file" name="foto"> <br><font size="-2" color="white" face="arial">(Campo obrigat&oacute;rio. Imagem no formato &quot;JPG&quot; e com um tamanho m&aacute;ximo de 100 kbytes)</font></td></tr>
		<tr><td><br></td><td></td></tr>			
	
		<tr><td><font size="-1" color="#FFCC66" face="arial"><b>T&Iacute;TULO: </b></font></td><td><input maxlength="50" size="40" type="text" name="titulo"></td></tr>
		<tr><td><font size="-1" color="#FFCC66" face="arial"><b>DESCRI&Ccedil;&Atilde;O: </b></font><font size="-1" color="white" face="arial"><br>(se ultrapassar<br>estas 6 linhas<br>o texto ser&aacute;<br>cortado)</font></td><td><textarea name="descricao" cols="38" rows="6" wrap="VIRTUAL"></textarea></td></tr>
	
		<tr><td><br></td><td></td></tr>		
		<tr><td></td><td>
			<input type="Submit" value="Inserir foto"><br>
			<font size="-1" color="white" face="arial">
				(logo a seguir a premir este bot&atilde;o &eacute; normal que pare&ccedil;a que	nada acontece.<br>
				Tem que	esperar uns momentos enquanto a foto &eacute; enviada.<br>
				Quando o envio termina com sucesso o seu <i>browser</i> salta autom&aacute;ticamente para a galeria deste evento)
			</font>
		</td></tr>	
	</table>
	
	<input name="evento" type="hidden" value="<% =evento %>">
	</form>
<% else %>
	<font color="#FFCC66" face="arial"><b>LIMITE M&Aacute;XIMO DE FOTOS ATINGIDO PARA ESTE EVENTO</b></font><br><br>
	<font size="-1" color="white" face="arial">
		Atingiu o limite de fotografias que pode ter neste evento. Para colocar novas fotos ter&aacute; que apagar uma, ou mais, das que j&aacute; foram inseridas.
		<br><br>
		O m&aacute;ximo de fotos que pode ter por evento � <font color="#FFCC66"><b><% =maxFotos %></b></font>.
		Este limite foi imposto por raz&otilde;es de ordem log&iacute;stica (espa&ccedil;o que as fotos ocupam).
	</font>
<% end if %>

<% FimPagina() %>
