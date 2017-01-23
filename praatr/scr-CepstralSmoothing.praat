n = numberOfSelected ("Spectrum")
Cepstral smoothing: 400
for i to n
	s[i] = selected ("Spectrum", i)
endfor

To SpectrumTier (peaks)
for i to n
	st[i] = selected ("SpectrumTier", i)
endfor

Remove points below: 0
Down to Table
Formula: "freq(Hz)", "fixed$(self,0)"
tb = selected("Table")

selectObject ()
for i to n
	plusObject: s[i]
	plusObject: st[i]
endfor
Remove
selectObject: tb

