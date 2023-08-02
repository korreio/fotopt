<%
' Copyright: (c) 1999-2023, Tiago Fonseca
' GNU General Public License v3.0+ (see LICENSE.md or https://www.gnu.org/licenses/gpl-3.0.html)
' SPDX-License-Identifier: GPL-3.0-or-later
%>

<%
function CheckNick(s)
	dim tmp
	tmp = s

	' codigos de erro
	' 1 - nulo
	' 2 - primeiro caracter nao e' do abecedario
	' 3 - caracteres invalidos
	' 4 - espaco ou tracos no fim
	' 5 - menor que 4 caracteres
	' 6 - dois espacos seguidos

	if not isnull(tmp) then
		primeiro = asc(left(tmp, 1))
		ultimo = asc(right(tmp, 1))

		erro = false
	    for i = 1 To len(tmp) 
			este = Asc(Mid(s, i, 1))
			if not ( _
				   ((este >= 97) and (este <= 122)) or _
				   ((este >= 65) and (este <= 90)) or _
				   (este = 32) or _
				   (este = 39) or _
				   (este = 45) or _
				   (este = 46) or _
				   (este = 40) or _
				   (este = 41) or _
				   (este = 255) or _
				   ((este >= 192) and (este <= 214)) or _
				   ((este >= 216) and (este <= 221)) or _
				   ((este >= 223) and (este <= 246)) or _
				   ((este >= 248) and (este <= 253)) _
				   ) then
				erro = true
			end if
		next
			
		if erro = true then
			checknick = 3
		elseif (primeiro = 32) or (primeiro = 45) or (primeiro = 39) or (primeiro = 46) then
			checknick = 2
		elseif (ultimo = 32) or (ultimo = 45) or (ultimo = 39) then
			checknick = 4
		elseif len(replace(replace(replace(replace(tmp, ".", ""), "'", ""), "-", ""), " ", "")) < 4 then
			checknick = 5
		elseif instr(tmp, "  ") or instr(tmp, "--") or instr(tmp, "''") or instr(tmp, "..") or instr(tmp, "((") or instr(tmp, "))") then
			checknick = 6
		else
			checknick = 0
		end if
	else
		' Nulo
		CheckNick = 1
	end if
end function

function LimparAcentos(str)
	s = lcase(str)

	s = replace(s, "�", "a")
	s = replace(s, "�", "a")
	s = replace(s, "�", "a")
	s = replace(s, "�", "a")
	s = replace(s, "�", "a")

	s = replace(s, "�", "e")
	s = replace(s, "�", "e")
	s = replace(s, "�", "e")
	s = replace(s, "�", "e")

	s = replace(s, "�", "i")
	s = replace(s, "�", "i")
	s = replace(s, "�", "i")
	s = replace(s, "�", "i")

	s = replace(s, "�", "o")
	s = replace(s, "�", "o")
	s = replace(s, "�", "o")
	s = replace(s, "�", "o")
	s = replace(s, "�", "o")

	s = replace(s, "�", "u")
	s = replace(s, "�", "u")
	s = replace(s, "�", "u")
	s = replace(s, "�", "u")

	s = replace(s, "�", "c")

	limpo = ""
    for i = 1 To len(s) 
		caracter = Mid(s, i, 1)
		if (caracter <> ".") and (caracter <> "-") and (caracter <> "'") and (caracter <> " ") and (caracter <> "(") and (caracter <> ")") then
			limpo = limpo & caracter
		end if
	next

	LimparAcentos = limpo
end function
%>