;function determines an individual YOY's optrho
FUNCTION rho, YOY, hatchday, a, actpar
;YOY = fltarr(17,5)
;YOY[8,*]=.01
;YOY[9,*]=1.0
n=n_elements(YOY[1,*])
par1 = fltarr(n)
par2 = fltarr(n)
par3 = fltarr(n)
par4 = fltarr(n)
par5 = fltarr(n)
par6 = fltarr(n)
;actpar = fltarr(2,n)
percent =fltarr(n)

par1 = (YOY[8,*]+YOY[9,*])/2 ;average of alleles for hatch
par2 = (YOY[10,*]+YOY[11,*])/2 ;average of alleles for July 1
par3 = (YOY[12,*]+YOY[13,*])/2 ;average of alleles for Aug 1
par4 = (YOY[14,*]+YOY[15,*])/2 ;avareage of alleles for Sept 1
par5 = (YOY[16,*]+YOY[17,*])/2 ;avareage of alleles for Sept 1
par6 = (YOY[18,*]+YOY[19,*])/2 ;avareage of alleles for Sept 1
;for a=150,160.0 do begin
for i=0L,n-1 do begin
  if hatchday[i] gt 0.0 then begin
    ;if hatchday[i] eq a then actpar[0,i]= 1.0
    if (a le 181)then begin
      percent[i] = actpar[0,i]/(181.0-hatchday[i])
      Actpar[1,i] = (1.0-percent[i])*par1[i]+percent[i]*par2[i]
      actpar[0,i]=actpar[0,i]+1
    endif
  
    if (a ge 182) and (a le 212) then begin
      if a eq 182 then actpar[0,i]=0.0
      percent = actpar[0,i]/31
      Actpar[1,i] = (1-percent)*par2[i]+percent*par3[i]
      actpar[0,i]=actpar[0,i]+1
    endif
  
    if (a ge 213) and (a le 243)then begin
      if a eq 213 then actpar[0,i]=0.0
      percent = actpar[0,i]/31
      Actpar[1,i] = (1-percent)*par3[i]+percent*par4[i]
      actpar[0,i]=actpar[0,i]+1
    endif
  
    if (a ge 244) and (a le 273)then begin
      if a eq 244 then actpar[0,i]=0.0
      percent = actpar[0,i]/30
      Actpar[1,i] = (1-percent)*par4[i]+percent*par5[i]
      actpar[0,i]=actpar[0,i]+1
    endif
  
    if (a ge 274) then begin
      if a eq 274 then actpar[0,i]=0.0
      percent = actpar[0,i]/61
      Actpar[1,i] = (1-percent)*par5[i]+percent*par6[i]
      actpar[0,i]=actpar[0,i]+1
    endif
  endif
endfor
;endfor
return, actpar
;print, actpar

end
