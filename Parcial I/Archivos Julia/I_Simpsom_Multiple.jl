# f(x) = 0.2 + 25*x - 200*x^2 + 675*x^3 - 900*x^4 + 400*x^5
f(x) = exp(x^2) + x^2 

function Trapecio(f, a, b)
    Integral = (b - a)*(f(a) + f(b))/2
    return Integral
end

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
    return Integral
end

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


function Simpson_Multiple(f, a, b, N)
    h = (b - a)/N
    sum = 0
    if N == 1
        sum = Trapecio(f, a, b)
    else
        m = N
        odd = N/2 - Integer(N/2)
        if odd > 0 && N > 1
            sum = sum + Simpson_3_8(f, a, b, N)
            m = N - 3
        end
        if m > 1
            sum = sum + Simpson_1_3_AM(f, a, b, N)
        end 
    end
    Simpson = sum
    return sum
end 

Integral = Simpson(f, 0.0, 0.8, 100)
println("Integral usando Simpson de aplicación multiple para elementos pares e impares =  ", Integral)