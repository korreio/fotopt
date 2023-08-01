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