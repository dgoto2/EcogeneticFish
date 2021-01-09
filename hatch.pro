;function to determine hatch day

FUNCTION hatch, T, a, no_inds, dv, y, h, l
;q =fltarr(5)
;daytemp=fltarr(365)

n=n_elements(no_inds)

 ;T = temperature(a)
  ;Daytemp(a) = T
for i=0L,n-1 do begin  
  if T ge y(i) or DV(i) gt 0.0 then begin
    DV(i) = DV(i)+ 1/(145.7+2.56*T-63.8*alog(T))
    if DV(i) ge 1.0 then begin
      l(i) = l(i)+1.0
       if l(i) eq 3.0 then begin
        h(i) = a
       endif
     endif
   endif
endfor
;endfor
;print, dv
;print, l
;print, h
return,  h
end

