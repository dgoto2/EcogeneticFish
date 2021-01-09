; function to determine consumption (without max included)
Function consump, T, p, YOY_no
;parameters required for the bioenergtics subroutine (From Hanson 1997)
;values are for larval yellow perch
;consumption
CQ = 2.3
CTO = 29.0
CTM = 32.0

cons = fltarr(YOY_no) ;array for consumption values
FOR i=0,1 do begin
V = CTO;(CTM - T) / (CTM-CTO)
natCQ = alog(CQ)
Z = natCQ*(CTM-CTO)
Y = natCQ*(CTM-CTO+2)
x = (Z^2*(1+(1+40/Y)^0.5)^2)/400
tempfunc=V^X*exp(X*(1-V))
cons(i)= tempfunc*p(i)
endfor
;cons is in terms of g/g/d
return,  cons
;print, cons
end

