f(x) = x/(x^3 - x + 3)

function DerivadaAdelante(f, xi, h)
    # Valores de xi
    xi_1 = xi + h
    xi_2 = xi + 2*h
    # Primera derivada
    dfx_1_ord = (f(xi_1) - f(xi))/h
    # Segunda derivada
    dfx_2_ord = (f(xi_2) - 2*f(xi_1) + f(xi))/h^2
    return [dfx_1_ord, dfx_2_ord]
end

function DerivadaAtras(f, xi, h)
    # Valores de xi
    xi_1 = xi - h
    xi_2 = xi - 2*h
    xi_3 = xi - 3*h
    # Primera derivada
    dfx_1_ord = (f(xi) - f(xi_1))/h
    # Segunda derivada
    dfx_2_ord = (f(xi) - 2*f(xi_1) + f(xi_2))/h^2
    return [dfx_1_ord, dfx_2_ord]
end

function DerivadaCentrada(f, xi, h)
    xi1 = xi + h # Punto adelante
    xi_1 = xi - h # Punto atrás 
    xi2 = xi + 2*h 
    xi_2 = xi - 2*h
    # Primera derivada
    dfx_1_ord = (f(xi1) - f(xi_1))/2*h
    # Segunda derivada
    dfx_2_ord = (f(xi1) - 2*f(xi) + f(xi_1))/(h^2)
    return [dfx_1_ord, dfx_2_ord]
end 

D1_Atras, D2_Atras = DerivadaAdelante(f, 10, 0.01)
D1_Cent, D2_Cent = DerivadaCentrada(f, 10, 0.01)
D1_Adel, D2_Adel  = DerivadaAdelante(f, 10, 0.01)

D1 = [D1_Atras, D1_Cent, D1_Adel]
D2 = [D2_Atras, D2_Cent, D2_Adel]

for i in D1
    println("Primera derivada: ", i)
end
println("")
for i in D1
    println("Segunda derivada: ", i)
end