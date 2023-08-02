<%
' Copyright: (c) 1999-2023, Tiago Fonseca
' GNU General Public License v3.0+ (see LICENSE.md or https://www.gnu.org/licenses/gpl-3.0.html)
' SPDX-License-Identifier: GPL-3.0-or-later
%>

<!-- #include file="funcoes_principais.asp" -->

<% 
Menu 5, 3, "BUSCA"
%>

<font size="-1" face="Arial" color="#ffffff">
Para encontrar qualquer texto no site basta escrever o que quer na caixa abaixo <br>
e primir o bot�o "Google Search". Tamb�m pode procurar esse texto na Internet<br>
inteira escolhendo a op��o "Procurar na WWW".
<br><br>
Se alguma p�gina actual n�o aparece � porque ainda n�o foi indexada pelo Google,<br>
o que � feito peri�dicamente.
</font>
<br><br><br>

<!-- Search Google -->
<FORM method=GET action=http://www.google.com/custom TARGET=_blank>
<TABLE bgcolor=#000000 cellspacing=0 border=0>
<tr valign=top><td>
<A HREF=http://www.google.com/search TARGET=_blank>
<IMG SRC=http://www.google.com/logos/Logo_40blk.gif border=0 ALT=Google align=middle></A>
</td>
<td>
<INPUT TYPE=text name=q size=31 maxlength=255 value="">
<INPUT type=submit name=sa VALUE="Google Search">
<INPUT type=hidden name=cof VALUE="GIMP:white;T:#FFFFFF;ALC:#FFCC66;GFNT:gray;LC:#FFCC66;BGC:#000000;AH:center;VLC:#FFCC66;GL:2;S:http://www.fotopr.net;GALT:silver;AWFID:1bbade6ed98e7570;">
<font face=arial,sans-serif size=-1 color="#ffffff"><input type=hidden name=domains value="fotopt.net"><br><input type=radio name=sitesearch value="" checked> Procurar na WWW <input checked type=radio name=sitesearch value="fotopt.net"> Procurar s� www.fotopt.net </font><br>
</td></tr></TABLE>
</FORM>
<!-- Search Google -->

<% FimPagina() %>
