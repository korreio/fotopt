<%
' Copyright: (c) 1999-2023, Tiago Fonseca
' GNU General Public License v3.0+ (see LICENSE.md or https://www.gnu.org/licenses/gpl-3.0.html)
' SPDX-License-Identifier: GPL-3.0-or-later
%>

<%
function SqlTextMemo(s)
	dim tmp
	tmp = s

	if not isnull(tmp) then
		tmp = replace(tmp, "�", "'")
		tmp = replace(tmp, "`", "'")
		tmp = replace(tmp, "'", "''")
		tmp = replace(tmp, "&quot;", """")
		
		' eleminar TAGS de HTML
		if session("login") <> 2 then
			tmp = replace(tmp, ">", "&gt;")
			tmp = replace(tmp, "<", "&lt;")
		end if
	end if

	SqlTextMemo = tmp
end function


function SqlText(s)
	dim tmp
	tmp = s

'	SqlText = SqlTextMemo(tmp)
	SqlText = SqlTextMemo(left(tmp, 255))
end function

function Aspas2Quot(s)
	dim tmp
	tmp = s
	
	if not isnull(tmp) then
		tmp = replace(tmp, """", "&quot;")
	end if

	Aspas2Quot = tmp
end function

function Enter2Br(s)
	dim tmp
	tmp = s

	if not isnull(tmp) then
		tmp = replace(tmp, chr(13), "<br>")
	end if
	
	Enter2Br = tmp
end function
%>
