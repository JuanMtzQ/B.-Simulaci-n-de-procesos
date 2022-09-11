using PyPlot
using LinearAlgebra

T = [595 623 761 849 989 1076 1146 1202 1382 1445 1562] # K
k = [2.12 3.12 14.4 30.6 80.3 131 186 240 489 605 868] # x10^20 (m^3/s)

function RegresionCuadratica(x, y)
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

ai, r, yn = RegresionCuadratica(T, k)

scatter(T, k)
plot(transpose(T), yn, "m")
title("Velocidad de reaccion respecto a la temperatura")
xlabel("Temperatura (K)")
ylabel("Velocidad k")
println("Ajuste cuadratico")
println(" y = (", ai[1], ") + (", ai[2], ") x + (", ai[3], ") x^2\nCon r = ", r)