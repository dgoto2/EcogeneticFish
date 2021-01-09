;function to print items out on an annual basis
FUNCTION RunPrint,iyear, inds, YOY, irun, numbers, eggprod
runoutput = fltarr(60)

;abundance
AbYOY = total(YOY[7,*])
AbAD = total(inds[7,*])

;number of adults in each age class
ADage = numbers

;number of SIs
SIad = size(inds, /dimensions)
SIYOY = size(YOY, /dimensions)
noSIad= SIad(1)
noSIYOY= SIYOY(1)

;biomass
bio=YOY[7,*]*YOY[3,*]
wtYOY=total(bio)
biobio=inds[7,*]*inds[3,*]
wtAD=total(biobio)

;average length of YOY
l=YOY[7,*]*YOY[2,*]
Lval=total(l)
meanL=Lval/abYOY

;variation in YOY length
St=((YOY[2,*]-meanL)^2)*YOY[7,*]
St1=total(st)
stdevL = (St1/(abYOY-1))^0.5
minL = min(YOY[2,*])
maxL = max(YOY[2,*])

;average weight of YOY
W=YOY[7,*]*YOY[3,*]
Wval=total(w)
meanW=Wval/abYOY

;average genes of entire pop
;first average the two allels for each gene
gene1=(inds[8,*]+inds[9,*])/2
gene2=(inds[10,*]+inds[11,*])/2
gene3=(inds[12,*]+inds[13,*])/2
gene4=(inds[14,*]+inds[15,*])/2
gene5=(inds[16,*]+inds[17,*])/2
gene6=(inds[18,*]+inds[19,*])/2

;next multiply by the number of individuals represented by the SI
gval1=gene1*inds[7,*]
gval2=gene2*inds[7,*]
gval3=gene3*inds[7,*]
gval4=gene4*inds[7,*]
gval5=gene5*inds[7,*]
gval6=gene6*inds[7,*]

;find the total
totval1=total(gval1)
totval2=total(gval2)
totval3=total(gval3)
totval4=total(gval4)
totval5=total(gval5)
totval6=total(gval6)

;find mean
meang1=totval1/AbAD
meang2=totval2/AbAD
meang3=totval3/AbAD
meang4=totval4/AbAD
meang5=totval5/AbAD
meang6=totval6/AbAD

;variation in genetics
;standard deviation
Stg1=((gene1-meang1)^2)*YOY[7,*]
Stg2=((gene2-meang2)^2)*YOY[7,*]
Stg3=((gene3-meang3)^2)*YOY[7,*]
Stg4=((gene4-meang4)^2)*YOY[7,*]
Stg5=((gene5-meang5)^2)*YOY[7,*]
Stg6=((gene6-meang6)^2)*YOY[7,*]
Stgg1=total(Stg1)
Stgg2=total(Stg2)
Stgg3=total(Stg3)
Stgg4=total(Stg4)
Stgg5=total(Stg5)
Stgg6=total(Stg6)
StdevG1 = (Stgg1/(abYOY-1))^0.5
StdevG2 = (Stgg2/(abYOY-1))^0.5
StdevG3 = (Stgg3/(abYOY-1))^0.5
StdevG4 = (Stgg4/(abYOY-1))^0.5
StdevG5 = (Stgg5/(abYOY-1))^0.5
StdevG6 = (Stgg6/(abYOY-1))^0.5
;min and max
minG1=min(gene1)
maxG1=max(gene1)
minG2=min(gene2)
maxG2=max(gene2)
minG3=min(gene3)
maxG3=max(gene3)
minG4=min(gene4)
maxG4=max(gene4)
minG5=min(gene5)
maxG5=max(gene5) 
minG6=min(gene6)
maxG6=max(gene6)
;quartiles
;quartile cutoffs
indL=0.25*(abad+1)
indH=0.75*(abad+1)

;gene1
sortg1=sort(gene1)
G1=gene1[(sortg1)]
x=inds[7,sortg1[0]]
i=1L
while (x lt indL) do begin
xx=inds[7,sortg1[i]]
x=x+xx
i=i+1
endwhile
ValG1L=G1(i-1)
y=inds[7,sortg1[0]]
counter=1L
while (y lt indH) do begin
yy = inds[7,sortg1[counter]]
y=y+yy
counter=counter+1
endwhile
ValG1H=G1(counter-1)

;gene2
sortg2=sort(gene2)
G2=gene2[(sortg2)]
q=inds[7,sortg2[0]]
k=1L
while (q lt indL) do begin
qq=inds[7,sortg2[k]]
q=q+qq
k=k+1
endwhile
ValG2L=G2(k-1)
z=inds[7,sortg2[0]]
a=1L
while (z lt indH) do begin
zz = inds[7,sortg2[a]]
z=z+zz
a=a+1
endwhile
ValG2H=G2(a-1)

;gene3
sortg3=sort(gene3)
G3=gene3[(sortg3)]
u=inds[7,sortg3[0]]
b=1L
while (u lt indL) do begin
uu=inds[7,sortg3[b]]
u=u+uu
b=b+1
endwhile
ValG3L=G3(b-1)
v=inds[7,sortg3[0]]
c=1L
while (v lt indH) do begin
vv = inds[7,sortg3[c]]
v=v+vv
c=c+1
endwhile
ValG3H=G3(c-1)

;gene4
sortg4=sort(gene4)
G4=gene4[(sortg4)]
r=inds[7,sortg4[0]]
d=1L
while (r lt indL) do begin
rr=inds[7,sortg4[d]]
r=r+rr
d=d+1
endwhile
ValG4L=G4(d-1)
s=inds[7,sortg4[0]]
e=1L
while (s lt indH) do begin
ss = inds[7,sortg4[e]]
s=s+ss
e=e+1
endwhile
ValG4H=G4(e-1)

;gene5
sortg5=sort(gene5)
G5=gene5[(sortg5)]
t=inds[7,sortg5[0]]
f=1L
while (t lt indL) do begin
tt=inds[7,sortg5[f]]
t=t+tt
f=f+1
endwhile
ValG5L=G5(f-1)
o=inds[7,sortg5[0]]
g=1L
while (o lt indH) do begin
oo = inds[7,sortg5[g]]
o=o+oo
g=g+1
endwhile
ValG5H=G5(g-1)

;gene6
sortg6=sort(gene6)
G6=gene6[(sortg6)]
p=inds[7,sortg6[0]]
h=1L
while (p lt indL) do begin
pp=inds[7,sortg6[h]]
p=p+pp
h=h+1
endwhile
ValG6L=G6(h-1)
q=inds[7,sortg1[0]]
n=1L
while (y lt indH) do begin
qq = inds[7,sortg6[n]]
q=q+qq
n=n+1
endwhile
ValG6H=G6(n-1)
             
  runoutput[0] = irun
  runoutput[1] = iyear
  runoutput[2] = WtAD
  runoutput[3] = ADage[0]
  runoutput[4] = ADage[1]
  runoutput[5] = ADage[2]
  runoutput[6] = ADage[3]
  runoutput[7] = ADage[4]
  runoutput[8] = ADage[5]
  runoutput[9] = ADage[6]
  runoutput[10] = ADage[7]
  runoutput[11] = ADage[8]
  runoutput[12] = ADage[9]
  runoutput[13] = AbAd
  runoutput[14] = eggprod[0,0]
  runoutput[15] = eggprod[1,0]
  runoutput[16] = meanL
  runoutput[17] = stdevL
  runoutput[18] = minL
  runoutput[19] = maxL 
  runoutput[20] = meanW
  runoutput[21] = AbYOY
  runoutput[22] = meang1
  runoutput[23] = Stdevg1 
  runoutput[24] = ming1
  runoutput[25] = maxg1
  runoutput[26] = ValG1L
  runoutput[27] = ValG1H
  runoutput[28] = meang2
  runoutput[29] = Stdevg2 
  runoutput[30] = ming2
  runoutput[31] = maxg2
  runoutput[32] = ValG2L
  runoutput[33] = ValG2H
  runoutput[34] = meang3
  runoutput[35] = Stdevg3 
  runoutput[36] = ming3
  runoutput[37] = maxg3
  runoutput[38] = ValG3L
  runoutput[39] = ValG3H
  runoutput[40] = meang4
  runoutput[41] = Stdevg4 
  runoutput[42] = ming4
  runoutput[43] = maxg4
  runoutput[44] = ValG4L
  runoutput[45] = ValG4H
  runoutput[46] = meang5
  runoutput[47] = Stdevg5 
  runoutput[48] = ming5
  runoutput[49] = maxg5
  runoutput[50] = ValG5L
  runoutput[51] = ValG5H
  runoutput[52] = meang6
  runoutput[53] = Stdevg6 
  runoutput[54] = ming6
  runoutput[55] = maxg6
  runoutput[56] = ValG6L
  runoutput[57] = ValG6H
  runoutput[58] = noSIad
  runoutput[59] = noSIYOY
return, runoutput
end
