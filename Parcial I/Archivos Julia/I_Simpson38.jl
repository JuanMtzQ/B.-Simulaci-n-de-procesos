f(x) = exp(x^2) + x^2 
# f(x) = 0.2 + 25*x - 200*x^2 + 675*x^3 - 900*x^4 + 400*x^5
"""N debe de ser múltiplo de 3"""
function Simpson_3_8(f, a, b, N_3)
    h = (b - a)/N_3
    suma_1 = 0 # Sumatoria de cada 3 elementos a partir del primer elemento
    suma_2 = 0 # Sumatoria de cada 3 elementos a partir del segundo elemento
    suma_3 = 0 # Sumatoria de cada 3 elementos a partir del tercer elemento
    x = []
    # Creación de divisiones
    for i = 1:N_3
        append!(x,  a + h*i)
    end 
    # Acumulación de la primera suma
    for i = 1:3:(N_3-2)
        suma_1 += f(x[i])
    end 
    # Acumulación de la segunda suma
    for i = 2:3:(N_3-1)
        suma_2 += f(x[i])
    end 
    # Acumulación de la tercera suma
    for i = 3:3:(N_3-3)
        suma_3 += f(x[i])
    end 
    Integral = (3*h)/8*(f(a) + 3*suma_1 + 3*suma_2 + 2*suma_3 + f(b) )
    return Integral
end

Resultado = Simpson_3_8(f, 0, 1, 9)
println("El resultado de la integral es = ", Resultado)
