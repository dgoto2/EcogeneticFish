;main program for the ecogenetic model
;model determines energy allocation for larval and YOY yellow perch

init_no = 100000 ;initial number of individuals
no_YOY = 10000 ;number of SIs represented by YOY
DayTemp= fltarr(365)
run =10
year =200
output=fltarr(21,year)
numbers=fltarr(10, year)
dyg = fltarr(18,335)
pgrowth=0.0
ponerun=1.0
qq=10.0
row=2
norows=(year/qq)+2
runpt =fltarr(60,norows,run)
;runpt=fltarr(60, year, run)
For irun=0, run-1 do begin
adult_inds = initiate (init_no)
qq=10.0
row=2
print, 'irun',irun
For iyear= 0,year-1 do begin
  print, iyear
  inds = adult_inds
  ;print, total(adult_inds[7,*])
  ;inds = death(inds) ;to remove SIs with no individuals
  inds[1,*] = mature(inds[6,*], inds[2,*], inds[1,*], inds[0,*])
  count= ages(inds)
  ;print, count
  ;numbers[*,iyear]= count
  n=n_elements(inds[0,inds])
  params =fltarr(n)
  params=adult_inds[8:19,*]
  repo = reproduction(inds[1,*], inds[0,*],inds[7,*], inds[6,*], inds[2,*], inds[3,*], params, no_YOY)
  Eggprod = repo[23:24,0]
  YOY=repo[0:22,*]
  if iyear eq 0 then begin
  runprintout = runprint(iyear, inds, yoy, irun, count, eggprod)
  runpt[*,0,irun] = runprintout
  endif
  New_atts = adults(inds[6,*],inds[2,*], inds[7,*], inds[0,*])
  inds[2,*]= New_atts[0,*]
  inds[3,*]= New_atts[1,*]
  inds[7,*]= New_atts[2,*]
  n=n_elements(YOY[0,*])
  actpar = fltarr(2,n)
  spawnday = fltarr(n)
  Tspawn = fltarr(n)
  DV = fltarr(n)
  h = fltarr(n)
  y=fltarr(n)
  l=fltarr(n)
  biom=fltarr(2,335)
  combomort = fltarr(n)

      For iday= 100,334 do begin ;if only run to date Nov 30, date would be 334
       ;print, iday
       a= Float(iday)
       T = temperature(a)
       Daytemp(iday) = T
       hatchday = hatch(T,a,YOY[7,*], dv, YOY[20,*], h, l)    
       biomass = bio(YOY)
       p = pval(YOY, biomass)
       rhos = rho(YOY, hatchday ,a, actpar)
       NewAttribute = YOYgrowth(YOY, T, p, hatchday, rhos)
       mortality = mort(YOY, a, hatchday, rhos)
       ;print, a, total(mortality[0,*]),total(mortality[1,*]), total(mortality[2,*])
       for i=0L,n-1 do begin
       combomort(i) = mortality[0,i]+mortality[1,i]+mortality[2,i]
       YOY[7,i] = (yoy[7,i]-combomort[i])
       if YOY[7,i] lt 0.0 then YOY[7,i] = 0.0
       endfor
       YOY[3,*] = NewAttribute[0,*] ;weight
       YOY[2,*] = NewAttribute[1,*] ;length
       YOY[4,*] = NewAttribute[3,*] ;storage
       YOY[5,*] = NewAttribute[2,*] ;structure
       dailyYOYgrowth = YOYdaily(YOY, biomass, p, a, mortality)
       dyg[*,iday]=dailyYOYgrowth
        if total(YOY[7,*])le 0.0 then begin
        print, 'Model error'
        print, iday
        endif
              endfor
     inds = death(inds) ;to remove SIs with no individuals
     ;print, total(inds[7,*])
     yoy = deathyoy(yoy) ;to remove SIs with no individuals
     yearlyoutput = printout(iyear, inds, YOY)
     output[*,iyear] = yearlyoutput
     YOY[6,*]=1 ;updating so that YOY are age 1s in next year
     inds[6,*]=inds[6,*]+1 ;updating adults so they age 1 year
     adult_inds=[[inds],[YOY]]
    ; print, mean(YOY[2,*])
    ; print, total(YOY[7,*])
     count= ages(inds)
    ; print, count
     if iyear eq 0 then begin
     runprintout = runprint(iyear, inds, yoy, irun, count, eggprod)
     runpt[*,1,irun] = runprintout
     ;runprintout = runprint(iyear, inds, yoy, irun, count, eggprod)
     ;runpt[*,iyear,irun] = runprintout
     endif 
     prcheck =iyear/qq
     if prcheck eq 1.0 then begin
     runprintout = runprint(iyear, inds, yoy, irun, count, eggprod)
     runpt[*,row,irun] = runprintout
     qq=qq+10
     row=1+row
     endif
     if iyear eq (year-1) then begin
     runprintout = runprint(iyear, inds, yoy, irun, count, eggprod)
     runpt[*,row,irun] = runprintout
     endif
     
     endfor
endfor

linewidth =8000
comma = ","
s = size(output,/dimensions)
xsize=s[0]
;print growth from 1 year
if pgrowth eq 0.0 then begin
openw, lun, 'growth.txt',/get_lun, width=linewidth 
printf, lun, dyg
free_lun, lun
endif

;print 1 model run for all 200 years
if ponerun eq 0.0 then begin
openw, lun, 'Ecogenetic_Model_Run.txt',/get_lun, width=linewidth
;sdata=strtrim(output,2)
;sdata[0:xsize,*] =sdata[0:xsize-2,*] +comma
;printf, lun,"year", "adult biomass", "yoy biomass", "adult length", "YOY length", "adult weight", "YOY weight", "Adult Abundance", "YOY abundance"
printf, lun, output
free_lun, lun
endif

;print results for multiple model runs (final year only)
openw, lun, 'Multiple Runs.txt',/get_lun, width=linewidth
printf, lun, runpt
free_lun, lun

print, 'Once again I ask too much of you'
end
