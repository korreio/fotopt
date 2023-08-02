<%
' Copyright: (c) 1999-2023, Tiago Fonseca
' GNU General Public License v3.0+ (see LICENSE.md or https://www.gnu.org/licenses/gpl-3.0.html)
' SPDX-License-Identifier: GPL-3.0-or-later
%>

<!-- #include file="sqltext.asp" -->
<!-- #include file="funcoes_principais.asp" -->

<%
Menu 2, 5, "APRESENTA��O DO J�RI"
%>

<%
SQL = "SELECT * FROM autor WHERE juri = true ORDER BY nome"
Set juriRes = dbConnection.Execute(SQL)
%>

<font size="-1" color="white" face="arial">
O j�ri do foto@pt era composto por um grupo de membros que se ofereceram para me ajudar a distinguir 
fotografias e autores pela sua qualidade. Nunca pretendemos ser profissionais na mat�ria, nem melhores 
do que o membro comum a decidir se esta fotografia seria melhor do aquela (afinal depende muito do gosto 
de cada um). Apenas queriamos homenagiar aqueles que, quanto a n�s, o mereciam pelo seu trabalho de 
qualidade. O j�ri era composto por um grupo de pessoas o mais heterog�neo possivel, tanto em termos de 
profiss�o como de faixa et�ria para que a escolha seja o menos tendenciosa possivel. 
<br><br>
Entretanto, por raz�es de natureza diversa, o j�ri deixou de existir, ficando as escolhas feitas
por ele como arquivo hist�rico do site. N�o poderia deixar de agradecer a todos os que fizeram parte
desse j�ri:<br><br>

<ul type="disc">

</ul>

</font><br><br>

<% FimPagina() %>
