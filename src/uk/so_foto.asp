<%
foto = request("foto")
primeira = request("primeira")
tipo = request("tipo")
id = request("id")
tema = request("tema")
num = request("num")

directoria = int(foto / 1000)
%>

<!-- #include file="topo.asp" -->
<!-- #include file="fim_topo.asp" -->

<div align="center">
<a href="foto.asp?foto=<% =foto %>&primeira=<% =primeira %>&tema=<% =tema %>&tipo=<% =tipo %>&id=<% =id %>&num=<% =num %>"><img src="/fotos/fotos/<% =directoria %>/foto<% =foto %>.jpg" border=0 alt="Press here to go back"></a>
</div>

<!-- #include file="fim.asp" -->