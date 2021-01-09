;function to grow YOY yellow perch in both storage and structure tissue
FUNCTION YOYgrowth, YOY, T, p, hatchday, rhos
;YOY=fltarr(8,10)
;YOY[2,*]=6.6
;YOY[3,*]=0.0028
;YOY[4,*]=0.00056
;YOY[5,*]=0.00224
;rhos=fltarr(2,10)
;rhos =[[0,0.003],[0,0.004],[0,-0.003],[0,-0.1],[0,0.1],[0,0.12],[0,-0.15],[0,0.03],[0,0.05],[0,-0.06]] 
;p=fltarr(10)
;p = [0.33, 0.44,0.54,0.23,0.76,0.544,0.66,0.23,0.032,0.43]
;T= 18.0
        
n=n_elements(YOY[3,*])
;energy values assigned for storage and structure in J/g
stor_energy = 6500.0
struc_energy = 500.0
frac = stor_energy / (stor_energy+struc_energy);fraction to storage

;egestion
FA= 0.15
;excretion
UA= 0.15
;specific dynamic action
SDA= 0.15

new_stor = fltarr(n) ;new storage tissue weight in grams
new_struc = fltarr(n) ;new structural tissue weight in grams
new_weight = fltarr(n) ;new weights for individual in grams
optrho = fltarr(n)
opt_wt = fltarr(n)

;arrays for this function
attribute = fltarr(4,n)
Cons = fltarr(n)
Cmaxx = fltarr(n)
YOYCons = fltarr(n)
YOYConsJ = fltarr(n)
YOYres = fltarr(n)
Eges = fltarr(n)
Exc = fltarr(n)
S= fltarr(n)
Energy_loss = fltarr(n)
Energy_gained = fltarr(n)
Energy_Change= fltarr(n)
opt_wt= fltarr(n)
pot_stor = fltarr(n)
percent_stor = fltarr(n)
percent_struc=fltarr(n)

;changewt=fltarr(n)
;changestor=fltarr(n)
;changestruc=fltarr(n)

length = YOY[2,*]
weight = YOY[3,*]
stor = YOY[4,*]
struc= YOY[5,*]

For i=0L, n-1 do begin
  if hatchday[i] gt 0.0 then begin
  if length[i] le 30.0 then ED_prey = 2300.0 else ED_prey = 3100.0;J/g average value from Schindler for clads and copes across an entire season; chiro from Arend
  
  w=weight[i] ;weight in g
  pp=p[i]
  optrho(i) = (0.0912*alog(length(i))+0.128)+rhos[1,i] ;(based on energy data from Hanson 1997$
  ;and seasonal genetic component from rho function
  opt_wt[i] = optrho[i] * weight[i] ;determines the percent weight that should be storage
  percent_stor(i) = Optrho(i)*frac
  percent_struc(i)= (1-optrho(i))*(1-frac)
  ;determining growth
  Cons[i] = ConsumptionYOY(T, pp) ;determine consumption
  Cmaxx[i]= cmax(w) ;determine cmaxx
  YOYCons[i] = Cons[i]*Cmaxx[i] ;determine actual consumption
  YOYConsJ[i] = YOYcons[i]*ED_prey ;converts to J/g/d
  YOYres[i] = YOYresp(T, w) ;determine respiration
  Eges[i] = FA*YOYConsJ[i] ;calculate egestion
  Exc[i] = UA*YOYConsJ[i] ;calculate excretion
  S[i] = SDA *(YOYConsJ[i]-Eges[i]) ;calculation SDS
  Energy_loss[i] = YOYres[i]+Eges[i]+Exc[i]+S[i] ;determine total energy lost in J/g/d
  Energy_gained[i] = YOYConsJ[i] ;energy consumed in J/g/d
  energy_change[i] = (energy_gained[i] - energy_loss[i])*weight[i] ;energy available for growth J/d
  pot_stor[i]=  stor[i] + (energy_change[i]/stor_energy) ;holds all the grams consumed that day and places it all in storage
  if energy_change[i] ge 0 then begin ;if you have consumed excess energy 
         if stor[i] ge opt_wt[i] then begin;if your storage_weight is greater than optimal rho
            ;add to storage and structural tissue
            new_stor [i]= stor[i] + (percent_stor[i]/(percent_stor[i] + percent_struc[i]))*(energy_change[i]/stor_energy)
            new_struc [i]= struc[i] +(percent_struc[i]/(percent_stor[i] + percent_struc[i]))*(energy_change[i]/struc_energy)
            new_weight[i] = new_struc[i] + new_stor[i]
         endif
         if stor[i] lt opt_wt[i] then begin ;if storage weight is less than optimal storage weight
            if pot_stor[i] lt opt_wt[i] then begin ;if potential storage is less than optimal storage
              new_stor[i] = pot_stor[i]
              new_struc[i] = struc[i]
              new_weight[i] = new_struc[i] + new_stor[i]
            endif
            if pot_stor[i] ge opt_wt[i] then begin ;if the potential storage is greater than optimal storage
              new_stor [i]= stor[i] + (percent_stor[i]/(percent_stor[i] + percent_struc[i]))*(energy_change[i]/stor_energy)
              new_struc [i]= struc[i] +(percent_struc[i]/(percent_stor[i] + percent_struc[i]))*(energy_change[i]/struc_energy)
              new_weight[i] = new_struc[i] + new_stor[i]
            endif
         endif
   endif
   if energy_change(i) lt 0 then begin ;if the inidividual lost weight
         new_stor[i] = pot_stor[i]
         new_struc[i] = struc[i]
         new_weight[i] = new_struc[i] + new_stor[i]
   endif
 endif else begin
        new_stor[i]=stor[i]
        new_struc[i]=struc[i]
        new_weight[i]=weight[i]
 endelse
 ;changewt[i]=new_weight[i]-weight[i]
 ;changestor[i]=new_stor[i]-stor[i]
 ;changestruc[i]=new_struc[i]-struc[i]
 
endfor

;determining growth in length
Pot_length = fltarr(n) ;potential increase in length
New_length = fltarr(n) ;new length

;ASK TOMAS if fish can grow when only go to storage and not structure???
for i=0L,n-1 do begin
  if hatchday[i] gt 0.0 then begin
  ;need a length weight regression equation determine pot_length
  if New_struc[i] gt struc[i] then begin
    Pot_length[i] = 61.561*(New_struc[i]^0.3554) ;equation from Rose et al. 1999 
      if Pot_length[i] gt length [i] then begin
        new_length[i] = Pot_length[i] 
      endif else begin
        new_length [i]= length[i]
      endelse
   endif else begin
    new_length [i]= length[i]
   endelse
  endif else begin
  new_length[i]=length[i]
  endelse
endfor
;print, new_stor, new_struc, new_weight, new_length

attribute[0,*] = new_weight
attribute[1,*] = new_length
attribute[2,*] = new_struc
attribute[3,*] = new_stor
return, attribute
;print, energy_change, changewt, changestor, changestruc  
end

