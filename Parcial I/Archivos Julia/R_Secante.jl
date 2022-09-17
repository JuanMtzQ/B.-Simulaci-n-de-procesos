f(x) = x^2 + 2*x - 4

function Dif_Atras(f, xi, h)
    x0 = xi - h
    fx_prima = (f(xi) - f(x0))/h
    return fx_prima
end

# Secante(funcion, punto_inicial, tamaño de paso (entre más pequeño mejor), criterio de convergencia (ej: 0.0001))
function Secante(f, x0, h, ϵ)
    while f(x0) <= -ϵ || f(x0) >= ϵ
        xr = x0 - f(x0)/Dif_Atras(f, x0, h)
        x0 = xr
    end
    return x0
end


Secante(f, 5, 0.01, 0.001)