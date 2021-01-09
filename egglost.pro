
;determine # inds lost from each SI during development
FUNCTION egglost, no_inds, T

    n=n_elements(no_inds)
    Z =fltarr(n)
    eloss=fltarr(n)
    egg_loss=fltarr(n)
    for i=0L, n-1 do begin
    Z(i) = 0.52 - 0.036 * T ;instantaneous mort for eggs from Rose et al. 1999
    eloss(i) = 1-EXP(-Z(i))
    no_inds(i) = no_inds(i)*egg_loss(i) ;removal of eggs lost before hatch
    endfor
    return, no_inds
end  