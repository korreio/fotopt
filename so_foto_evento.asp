<!-- #include file="funcoes_principais.asp" -->

<%
foto = request("foto")
primeira = request("primeira")
evento = request("evento")
num = request("num")

directoria = int(foto / 1000)

Cabecalho "FOTOGRAFIA", True
%>

<br>
<div align="center">
<a href="foto_evento.asp?foto=<% =foto %>&primeira=<% =primeira %>&evento=<% =evento %>&&num=<% =num %>"><img src="/fotos/arquivo/eventos_fotopt/fotos/<% =directoria %>/foto<% =foto %>.jpg" border=0 alt="Prima para voltar atr&aacute;s"></a>
</div>

</body></html>
