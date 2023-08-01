<%
ordem = request("ordem")
if (ordem <> "") then
	if ordem = "dec" then
		session("ordem") = ""
	elseif ordem = "cre" then
		session("ordem") = "c"
	end if
end if
%>