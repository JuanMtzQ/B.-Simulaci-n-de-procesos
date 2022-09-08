f(x) = x/(x^3 - x + 3)

function DerivadaAdelante(fx, xi, h)
    println("\n---- Derivada hacia adelante ----")
    # Valores de xi
    xi_1 = xi + h
    xi_2 = xi + 2*h
    xi_3 = xi + 3*h
    # Primera derivada
    dfx_1_ord = (f(xi_1) - f(xi))/h
    dfx_1_pascal = (-f(xi_2) + 4*f(xi_1) - 3*f(xi))/(2*h)
    println("Primera derivada → Ord: ", dfx_1_ord, " Pascal : ", dfx_1_pascal)

    # Segunda derivada
    dfx_2_ord = (f(xi_2) - 2*f(xi_1) + f(xi))/h^2
    dfx_2_pascal = (-f(xi_3) + 4*f(xi_2) - 5*f(xi_1) + 2*f(xi))/h^2
    println("Segunda derivada → Ord: ", dfx_2_ord, " Pascal : ", dfx_2_pascal)
end

function DerivadaAtras(fx, xi, h)
    println("\n---- Derivada hacia atrás ----")
    # Valores de xi
    xi_1 = xi - h
    xi_2 = xi - 2*h
    xi_3 = xi - 3*h
    # Primera derivada
    dfx_1_ord = (f(xi) - f(xi_1))/h
    dfx_1_pascal = (3*f(xi) - 4*f(xi_1) + f(xi_2))/(2*h)
    println("Primera derivada → Ord: ", dfx_1_ord, " Pascal : ", dfx_1_pascal)

    # Segunda derivada
    dfx_2_ord = (f(xi) - 2*f(xi_1) + f(xi_2))/h^2
    dfx_2_pascal = (2*f(xi) - 5*f(xi_1) + 4*f(xi_2) - f(xi_3))/h^2
    println("Segunda derivada → Ord: ", dfx_2_ord, " Pascal : ", dfx_2_pascal)
end

function DerivadaCentrada(fx, xi, h)
    println("\n---- Derivada centrada ----")
    xi1 = xi + h # Punto adelante
    xi_1 = xi - h # Punto atrás 
    xi2 = xi + 2*h 
    xi_2 = xi - 2*h

    # Primera derivada
    dfx_1_ord = (f(xi1) - f(xi_1))/2*h
    dfx_1_pascal = (-f(xi2) + 8*f(xi1) - 8*f(xi_1) + f(xi_2))/(12*h)
    println("Primera derivada → Ord: ", dfx_1_ord, " Pascal : ", dfx_1_pascal)

    # Segunda derivada
    dfx_2_ord = (f(xi1) - 2*f(xi) + f(xi_1))/(h^2)
    dfx_2_pascal =(-f(xi2) + 16*f(xi1) - 30*f(xi) + 16*f(xi_1) - f(xi_2))/(12*h^2)
    println("Segunda derivada → Ord: ", dfx_2_ord, " Pascal : ", dfx_2_pascal)
end 

function ComparacionDerivadas(f, xi, h)
    DerivadaAdelante(f, xi, h)
    DerivadaAtras(f, xi, h)
    DerivadaCentrada(f, xi, h)
end

ComparacionDerivadas(f, 3, 0.00001)