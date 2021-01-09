;this function determines the p-value used for the bioenergetics model
;is a function of predator biomass

;VALUES FOR p are MADE-UP!
;based on a number of assumption on total biomass in Saginaw Bay
;NEED TO CONFIRM these values

FUNCTION pval, YOY, biomass
;biomass = 20000
;YOY=fltarr(10,100)
;YOY[7,*] = 10

n=n_elements(YOY[7,*])
prop = fltarr(n)
biomass=70000.0
p =0.8022*EXP(-0.000003*biomass)

if p lt 0.0 then p = 0.05

for i=0L,n-1 do begin
  y = round(randomu(seed,1))
  if y eq 1 then prop(i)= p+((1-p)*randomu(seed,1)) else prop(i)=p*randomu(seed)
endfor
;print, p,y,prop
return, prop
end