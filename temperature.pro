;function determines daily temperature readings
FUNCTION temperature,a
a=a+1
;temperature function based on data from T. Johengen Saginaw Data 1991-1996
sq =a*a
q = 0.0016*sq
w = 0.6803*a
TempDay = w-q-50.281
If TempDay lt 1.0 then begin
Tempday = 1.0
endif
;print, Tempday
return, Tempday
end