<%
' Copyright: (c) 1999-2023, Tiago Fonseca
' GNU General Public License v3.0+ (see LICENSE.md or https://www.gnu.org/licenses/gpl-3.0.html)
' SPDX-License-Identifier: GPL-3.0-or-later
%>

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
