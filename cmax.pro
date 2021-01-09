; function to determine cmax
Function cmax, w
;parameters required for the bioenergtics subroutine (From Hanson 1997)
;values are for larval yellow perch
;consumption
CA = 0.51
CB = -0.42
;cmaxx= fltarr(20)
;FOR i=0,19 do begin
cmaxx = CA*w^CB
;endfor
;units are g/g/d
return,  cmaxx

end
