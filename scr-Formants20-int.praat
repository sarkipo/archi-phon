#v3.1 minimizing internal variation (during one token) instead of external (between tokens)
#v3.0 another formula for variation; add status column
#v2.7 fixed error in calculations with F3; fixed error if 1 token; sound filename saved in table;
#++++ separate calculations for +/- phar AND +/- stress; U+0301 (grave) counted as stress
#v2.6 F1+F2+F3, front vowels have higher ceiling range (+1kHz) and mid vowels, +0.5 kHz
#++++ ceiling range 1 kHz for each vowel instead of 2 kHz
#v2.3 Calculates best ceiling for F2+F3 instead of F1+F2

t = selected("TextGrid")
s = selected("Sound")
s$ = selected$("Sound") 
#save filename for use in the table

select t
form Specify the following parameters
	word Speaker PSX
	boolean Male false
	natural Default_ceiling_(for_F5) 5750
	real left_Time_range 0.0
	real right_Time_range 0.0
	natural Vowel_tier 2
	natural Word_tier 1
	sentence Vowel_list_(with_spaces) i e a o u ə ɪ ɐ
	optionmenu Search_criteria: 3
		option is equal to
		option is not equal to
		option starts with
		option ends with
		option contains
		option does not contain
		option matches (regex)
	boolean Draw_pictures_(for_each_token:_SLOW) no
	boolean Overwrite_file yes
endform

##### VOWEL SYMBOLS ################################
 #Archi = i í e é a á o ó u ú ə ˤ
 #i e a o u ə ɪ ɐ ɵ ʊ ᵊ
 #mylist1 = i0 i1 i2 e0 e1 e2 a0 a1 a2 o0 o1 o2 u0 u1 u2
 #specify vowels to look for in TG

a$ = replace_regex$(replace_regex$(vowel_list$,"\s+"," ",0),"(^ | $)","",0)

i = 1
while a$<>"" 
	len = length(a$)
	wordlen = index(a$," ")
	if wordlen > 1 
		wordlen = wordlen-1
		vowel$[i] = left$(a$,wordlen)
		a$ = right$(a$,len-wordlen-1)
	else
		vowel$[i] = a$
		a$ = ""
	endif

	v$ = vowel$[i]
	i = i+1
endwhile
vowel_num = i-1
 #read and count vowels to look for


#tb_phones = 0 		
#tb_phones_sum = 0	
 #initialize pointers to tables where phones will be stored

#@get_all_phones: vowel_tier, "matches (regex)", "^[ieaouəɪɐɵʊᵊ]"
 #write counts of all phones and counts of all vowels ("phonemes") found in vowel_tier to tables
 #'vowel' is taken to be the first unicode character of the 'phone'


##### FILENAMES ####################################

defaultfilename$ = "formants-int.txt"
outfilename$ = chooseWriteFile$ ("Write formants to text file...", defaultfilename$)
outfilename$ = if outfilename$ <> "" then outfilename$ else defaultfilename$ fi
if not fileReadable (outfilename$)
	writeFileLine: outfilename$, "speaker",tab$, "phone",tab$, "vowel",tab$, "duration",tab$, "ceiling",tab$, "variance",tab$, "F1",tab$, "F2",tab$, "F3",tab$, "F1Bk",tab$, "F2Bk",tab$, "F3Bk",tab$, "start",tab$, "word",tab$, "filename",tab$, "status"
elsif overwrite_file = 1
	writeFileLine: outfilename$, "speaker",tab$, "phone",tab$, "vowel",tab$, "duration",tab$, "ceiling",tab$, "variance",tab$, "F1",tab$, "F2",tab$, "F3",tab$, "F1Bk",tab$, "F2Bk",tab$, "F3Bk",tab$, "start",tab$, "word",tab$, "filename",tab$, "status"
endif
 #ask filename to store formants


##### FORMANT SETTINGS #############################

halfrange = 600
male_d = -500
phar_d = -500
front_d[1] = 750
front_d[2] = 500
front_d[3] = 0
front_d[4] = -300
front_d[5] = -500
 #delta to ceiling range center for various features

##### VOWEL SYMBOLS ################################

select t
Extract one tier: vowel_tier
Down to Table: "no", 3, "no", "no"
if left_Time_range > 0 or right_Time_range > 0
  Extract rows where column (number): "tmin", "greater than or equal to", left_Time_range
  Extract rows where column (number): "tmax", "less than or equal to", right_Time_range
endif
tb = Extract rows where column (text): "text", "matches (regex)", "^[ieaouəɪɐɵʊ]"
numphones = Get number of rows
Append column: "tmin0"
Append column: "tmax0"
Formula: "tmin0", "fixed$(self[1]-0.025,3)"
Formula: "tmax0", "fixed$(self[3]+0.025,3)"
Append difference column: "tmax", "tmin", "tdur"
Formula: "tdur", "fixed$(self,3)"

for i to numphones
	select tb
	times[1] = Get value: i, "tmin0"
	times[2] = Get value: i, "tmax0"
	times[3] = Get value: i, "tmin"
	times[4] = Get value: i, "tmax"
	tdur = Get value: i, "tdur"
	 #Get 25ms-extended and real start and end time

	phone$ = Get value: i, "text"
	vowel$ = left$(phone$,1)
	if vowel$ ="ɪ" 
		vowelcat$ = "i"
	elsif vowel$ ="ɐ" 
		vowelcat$ = "a"
	elsif vowel$ = "ʊ" 
		vowelcat$ = "u"
	elsif vowel$ = "ɵ" or vowel$ = "ᵊ"
		vowelcat$ = "ə"
	else
		vowelcat$ = vowel$
	endif
	 #Get phone, vowel and "gross" vowel transcription
	if vowelcat$ = "i"
		.front=1
	elif vowelcat$ = "e"
		.front=2
	elif vowelcat$ = "a" or vowelcat$ = "ə"
		.front=3
	elif vowelcat$ = "o"
		.front=4
	elif vowelcat$ = "u"
		.front=5
	endif
	 #Set front-back feature
	if index(phone$,"ˤ") > 0
		phar = 1
	else
		phar = 0
	endif
	 #Set phar feature

	mid_ceiling = default_ceiling + (if male then male_d else 0 fi) +
	 ...front_d[.front] + (if phar then phar_d else 0 fi)

	select t
	wordint = Get high interval at time: word_tier, times[3]
	word$ = Get label of interval: word_tier, wordint
	 #Get word

	select s
	ph = Extract part: times[1], times[2], "rectangular", 1, "yes"
	@getformantsint: mid_ceiling, draw_pictures
	 #extract sound with +25ms margins and calculate formant values
	select ph
	Remove
endfor

select s
plus t
#select initial sound and TG again




########
########
########


procedure get_all_phones .tier .search_criteria$ .vowels$
	select t
	Extract one tier: .tier
	tg_tmp = selected ("TextGrid")
	tb_tmp_1 = Down to Table: "no", 2, "no", "no"
	Sort rows: "text"
	tb_tmp_2 = Extract rows where column (text): "text", .search_criteria$, .vowels$
###	Extract rows where column (text): "text", "matches (regex)", "^[aeiouə]"
### ONLY WORKS FOR SPECIFIED REGEX: ALL VOWELS INCL. SCHWA AS FIRST LETTER OF THE PHONE

	Append column: "count"
	Formula: "count", "1"
	tb_phones = Collapse rows: "text", "count", "", "", "", ""

	Append column: "vowel"
#distinguish +/- stressed, +/- pharyngzd
	Formula: "vowel", "left$(self$[row,1],1) 
		...+ (if index(self$[row,1],""́"")>0 or index(self$[row,1],""̀"")>0 then ""́"" else """" fi)
		...+ (if index(self$[row,1],""ˤ"")>0 then ""ˤ"" else """" fi)"
	tb_phones_sum = Collapse rows: "vowel", "count", "", "", "", ""

	select tg_tmp
	Remove
endproc



########### GET FORMANT VALUES ##############

#optimize formant measurements by internal variation during central part of the vowel
procedure getformantsint .mid_ceiling .draw
  if .draw
	Erase all
	Black
	Line width: 1
	writeInfoLine: ""
  endif

  t1 = times[3]+0.3*tdur
  t2 = times[4]-0.3*tdur
   #cutting first and last 30% of the vowel
  nsteps = 20
  tstep = 0.4*tdur/nsteps
   #analyzing central 40% of the vowel
  fstep = 20
  fsteps = halfrange*2/fstep
   #how many steps to cover the full range
  result_ceiling = 0
  min = 1000000000000 
   #Technical value for comparison
  .min_ceiling = .mid_ceiling - halfrange
  .max_ceiling = .mid_ceiling + halfrange


for j from 0 to fsteps
   ceiling = .min_ceiling + fstep*j 

   mf1 = 0 
   mf2 = 0 
   mf3 = 0 
   sum1 = 0
   sum2 = 0
   sum3 = 0
   mf1b = 0 
   mf2b = 0 
   mf3b = 0 
   sum1b = 0
   sum2b = 0
   sum3b = 0
   vf1 = 0 
   vf2 = 0 
   vf3 = 0 
   sumdev1 = 0
   sumdev2 = 0
   sumdev3 = 0
    #Initializing variables

   select ph
   noprogress To Formant (burg): 0.0, 5, ceiling, 0.025, 50
   formant[j] = selected("Formant")

   if .draw 
	Draw tracks: times[3], times[4], .max_ceiling, "no"
   endif
   for k from 0 to nsteps
    #actual number of steps is nsteps+1
      f1[k] = Get value at time: 1, t1+tstep*k, "Hertz", "Linear"
      f2[k] = Get value at time: 2, t1+tstep*k, "Hertz", "Linear"
      f3[k] = Get value at time: 3, t1+tstep*k, "Hertz", "Linear"
      f1b[k] = Get value at time: 1, t1+tstep*k, "Bark", "Linear"
      f2b[k] = Get value at time: 2, t1+tstep*k, "Bark", "Linear"
      f3b[k] = Get value at time: 3, t1+tstep*k, "Bark", "Linear"
      sum1 = sum1 + f1[k]
      sum2 = sum2 + f2[k]
      sum3 = sum3 + f3[k]
      sum1b = sum1b + f1b[k]
      sum2b = sum2b + f2b[k]
      sum3b = sum3b + f3b[k]
   endfor
    #Get formant values along the central part of the vowel with current ceiling

   mf1 = sum1/(nsteps+1)
   mf2 = sum2/(nsteps+1)
   mf3 = sum3/(nsteps+1)
   mf1b = sum1b/(nsteps+1)
   mf2b = sum2b/(nsteps+1)
   mf3b = sum3b/(nsteps+1)
    #Sample mean F1-F3 values for current ceiling

   for k from 0 to nsteps
      sumdev1 = sumdev1 + (f1b[k]-mf1b)^2
      sumdev2 = sumdev2 + (f2b[k]-mf2b)^2
      sumdev3 = sumdev3 + (f3b[k]-mf3b)^2
   endfor
   vf1 = sumdev1/nsteps
   vf2 = sumdev2/nsteps
   vf3 = sumdev3/nsteps
    #Unbiased sample variance (using Bark scale) for current ceiling
   
   if vf1 + vf2 + vf3 < min 
    #If variance is less than previous minimum...
      result_f1 = Get quantile: 1, 0, 0, "Hertz", 0.5
      result_f2 = Get quantile: 2, 0, 0, "Hertz", 0.5
      result_f3 = Get quantile: 3, 0, 0, "Hertz", 0.5
      result_f1b = Get quantile: 1, 0, 0, "Bark", 0.5
      result_f2b = Get quantile: 2, 0, 0, "Bark", 0.5
      result_f3b = Get quantile: 3, 0, 0, "Bark", 0.5
       #...keep median formant values
      min = vf1 + vf2 + vf3
      result_ceiling = ceiling 
      result_num = j
       #...keep variance as a new minimum and keep ceiling value
   endif
endfor

   select formant[result_num]
   if .draw
      Red
      Line width: 2
      Draw tracks: times[3], times[4], .max_ceiling, "yes"
      One mark right: result_f1, "yes", "yes", "yes", ""
      One mark right: result_f2, "yes", "yes", "yes", ""
      One mark right: result_f3, "yes", "yes", "yes", ""

      Text top: "yes", string$(result_ceiling)
      Text top: "no", "from "+string$(.min_ceiling)+" to "+string$(.min_ceiling+fsteps*fstep)+" by "+string$(fstep)
   endif
   for j from 0 to fsteps
      plusObject: formant[j]
   endfor
   Remove
    #Remove formants

   appendFileLine: outfilename$, speaker$,tab$, phone$,tab$, vowel$,tab$, 
	...fixed$(tdur,3),tab$, result_ceiling,tab$, fixed$(min,3),tab$,
	...fixed$(result_f1,0),tab$, fixed$(result_f2,0),tab$, fixed$(result_f3,0),tab$,
	...fixed$(result_f1b,2),tab$, fixed$(result_f2b,2),tab$, fixed$(result_f3b,2),tab$, 
	...fixed$(times[3],3),tab$, word$,tab$, s$,tab$, "Auto"
   if .draw
	writeInfoLine: "Phone: ",phone$,"  Ceiling: ",result_ceiling,"  Median:  ", fixed$(result_f1,0)," ", fixed$(result_f2,0)," ", fixed$(result_f3,0),"  Var: ",fixed$(min,3)
	pauseScript: "Next vowel?"
   endif
endproc


########
########
########
