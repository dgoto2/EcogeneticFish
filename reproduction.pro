;reproduction function as modified from the whitefish model
FUNCTION reproduction, maturity, sex, no_inds, age, weight, length, params, no_YOY
;sex = [0,1,0,1,0,1,0,1]
;maturity = [1,1,1,1,1,1,1,1]
;no_inds=[1300,2455,2344,5433,123,234,122,1234]
;params=[[10,10,2,2,5,5],[20,20,3,3,5,5],[30,30,4,4,5,5],[40,40,5,5,5,5],[50,50,6,6,5,5],[60,60,7,7,5,5],[70,70,8,8,5,5],[80,80,9,9,5,5]]
;age=[3,5,2,5,8,4,7,5]
;weight=[54, 75, 100, 89,75,65,98,150]
;Length=[130,155,230,178,150,145,215,265]
q=n_elements(sex)
f=fltarr(q)
eggtot=fltarr(q)
totegg=fltarr(q)
m=fltarr(q)
milt=fltarr(q)
milttot=fltarr(q)

for i=0L,q-1 do begin
if (sex[i] eq 1) and (maturity[i] eq 1) then begin
f[i] = no_inds[i] ;mature females
;based on fecundtiy relationship from Brazo et al. 1975
eggtot[i] = 138.215 + 187.054*weight[i] ;# eggs/individuals
totegg[i]=eggtot[i]*f[i] ;total # eggs produced by SI
endif
if (sex[i] eq 0) and (maturity[i] eq 1) then begin 
m[i] = no_inds[i] ;# mature males in SI
milt[i] = 0.08 * weight[i]
milttot[i] = milt[i] * m[i] ; total milt production by SI
endif
endfor

Eggtotal = TOTAL(totegg) ;total number of eggs produced by females
milttotal= TOTAl(milttot) ;biomass of milt produced by males
;print, eggtotal
;print, eggtotal
;determine # eggs placed into each SI
;determine number of eggs to survive to place into each SI
Larvae = (0.09*EXP(-0.000000000003*eggtotal))*eggtotal
;print, larvae
recruit = larvae /no_YOY
;print, recruit

; total egg production is not allowed to exceed 10E12 eggs based on data from 
;Saginaw Bay trawl and assumed fecundity values

Young = fltarr(7,no_YOY)
if (recruit gt 1) then Young[0,*] = fltarr(no_YOY)+recruit
if (recruit le 1) then Young[0,*] = fltarr(no_YOY)+1.0
if (recruit gt 5000000000.0) then Young[0,*] = fltarr(no_YOY)+5000000000.0
Young[1,*]= round(randomu(seed,no_YOY)) ;sets to zero or 1 for sex
;determine parents for each super individuals
pp=n_elements(Young[1,*])

;randomly select dad with larger males producing milt
miltp= where(milttot gt 0) ;only include males that produce eggs
hhh =n_elements(miltp) ;# mature males
m_spawn=fltarr(4,hhh)
tt=0.0
for jj=0L,hhh-1 do begin
  m_spawn[0,jj]=miltp[jj]
  m_spawn[1,jj]=milttot[miltp[jj]]/milttotal
  m_spawn[2,jj]=tt
  m_spawn[3,jj]=tt+m_spawn[1,jj]
  tt=m_spawn[3,jj]
endfor
m_spawn[3,hhh-1]=1.0
select = randomu(seed,pp) ;random uniform #
gq=m_spawn[3,*]
dad=fltarr(pp)
for ww=0L,pp-1 do begin
  finderd =where(gq ge select[ww]) ;find dads with values > random #
  dad[ww]=miltp[finderd[0]] ;random assignment since individual nearest the random # is assigned father
  young[2,ww]=dad[ww] ;dad for individual ww
endfor

;randomly select mom with higher probability with increased weight of female
eggs= where(eggtot gt 0) ;only inlcude females that produce eggs
hh=n_elements(eggs) ;# mature females
F_spawn = fltarr(4,hh)
t=0.0
for j = 0L,hh-1 do begin
  F_spawn[0,j]=eggs[j] ;location of females in the array
  F_spawn[1,j]=totegg[eggs[j]]/eggtotal ;relative production of SI to all production by pop
  F_spawn[2,j]=t
  F_spawn[3,j]=t+F_spawn[1,j]
  t=f_spawn[3,j] ;places females in cue from 0-1
endfor
f_spawn[3,hh-1] = 1.0
gg=f_spawn[3,*]

selection=randomu(seed,pp) ;randomly selected #
mom=fltarr(pp) ;array for moms needed for all new YOY SIs
for w=0L,pp-1 do begin
  finder=where(gg ge selection[w]) ;find moms with values > random #
  mom[w]=eggs[finder[0]]
  Young[3,w]=mom[w]
endfor

YOY=fltarr(25,pp) ;array to hold YOY SIs

;params are set up as gene1, gene2
;so params are M1,D1,M2,D2

for ind=0L,pp-1 do begin 
  sel =round(randomu(seed,12))
  for gene=0, 10 do begin
    YOY[8+gene,ind] = params[sel[gene]+gene, young[2,ind]]
    YOY[9+gene,ind] = params[sel[gene+1]+gene, young[3,ind]]
    gene=gene+1
  endfor
endfor

opt_rho =fltarr(pp)
for k=0L,pp-1 do begin
  YOY[2,k]=6.6 +0.2 * randomn(seed);length in mm
  if YOY[2,k] gt 8.0 or YOY[2,k] lt 5.0 then begin
    while YOY[2,k] gt 8.0 or YOY[2,k] lt 5.0 do begin
     YOY[2,k]=6.6 +0.2 * randomn(seed);length in mm
    endwhile
  endif
  ;YOY[3,k]= EXP((alog(YOY[2,k]/45.9))/0.33) ;weight in g
  ;opt_rho[k]=(0.1026*alog(YOY[2,k])+0.1604) 
  ;YOY[4,k]= opt_rho[k] * YOY[3,k] ;storage in g
  ;YOY[5,k]= (1-opt_rho(k))* YOY[3,k] ;structure in g
  YOY[5,k]= 0.000009*(YOY[2,k])^2.8134
  opt_rho[k]=(0.0912*alog((YOY[2,k]))+0.128)
  if opt_rho[k] lt 0.3 then opt_rho[k] = 0.3
  YOY[3,k]= (YOY[5,k]/(1-opt_rho[k]))
  YOY[4,k]=YOY[3,k]-YOY[5,k] 
endfor

       ;assining a hatch temp
       ahd = 11.0*randomu(seed,pp)
       for qq=0L,pp-1 do begin
       while ahd(qq) lt 7.0 do ahd(qq) = 11.0*randomu(seed,1)
       endfor 
       
YOY[0,*]=young[1,*] ;sex
YOY[1,*]=0.0 ;maturity
YOY[6,*]=0 ;age
YOY[7,*]=(young[0,*]) ;#
YOY[20,*]= ahd
YOY[21,*]=young[2,*] ;dad of the yoy
YOY[22,*]=young[3,*] ;mom of the yoy
YOY[23,*]=eggtotal ;total number of eggs produced
YOY[24,*]=larvae ;total number of larvae produced
return, YOY
end
