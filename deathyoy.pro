;function to remove dead individuals

FUNCTION deathyoy, YOY
;inds = [[1,1234],[1,42324],[1,1542],[1,14234],[1,0],[1,1242],[1,142],[1,0]]
dead = where(YOY[7,*] le 0.0, count)
if count gt 0.0 then begin
dims =size(YOY,/dimensions)
nrows =dims[1]
index=replicate(1L,nrows)
index[dead]=0L
keeprow= where(index eq 1)
YOY =YOY[*,keeprow]
endif
;print, inds
return, YOY
end