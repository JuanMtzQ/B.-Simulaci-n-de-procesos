# f(x) = exp(x^2) + x^2 
f(x) = 0.2 + 25*x - 200*x^2 + 675*x^3 - 900*x^4 + 400*x^5

# Regla de Simpson 1/3
function Simpson_1_3(f, a, b, N_impar)
    n = N_impar - 1 # Divisiones
    h = (b-a)/n # Tamaño de paso
    xi = [] # Vector de Divisiones
    suma_1 = 0 # Primer elemento suma
    suma_2 = 0 # Segundo elemento suma
    lim = Integer((n-2)/2)  #Flotante a entero para evitar problemas con Julia
    #División de elementos
    for i=0:n
        append!(xi, a+h*i)
    end
    # Elementos de la primera suma_1
    if lim >=1
        for k=0:lim
            suma_1 = suma_1 + f(xi[2*k+1])
        end
    end
    #Elementos de la segunda suma_2
    if lim>=2 # De lo contrario, el valor de (n-2)/2 hubiera dado negativo, lo que 
        for k = 1:lim
            suma_2 = suma_2 + f(xi[2*k])
        end
    end
    Integral = h/3*(f(a)+ f(b) + 4*suma_1 + 2*suma_2)
    return round(Integral, digits = 6)
end


# Regla de Simpson 1/3 con aplicacion multiple
"""N debe ser par"""
function Simpson_1_3_AM(f, a, b, N_par)
    h = (b-a)/N_par
    suma_1 = 0 # Sumatoria de cada 3 elementos a partir del primer elemento
    suma_2 = 0 # Sumatoria de cada 3 elementos a partir del segundo elemento
    x = []
    # Creación de divisiones
    for i = 1:N_par
        append!(x,  a + h*i)
    end 
    # Acumulación de la primera suma
    for i = 1:2:(N_par-1)
        suma_1 += f(x[i])
    end 
    # Acumulación de la segunda suma
    for j = 2:2:(N_par-2)
        suma_2 += f(x[j])
    end 
    Integral = (b-a)/(3*N_par)*(f(a) + 4*suma_1 + 2*suma_2 + f(b) )
    return round(Integral, digits = 6)
end

Integral = Simpson_1_3(f, 0, 0.8, 101)
println("Integral usando Simpson 1/3 =  ", Integral)

Integral = Simpson_1_3_AM(f, 0, 0.8, 100)
println("Integral usando Simpson 1/3 con aplicación multiple =  ", Integral)
