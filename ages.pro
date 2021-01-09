;function to determine number of fish in each age category
FUNCTION ages, inds

;inds=fltarr(20,40)
;inds[6,0:3] = 1
;inds[6,4:5] = 2
;inds[6,6:9] = 3
;inds[6,10:14] = 4
;inds[6,15:19] = 5
;inds[6,20:23] = 6
;inds[6,24:28] = 7
;inds[6,29:32] = 8
;inds[6,33:35] = 9
;inds[6,36:39] = 10
;inds[7,0:10] = 10
;inds[7,11:20] = 20
;inds[7,21:39] = 50

n=n_elements(inds[6,*])
num = fltarr(10,n)
numbers = fltarr(10)
no_inds =inds[7,*]
age=inds[6,*]

for i=0L, n-1 do begin
case age[i]  of
1: num[0,i] = no_inds[i]
2: num[1,i] = no_inds[i]
3: num[2,i] = no_inds[i]
4: num[3,i] = no_inds[i]
5: num[4,i] = no_inds[i]
6: num[5,i] = no_inds[i]
7: num[6,i] = no_inds[i]
8: num[7,i] = no_inds[i]
9: num[8,i] = no_inds[i]
10: num[9,i] =no_inds[i]
endcase
endfor

numbers[0] = TOTAL(num[0,*])
numbers[1] = TOTAL(num[1,*])
numbers[2] = TOTAL(num[2,*])
numbers[3] = TOTAL(num[3,*])
numbers[4] = TOTAL(num[4,*])
numbers[5] = TOTAL(num[5,*])
numbers[6] = TOTAL(num[6,*])
numbers[7] = TOTAL(num[7,*])
numbers[8] = TOTAL(num[8,*])
numbers[9]= TOTAL(num[9,*])
;print,numbers 
return, numbers
;print, num
;print, totinds, totval1, meanval
end