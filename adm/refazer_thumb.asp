<!-- #include file="inicio_basedados.asp" -->
<!-- #include file="topo.asp" -->
<td bgcolor="gray" width="100%" align="left"><font size="-1" color="black" face="arial">&nbsp;REFAZER THUMB</font></td>
<!-- #include file="fim_topo.asp" -->
<!-- #include file="autenticar_webmaster.asp" -->

<%
foto = request("foto")

' Dados referentes a galeria
primeira = request("primeira")
tipo = request("tipo")
id = request("id")
temaid = request("tema")
num = request("num")
directoria = int(foto / 1000)

' Fazer thumbnail
Dim JPEGServer 
' Localhost
Set JPEGServer = CreateObject("JPEGServer.JPEGBuilder")
JPEGServer.Transform "c:\inetpub\wwwroot\foto\fotos\fotos\" & directoria & "\foto" & foto & ".jpg", "c:\inetpub\wwwroot\foto\fotos\thumbs\" & directoria & "\thumbs" & foto & ".jpg", 150, 90
Set JPEGServer = Nothing
%>

<meta http-equiv="refresh" content="0;url=../foto.asp?foto=<% =foto %>&primeira=<% =primeira %>&tema=<% =temaid %>&tipo=<% =tipo %>&id=<% =id %>&num=<% =num %>">
<font size="+1" color="white" face="arial"><b>Thumbnail refeito com sucesso</b></font>

<!-- #include file="fim_autenticacao.asp" -->
<!-- #include file="fim_basedados.asp" -->