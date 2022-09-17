using LinearAlgebra
using PyPlot

# Datos
T = [273.15 278.15 283.15 293.15 303.15 313.15 333.15 353.15 373.15]
mu = [1.787*10^-3 1.519*10^-3 1.307*10^-3 1.002*10^-3 7.975*10^-4 6.529*10^-4 4.665*10^-4 3.547*10^-4 2.828*10^-4]

# Regresión polinomica => Ajustar a modelo a la cuarta
function RegresionPolinomial(x, y)
    x = float(x)
    y = float(y)
    n = length(x)
    suma_x = 0
    suma_x2 = 0
    suma_y = 0
    suma_x3 = 0
    suma_xy = 0
    suma_x4 = 0
    suma_x2y = 0
    for i=1:n
        suma_x = suma_x + x[i]
        suma_x2 = suma_x2 + x[i]^2
        suma_y = suma_y + y[i]
        suma_x3 = suma_x3 + x[i]^3
        suma_xy = suma_xy + x[i]*y[i]
        suma_x4 = suma_x4 + x[i]^4
        suma_x2y = suma_x2y + y[i]*x[i]^2
    end
    
    # Resolución de matriz con regla de Cramer
    A = [n suma_x suma_x2; suma_x suma_x2 suma_x3; suma_x2 suma_x3 suma_x4]
    b = [suma_y; suma_xy; suma_x2y]
    tam_matriz = size(A)
    DetA = det(A)
    ai = [] # [a0, a1, a2]
    for i=1:tam_matriz[1]
        Apivot = copy(A)
        Apivot[:,i] = b
        DetApivot = det(Apivot)
        a = DetApivot/DetA
        append!(ai, a)
    end

    # Aproximacion a los resultados
    yn = []
    for i = 1:n
        append!(yn, ai[1] + ai[2]*x[i] + ai[3]*x[i]^2)
    end

    # Cálculo del coeficiente de correlacion
    media_y = suma_y/n
    suma_1 = 0
    suma_2 = 0
    for i=1:n
        suma_1 = suma_1 + (y[i] - media_y)^2
        suma_2 = suma_2 + (y[i] - ai[1] - ai[2]*x[i] - ai[3]*x[i]^2)^2
    end 
    r = (suma_1 - suma_2)/suma_1
    return ai, r, yn
end
# Ajuste polinomico de segundo orden
ai, r, yn = RegresionPolinomial(T, mu)
scatter(T, mu)
plot(transpose(T), yn, "r")
title("Ajuste polinomico de segundo orden")
xlabel("Temperatura (K)")
ylabel("Viscosidad (Pa*s)")
println(" y = (", ai[1], ") + (", ai[2], ") x + (", ai[3], ") x^2\nCon un ajuste r = ", r)

T_pred = 50 + 273.15
mu_pred = ai[1] + ai[2]*T_pred + ai[3]*T_pred^2
println("Viscosidad aproximada con modelo de segundo orden: ", round(mu_pred, digits=8))
