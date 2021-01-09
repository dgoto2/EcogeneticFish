;function for determining maturity status
FUNCTION mature, age, length, maturity, sex
;length=[154.0,208.0,125.0,90.1,161.0]
;age=[4,7,2,1,2]

;percent maturity from Thayer et al. 2007
m = n_elements(length)
maturity =fltarr(m)
For i=0L,m-1 do begin
if sex[i] eq 0 then begin
;males based on info from Diana and Salz 1990
    if (age[i] eq 1) and (length[i] ge 129.0) then maturity[i] = 1
    if (age[i] eq 2) and (length[i] ge 113.0) then maturity[i] = 1
    if (age[i] ge 3) then maturity[i] = 1
endif else begin
 ;females based on Thayer et al. 2007
    if (age[i] eq 2) and (length[i] ge 135.0 ) then maturity[i] = 1
    if (age[i] eq 3) and (length[i] ge 130.0) then maturity[i] = 1
    if (age[i] eq 4) and (length[i] ge 125.0) then maturity[i] = 1
    if (age[i] ge 5) then maturity[i] = 1
endelse
endfor

;print, maturity
return, maturity
end