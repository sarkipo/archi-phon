#Рисование графиков для F1..F3 и длительности
#Оси для перевернутой F3
#линия вместо цвета

clicked = 0
Colour: "black"
Line width: 1

speaker$ = "JSP"
#speaker$ = "SPK"
which_vowels = 3
by_stress = 2
by_length = 1
by_pharyngztion = 1
contrastLine = 1
contrastTopBottom = 1
formantHor = 2
formantVert = 1
###default values

repeat

tb = selected("Table")
#в таблице должны быть фонемы, фоны, время, длительность, форманты, потолок, форманты в Барках

beginPause: "Specify the following parameters"
	word: "Speaker", speaker$
	boolean: "Erase picture", 1
	boolean: "Get ranges from data", 1
	optionMenu: "Which vowels", which_vowels
		option: "All vowels"
		option: "Selected vowel"
		option: "Only phonemes (aeiouə)"
	comment: "Which phones:"
	optionMenu: "by stress", by_stress
		option: "All phones"
		option: "Only stressed"
		option: "Only unstressed"
	optionMenu: "by length", by_length
		option: "All phones"
		option: "Only long"
		option: "Only short"
	optionMenu: "by pharyngztion", by_pharyngztion
		option: "All phones"
		option: "Only pharyngzd"
		option: "Only non-pharyngzd"
	optionMenu: "ContrastLine", contrastLine
		option: "No contrast"
		option: "Stressed vs unstressed"
		option: "Pharyngzd vs non-pharyngzd"
		option: "Long vs short"
	optionMenu: "ContrastTopBottom", contrastTopBottom
		option: "No contrast"
		option: "Stressed vs unstressed"
		option: "Pharyngzd vs non-pharyngzd"
		option: "Long vs short"
	comment: "Which formants"
	optionMenu: "FormantHor", formantHor
		option: "F1"
		option: "F2"
		option: "F3"
		option: "F2-F1"
		option: "F3-F1"
		option: "F3-F2"
		option: "duration"
	optionMenu: "FormantVert", formantVert
		option: "F1"
		option: "F2"
		option: "F3"
		option: "F2-F1"
		option: "F3-F1"
		option: "F3-F2"
		option: "duration"
#	boolean: "AddBark", 1
endPause: "OK", 1

if erase_picture = 1
	Erase all
endif


if which_vowels = 1
	vowels_cond$ = "1"
	vowels_txt$ = "all phones"
elsif which_vowels = 2
	beginPause: "Select vowel"
		word: "Vowel", "a"
	endPause: "OK", 1
	vowels_cond$ = "(startsWith(self$[""phone""],""" + vowel$ + """))"
	vowels_txt$ = vowel$
elsif which_vowels = 3
	vowels_cond$ = "(index_regex(self$[""phone""],""^[aeiouə]""))"
	vowels_txt$ = "aeiouə"
endif

@getRanges


if by_stress = 1
	stress_cond$ = "1"
	stress_txt$ = ""
elsif by_stress = 2
	stress_cond$ = "(index_regex(self$[""phone""],""[̀́]"")>0)"
	stress_txt$ = "|only stressed"
#only stressed: U+0300 or U+0301
elsif by_stress = 3
	stress_cond$ = "(index_regex(self$[""phone""],""[̀́]"")=0)"
	stress_txt$ = "|only unstressed"
#only unstressed
endif

if by_length = 1
	length_cond$ = "1"
	length_txt$ = ""
elsif by_length = 2
	length_cond$ = "(index(self$[""phone""],""ː"")>0)"
	length_txt$ = "|only long"
#only long: U+02D0
elsif by_length = 3
	length_cond$ = "(index(self$[""phone""],""ː"")=0)"
	length_txt$ = "|only short"
#only short
endif


if by_pharyngztion = 1
	pharyngztion_cond$ = "1"
	phar_txt$ = ""
elsif by_pharyngztion = 2
	pharyngztion_cond$ = "(index(self$[""phone""],""ˤ"")>0)"
	phar_txt$ = "|only +phar"
#only pharyngzd: U+02E4
elsif by_pharyngztion = 3
	pharyngztion_cond$ = "(index(self$[""phone""],""ˤ"")=0)"
	phar_txt$ = "|only -phar"
#only non-pharyngzd
endif

phones_cond$ = stress_cond$+" and "+length_cond$+" and "+pharyngztion_cond$
phones_txt$ = stress_txt$+length_txt$+phar_txt$


if contrastLine = 1
	contLine_cond_1$ = "1"
	contLine_cond_2$ = "1"
	contrast_txt$ = ""
elsif contrastLine = 2
	contLine_cond_1$ = "(index_regex(self$[""phone""],""[̀́]"")>0)"
	contLine_cond_2$ = "(index_regex(self$[""phone""],""[̀́]"")=0)"
	contrast_txt$ = " | DOTTED stressed, SOLID unstressed"
elsif contrastLine = 3
	contLine_cond_1$ = "(index(self$[""phone""],""ˤ"")>0)"
	contLine_cond_2$ = "(index(self$[""phone""],""ˤ"")=0)"
	contrast_txt$ = " | DOTTED +phar, SOLID -phar"
elsif contrastLine = 4
	contLine_cond_1$ = "(index(self$[""phone""],""ː"")>0)"
	contLine_cond_2$ = "(index(self$[""phone""],""ː"")=0)"
	contrast_txt$ = " | DOTTED long, SOLID short"
endif


if contrastTopBottom = 1
	contTop_cond$ = "1"
	contBot_cond$ = "1"
	top_txt$ = ""
	bot_txt$ = ""
elsif contrastTopBottom = 2
	contTop_cond$ = "(index_regex(self$[""phone""],""[̀́]"")>0)"
	contBot_cond$ = "(index_regex(self$[""phone""],""[̀́]"")=0)"
	top_txt$ = "|stressed"
	bot_txt$ = "|unstressed"
elsif contrastTopBottom = 3
	contTop_cond$ = "(index(self$[""phone""],""ˤ"")>0)"
	contBot_cond$ = "(index(self$[""phone""],""ˤ"")=0)"
	top_txt$ = "|+phar"
	bot_txt$ = "|-phar"
elsif contrastTopBottom = 4
	contTop_cond$ = "(index(self$[""phone""],""ː"")>0)"
	contBot_cond$ = "(index(self$[""phone""],""ː"")=0)"
	top_txt$ = "|long"
	bot_txt$ = "|short"
endif


#########
#########
#рисуем графики


if contrastLine = 1
	if contrastTopBottom = 1
		condition$ = vowels_cond$ + " and " +phones_cond$
		@plotOneColorBark: 1, 1, condition$, formantHor, formantVert, 1
#frame, line, condition, formantHor, formantVert, garnish
		Text top: 1, speaker$+": "+vowels_txt$+phones_txt$
	elsif contrastTopBottom > 1
		condition_top$ = vowels_cond$ + " and " +phones_cond$ + " and " +contTop_cond$
		condition_bot$ = vowels_cond$ + " and " +phones_cond$ + " and " +contBot_cond$
		@plotOneColorBark: 1, 1, condition_top$, formantHor, formantVert, 1
		Text top: 1, speaker$+": "+vowels_txt$+phones_txt$+top_txt$
		@plotOneColorBark: 2, 1, condition_bot$, formantHor, formantVert, 1
		Text top: 1, speaker$+": "+vowels_txt$+phones_txt$+bot_txt$
	endif

elsif contrastLine > 1
	if contrastTopBottom = 1
		condition_1$ = vowels_cond$+" and "+phones_cond$+" and "+contLine_cond_1$
		condition_2$ = vowels_cond$+" and "+phones_cond$+" and "+contLine_cond_2$
		@plotOneColorBark: 1, 2, condition_1$, formantHor, formantVert, 1
		@plotOneColorBark: 1, 1, condition_2$, formantHor, formantVert, 0
		Text top: 1, speaker$+": "+vowels_txt$+phones_txt$+contrast_txt$
	elsif contrastTopBottom > 1
		condition_top_1$ = vowels_cond$+" and "+phones_cond$+" and "+contTop_cond$+" and "+contLine_cond_1$
		condition_top_2$ = vowels_cond$+" and "+phones_cond$+" and "+contTop_cond$+" and "+contLine_cond_2$
		condition_bot_1$ = vowels_cond$+" and "+phones_cond$+" and "+contBot_cond$+" and "+contLine_cond_1$
		condition_bot_2$ = vowels_cond$+" and "+phones_cond$+" and "+contBot_cond$+" and "+contLine_cond_2$
		@plotOneColorBark: 1, 2, condition_top_1$, formantHor, formantVert, 1
		@plotOneColorBark: 1, 1, condition_top_2$, formantHor, formantVert, 0
		Text top: 1, speaker$+": "+vowels_txt$+phones_txt$+top_txt$+contrast_txt$
		@plotOneColorBark: 2, 2, condition_bot_1$, formantHor, formantVert, 1
		@plotOneColorBark: 2, 1, condition_bot_2$, formantHor, formantVert, 0
		Text top: 1, speaker$+": "+vowels_txt$+phones_txt$+bot_txt$+contrast_txt$
	endif
endif


select tb
#вернуть выделенные файлы

beginPause: "Another plot?"
clicked = endPause: "Repeat", "Finish", 1
until clicked = 2


########
########
########


procedure getRanges

f_col$[1]="F1"
f_col$[2]="F2"
f_col$[3]="F3"
f_col$[4]="F2-F1"
f_col$[5]="F3-F1"
f_col$[6]="F3-F2"
f_col$[7]="duration"
f_Bcol$[1]="F1Bk"
f_Bcol$[2]="F2Bk"
f_Bcol$[3]="F3Bk"
f_Bcol$[4]="F2-F1Bk"
f_Bcol$[5]="F3-F1Bk"
f_Bcol$[6]="F3-F2Bk"
f_Bcol$[7]="duration"
#имена столбцов с формантами в таблице
f_step[1]=100
f_step[2]=200
f_step[3]=250
f_step[4]=200
f_step[5]=200
f_step[6]=200
f_step[7]=0.050
#шаг для отметок на графике

if get_ranges_from_data = 1
	if which_vowels = 1 or which_vowels = 3
		for i to 7
			f_min[i] = Get minimum: f_col$[i]
			f_max[i] = Get maximum: f_col$[i]
			f_Bmin[i] = Get minimum: f_Bcol$[i]
			f_Bmax[i] = Get maximum: f_Bcol$[i]
		endfor
	#берём крайние значения формант по всей таблице
	elsif which_vowels = 2
		Extract rows where column (text): "vowel", "starts with", vowel$
		for i to 7
			f_min[i] = Get minimum: f_col$[i]
			f_max[i] = Get maximum: f_col$[i]
			f_Bmin[i] = Get minimum: f_Bcol$[i]
			f_Bmax[i] = Get maximum: f_Bcol$[i]
		endfor
		Remove
		select tb
	#берем значения для выбранного гласного
	endif
	
	for i to 6
		f_min[i] = (floor(f_min[i]/50)-1)*50
		f_max[i] = (ceiling(f_max[i]/50)+1)*50
		f_Bmin[i] = (floor(f_Bmin[i]*4))/4-0.1
		f_Bmax[i] = (ceiling(f_Bmax[i]*4))/4+0.1
	endfor
	f_min[7] = (floor(f_min[i]*100)-1)/100
	f_max[7] = (ceiling(f_max[i]*100)+1)/100
	f_Bmin[7] = (floor(f_Bmin[i]*100)-1)/100
	f_Bmax[7] = (ceiling(f_Bmax[i]*100)+1)/100
	
	#добавляем "поля" по 50-100 Гц
else
	f_min[1] = 200
	f_max[1] = 1100
	f_min[2] = 500
	f_max[2] = 3300
	f_min[3] = 1750
	f_max[3] = 4000
	f_Bmin[1] = 2.5
	f_Bmax[1] = 8.5
	f_Bmin[2] = 6.5
	f_Bmax[2] = 16.5
	f_Bmin[3] = 12.0
	f_Bmax[3] = 18.0
#JSP: 3-7, 6-14  PSX: 2.5-8.5, 6.5-16.5
#иначе берём для шкалы фиксированный диапазон
endif
.tmp=f_max[3]
f_max[3]=f_min[3]
f_min[3]=.tmp
.tmp=f_Bmax[3]
f_Bmax[3]=f_Bmin[3]
f_Bmin[3]=.tmp
.tmp=f_max[7]
f_max[7]=f_min[7]
f_min[7]=.tmp
.tmp=f_Bmax[7]
f_Bmax[7]=f_Bmin[7]
f_Bmin[7]=.tmp
#переворачиваем шкалу для F3 & duration
endproc


procedure marksBark: .formantHor, .formantVert
	ceilingHor=ceiling(f_Bmin[.formantHor])
	floorHor=floor(f_Bmax[.formantHor])

	ceilingVert=ceiling(f_Bmin[.formantVert])
	floorVert=floor(f_Bmax[.formantVert])
	if .formantHor=3
		ceilingHor = ceilingHor-1
		floorHor = floorHor+1
		for k from floorHor to ceilingHor
			markHertz = barkToHertz(k)
			One mark top: k, "no", "yes", "no", fixed$(markHertz,0)
		endfor
#adjusting margins for (un)reversed F3
	else
		for k from ceilingHor to floorHor
			markHertz = barkToHertz(k)
			One mark top: k, "no", "yes", "no", fixed$(markHertz,0)
		endfor
	endif
	if .formantVert=3
		ceilingVert = ceilingVert-1
		floorVert = floorVert+1
		for k from floorVert to ceilingVert
			markHertz = barkToHertz(k)
			One mark right: k, "no", "yes", "no", fixed$(markHertz,0)
		endfor
#adjusting margins for (un)reversed F3
	else
		for k from ceilingVert to floorVert
			markHertz = barkToHertz(k)
			One mark right: k, "no", "yes", "no", fixed$(markHertz,0)
		endfor
	endif
endproc


procedure setFrame: .frame
	if .frame = 1
		Select outer viewport: 0, 6, 0, 4
#		Select outer viewport: 0, 9, 0, 6
	elsif .frame = 2
		Select outer viewport: 0, 6, 4, 8
#		Select outer viewport: 0, 9, 6, 12
	elsif .frame = 3
		Select outer viewport: 0, 6, 0, 4
	elsif .frame = 4
		Select outer viewport: 6, 12, 0, 4
	elsif .frame = 5
		Select outer viewport: 0, 6, 4, 8
	elsif .frame = 6
		Select outer viewport: 6, 12, 4, 8
	endif
endproc


procedure plotOneColor: .frame, .line, .condition$, .fHor, .fVert, .garnish
	@setFrame: .frame
	if .line=1
		Solid line
	else
		Dotted line
	endif
	Scatter plot where: f_col$[.fHor], f_max[.fHor], f_min[.fHor], f_col$[.fVert],
	... f_max[.fVert], f_min[.fVert], "phone", 10, "no", .condition$
	Line width: 2.0
	Draw ellipses where: f_col$[.fHor], f_max[.fHor], f_min[.fHor], f_col$[.fVert],
	... f_max[.fVert], f_min[.fVert], "vowel", 2, 1, "no", .condition$
	Line width: 1.0
	if .garnish
		Draw inner box
		Text bottom: 1, f_col$[.fHor]+", Hertz"
		Text left: 1, f_col$[.fVert]+", Hertz"
		Marks top every: 1, f_step[.fHor], "yes", "yes", "yes"
		Marks right every: 1, f_step[.fVert], "yes", "yes", "yes"
	endif
endproc


procedure plotOneColorBark: .frame, .line, .condition$, .fHor, .fVert, .garnish
	@setFrame: .frame
	if .line=1
		Solid line
	else
		Dotted line
	endif
	Scatter plot where: f_Bcol$[.fHor], f_Bmax[.fHor], f_Bmin[.fHor], f_Bcol$[.fVert],
	... f_Bmax[.fVert], f_Bmin[.fVert], "phone", 10, "no", .condition$
	Line width: 2.0
	Draw ellipses where: f_Bcol$[.fHor], f_Bmax[.fHor], f_Bmin[.fHor], f_Bcol$[.fVert],
	... f_Bmax[.fVert], f_Bmin[.fVert], "vowel", 2, 1, "no", .condition$
	Line width: 1.0
	if .garnish
		Draw inner box
		Text bottom: 1, f_col$[.fHor]-"Bk"+", Bark (Hertz)"
		Text left: 1, f_col$[.fVert]-"Bk"+", Bark (Hertz)"
		Marks bottom every: 1, 1, "yes", "yes", "yes"
		Marks left every: 1, 1, "yes", "yes", "yes"
		@marksBark: .fHor, .fVert
	endif
endproc