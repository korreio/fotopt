<!-- #include file="funcoes_principais.asp" -->

<%
foto = request("foto")
primeira = request("primeira")
tipo = request("tipo")
id = request("id")
tema = request("tema")
num = request("num")

directoria = int(foto / 1000)

Cabecalho "FOTOGRAFIA", True
%>

<br>
<div align="center">
<a href="foto.asp?foto=<% =foto %>&primeira=<% =primeira %>&tema=<% =tema %>&tipo=<% =tipo %>&id=<% =id %>&num=<% =num %>"><img src="/fotos/fotos/<% =directoria %>/foto<% =foto %>.jpg" border=0 alt="Prima para voltar atr&aacute;s"></a>
</div>

</body></html>
