; function to determine respiration
Function ConsumptionYOY, T, pp
;parameters required for the bioenergtics subroutine (From Hanson 1997)
;values are for larval yellow perch
;respiration
;parameters required for the bioenergtics subroutine (From Hanson 1997)
;values are for larval yellow perch
;consumption

CQ = 2.3
CTO = 29.0
CTM = 32.0

;FOR i=0,19 do begin
V = (CTM - T) / (CTM-CTO)
natCQ = alog(CQ)
Z = natCQ*(CTM-CTO)
Y = natCQ*(CTM-CTO+2)
x = (Z^2*(1+(1+40/Y)^0.5)^2)/400
tempfunc=V^X*exp(X*(1-V))
Consumption=tempfunc*pp
;endfor
;units are G/g/d
return,  Consumption
;print, consumption
end
