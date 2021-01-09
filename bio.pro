;function to determine biomass of YOY
FUNCTION bio, YOY

co_wt=YOY[3,*]*YOY[7,*]

biomass = TOTAL(co_wt) ;in g
biomass=biomass/1000 ;in kg
;print, biomass
return, biomass
end