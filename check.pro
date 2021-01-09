function check, f
x=5.0
q=fltarr(5)
for i=0,4 do begin
q(i)=f(i)*x
endfor
return, q
end  