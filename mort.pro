;this function determines daily and overwinter mortality of YOY
FUNCTION mort, YOY, a, hatchday, rhos
;no_inds = [123,2432,4534,232,123,4234]
;iday =365.0
;stor = [20.0,32.0,25.0,23.0,41.0,9.0]
;struc = [20.0,35.0,34.0,24.0,41.0,12.0]
;length=[121.0,98.0,59.0,100.1,89.0,78.0]
;a=187
;hatchday=[141,145,147,145,146,146]
;rhos=[0.01,0.01,0.01,0.01,0.01,0.01]

length = YOY[2,*]
stor = YOY[4,*]
struc = YOY[5,*]
no_inds = YOY[7,*]

n=n_elements(no_inds)
p_pred = fltarr(n)
p_starve = fltarr(n)
Z = fltarr(n)
ActZ =fltarr(n)
actrho=fltarr(n)
optrho = fltarr(n)
p_wint = fltarr(n)
pred = fltarr(n)
star = fltarr(n)
wint = fltarr(n)
ratio=fltarr(n)
TotMort = fltarr(4,n)

For i=0L,n-1 do begin
  if hatchday[i] gt 0.0 then begin
    ;predation mortality is based on data from South Bay from Mason and Brandt 1996
    ;for larve less than 8.0mm
   ;and Forney 1971 (older individuals)
   ;ave for less than 8.0 mm is 0.243 total+- 0.0347
    ;if length[i] lt 8.0  then z(i) = 0.1701+0.024*randomn(seed)
    ;best equation is 0.0002*X^2-0.0139*X+0.3106
    ;if length[i] ge 8.0 and length[i] lt 40.0 then Z(i) = (0.0001*length(i)^2-0.0094*length(i)+0.2159)+0.02*randomn(seed)
    ;average from Forney 1971 is 0.0334+-0.012682
    ;if length [i] ge 40.0 then z(i) = 0.0205+0.012*randomn(seed)
 
      ;z(i) = 0.4*EXP(-(length(i))*0.06); higher mort
      z(i) = 0.4*EXP(-(length(i))*0.08) ;low mort
      if Z(i) lt 0.0 then Z(i) = 0.0
      p_pred(i) = 1-EXP(-Z(i))
      if p_pred(i) gt 0.0 then begin
      if no_inds[i] lt 1.0 then pred[i] = no_inds[i]
      if no_inds[i] ge 1.0 then pred(i) = (RANDOMN(seed,BINOMIAL=[no_inds[i],p_pred[i]],/double))
      endif else begin
      pred(i)= 0.0
      endelse
  
  ;starvation component
  optrho(i) = (0.0912*alog(length(i))+0.128);(based on energy data from Hanson 1997
  if optrho(i) lt 0.3 then optrho(i) =0.3
  p_starve(i) = 0.1 + 0.4*(optrho(i))
  actrho(i)=stor(i)/(stor(i)+struc(i))
  if no_inds[i] lt 1.0 then star(i) = no_inds(i)
  if no_inds[i] ge 1.0 then begin
  if actrho(i) lt p_starve(i) then star(i) =(RANDOMN(seed, BINOMIAL=[no_inds(i),p_starve(i)],/double))
  endif
  
  ;;starvation component
  
  ; actrho(i)=stor(i)/(stor(i)+struc(i))
  ; p_starve[i]=1.5-2*(actrho[i]/optrho[i])
  ; ;p_starve[i] = 1- 2* actrho[i]/optrho[i]
  ;  if (actrho[i] gt 0.7*optrho[i]) then p_starve[i]=0.0
  ;  if (actrho[i] lt 0.2*optrho[i]) then p_starve[i]=1.0
  ;    if p_starve[i] gt 1.0 then p_starve[i] =1.0
  ;    if no_inds[i] lt 1.0 then star[i] =no_inds[i]
  ;    if no_inds[i] ge 1.0 then star[i]=(RANDOMN(seed, BINOMIAL=[no_inds[i],p_starve[i]],/double))
  
endif  
  ;overwinter mortality component
  ;ranges based on mean fall length for YOY from Fielder et al. 2006, which ranged from 66.1 to 96.5
    if a eq 334.0 then begin
      if length(i) lt 40.0 then wint(i) = no_inds(i)
      if length(i) gt 120.0 then wint(i) = 0.0
      if length(i) ge 40.0 and length(i) le 120.0 then begin
        ;to use for baseline sims
        p_wint(i) = -172.67*(stor(i)/length(i))^2-3.0353*(stor(i)/length(i))+1.0258   
        ;p_wint(i) = p_wint(i)+(0.10*p_wint(i))
        ;ratio(i) = stor(i)/((length(i))^2.64)
        ;p_wint(i) = -0.0000000008*(ratio(i)^2)+249024*ratio(i)-0.9332
        ;less winter severity ?
        ;p_wint(i) = -8000000000*(stor(i)/(length(i))^2.64)^2+249024.0*(Stor(i)/(length(i)^2.64))-0.9332
        if p_wint(i) lt 0.0 then p_wint(i) =0.0
        if p_wint(i) gt 1.0 then p_wint(i) =1.0
        if no_inds(i) lt 1.0 then wint(i) = no_inds(i)
        if no_inds(i) ge 1.0 then wint(i) = (RANDOMN(seed, BINOMIAL=[no_inds(i),p_wint(i)],/double))
      endif
    endif    
      ;p_wint(i) = 1.922-0.367*actrho(i)-0.018*length(i) ;making rho dependent on length and rho
      ;;values used are saved in SPSS under winter mort... made up values
      ;if p_wint(i) ge 1.0 then p_wint(i) = 1.0
      ;if p_wint(i) le 0.0 then p_wint(i) = 0.0
      ;if no_inds[i] lt 1.0 then wint[i] = no_inds[i]
      ;if no_inds[i] ge 1.0 then wint(i) = (RANDOMN(seed, BINOMIAL=[no_inds[i],p_wint[i]],/double)) 
    ;endif ;else begin
    ;;wint(i) = 0.0
    ;;endelse

endfor

TotMort[0,*] =round(pred)
TotMort[1,*]=round(star)
TotMort[2,*]=round(wint)
;print, actrho
;print, p_pred, p_starve, p_wint
;print, no_inds
return, totmort
;print, totmort
;totmort [0,*]=pred
;totmort [3,*]=z
end

