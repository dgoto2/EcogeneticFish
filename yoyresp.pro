; function to determine respiration
Function YOYresp, T, w
;parameters required for the bioenergtics subroutine (From Hanson 1997)
;values are for larval yellow perch
;respiration
;W=0.0028
;t =18.0

RA= 0.0065;Wisconsin Bioenergetics Manual
RB= -0.2
RQ= 2.1
RTO= 32.0
RTM= 35.0
ACT= 4.4;4.4 ;in WBM, is 4.4, but this doesn't allow the fish to grow due to high resp costs 
;NEED TO CHECK ON FUNCTION FOR UNITS

Oxygen = 13560 ;determine what this number should really be

;array for respiration values
;Resp = fltarr(20)
;FOR i=0,19 do begin
V = (RTM - T) / (RTM-RTO)
natRQ = alog(RQ)
Z = natRQ*(RTM-RTO)
Y = natRQ*(RTM-RTO+2)
x = (Z^2*(1+(1+40/Y)^0.5)^2)/400
tempfunc=V^X*exp(X*(1-V))
Resp = RA* w^RB*tempfunc*Act*oxygen
;endfor
;units are J/g/d
return,  Resp
;PRINT, RESP
end
