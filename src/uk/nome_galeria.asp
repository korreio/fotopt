<%
if tipo = "assunto" then 
	SQL = "SELECT en_nome FROM assunto WHERE id = " & id
	Set assuntoRes = dbConnection.Execute(SQL)
	
	nomeGaleria = assuntoRes("en_nome")
elseif tipo = "autor" then 
	SQL = "SELECT nome FROM autor WHERE id = " & id
	Set autorRes = dbConnection.Execute(SQL)
	
	if (tema <> "-1") and (tema <> "0") then
		SQL = "SELECT nome_uk FROM folder WHERE id = " & tema
		Set temaRes = dbConnection.Execute(SQL)

		nomeGaleria = autorRes("nome") & " - '" & temaRes("nome_uk") & "'"
	elseif tema = "-1" then
		nomeGaleria = autorRes("nome")
	elseif tema = "0" then
		nomeGaleria = autorRes("nome")
	end if
elseif tipo = "data" then
	if id = "novas" then
		nomeGaleria = "NEW PHOTOS"
	elseif id = "hoje" then
		nomeGaleria = "PHOTOS SUBMITED TODAY"
	elseif id = "ontem" then
		nomeGaleria = "PHOTOS SUBMITED YERTERDAY"
	elseif id = "ultimos" then
		nomeGaleria = "PHOTOS SUBMITED IN THE LAST 5 DAYS"
	elseif id = "mes" then
		nomeGaleria = "PHOTOS SUBMITED THIS MONTH"
	elseif id = "mespassado" then
		nomeGaleria = "PHOTOS SUBMITED LAST MONTH"
	elseif id = "ano" then
		nomeGaleria = "PHOTOS SUBMITED THIS YEAR"
	elseif id = "todas" then
		nomeGaleria = "ALL PHOTOS"
	end if
elseif tipo = "fotomes" then
	if id = "votadas" then
		nomeGaleria = "VOTED IN MONTH PHOTO CONTEST"
	elseif id = "vencedoras" then
		nomeGaleria = "WINNERS IN MONTH PHOTO CONTEST"
	elseif id = "propostas" then
		nomeGaleria = "PROPOSED IN MONTH PHOTO CONTEST"
	end if
end if
%>