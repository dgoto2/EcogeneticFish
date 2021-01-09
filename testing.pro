;initiate number of adults
;FUNCTION initiate, init_no
init_no =100000
;init_no =5
m=init_no

temp_inds = fltarr(23,m)

;randomly assign ages 1-8 based on a uniform distribution
age = 1+round(9*randomu(seed,m))
for i=0L, m-1 do begin
  ;below statement is required to make an even distribution of ages between 1-8
  if age(i) eq 10.0 then age(i) = 1.0
  ;set the number of individuals within an age category to frequency dist from Fielder and Thomas 2006
endfor

pop=50000000.0 ;initial population size
 
  ;determine the number of SIs at age and the total number of indvids represented by an age
    y1=where(age eq 1, count)
    age1=age[y1]
    x1 =count
    numberinds1 = round(pop*0.447)
    noperSI1 = numberinds1/X1
    y2=where(age eq 2, count)
    age2=age[y2]
    x2 =count
    numberinds2 = round(pop*0.292)
    noperSI2 = numberinds2/X2
    y3=where(age eq 3, count)
    age3=age[y3]
    x3 =count
    numberinds3 = round(pop*0.167)
    noperSI3 = numberinds3/X3
    y4=where(age eq 4, count)
    age4=age[y4]
    x4 =count
    numberinds4 = round(pop*0.065)
    noperSI4 = numberinds4/X4
    y5=where(age eq 5, count)
    age5=age[y5]
    x5 =count
    numberinds5 = round(pop*0.020)
    noperSI5 = numberinds5/X5
    y6=where(age eq 6, count)
    age6=age[y6]
    x6 =count
    numberinds6 = round(pop*0.006)
    noperSI6 = numberinds6/X6
    y7=where(age eq 7, count)
    age7=age[y7]
    x7 =count
    numberinds7 = round(pop*0.002)
    noperSI7 = numberinds7/X7
    y8=where(age eq 8, count)
    age8=age[y8]
    x8 =count
    numberinds8 = round(pop*0.001)
    noperSI8 = numberinds8/X8
    y9=where(age eq 9, count)
    age9=age[y9]
    x9 =count
    numberinds9 = round(pop*0.001)
    noperSI9 = numberinds9/X9

if noperSI7 lt (0.1*x7) then begin
 x7=(x7/10)
numberinds7=round(pop*0.001)
noperSI7=numberinds7/x7
endif
 
if noperSI8 lt (0.1*x8) then begin
 x8=(x8/10)
numberinds8=round(pop*0.001)
noperSI8=numberinds8/x8
endif

if noperSI9 lt (0.1*x9) then begin
 x9=(x9/10)
numberinds9=round(pop*0.001)
noperSI9=numberinds9/x9
endif

totsi=x1+x2+x3+x4+x5+x6+x7+x8+x9
print, 'totsi', totsi
nage=fltarr(totsi)
no_inds=fltarr(totsi)
a=0L
while a lt x1 do begin
nage[a]=1
no_inds[a]=noperSI1
a=a+1
endwhile
print, x1, a
w1=x1+x2
while (a ge x1) and (a lt w1) do begin
nage[a] =2
no_inds[a]=noperSI2
a=a+1
endwhile
print, w1, a
w2=w1+x3
while (a ge w1) and (a lt w2) do begin
nage[a]=3
no_inds[a]=noperSI3
a=a+1
endwhile
print, w2, a
w3=w2+x4
while (a ge w2) and (a lt w3) do begin
nage[a]=4
no_inds[a]=noperSI4
a=a+1
endwhile
print, w3, a
w4=w3+x5
while (a ge w3) and (a lt w4) do begin
nage[a]=5
no_inds[a]=noperSI5
a=a+1
endwhile
print, w4, a
w5=w4+x6
while (a ge w4) and (a lt w5) do begin
nage[a]=6
no_inds[a]=noperSI6
a=a+1
endwhile
print, w5, a
w6=w5+x7
while (a ge w5) and (a lt w6) do begin
nage[a]=7
no_inds[a]=noperSI7
a=a+1
endwhile
print, w6, a
w7=w6+x8
while (a ge w6) and (a lt w7) do begin
nage[a]=8
no_inds[a]=noperSI8
a=a+1
endwhile
print, w7, a
while (a ge w7) and (a lt totsi) do begin
nage[a]=9
no_inds[a]=noperSI9
a=a+1
endwhile
print, totsi, a

print, size(no_inds)
print, size(nage)
print, total(no_inds)    
end
