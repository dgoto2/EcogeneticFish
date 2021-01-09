;function to grow YOY yellow perch in both storage and structure tissue
;FUNCTION YOYgrowth, weight, stor, struc, length, YOY_no, i

 
;energy values assigned for storage and structure in J/g
stor_energy = 16000.0
struc_energy = 2000.0

;energy density of prey
ED_prey = 2500 ;J/g RANDOMLY SELECTED as mid-range for copepods and cladocerans from Hanson et al. 1997

new_stor = fltarr(n) ;new storage tissue weight in grams
new_struc = fltarr(n) ;new structural tissue weight in grams
new_weight = fltarr(n) ;new weights for individual in grams

;determining growth in weight

optrho = 0.7 ;value of storage to structural tissue
opt_wt = optrho * weight(i) ;determines the percent weight that should be storage

percent_stor = 0.7;5* optrho/6 ;values are directly from Tomas' code... need to check
percent_struc = 0.3;(1-optrho)/6 ;values are directly from Tomas' code... need to check

;determining growth
Cons(i) = consump (T, CQ, CTO, CTM, p, i) ;determine consumption
Cmaxx(i)= cmax(CA, CB, weight, i) ;determine cmaxx
YOYCons(i) = Cons(i)*Cmaxx(i) ;determine actual consumption
YOYConsJ(i) = YOYcons(i)*ED_prey ;converts to J/g/d
YOYresp(i) = respir(T, RQ, RTO, RTM, RA, RB, Act, oxygen, weight, i) ;determine respiration
Eges(i) = FA*YOYConsJ(i) ;calculate egestion
Exc(i) = UA*YOYConsJ(i) ;calculate excretion
S(i) = SDA *(YOYConsJ(i)-Eges(i)) ;calculation SDS
Energy_loss(i) = YOYresp(i)+Eges(i)+Exc(i)+S(i) ;determine total energy lost in J/g/d
Energy_gained(i) = YOYConsJ(i) ;energy consumed in J/g/d
energy_change(i) = energy_consumed(i) - energy_loss(i) ;energy available for growth

pot_stor(i)=  stor(i) + (energy_change(i)/16000) ;holds all the grams consumed that day and places it all in storage
    if energy_change(i) ge 0 then begin ;if you have consumed excess energy 
         if stor[i] ge opt_wt[i] then begin;if your storage_weight is greater than optimal rho
          ;add to storage and structural tissue
          new_stor [i]= stor[i] + (percent_stor/(percent_stor + percent_struc))*(energy_change/stor_energy)
          new_struc [i]= struc[i] +(percent_struc/(percent_stor + percent_struc))*(energy_change/struc_energy)
          new_weight[i] = new_struc[i] + new_stor[i]
         endif
         if stor[i] lt opt_wt[i] then begin ;if storage weight is less than optimal storage weight
            if pot_stor[i] lt opt_wt[i] then begin ;if potential storage is less than optimal storage
              new_stor[i] = pot_stor[i]
              new_struc[i] = struc[i]
              new_weight[i] = new_struc[i] + new_stor[i]
            endif
            if pot_stor[i] ge opt_wt[i] then begin ;if the potential storage is greater than optimal storage
              new_stor [i]= stor[i] + (percent_stor/(percent_stor + percent_struc))*(energy_change/stor_energy)
              new_struc [i]= struc[i] +(percent_struc/(percent_stor + percent_struc))*(energy_change/struc_energy)
              new_weight[i] = new_struc[i] + new_stor[i]
            endif
         endif
     endif
     if energy_change lt 0 then begin ;if the inidividual lost weight
         new_stor[i] = pot_stor[i]
         new_struc[i] = struc[i]
         new_weight[i] = new_struc[i] + new_stor[i]
     endif

;determining growth in length
Pot_length = fltarr(n) ;potential increase in length
New_length = fltarr(n) ;new length

for i=0,m do begin
  ;need a length weight regression equation for walleye and YP to determine pot_length
  Pot_length[i] = 45.9 * Weight[i]^0.33 ;equation from Rose et al. 1999 
  if Pot_length[i] gt length [i] then new_length[i] = Pot_length[i] else $
  new_length [i]= length[i]
endfor
print, new_stor, new_struc, new_weight, new_length
;return, individual
end