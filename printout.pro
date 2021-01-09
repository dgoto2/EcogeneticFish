;function to print items out on an annual basis
FUNCTION printout, iyear, inds, YOY
;inds = fltarr(8,5)
;inds[2,*]=20.0
;inds[3,*]=30.0
;inds[7,*]=100.0
;iyear = 0

n=n_elements(inds[0,*])
m=n_elements(YOY[0,*])
summary = fltarr(21)
wt=fltarr(n)
wtYOY=fltarr(m)


for i=0L,n-1 do begin
  wt(i) = inds[3,i]*inds[7,i]
endfor
for ii=0L,m-1 do begin
 wtYOY(ii) = YOY[3,ii]*YOY[7,ii]
endfor

  TotBiomass = TOTAL(wt)
  TotYOYBiom = TOTAL(wtYOY)
  AveL = mean(inds[2,*])
  AveLYOY = mean(YOY[2,*])
  Avewt = mean(inds[3,*])
  AvewtYOY= mean(YOY[3,*])
  Abun = TOTAL(inds[7,*])
  AbunYOY = TOTAL(YOY[7,*])
  
  gene1=[[YOY[8,*]],[YOY[9,*]]]
   gene2=[[YOY[10,*]],[YOY[11,*]]]
    gene3=[[YOY[12,*]],[YOY[13,*]]]
     gene4=[[YOY[14,*]],[YOY[15,*]]]
      gene5=[[YOY[16,*]],[YOY[17,*]]]
       gene6=[[YOY[18,*]],[YOY[19,*]]]

all1ave=mean(gene1)
all1stdev=stddev(gene1)  
all2ave=mean(gene2)
all2stdev=stddev(gene2)
all3ave=mean(gene3)
all3stdev=stddev(gene3)
all4ave=mean(gene4)
all4stdev=stddev(gene4)
all5ave=mean(gene5)
all5stdev=stddev(gene5)
all6ave=mean(gene6)
all6stdev=stddev(gene6) 
             
  summary[9] = all1ave
  summary[10] = all1stdev
  summary[11] = all2ave
  summary[12] = all2stdev
  summary[13] = all3ave
  summary[14] = all3stdev
  summary[15] = all4ave
  summary[16] = all4stdev
  summary[17] = all5ave
  summary[18] = all5stdev
  summary[19] = all6ave
  summary[20] = all6stdev
  
  summary[0] = iyear
  summary[1] = TotBiomass
  summary[2] = TotYOYBiom
  summary[3] = AveL
  summary[4] = AveLYOY
  summary[5] = Avewt
  summary[6] = AvewtYOY
  summary[7] = Abun
  summary[8] = AbunYOY
  
return, summary 
end
