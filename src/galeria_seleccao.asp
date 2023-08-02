<%
' Copyright: (c) 1999-2023, Tiago Fonseca
' GNU General Public License v3.0+ (see LICENSE.md or https://www.gnu.org/licenses/gpl-3.0.html)
' SPDX-License-Identifier: GPL-3.0-or-later
%>

<!-- #include file="sqltext.asp" -->

<%
primeira = request("primeira")
tipo = request("tipo")
id = request("id")
if isnumeric(id) then
	id = clng(request("id"))
end if
tema = request("tema")

if tipo = "assunto" then
	SQLW = "WHERE " & tipo & " = " & id
elseif tipo = "autor" then
	if (session("login") = 2) or (session("login") = clng(id)) then
		if tema = "-1" then
			SQLW = "WHERE autor = " & id
		else
			SQLW = "WHERE autor = " & id & " AND tema = " & tema
		end if
	else
		if tema = "-1" then
			SQLW = "WHERE autor = " & id & " AND (anonima <> 2 OR (anonima = 2 AND data < #" & cdate(date() & " " & time()) - 7 & "#))"
		else
			SQLW = "WHERE autor = " & id & " AND tema = " & tema & " AND (anonima <> 2 OR (anonima = 2 AND data < #" & cdate(date() & " " & time()) - 7 & "#))"
		end if
	end if
elseif tipo = "novas" then
	if session("login") <> 0 then
		SQL = "SELECT autor.data_anterior, autor_opcoes.tipo_novidades FROM autor, autor_opcoes WHERE autor.id = " & session("login") & " AND autor.id = autor_opcoes.autor"
		Set loginRes = dbConnection.Execute(SQL)
		
		if isdate(loginRes("data_anterior")) then
			data = loginRes("data_anterior")
			if loginRes("tipo_novidades") = "3" then
				data_autor = cdate(month(data) & "/" & day(data) & "/" & year(data))
			elseif loginRes("tipo_novidades") = "4" then
				data_autor = cdate(month(data) & "/" & day(data) & "/" & year(data) & " " & hour(data) & ":00:00")
			elseif loginRes("tipo_novidades") = "5" then
				data_autor = cdate(month(data) & "/" & day(data) & "/" & year(data) & " " & hour(data) & ":" & minute(data) & ":00")
			elseif (loginRes("tipo_novidades") = "6") or (loginRes("tipo_novidades") = "") or (loginRes("tipo_novidades") = "0") then
				data_autor = data
			end if
	
			SQLW = "WHERE data >= #" & data_autor & "#"
		else
			SQLW = "WHERE data >= #" & date() & "#"
		end if
	else
		SQLW = "WHERE data >= #" & date() & "#"
	end if

	if id > 0 then
		SQLW = SQLW & " AND assunto = " & id
	end if
	if id < 0 then
		' Anonimos
		SQLW = SQLW & " AND foto.anonima <> 0 AND foto.data > #" & cdate(date() & " " & time()) - 7 & "#"
	end if
elseif tipo = "novasautor" then
	if session("login") <> 0 then
		SQL = "SELECT autor.data_anterior, autor_opcoes.tipo_novidades FROM autor, autor_opcoes WHERE autor.id = " & session("login") & " AND autor.id = autor_opcoes.autor"
		Set loginRes = dbConnection.Execute(SQL)

		if isdate(loginRes("data_anterior")) then
			data = loginRes("data_anterior")
			if loginRes("tipo_novidades") = "3" then
				data_autor = cdate(month(data) & "/" & day(data) & "/" & year(data))
			elseif loginRes("tipo_novidades") = "4" then
				data_autor = cdate(month(data) & "/" & day(data) & "/" & year(data) & " " & hour(data) & ":00:00")
			elseif loginRes("tipo_novidades") = "5" then
				data_autor = cdate(month(data) & "/" & day(data) & "/" & year(data) & " " & hour(data) & ":" & minute(data) & ":00")
			elseif (loginRes("tipo_novidades") = "6") or (loginRes("tipo_novidades") = "") or (loginRes("tipo_novidades") = "0") then
				data_autor = data
			end if

			SQLW = "WHERE data >= #" & data_autor & "#"
		else
			SQLW = "WHERE data >= #" & date() & "#"
		end if
	else
		SQLW = "WHERE data >= #" & date() & "#"
	end if

	SQLW = SQLW & " AND autor = " & id
elseif tipo = "data" then
	if id = "hoje" then
		SQLW = "WHERE data >= #" & date() & "#"
	elseif id = "24horas" then
		SQLW = "WHERE data >= #" & cdate(date() & " " & time()) - 1 & "#"
	elseif id = "24anonimas" then
		SQLW = "WHERE data >= #" & cdate(date() & " " & time()) - 1 & "# AND foto.anonima <> 0 AND foto.data > #" & cdate(date() & " " & time()) - 7 & "#"
	elseif id = "ontem" then
		SQLW = "WHERE data >= #" & date() - 1 & "# AND data < #" & date() & "#"
	elseif id = "ultimos" then
		SQLW = "WHERE data > #" & date() - 7 & "#"
	elseif id = "mespassado" then
		if month(date()) = 1 then
			SQLW = "WHERE data >= #12/1/" & year(date()) - 1 & "# AND data < #1/1/" & year(date()) & "#"
		else
			SQLW = "WHERE data >= #" & month(date()) - 1 & "/1/" & year(date()) & "# AND data < #" & month(date()) & "/1/" & year(date()) & "#"
		end if
	elseif id = "mes" then
		SQLW = "WHERE data >= #" & month(date()) & "/1/" & year(date()) & "#"
	elseif id = "ano" then
		SQLW = "WHERE data >= #1/1/" & year(date()) & "#"
	elseif id = "todas" then
		SQLW = "WHERE id > 0"
	end if
elseif tipo = "fotomes" then
	if id = "votadas" then
		SQLW = "INNER JOIN fotomes_votos ON foto.id = fotomes_votos.foto WHERE true"
	elseif id = "vencedoras" then
		SQLW = "INNER JOIN fotomes_votos AS fotomes ON foto.id = fotomes.foto WHERE votos = "
		SQLW = SQLW & "(SELECT max(votos) FROM fotomes_votos WHERE fotomes.mes = fotomes_votos.mes AND fotomes.ano = fotomes_votos.ano) AND NOT (fotomes.mes = " & month(date()) & " AND fotomes.ano = " & year(date()) & ")"
	elseif id = "propostas" then
		if month(date()) = 1 then
			SQLW = "INNER JOIN foto_mes_proposta ON foto.id = foto_mes_proposta.foto "
			SQLW = SQLW & "WHERE foto_mes_proposta.mes = 12 AND foto_mes_proposta.ano = " & year(date()) - 1
		else
			SQLW = "INNER JOIN foto_mes_proposta ON foto.id = foto_mes_proposta.foto "
			SQLW = SQLW & "WHERE foto_mes_proposta.mes = " & month(date()) - 1 & " AND foto_mes_proposta.ano = " & year(date())
		end if
	elseif id = "propostas_anteriores" then
		SQLW = "INNER JOIN foto_mes_proposta ON foto.id = foto_mes_proposta.foto "
		SQLW = SQLW & "WHERE foto_mes_proposta.mes = " & request("mes") & " AND foto_mes_proposta.ano = " & request("ano")
		tipo = "fotomes_sqlw"
		session("sqlw") = SQLW
	end if
elseif tipo = "especial" then
	SQLW = "INNER JOIN galeria_especial_foto ON foto.id = galeria_especial_foto.foto WHERE galeria_especial_foto.galeria_especial = " & id
elseif tipo = "juri" then
	SQLW = "INNER JOIN juri_folder_foto ON foto.id = juri_folder_foto.foto WHERE folder = " & id
elseif tipo = "cronicas" then
	if id = "" then
		SQLW = "INNER JOIN cronicas ON foto.id = cronicas.foto WHERE cronicas.id > 0"
	else
		SQLW = "INNER JOIN cronicas ON foto.id = cronicas.foto WHERE foto.assunto = " & id
	end if
elseif tipo = "cronicas_mes" then
	if id = 1 then
		SQLW = "INNER JOIN cronicas ON foto.id = cronicas.foto WHERE cronicas.data >= #" & 12 & "/" & 1 & "/" & year(date()) - 1 & "# AND cronicas.data < #" & 1 & "/" & 1 & "/" & year(date()) & "#"
	else
		SQLW = "INNER JOIN cronicas ON foto.id = cronicas.foto WHERE cronicas.data >= #" & id - 1 & "/" & 1 & "/" & year(date()) & "# AND cronicas.data < #" & id & "/" & 1 & "/" & year(date()) & "#"
	end if
elseif tipo = "cronicas_vencedoras" then
	SQLW = "INNER JOIN destaque_cronica ON foto.id = destaque_cronica.foto WHERE destaque_cronica.id > 0"
elseif tipo = "temames" then
	SQLW = "INNER JOIN tema_mes_foto ON foto.id = tema_mes_foto.foto WHERE tema_mes_foto.tema_mes = " & id
elseif tipo = "preferidas" then
	if tema = -1 then
		SQLW = "INNER JOIN preferidas_fotos ON foto.id = preferidas_fotos.foto WHERE preferidas_fotos.autor = " & id & " AND foto.autor <> " & id
	else
		SQLW = "INNER JOIN preferidas_fotos ON foto.id = preferidas_fotos.foto WHERE preferidas_fotos.autor = " & id & " AND preferidas_fotos.folder = " & tema & " AND foto.autor <> " & id
	end if
elseif tipo = "preferidas_autor" then
	SQLW = "INNER JOIN preferidas_fotos ON foto.id = preferidas_fotos.foto WHERE preferidas_fotos.autor = " & id & " AND foto.autor = " & id
elseif tipo = "temames_escolhidas" then
	SQLW = "INNER JOIN tema_mes_foto ON foto.id = tema_mes_foto.foto WHERE tema_mes_foto.tema_mes = " & id & " AND tema_mes_foto.vencedora = true"
elseif tipo = "galeria_mes" then
	SQLW = "INNER JOIN destaque_galeria_foto ON foto.id = destaque_galeria_foto.foto WHERE destaque_galeria_foto.galeria_destaque = " & id
elseif tipo = "vencedoras_autor" then
	SQLW = "WHERE foto.autor = " & id & " AND ("
	SQLW = SQLW & "foto.id IN (SELECT foto FROM destaque_galeria_foto) OR "
	SQLW = SQLW & "foto.id IN (SELECT foto FROM tema_mes_foto WHERE vencedora = True) OR "
	SQLW = SQLW & "foto.id IN (SELECT foto FROM destaque_cronica) OR "
	SQLW = SQLW & "foto.id IN (SELECT foto FROM fotomes_votos as fotomes WHERE votos IN "
	SQLW = SQLW & "(SELECT DISTINCT TOP 3 votos FROM fotomes_votos WHERE fotomes.mes = fotomes_votos.mes AND fotomes.ano = fotomes_votos.ano ORDER BY votos DESC) AND "
	SQLW = SQLW & "NOT (fotomes.mes = " & month(date()) & " AND fotomes.ano = " & year(date()) & ")))"
elseif tipo = "associado" then
	SQLW = "INNER JOIN associados_galerias ON foto.id = associados_galerias.foto WHERE associados_galerias.associado = " & id & " AND associados_galerias.mes = " & request("mes") & " AND associados_galerias.ano = " & request("ano")
	tipo = "associados_sqlw"
	session("sqlw") = SQLW
elseif tipo = "busca" then
	' PROCURAR POR ID
	if id = "umid" then
		if isnumeric(request("idprocurado")) then
			SQLW = "WHERE foto.id = " & request("idprocurado")
		else
			SQLW = "WHERE id = 0"
		end if
	elseif id = "intervaloid" then
		if isnumeric(request("id1")) and isnumeric(request("id2")) then
			if clng(request("id1")) < clng(request("id2")) then
				SQLW = "WHERE foto.id >= " & request("id1") & " AND foto.id <= " & request("id2")
			else
				SQLW = "WHERE foto.id >= " & request("id2") & " AND foto.id <= " & request("id1")
			end if
		else
			SQLW = "WHERE id = 0"
		end if
	elseif id = "ateid" then
		if isnumeric(request("idprocurado")) then
			if request("desde") = 1 then
				SQLW = "WHERE foto.id <= " & request("idprocurado")
			elseif request("desde") = 2 then
				SQLW = "WHERE foto.id >= " & request("idprocurado")
			end if
		else
			SQLW = "WHERE id = 0"
		end if

	' PROCURAR POR DATAS
	elseif id = "umadata" then
		if isdate(request("mes") & "/" & request("dia") & "/" & request("ano")) then
			data = cdate(request("mes") & "/" & request("dia") & "/" & request("ano"))
			if request("assunto") <> "" then
				if request("assunto") > 0 then
					SQLW = "WHERE foto.data >= #" & data & "# AND foto.data < #" & data + 1 & "# AND foto.assunto = " & request("assunto")
				else
					' Anonimas
					SQLW = "WHERE foto.data >= #" & data & "# AND foto.data < #" & data + 1 & "# AND foto.anonima <> 0 AND foto.data > #" & cdate(date() & " " & time()) - 7 & "#"
				end if
			elseif request("autor") <> "" then
				SQLW = "WHERE foto.data >= #" & data & "# AND foto.data < #" & data + 1 & "# AND foto.autor = " & request("autor")
			else
				SQLW = "WHERE foto.data >= #" & data & "# AND foto.data < #" & data + 1 & "#"
			end if
		else
			SQLW = "WHERE id = 0"
		end if
	elseif id = "24horas" then
		data = date() - 1
		if request("assunto") <> "" then
			SQLW = "WHERE foto.data >= #" & data & "# AND foto.assunto = " & request("assunto")
		elseif request("autor") <> "" then
			SQLW = "WHERE foto.data >= #" & data & "# AND foto.autor = " & request("autor")
		end if
	elseif id = "intervalodata" then
		data1 = request("mes1") & "/" & request("dia1") & "/" & request("ano1")
		data2 = request("mes2") & "/" & request("dia2") & "/" & request("ano2")
	
		if isdate(data1) and isdate(data2) then
			if cdate(data1) < cdate(data2) then
				SQLW = "WHERE foto.data >= #" & data1 & "# AND foto.data <= #" & data2 & "#"
			else
				SQLW = "WHERE foto.data >= #" & data2 & "# AND foto.data <= #" & data1 & "#"
			end if
		else
			SQLW = "WHERE id = 0"
		end if
	elseif id = "atedata" then
		if isdate(request("mes") & "/" & request("dia") & "/" & request("ano")) then
			if request("desde") = 1 then
				SQLW = "WHERE foto.data <= #" & request("mes") & "/" & request("dia") & "/" & request("ano") & "#"
			elseif request("desde") = 2 then
				SQLW = "WHERE foto.data >= #" & request("mes") & "/" & request("dia") & "/" & request("ano") & "#"
			end if
		else
			SQLW = "WHERE id = 0"
		end if

	' PROCURAR POR DADOS
	elseif id = "dados" then
		SQLW = "WHERE true"
		if request("titulo") <> "" then
			SQLW = SQLW & " AND foto.titulo LIKE '%" & sqltext(replace(request("titulo"), " ", "%")) & "%'"
		end if
		if request("lugar") <> "" then
			SQLW = SQLW & " AND foto.lugar LIKE '%" & sqltext(replace(request("lugar"), " ", "%")) & "%'"
		end if
		if request("maquina") <> "" then
			SQLW = SQLW & " AND foto.maquina LIKE '%" & sqltext(replace(request("maquina"), " ", "%")) & "%'"
		end if
		if request("lente") <> "" then
			SQLW = SQLW & " AND foto.lente LIKE '%" & sqltext(replace(request("lente"), " ", "%")) & "%'"
		end if
		if request("filme") <> "" then
			SQLW = SQLW & " AND foto.filme LIKE '%" & sqltext(replace(request("filme"), " ", "%")) & "%'"
		end if
		if request("filtros") <> "" then
			SQLW = SQLW & " AND foto.filtros LIKE '%" & sqltext(replace(request("filtros"), " ", "%")) & "%'"
		end if
		if request("flash") <> "" then
			SQLW = SQLW & " AND foto.flash LIKE '%" & sqltext(replace(request("flash"), " ", "%")) & "%'"
		end if
		if request("velocidade") <> "" then
			SQLW = SQLW & " AND foto.velocidade LIKE '%" & sqltext(replace(request("velocidade"), " ", "%")) & "%'"
		end if
		if request("abertura") <> "" then
			SQLW = SQLW & " AND foto.abertura LIKE '%" & sqltext(replace(request("abertura"), " ", "%")) & "%'"
		end if
	end if
	
	tipo = "busca_sqlw"
	session("sqlw") = SQLW
elseif (tipo = "busca_sqlw") or (tipo = "associados_sqlw") or (tipo = "fotomes_sqlw") then
	SQLW = session("sqlw")
	session("sqlw") = SQLW
end if

if ((tipo = "autor") and (id = session("login"))) or (session("login") = 2) then
else
	SQLW = SQLW & " AND foto.moderar = False "
end if
%>