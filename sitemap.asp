<script language="JavaScript">
<!-- hide from old browsers
function openWindow(url, name) {
	popupWin = window.open(url, name, 'scrollbars,resizable,width=500,height=420')
}
// -->
</script>

<!-- #include file="funcoes_principais.asp" -->

<%
Menu 5, 1, "MAPA DO SITE"
%>

<table cellpadding="5" cellspacing="0" border="0">
<tr align="center" valign="top">
<% for i = 0 to 2 %>
	<td><table cellpadding="0" cellspacing="0" width="100%" border="1" bordercolor="silver" bordercolordark="silver" bordercolorlight="silver"><tr><td>
		<table cellpadding="0" cellspacing="0" width="100%" border="0" bgcolor="#808080">
		<tr><td bgcolor="#000000"><table cellpadding="4" cellspacing="0" border="0"><tr><td><a href="<% =url_base %><% =menuPrincipal(i)(1) %>" class="pa"><% =menuPrincipal(i)(0) %></a></td></tr></table></td></tr>
		<% for j = 0 to (menuPrincipal(i)(2) - 1) %>
			<tr><td height="1" bgcolor="#c0c0c0"><img src="Imagens/pixel.gif" width="1" height="1" border="0" alt=""></td></tr>
			<tr><td><table cellpadding="4" cellspacing="0" border="0"><tr><td><a href="<% =url_base %><% =menuPrincipal(i)(3)(j)(1) %>" class="si"><% =menuPrincipal(i)(3)(j)(0) %></a></td></tr></table></td></tr>
		<% next %>
		</table></td></tr></table>
	</td>
<% next %>
</tr></table>

<br>

<table cellpadding="5" cellspacing="0" border="0">
<tr align="center" valign="top">
<% for i = 3 to 4 %>
	<td><table cellpadding="0" cellspacing="0" width="100%" border="1" bordercolor="silver" bordercolordark="silver" bordercolorlight="silver"><tr><td>
		<table cellpadding="0" cellspacing="0" width="100%" border="0" bgcolor="#808080">
		<tr><td bgcolor="#000000"><table cellpadding="4" cellspacing="0" border="0"><tr><td><a href="<% =url_base %><% =menuPrincipal(i)(1) %>" class="pa"><% =menuPrincipal(i)(0) %></a></td></tr></table></td></tr>
		<% for j = 0 to (menuPrincipal(i)(2) - 1) %>
			<tr><td height="1" bgcolor="#c0c0c0"><img src="Imagens/pixel.gif" width="1" height="1" border="0" alt=""></td></tr>
			<tr><td><table cellpadding="4" cellspacing="0" border="0"><tr><td><a href="<% =url_base %><% =menuPrincipal(i)(3)(j)(1) %>" class="si"><% =menuPrincipal(i)(3)(j)(0) %></a></td></tr></table></td></tr>
		<% next %>
		</table></td></tr></table>
	</td>
<% next %>
</tr></table>

<br>

<% FimPagina() %>
