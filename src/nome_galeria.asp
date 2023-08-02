<%
' Copyright: (c) 1999-2023, Tiago Fonseca
' GNU General Public License v3.0+ (see LICENSE.md or https://www.gnu.org/licenses/gpl-3.0.html)
' SPDX-License-Identifier: GPL-3.0-or-later
%>

<%
Dim meses
meses = Array("JANEIRO", "FEVEREIRO", "MAR&Ccedil;O", "ABRIL", "MAIO", "JUNHO", "JULHO", _
		  "AGOSTO", "SETEMBRO", "OUTUBRO", "NOVEMBRO", "DEZEMBRO")

if tipo = "assunto" then 
	SQL = "SELECT nome FROM assunto WHERE id = " & id
	Set assuntoRes = dbConnection.Execute(SQL)
	
	nomeGaleria = assuntoRes("nome")
elseif tipo = "autor" then 
	SQL = "SELECT nome FROM autor WHERE id = " & id
	Set autorRes = dbConnection.Execute(SQL)
	
	if (tema <> "-1") and (tema <> "0") then
		SQL = "SELECT nome FROM folder WHERE id = " & tema
		Set temaRes = dbConnection.Execute(SQL)

		nomeGaleria = autorRes("nome") & " - '" & temaRes("nome") & "'"
	elseif tema = "-1" then
		nomeGaleria = autorRes("nome")
	elseif tema = "0" then
		nomeGaleria = autorRes("nome")
	end if
elseif tipo = "preferidas" then 
	SQL = "SELECT nome FROM autor WHERE id = " & id
	Set autorRes = dbConnection.Execute(SQL)
	
	if (tema <> "-1") and (tema <> "0") then
		SQL = "SELECT nome FROM preferidas_folder WHERE id = " & tema
		Set temaRes = dbConnection.Execute(SQL)

		nomeGaleria = "FOTOS PREFERIDAS DE " & autorRes("nome") & " - '" & temaRes("nome") & "'"
	elseif tema = "-1" then
		nomeGaleria = "FOTOS PREFERIDAS DE " & autorRes("nome")
	elseif tema = "0" then
		nomeGaleria = "FOTOS PREFERIDAS DE " & autorRes("nome")
	end if
elseif tipo = "preferidas_autor" then 
	SQL = "SELECT nome FROM autor WHERE id = " & id
	Set autorRes = dbConnection.Execute(SQL)

	nomeGaleria = "AS MELHORES FOTOS DE " & autorRes("nome") & " (SELEC��O DO AUTOR)"
elseif tipo = "novas" then
	SQL = "SELECT nome FROM assunto WHERE id = " & id
	Set assuntoRes = dbConnection.Execute(SQL)

	if id = 0 then
		nomeGaleria = "FOTOGRAFIAS NOVAS"
	elseif id < 0 then
		nomeGaleria = "FOTOGRAFIAS AN�NIMAS NOVAS"
	else
		nomeGaleria = "FOTOGRAFIAS NOVAS - '" & assuntoRes("nome") & "'"
	end if
elseif tipo = "novasautor" then
	SQL = "SELECT nome FROM autor WHERE id = " & id
	Set autorRes = dbConnection.Execute(SQL)

	nomeGaleria = "FOTOGRAFIAS NOVAS - '" & autorRes("nome") & "'"
elseif tipo = "data" then
	if id = "hoje" then
		nomeGaleria = "FOTOGRAFIAS INSERIDAS HOJE"
	elseif id = "24horas" then
		nomeGaleria = "FOTOGRAFIAS INSERIDAS NAS �LTIMAS 24 HORAS"
	elseif id = "24anonimas" then
		nomeGaleria = "FOTOGRAFIAS AN�NIMAS INSERIDAS NAS �LTIMAS 24 HORAS"
	elseif id = "ontem" then
		nomeGaleria = "FOTOGRAFIAS INSERIDAS ONTEM"
	elseif id = "ultimos" then
		nomeGaleria = "FOTOGRAFIAS INSERIDAS NA �LTIMA SEMANA"
	elseif id = "mes" then
		nomeGaleria = "FOTOGRAFIAS INSERIDAS ESTE M&Ecirc;S"
	elseif id = "mespassado" then
		nomeGaleria = "FOTOGRAFIAS INSERIDAS NO M&Ecirc;S PASSADO"
	elseif id = "ano" then
		nomeGaleria = "FOTOGRAFIAS INSERIDAS ESTE ANO"
	elseif id = "todas" then
		nomeGaleria = "TODAS AS FOTOGRAFIAS"
	end if
elseif tipo = "fotomes" then
	if id = "votadas" then
		nomeGaleria = "FOTOGRAFIAS VOTADAS PARA FOTO DO M&Ecirc;S"
	elseif id = "vencedoras" then
		nomeGaleria = "FOTOGRAFIAS VENCEDORAS NA FOTO DO M&Ecirc;S"
	elseif id = "propostas" then
		nomeGaleria = "FOTOGRAFIAS PROPOSTAS PARA ESTE M&Ecirc;S"
	end if
elseif tipo = "especial" then
	SQL = "SELECT nome FROM galeria_especial WHERE id = " & id
	Set galeriaRes = dbConnection.Execute(SQL)

	nomeGaleria = "FOTOS " & galeriaRes("nome")
elseif tipo = "juri" then
	SQL = "SELECT nome, autor, tema_mes FROM juri_folder WHERE id = " & id
	Set folderRes = dbConnection.Execute(SQL)

	SQL = "SELECT nome FROM autor WHERE id = " & folderRes("autor")
	Set autorRes = dbConnection.Execute(SQL)

	if folderRes("tema_mes") = True then
		nomeGaleria = "TEMA DO M&Ecirc;S" & " (" & folderRes("nome") & ")"
	else
		nomeGaleria = folderRes("nome") & " (" & autorRes("nome") & ")"
	end if
elseif tipo = "temames" then
	SQL = "SELECT nome, mes, ano FROM tema_mes WHERE id = " & id
	Set temaRes = dbConnection.Execute(SQL)

	nomeGaleria = temaRes("nome") & " (PROPOSTAS TEMA DE " & meses(temaRes("mes") - 1) & " " & temaRes("ano") & ")"
elseif tipo = "temames_escolhidas" then
	SQL = "SELECT nome, mes, ano FROM tema_mes WHERE id = " & id
	Set temaRes = dbConnection.Execute(SQL)

	nomeGaleria = temaRes("nome") & " (VENCEDORAS TEMA DE " & meses(temaRes("mes") - 1) & " " & temaRes("ano") & ")"
elseif tipo = "galeria_mes" then
	SQL = "SELECT nome, mes, ano FROM destaque_galeria WHERE id = " & id
	Set temaRes = dbConnection.Execute(SQL)

	nomeGaleria = temaRes("nome") & " (DESTAQUE EM " & meses(temaRes("mes") - 1) & " " & temaRes("ano") & ")"
elseif tipo = "vencedoras_autor" then
	SQL = "SELECT nome FROM autor WHERE id = " & id
	Set autorRes = dbConnection.Execute(SQL)

	nomeGaleria = "DESTACADAS E VENCEDORAS DE " & autorRes("nome")
elseif (tipo = "busca") or (tipo = "busca_sqlw") then
	if (id = "umid") or (id = "intervaloid") or (id = "ateid") then
		nomeGaleria = "RESULTADO DE PROCURA POR ID"
	elseif (id = "umadata") or (id = "intervalodata") or (id = "atedata") or (id = "24horas") then
		nomeGaleria = "RESULTADO DE PROCURA POR DATA"
	elseif id = "dados" then
		nomeGaleria = "RESULTADO DE PROCURA POR DADOS"
	end if
elseif (tipo = "associados") or (tipo = "associados_sqlw") then
	SQL = "SELECT nome FROM associados WHERE id = " & id
	Set associadosRes = dbConnection.Execute(SQL)

	nomeGaleria = associadosRes("nome")
elseif tipo = "fotomes_sqlw" then
	nomeGaleria = "FOTOGRAFIAS PROPOSTAS PARA FOTO DO MES"
elseif tipo = "cronicas" then
	if id = "" then
		nomeGaleria = "FOTOGRAFIAS COM CR&Oacute;NICAS"
	else
		SQL = "SELECT nome FROM assunto WHERE id = " & id
		Set temaRes = dbConnection.Execute(SQL)
	
		nomeGaleria = "FOTOGRAFIAS COM CR&Oacute;NICAS - " & temaRes("nome")
	end if
elseif tipo = "cronicas_mes" then
	if id = 1 then
		nomeGaleria = "FOTOGRAFIAS COM CR&Oacute;NICAS DE " & meses(11)
	else
		nomeGaleria = "FOTOGRAFIAS COM CR&Oacute;NICAS DE " & meses(id - 2)
	end if
elseif tipo = "cronicas_vencedoras" then
	nomeGaleria = "FOTOGRAFIAS COM CR&Oacute;NICAS VENCEDORAS"
end if
%>