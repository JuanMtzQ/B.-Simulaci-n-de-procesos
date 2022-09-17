f(x) = x^2 + 2*x - 4
g(x) = (4-x^2)/2

function PuntoFijo(g, x0, ϵ)
    i = 1
    xi_vector = [Float64(x0)]
    Tolerancia = 10
    error_relativo = [0.0]
    while Tolerancia <= -ϵ || Tolerancia >= ϵ
        xrold = x0
        xr = g(xrold)
        append!(xi_vector, xr)
        Tolerancia = abs(xr - xrold)/abs(xr)*100
        append!(error_relativo, Tolerancia)
        println("Iteracion ", i , " = ", x0)
        x0 = xr
        i += 1
    end
    return xr
end

PuntoFijo(g, -5, 0.0001)