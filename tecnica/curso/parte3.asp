<!-- #include file="../../funcoes_principais.asp" -->
<% 
OpcaoMenu ">> SEGUINTE", "tecnica/curso/parte4.asp", False, False, -1, False, False
OpcaoMenu "<< ANTERIOR", "tecnica/curso/parte2.asp", False, False, -1, False, False
Menu 4, 1, "FOTOGRAFIA BÁSICA EXEMPLO A EXEMPLO - FOTOMETRIA" 
%>

<font color="#FFCC66" face="arial"><b>FOTOMETRIA</b></font>
<br><br>

<font size="-1" color="white" face="arial">
Para que uma fotografia fique "boa" s&atilde;o necess&aacute;rias duas coisas b&aacute;sicas: enquadrar bem o que se quer, e medir correctamente
a luz existente na cena, para que o negativo receba a quantidade de luz certa. &Eacute; a esta medi&ccedil;&atilde;o da luz, que se d&aacute; o nome
de <b>FOTOMETRIA</b>.
<br><br>
A luz &eacute; normalmente medida pelo <b>fot&oacute;metro</b> da m&aacute;quina fotogr&aacute;fica ou por um fot&oacute;metro de m&atilde;o. H&aacute;
dois par&acirc;metros que nos permitem aumentar e diminuir a quantidade de luz que o negativo recebe - a <b>abertura do diafragma</b>, normalmente chamada
de <b>f</b>, e o <b>tempo de exposi&ccedil;&atilde;o</b>. Alguns valores comuns:

<ul type="disc">
	<li>abertura de diafragma - f1.4, f2, f2.8, f4, f5.6, f8, f11, f16<br>
	<li>tempo de exposi&ccedil;&atilde;o - 1/25s, 1/50s, 1/100s, 1/200s, 1/400s<br>
</ul>

Cada salto entre valores, adjacentes, destes par&acirc;metros (por exemplo de f1.4, para f2, ou de 1/100s para 1/200s) &eacute; chamado um <b>stop</b>. Cada vez
que aumentamos um stop, estamos a deixar entrar o dobro da luz na m&aacute;quina, inversamente cada vez que diminuimos um stop, estamos a deixar entrar
metade da luz.
<br><br>
Se estes par&acirc;metros estiverem mal, podem acontecer duas coisas - a foto pode fica <b>sobrexposta</b> (o negativo recebeu luz a mais) ou
<b>subexposta</b> (o negativo recebeu luz a menos). Os negativos normalmente t&ecirc;m uma latitude suficiente para se poderem ignorar pequenos erros (depende do tipo de negativo), mas
quando o erro &eacute; muito grande (por distra&ccedil;&atilde;o ou porque o fot&oacute;metro foi enganado por a cena ser "fora do normal") podemos ter
o azar de n&atilde;o se conseguir aproveitar nada da foto.
<br><br>
Nos exemplos abaixo est&aacute; uma foto com exposi&ccedil;&atilde;o correcta e duas incorrectas (propositadamente). As incorrectas t&ecirc;m +3 stops
e -3 stops do que a exposi&ccedil;&atilde;o correcta.
</font>

<br><br>
<div align="center">
	<table cellpadding="20" cellspacing="0" border="0" width="100%">
		<tr><td align="left">
			<img src="/fotos/arquivo/cursobasico/foto6.jpg" width=531 height=362 border=0 alt="">
			<font size="-1" color="white" face="arial">
				<br><br>
				<b>Negativo sobrexposto</b> (luz a mais)
				<br>
				f 8 - 1/20s (+3 stops)
			</font>
		</td></tr>
		<tr><td align="center">
			<img src="/fotos/arquivo/cursobasico/foto7.jpg" width=528 height=360 border=0 alt="">
			<font size="-1" color="white" face="arial">
				<br><br>
				<b>Exposi&ccedil;&atilde;o correcta</b>
				<br>
				f 8 - 1/160s
			</font>
		</td></tr>
		<tr><td align="right">
			<img src="/fotos/arquivo/cursobasico/foto8.jpg" width=531 height=361 border=0 alt="">
			<font size="-1" color="white" face="arial">
				<br><br>
				<b>Negativo subexposto</b> (luz a menos)
				<br>
				f 8 - 1/1250s (-3 stops)
			</font>
		</td></tr>
	</table>

	<font size="-2" color="white" face="arial">Todas as imagens s&atilde;o da autoria de <a href="../../autor.asp?autor=2">Tiago Fonseca</a></font>
</div>

<% FimPagina() %>
