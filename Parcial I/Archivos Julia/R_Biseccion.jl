f(x) = x^2 + 2*x - 4

function Biseccion(f, a0, b0, ϵ)
    xr = 2 #Aproximacion inicial 
    while f(xr) <= -ϵ || f(xr) >= ϵ
        #Ecuacion del metodo
        xr = (a0 + b0)/2
        #Descartar subintervalos
        if f(a0)*f(xr) < 0
            b0 = xr 
        end 
        if f(xr)*f(b0) < 0
            a0 = xr 
        end    
    end
    return xr
end

Biseccion(f, 0, 5, 0.0001)