;function for the growth or adults annually
;based on von bertalanffy growthLinf = 280.5
FUNCTION adults, age,length, no_inds, sex

;no_inds=[124,2555,2344,122,232,532,41,2344]
;age=[1,4,3,2,1,4,8,3]
;length = [167,234,210,189,150,250,260,190]
;von bertalanffy params from Fielder and Thomas 2007

m= n_elements(no_inds)
new_L = fltarr(m)
new_w =fltarr(m)
logwt = fltarr(m)
No_die = fltarr(m)
new_atts =fltarr(3,m)
survival = fltarr(m)
surv = fltarr(m)
rand = fltarr(m)

For i=0L, m-1 do begin

if sex[i] eq 0 then begin
;males
Linf =272.0
K=0.184
to = -2.45
endif else begin
;females
Linf = 307.0
K=0.333
to=0.031
endelse

new_L(i) = (Linf-length[i])*(1-EXP(-k)) ;change in growth
new_L(i) = new_L(i) + ((0.25*randomn(seed))*10)
new_L(i) = new_L(i)+length(i) ; increase in length
if new_L(i) le length(i) then new_L(i) = length(i)
if new_L(i) gt Linf then new_L(i) = Linf

;weight from Fielder and Thomas 2006 appendix 4
logwt(i) =2.888*alog10(new_l(i))-4.627
new_w(i) = 10^(logwt(i)) 

;use Thayer et al. 2008 annual survival rates to estimate mortality of individuals
case age(i) of
  1.0: surv(i) = 0.653
  2.0: surv(i) = 0.571
  3.0: surv(i)= 0.388
  4.0: surv(i) = 0.302
  5.0: surv(i) = 0.302
  6.0: surv(i) = 0.401
  7.0: surv(i) = 0.45
  8.0: surv(i) = 0.001
  9.0: surv(i) = 0.00
  10.0: surv(i) = 0.00
endcase
rand(i) =  0.1*randomn(seed)
survival(i) = surv(i)+ rand(i)

No_die(i) = ROUND((1-survival(i))*no_inds(i))
no_inds(i) = ROUND(no_inds(i) -no_die(i))
if age(i) eq 10.0 then no_inds(i) = 0.0
if no_inds(i) lt 0.0 then begin
  no_inds(i) = 0.0
endif

endfor
new_atts[0,*]=New_l
New_atts[1,*]=New_w
new_atts[2,*]=no_inds
;print, new_atts
return, New_atts
end