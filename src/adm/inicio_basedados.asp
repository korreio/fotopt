<%
' Copyright: (c) 1999-2023, Tiago Fonseca
' GNU General Public License v3.0+ (see LICENSE.md or https://www.gnu.org/licenses/gpl-3.0.html)
' SPDX-License-Identifier: GPL-3.0-or-later
%>

<%
Set dbConnection = Server.CreateObject("ADODB.Connection")
dbConnection.Open "Data Source=c:\databases\foto.mdb;Provider=Microsoft.Jet.OLEDB.4.0;Jet OLEDB"
%>