<%
' Copyright: (c) 1999-2023, Tiago Fonseca
' GNU General Public License v3.0+ (see LICENSE.md or https://www.gnu.org/licenses/gpl-3.0.html)
' SPDX-License-Identifier: GPL-3.0-or-later
%>

<!-- #include file="sqltext.asp" -->
<!-- #include file="funcoes_principais.asp" -->

<%
autor = request("autor")

AutenticarMembro(autor)
Menu 3, 2, "MUDAR DADOS DE MEMBRO"
%>

<%
SQL = "SELECT * FROM autor WHERE id = " & autor
Set autorRes = dbConnection.Execute(SQL)

SQL = "SELECT * FROM autor_opcoes WHERE autor = " & autor
Set autorOpcoesRes = dbConnection.Execute(SQL)

SQL = "SELECT id, nome_pt FROM paises_todos ORDER BY nome"
Set paisRes = dbConnection.Execute(SQL)
%>

<form action="mudar_autor_res.asp?autor=<% =autor %>" method=post>

<table border="0" cellpadding="3" cellspacing="0">
	<tr>
		<td><font color="#FFCC66" size="-1" face="arial"><b>NOME COMPLETO:</b></font></td>
		<td>
			<input value="<% =autorRes("nome_real") %>" maxlength="255" size="40" type="Text" name="nome_real"> 
			<select name="esconder_real">
				<option value="0">Dispon&iacute;vel</option>
				<% if autorRes("esconder_real") = true then %>
					<option selected value="1">Esconder</option>
				<% else %>
					<option value="1">Esconder</option>
				<% end if %>
			</select>
			<font size="-1" color="white" face="arial">(obrig)</font><br>
			<font size="-2" color="white" face="arial">(Obrigat�rio escrever o nome <b>real</b> completo, n�o abreviado)</font>
		</td>
	</tr>
	<tr>
		<td><font color="#FFCC66" size="-1" face="arial"><b>NOME NO SITE:<br><font color="white" size="-2">(NOME ART�STICO)</font></font></td>
		<td>
			<input maxlength="255" value="<% =autorRes("nome") %>" size="40" type="Text" name="nome"> <font size="-1" color="white" face="arial">(obrig)</font><br>
			<font size="-2" color="white" face="arial">(Nome pelo qual ser� identificado perante os outros membros, pode ser igual ao nome completo)</font>
		</td>
	</tr>
	<tr><td><br></td><td></td></tr>	
	<tr><td><font size="-1" color="#FFCC66" face="arial"><b>PASSWORD:</b></font><br><font face="arial" color="white" size="-2">(PALAVRA CHAVE)</font></td><td><input maxlength="255" value="" size="15" type="password" name="password1"> <font size="-1" color="white" face="arial">(deixar em branco para n�o alterar a actual)</font></td></tr>
	<tr><td><font size="-1" color="#FFCC66" face="arial"><b>CONFIRMAR<br>PASSWORD: </b></font></td><td><input maxlength="255" value="" size="15" type="password" name="password2"> <font size="-1" color="white" face="arial">(deixar em branco para n�o alterar a actual)</font></td></tr>
	<tr><td><br></td><td></td></tr>
	<% if autorRes("home_page") <> "" then %>
		<tr><td><font size="-1" color="#FFCC66" face="arial"><b>HOMEPAGE: </b></font></td><td><input maxlength="255" value="<% =Aspas2Quot(autorRes("home_page")) %>" size="40" type="Text" name="homepage"></td></tr>
	<% else %>
		<tr><td><font size="-1" color="#FFCC66" face="arial"><b>HOMEPAGE: </b></font></td><td><input maxlength="255" value="http://" size="40" type="Text" name="homepage"></td></tr>	
	<% end if %>
	<tr>
		<td><font size="-1" color="#FFCC66" face="arial"><b>E-MAIL: </b></font></td>
		<td>
			<input maxlength="255" value="<% =Aspas2Quot(autorRes("email")) %>" size="40" type="Text" name="email"> 
			<select name="mostrar">
				<option value="1">Dispon&iacute;vel</option>
				<% if autorRes("mostrar_email") = False then %>
					<option selected value="0">Esconder</option>
				<% else %>
					<option value="0">Esconder</option>
				<% end if %>
			</select>
			<font size="-1" color="white" face="arial">(obrig)</font>
		</td>
	</tr>
	<tr><td><br></td><td></td></tr>
	<tr><td><font size="-1" color="#FFCC66" face="arial"><b>PROFISS&Atilde;O: </b></font></td><td><input maxlength="255" value="<% =Aspas2Quot(autorRes("profissao")) %>" size="40" type="Text" name="profissao"></td></tr>
	<tr><td><font color="#FFCC66" size="-1" face="arial"><b>REGI&Atilde;O DO PA&Iacute;S: </b></font></td><td><input value="<% =autorRes("regiao") %>" maxlength="255" size="40" type="Text" name="regiao"></td></tr>
	<tr>
		<td><font size="-1" color="#FFCC66" face="arial"><b>PA&Iacute;S: </b></font></td>
		<td><select name="pais">
			<% do while not paisRes.eof %>
				<% if paisRes("id") = autorRes("pais") then %>
					<option selected value="<% =paisRes("id") %>"><% =paisRes("nome_pt") %></option>
				<% else %>
					<option value="<% =paisRes("id") %>"><% =paisRes("nome_pt") %></option>
				<% end if %>
				<% paisRes.MoveNext %>
			<% loop %>
		</select> <font size="-1" color="white" face="arial">(obrig)</font></td>
	</tr>
	<tr>
		<td>
			<font size="-1" color="#FFCC66" face="arial"><b>DATA NASCIMENTO: </b></font>
			<font size="-1" color="white" face="arial"><br>(dia/m�s/ano ou nada)</font>
		</td>
		<td>
			<input value="<% =day(autorRes("data_nascimento")) %>" maxlength="2" type="Text" size="3" name="dia">
			<select name="mes">
				<option value="0"></option>
				<option <% if month(autorRes("data_nascimento")) = 1 then %>selected<% end if %> value="1">Janeiro</option>
				<option <% if month(autorRes("data_nascimento")) = 2 then %>selected<% end if %> value="2">Fevereiro</option>
				<option <% if month(autorRes("data_nascimento")) = 3 then %>selected<% end if %> value="3">Mar&ccedil;o</option>
				<option <% if month(autorRes("data_nascimento")) = 4 then %>selected<% end if %> value="4">Abril</option>
				<option <% if month(autorRes("data_nascimento")) = 5 then %>selected<% end if %> value="5">Maio</option>
				<option <% if month(autorRes("data_nascimento")) = 6 then %>selected<% end if %> value="6">Junho</option>
				<option <% if month(autorRes("data_nascimento")) = 7 then %>selected<% end if %> value="7">Julho</option>
				<option <% if month(autorRes("data_nascimento")) = 8 then %>selected<% end if %> value="8">Agosto</option>
				<option <% if month(autorRes("data_nascimento")) = 9 then %>selected<% end if %> value="9">Setembro</option>
				<option <% if month(autorRes("data_nascimento")) = 10 then %>selected<% end if %> value="10">Outubro</option>
				<option <% if month(autorRes("data_nascimento")) = 11 then %>selected<% end if %> value="11">Novembro</option>
				<option <% if month(autorRes("data_nascimento")) = 12 then %>selected<% end if %> value="12">Dezembro</option>
			</select>
			<input value="<% =year(autorRes("data_nascimento")) %>" maxlength="4" type="Text" size="5" name="ano">
			<select name="mostrar_data_nascimento">
				<option <% if autorRes("mostrar_data_nascimento") = false then %>selected<% end if %> value="0">Mostrar s� a idade (esconder data)</option>
				<option <% if autorRes("mostrar_data_nascimento") = true then %>selected<% end if %> value="1">Mostrar idade e a data</option>
			</select>
		</td>
	</tr>
	<tr><td><br></td><td></td></tr>
	<tr><td><font size="-1" color="#FFCC66" face="arial"><b>APRESENTA&Ccedil;&Atilde;O: </b></font><font size="-1" color="white" face="arial"><br>(se escrever<br>mais do que 20<br>linhas o texto<br>ser&aacute; cortado)</font></td><td><textarea name="apresentacao" cols="46" rows="6" wrap="VIRTUAL"><% =autorRes("apresentacao") %></textarea></td></tr>
	<tr><td><br></td><td></td></tr>	
	<tr><td><font color="#FFCC66" size="-1" face="arial"><b>COMO DESCOBRIU<br>ESTE SITE?: </b></font></td><td><input maxlength="255" size="40" type="Text" value="<% =Aspas2Quot(autorRes("como_chegou_ca")) %>" name="como_chegou_ca"></td></tr>
	<tr><td><br></td><td></td></tr>		
	<tr><td><font color="#FFCC66" size="-1" face="arial"><b>OP&Ccedil;&Otilde;ES<br>AVAN&Ccedil;ADAS: </b></font><br><font color="white" size="-1" face="arial">(se n&atilde;o as percebe<br>o melhor &eacute; n&atilde;o mudar<br>estas op&ccedil;&otilde;es)</font></td><td>
		<table border="1" cellpadding="10" cellspacing="0"><tr><td>
			<table border="0" cellpadding="2" cellspacing="0">
			<tr>
				<td><font size="-1" color="#FFCC66" face="arial"><b>APROVA��O DE<br>COMENT�RIOS: </b></font></td>
				<td><font size="-1" color="white" face="arial">os coment�rios �s minhas fotos e � minha ficha s�o </font> <select name="aprovacao">
					<option <% if autorOpcoesRes("aprovacao") = "0" then %>selected<% end if %> value="0">s� mostrados depois de aprovados por mim</option>
					<option <% if autorOpcoesRes("aprovacao") = "1" then %>selected<% end if %> value="1">mostrados de imediato com modera��o posterior</option>
				</select></td>
			</tr>
			<% if session("login") = 2 then %>
				<tr>
					<td><font size="-1" color="#FFCC66" face="arial"><b>FOTOS DE<br>CARACTER<br>SENS�VEL: </b></font></td>
					<td><font size="-1" color="white" face="arial">imagens de caracter sensivel (nudez e viol�ncia) </font> <select name="sensiveis">
						<option <% if autorOpcoesRes("sensiveis") = "0" then %>selected<% end if %> value="0">s�o ocultadas</option>
						<option <% if autorOpcoesRes("sensiveis") = "1" then %>selected<% end if %> value="1">s�o mostradas</option>
					</select><font size="-1" color="white" face="arial"> quando vejo as galerias.</font></td>
				</tr>
			<% end if %>
			<tr>
				<td><font size="-1" color="#FFCC66" face="arial"><b>NOVIDADES: </b></font></td>
				<td><font size="-1" color="white" face="arial">mostrar todas desde o in&iacute;cio </font> <select name="tipo_novidades">
					<option <% if autorOpcoesRes("tipo_novidades") = "6" then %>selected<% end if %> value="6">do segundo</option>
					<option <% if autorOpcoesRes("tipo_novidades") = "5" then %>selected<% end if %> value="5">do minuto</option>
					<option <% if autorOpcoesRes("tipo_novidades") = "4" then %>selected<% end if %> value="4">da hora</option>
					<option <% if autorOpcoesRes("tipo_novidades") = "3" then %>selected<% end if %> value="3">do dia</option>
				</select> <font size="-1" color="white" face="arial">do login anterior</font></td>
			</tr>
			<tr>
				<td><font size="-1" color="#FFCC66" face="arial"><b>FOTOS NAS<br>GALERIAS: </b></font></td>
				<td><font size="-1" color="white" face="arial">cada p&aacute;gina da galeria mostra </font> <select name="fotos_por_galeria">
					<option <% if autorOpcoesRes("fotos_por_galeria") = "1" then %>selected<% end if %> value="1">2x3 fotos (800x600)</option>
					<option <% if autorOpcoesRes("fotos_por_galeria") = "2" then %>selected<% end if %> value="2">2x4 fotos (1024x768)</option>
					<option <% if autorOpcoesRes("fotos_por_galeria") = "7" then %>selected<% end if %> value="7">3x3 fotos (1024x768)</option>
					<option <% if autorOpcoesRes("fotos_por_galeria") = "3" then %>selected<% end if %> value="3">3x4 fotos (1024x768)</option>
					<option <% if autorOpcoesRes("fotos_por_galeria") = "4" then %>selected<% end if %> value="4">2x5 fotos (1152x864)</option>
					<option <% if autorOpcoesRes("fotos_por_galeria") = "5" then %>selected<% end if %> value="5">3x5 fotos (1152x864)</option>
					<option <% if autorOpcoesRes("fotos_por_galeria") = "8" then %>selected<% end if %> value="8">4x3 fotos (1280x1024)</option>
					<option <% if autorOpcoesRes("fotos_por_galeria") = "9" then %>selected<% end if %> value="9">4x4 fotos (1280x1024)</option>
					<option <% if autorOpcoesRes("fotos_por_galeria") = "6" then %>selected<% end if %> value="6">4x5 fotos (1280x1024)</option>
				</select><br><font size="-1" color="white" face="arial">(resolu&ccedil;&atilde;o m&iacute;nima aconselhada entre par&ecirc;ntesis)</font></td>
			</tr>
			<tr>
				<td><font size="-1" color="#FFCC66" face="arial"><b>FICHA DE<br>FOTO: </b></font></td>
				<td><font size="-1" color="white" face="arial">mostrar fotos com </font> <select name="ficha_foto">
					<option <% if autorOpcoesRes("ficha_foto") = "1" then %>selected<% end if %> value="1">ficha resumida</option>
					<option <% if autorOpcoesRes("ficha_foto") = "2" then %>selected<% end if %> value="2">ficha completa</option>
				</select></td>
			</tr>
			</table>
		</td></tr></table>
	</td></tr>
	<tr><td><br></td><td></td></tr>		
	<tr><td></td><td><input type="Submit" value="Mudar dados">&nbsp;&nbsp;<input type="Reset"></td></tr>
</table>
</form>

<% FimPagina() %>