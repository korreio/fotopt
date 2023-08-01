<!-- #include file="inicio_basedados.asp" -->

<%
Dim letra
letra = Array("A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z")
%>

<!-- #include file="autenticar_webmaster.asp" -->
<!-- #include file="../sqltext.asp" -->

<html>
<head>
  <title>Administra&ccedil;&atilde;o do foto@pt</title>
</head>
<body>

<a href="adm_nao_confirmados.asp">N&Atilde;O CONFIRMADOS E CONGELADOS</a><br><br>

CONFIRMADOS</a><br>
<font size="-1">POR NOME</font> - 
<% for i = 0 to 25 %>
	<font size="-1"><a href="adm_confirmados.asp?letra=<% =letra(i) %>"><b><% =letra(i) %></b></a></font>
<% next %>
<font size="-1"><a href="adm_confirmados.asp"><b>TODOS</b></a></font>
<br>

<font size="-1">POR NICK</font> - 
<% for i = 0 to 25 %>
	<font size="-1"><a href="adm_confirmados_nick.asp?letra=<% =letra(i) %>"><b><% =letra(i) %></b></a></font>
<% next %>
<font size="-1"><a href="adm_confirmados_nick.asp"><b>TODOS</b></a></font>

<br><br>
<a href="fotos_trocadas.asp">FOTOS TROCADAS</a>
<br><a href="fotos_moderar.asp">FOTOS A MODERAR</a>
<br><a href="fotos_eventos_moderar.asp">FOTOS DE EVENTOS A MODERAR</a>
<br><a href="adm_nome_real_alterado.asp">NOME REAL ALTERADO</a>
<br><a href="adm_login_antigo.asp">ÚLTIMO LOGIN À MAIS DE 3 MESES</a>

<br><br>
<a href="adm_avisos.asp">MENSAGENS</a>
<br><a href="adm_lista_negra.asp">LISTA NEGRA</a>
<br><a href="adm_so_foto_mes.asp">FOTO DO M&Ecirc;S</a>

<br><br>
<a href="adm_mesmo_ssuid.asp">MESMO SSUID</a>
<br><a href="adm_calc_clones.asp">CALCULAR CLONES</a>
<br><a href="adm_clones.asp">MOSTRAR CLONES</a>

<br><br>
<font size="-1">COMENTÁRIOS A FOTOS APAGADOS</font>
&nbsp;&nbsp;<a href="adm_comentarios_apagados_por.asp">POR</a>
&nbsp;&nbsp;<a href="adm_comentarios_apagados_de.asp">DE</a>
<br>
<font size="-1">COMENTÁRIOS A AUTORES APAGADOS</font>
&nbsp;&nbsp;<a href="adm_comentarios_autor_apagados_por.asp">POR</a>
&nbsp;&nbsp;<a href="adm_comentarios_autor_apagados_de.asp">DE</a>

<br><br>
<font size="-1">COMENTÁRIOS A FOTOS POR APROVAR</font>
&nbsp;&nbsp;<a href="adm_comentarios_aprovar_por.asp">POR</a>
&nbsp;&nbsp;<a href="adm_comentarios_aprovar_de.asp">DE</a>
<br>
<font size="-1">COMENTÁRIOS A AUTORES POR APROVAR</font>
&nbsp;&nbsp;<a href="adm_comentarios_autor_aprovar_por.asp">POR</a>
&nbsp;&nbsp;<a href="adm_comentarios_autor_aprovar_de.asp">DE</a>

<br><br>
<a href="search/admin.php">INDEXAR SITE</a>
<br><a href="search/index.php">TESTAR BUSCA</a>

<br><br>
<a href="../logs/completo/">LOG COMPLETO</a>
&nbsp;&nbsp;<a href="../logs/mes/">MES</a>
&nbsp;&nbsp;<a href="../logs/semana/">SEMANA</a>
&nbsp;&nbsp;<a href="../logs/ontem/">ONTEM</a>
&nbsp;&nbsp;<a href="../logs/hoje/">HOJE</a>
&nbsp;&nbsp;<a href="../logs/referers/">REFERERS</a>
&nbsp;&nbsp;<a href="../logs/tecnico/">TÉCNICO</a>

</body>
</html>

<% end if %>
<!-- #include file="fim_basedados.asp" -->