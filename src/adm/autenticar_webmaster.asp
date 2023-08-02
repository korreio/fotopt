<%
' Copyright: (c) 1999-2023, Tiago Fonseca
' GNU General Public License v3.0+ (see LICENSE.md or https://www.gnu.org/licenses/gpl-3.0.html)
' SPDX-License-Identifier: GPL-3.0-or-later
%>

<%
login = session("login")

if login <> 2 then
%>
	<font size="+1" color="white" face="arial">Esta opera&ccedil;&atilde;o s&oacute; pode ser realizada pelo webmaster!</font>
<%
else
	session("login") = clng(login)
%>