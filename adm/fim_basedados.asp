<%
if dbConnection <> "" then
	dbConnection.close
end if
set dbConnection = Nothing
%>