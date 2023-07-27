<%
	' Comentario a fotos de eventos
	SQL = "DELETE FROM eventos_fotopt_comentarios WHERE autor = " & autor
	dbConnection.Execute(SQL)

	' Comentario a fotos
	SQL = "DELETE FROM comentario WHERE autor = " & autor
	dbConnection.Execute(SQL)

	' Comentario apagados a fotos
	SQL = "DELETE FROM comentario_apagado WHERE autor = " & autor
	dbConnection.Execute(SQL)

	' Comentario apagados a fotos dele
	SQL = "DELETE FROM comentario_apagado WHERE autor_foto = " & autor
	dbConnection.Execute(SQL)

	' Comentarios a autores
	SQL = "DELETE FROM comentario_autor WHERE comentador = " & autor
	dbConnection.Execute(SQL)

	' Comentarios a este autor
	SQL = "DELETE FROM comentario_autor WHERE autor = " & autor
	dbConnection.Execute(SQL)

	' Comentarios a autores
	SQL = "DELETE FROM comentario_autor_apagado WHERE comentador = " & autor
	dbConnection.Execute(SQL)

	' Comentarios a este autor
	SQL = "DELETE FROM comentario_autor_apagado WHERE autor = " & autor
	dbConnection.Execute(SQL)
	
	' Candidato a emprego
	SQL = "DELETE FROM emprego_candidato WHERE autor = " & autor
	dbConnection.Execute(SQL)

	' Oportunidade de emprego
	SQL = "DELETE FROM emprego_oportunidade WHERE autor = " & autor
	dbConnection.Execute(SQL)

	' Evento
	SQL = "UPDATE evento SET autor = '2' WHERE autor = " & autor
	dbConnection.Execute(SQL)

	' Folder
	SQL = "DELETE FROM folder WHERE autor = " & autor
	dbConnection.Execute(SQL)
	
	' Foto do mes
	SQL = "SELECT id, foto FROM foto_mes WHERE autor = " & autor
	Set fotoMesRes = dbConnection.Execute(SQL)
	
	do while not fotoMesRes.eof
		SQL = "DELETE FROM foto_mes WHERE id = " & fotoMesRes("id")
		dbConnection.Execute(SQL)

		fotoMesRes.MoveNext
	loop

	' Links
	SQL = "UPDATE links SET autor = '2' WHERE autor = " & autor
	dbConnection.Execute(SQL)

	' Livros
	SQL = "DELETE FROM livros WHERE autor = " & autor
	dbConnection.Execute(SQL)

	' Contactos
	SQL = "DELETE FROM contactos WHERE autor = " & autor
	dbConnection.Execute(SQL)
	
	' Procura artigo
	SQL = "DELETE FROM procura_artigo WHERE autor = " & autor
	dbConnection.Execute(SQL)

	' Venda artigo
	SQL = "DELETE FROM venda_artigo WHERE autor = " & autor
	dbConnection.Execute(SQL)

	' Votacao votos
	SQL = "SELECT id, item FROM votacao_voto WHERE autor = " & autor
	Set votosRes = dbConnection.Execute(SQL)
	
	do while not votosRes.eof
		SQL = "SELECT id, votos FROM votacao_item WHERE id = " & votosRes("item")
		Set itemRes = dbConnection.Execute(SQL)

		SQL = "UPDATE votacao_item SET votos = '" & itemRes("votos") - 1 & "' WHERE id = " & itemRes("id")
		dbConnection.Execute(SQL)
		
		SQL = "DELETE FROM votacao_voto WHERE id = " & votosRes("id")
		dbConnection.Execute(SQL)
		
		votosRes.MoveNext
	loop
	
	' Votacao item
	SQL = "SELECT id FROM votacao_item WHERE autor = " & autor
	Set itemRes = dbConnection.Execute(SQL)
	
	do while not itemRes.eof
		SQL = "UPDATE votacao_item SET autor = '2' WHERE id = " & itemRes("id")
		dbConnection.Execute(SQL)
		
		itemRes.MoveNext
	loop

	' Votacao topico
	SQL = "SELECT id FROM votacao_topico WHERE autor = " & autor
	Set topicoRes = dbConnection.Execute(SQL)
	
	do while not topicoRes.eof
		SQL = "UPDATE votacao_topico SET autor = '2' WHERE id = " & topicoRes("id")
		dbConnection.Execute(SQL)
		
		topicoRes.MoveNext
	loop

	' Opiniao
	SQL = "SELECT id, artigo, classificacao FROM opiniao WHERE autor = " & autor
	Set opiniaoRes = dbConnection.Execute(SQL)
	
	do while not opiniaoRes.eof
		SQL = "SELECT valor FROM opiniao_classificacao WHERE id = " & opiniaoRes("classificacao")
		Set classificacaoRes = dbConnection.Execute(SQL)

		SQL = "SELECT soma_opinioes, num_opinioes, media_opinioes FROM opiniao_artigo WHERE id = " & opiniaoRes("artigo")
		Set artigoRes = dbConnection.Execute(SQL)

		if artigoRes("num_opinioes") > 1 then
			SQL = "UPDATE opiniao_artigo SET soma_opinioes = '" & artigoRes("soma_opinioes") - classificacaoRes("valor")
			SQL = SQL & "', num_opinioes = '" & artigoRes("num_opinioes") - 1
			SQL = SQL & "', media_opinioes = '" & (artigoRes("soma_opinioes") - classificacaoRes("valor")) / (artigoRes("num_opinioes") - 1)
			SQL = SQL & "' WHERE id = " & opiniaoRes("artigo")
			dbConnection.Execute(SQL)
		else
			SQL = "UPDATE opiniao_artigo SET soma_opinioes = '0', num_opinioes = '0', media_opinioes = '0' WHERE id = " & opiniaoRes("artigo")
			dbConnection.Execute(SQL)
		end if		

		SQL = "DELETE FROM opiniao WHERE id = " & opiniaoRes("id")
		dbConnection.Execute(SQL)
		
		opiniaoRes.MoveNext
	loop

	' Artigos opiniao
	SQL = "SELECT id FROM opiniao_artigo WHERE autor = " & autor
	Set artigoRes = dbConnection.Execute(SQL)
	
	do while not artigoRes.eof
		SQL = "UPDATE opiniao_artigo SET autor = '2' WHERE id = " & artigoRes("id")
		dbConnection.Execute(SQL)
		
		artigoRes.MoveNext
	loop

	' Fotos
	Set fileSystem = CreateObject("Scripting.FileSystemObject")
	
	SQL = "SELECT id FROM foto WHERE autor = " & autor
	Set fotoRes = dbConnection.Execute(SQL)
	
	do while not fotoRes.eof
		directoria = int(fotoRes("id") / 1000)

		if fileSystem.FileExists("c:\inetpub\wwwroot\foto\fotos\fotos\" & directoria & "\foto" & fotoRes("id") & ".jpg") then
			fileSystem.DeleteFile "c:\inetpub\wwwroot\foto\fotos\fotos\" & directoria & "\foto" & fotoRes("id") & ".jpg"
		end if
		if fileSystem.FileExists("c:\inetpub\wwwroot\foto\fotos\thumbs\" & directoria & "\thumbs" & fotoRes("id") & ".jpg") then
			fileSystem.DeleteFile "c:\inetpub\wwwroot\foto\fotos\thumbs\" & directoria & "\thumbs" & fotoRes("id") & ".jpg"
		end if

		' Novas
		if fileSystem.FileExists("c:\inetpub\wwwroot\foto\fotos\trocar\foto" & fotoRes("id") & ".jpg") then
			fileSystem.DeleteFile "c:\inetpub\wwwroot\foto\fotos\trocar\foto" & fotoRes("id") & ".jpg"
		end if
		if fileSystem.FileExists("c:\inetpub\wwwroot\foto\fotos\trocar\thumbs" & fotoRes("id") & ".jpg") then
			fileSystem.DeleteFile "c:\inetpub\wwwroot\foto\fotos\trocar\thumbs" & fotoRes("id") & ".jpg"
		end if

		SQL = "DELETE FROM comentario WHERE foto = " & fotoRes("id")
		dbConnection.Execute(SQL)

		SQL = "DELETE FROM foto_mes WHERE foto = " & fotoRes("id")
		dbConnection.Execute(SQL)

		SQL = "DELETE FROM fotomes_votos WHERE foto = " & fotoRes("id")
		dbConnection.Execute(SQL)

		SQL = "DELETE FROM foto_mes_proposta WHERE foto = " & fotoRes("id")
		dbConnection.Execute(SQL)

		SQL = "DELETE FROM tema_mes_foto WHERE foto = " & fotoRes("id")
		dbConnection.Execute(SQL)

		SQL = "DELETE FROM juri_folder_foto WHERE foto = " & fotoRes("id")
		dbConnection.Execute(SQL)

		SQL = "DELETE FROM destaque_galeria_foto WHERE foto = " & fotoRes("id")
		dbConnection.Execute(SQL)

		SQL = "DELETE FROM cronicas WHERE foto = " & fotoRes("id")
		dbConnection.Execute(SQL)

		SQL = "DELETE FROM preferidas_fotos WHERE foto = " & fotoRes("id")
		dbConnection.Execute(SQL)

		SQL = "DELETE FROM associados_galerias WHERE foto = " & fotoRes("id")
		dbConnection.Execute(SQL)

'		SQL = "DELETE FROM foto_membro WHERE foto = " & fotoRes("id")
'		dbConnection.Execute(SQL)
		
		SQL = "DELETE FROM foto WHERE id = " & fotoRes("id")
		dbConnection.Execute(SQL)

		fotoRes.MoveNext
	loop

	' Fotos de eventos do site
	SQL = "SELECT id FROM eventos_fotopt_foto WHERE autor = " & autor
	Set fotoRes = dbConnection.Execute(SQL)
	
	do while not fotoRes.eof
		directoria = int(fotoRes("id") / 1000)

		if fileSystem.FileExists("c:\inetpub\wwwroot\foto\fotos\arquivo\eventos_fotopt\fotos\" & directoria & "\foto" & fotoRes("id") & ".jpg") then
			fileSystem.DeleteFile "c:\inetpub\wwwroot\foto\fotos\arquivo\eventos_fotopt\fotos\" & directoria & "\foto" & fotoRes("id") & ".jpg"
		end if
		if fileSystem.FileExists("c:\inetpub\wwwroot\foto\fotos\arquivo\eventos_fotopt\thumbs\" & directoria & "\thumbs" & fotoRes("id") & ".jpg") then
			fileSystem.DeleteFile "c:\inetpub\wwwroot\foto\fotos\arquivo\eventos_fotopt\thumbs\" & directoria & "\thumbs" & fotoRes("id") & ".jpg"
		end if

		SQL = "DELETE FROM eventos_fotopt_comentarios WHERE foto = " & fotoRes("id")
		dbConnection.Execute(SQL)

		SQL = "DELETE FROM eventos_fotopt_foto WHERE id = " & fotoRes("id")
		dbConnection.Execute(SQL)

		fotoRes.MoveNext
	loop

	' Debates
	SQL = "SELECT id, assunto FROM debate_mensagem WHERE autor = " & autor
	Set mensagemRes = dbConnection.Execute(SQL)
	
	do while not mensagemRes.eof
		ApagaSubMensagens mensagemRes("id"), mensagemRes("assunto")
		mensagemRes.MoveNext
	loop

	' Retrato
	if fileSystem.FileExists("c:\inetpub\wwwroot\foto\fotos\retratos\retrato" & autor & ".jpg") then
		fileSystem.DeleteFile "c:\inetpub\wwwroot\foto\fotos\retratos\retrato" & autor & ".jpg"
	end if

	Set fileSystem = Nothing
	
	' Autor mes
	SQL = "DELETE FROM autor_mes WHERE autor = " & autor
	dbConnection.Execute(SQL)

	' Autor mencao honrosa
	SQL = "DELETE FROM autor_mencao_honrosa WHERE autor = " & autor
	dbConnection.Execute(SQL)

	' Juri autor mes
	SQL = "DELETE FROM juri_autor_mes WHERE autor = " & autor
	dbConnection.Execute(SQL)

	' Juri autor mencao honrosa
	SQL = "DELETE FROM juri_autor_mencao_honrosa WHERE autor = " & autor
	dbConnection.Execute(SQL)

	' Camera de mao em mao
	SQL = "DELETE FROM pam_membros_inscritos WHERE autor = " & autor
	dbConnection.Execute(SQL)

	' Mensagens do webmaster
	SQL = "DELETE FROM avisos_webmaster WHERE autor = " & autor
	dbConnection.Execute(SQL)

	' Lista negra
	SQL = "DELETE FROM lista_negra WHERE autor = " & autor
	dbConnection.Execute(SQL)

	' Clones
	SQL = "DELETE FROM clones WHERE autor1 = " & autor & " OR autor2 = " & autor
	dbConnection.Execute(SQL)

	' Preferidas
	SQL = "DELETE FROM preferidas_fotos WHERE autor = " & autor
	dbConnection.Execute(SQL)

	' Autores Preferidos
	SQL = "DELETE FROM preferido_autor WHERE autor = " & autor
	dbConnection.Execute(SQL)

	' Autores que preferem este autor
	SQL = "DELETE FROM preferido_autor WHERE autor_preferido = " & autor
	dbConnection.Execute(SQL)

	' Autor opcoes
	SQL = "DELETE FROM autor_opcoes WHERE autor = " & autor
	dbConnection.Execute(SQL)

	' Autor
	SQL = "DELETE FROM autor WHERE id = " & autor
	dbConnection.Execute(SQL)
%>