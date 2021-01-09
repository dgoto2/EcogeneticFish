;function to remove dead individuals

FUNCTION death, inds
;inds = [[1,1234],[1,42324],[1,1542],[1,14234],[1,0],[1,1242],[1,142],[1,0]]
dead = where(inds[7,*] le 0.0, count)
if count gt 0.0 then begin
dims =size(inds,/dimensions)
nrows =dims[1]
index=replicate(1L,nrows)
index[dead]=0L
keeprow= where(index eq 1)
inds =inds[*,keeprow]
endif
;print, inds
return, inds
end