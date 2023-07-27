<%
login = session("login")

if login <> 2 then
%>
	<font size="+1" color="white" face="arial">Esta opera&ccedil;&atilde;o s&oacute; pode ser realizada pelo webmaster!</font>
<%
else
	session("login") = clng(login)
%>