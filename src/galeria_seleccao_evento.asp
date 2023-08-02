<%
' Copyright: (c) 1999-2023, Tiago Fonseca
' GNU General Public License v3.0+ (see LICENSE.md or https://www.gnu.org/licenses/gpl-3.0.html)
' SPDX-License-Identifier: GPL-3.0-or-later
%>

<!-- #include file="sqltext.asp" -->

<%
primeira = request("primeira")
evento = request("evento")

SQLW = "WHERE evento_fotopt = " & evento

if (session("login") = 2) then
else
	SQLW = SQLW & " AND moderar = False "
end if
%>