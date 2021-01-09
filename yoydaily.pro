;this function prints out yearly growth of YOY
Function YOYdaily, YOY, biomass, p, a, mortality

growth = fltarr(18)

growth [0] = a
growth [1] = mean(YOY[2,*]) ;mean length
growth [2] = stddev(YOY[2,*]) ;stdev length
growth [3] = max(YOY[2,*]) ;max length
growth [4] = min(YOY[2,*]) ;min length
growth [5] = mean(YOY[3,*]) ;mean weight
growth [6] = stddev(YOY[3,*]) ;stdev weight
growth [7] = max(YOY[3,*]) ;max weight
growth [8] = min(YOY[3,*]) ;min weight
growth [9] = mean(YOY[4,*]) ;mean storage weight
growth [10] = stddev(YOY[4,*]) ;stdev storage weight
growth [11] = mean(p)
growth [12] = stddev(p)
growth [13] = biomass
growth [14] = total(YOY[7,*])
growth [15] = total(mortality[0,*])
growth [16] = total(mortality[1,*])
growth [17] = total(mortality[2,*])

return, growth
end