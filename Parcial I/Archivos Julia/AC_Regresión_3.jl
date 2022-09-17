using LinearAlgebra
using PyPlot

# Datos
x = [100 150 200 250 300 350 400 450 500 550 600 650 700 750 800]
y = [40.461 42.256 43.881 45.355 46.694 47.917 49.034 50.055 50.989 51.843 52.624 53.339 53.994 54.593 55.144]

# Regla de Cramer para uso en regresion polinomial
function Cramer(A, b)
    DetA = det(A)
    n = length(b)
    xi = []
    for i=1:n
        Apivot = copy(A)
        Apivot[:,i] = b
        DetApivot = det(Apivot)
        x = DetApivot/DetA
        append!(xi, x)
    end
    return xi
end

# Ajuste de curva
function RegresionPol_3(x, y)
    x = float(x)
    y = float(y)
    n = length(x)
    # Matriz de coeficientes
    suma_x = 0
    suma_x2 = 0
    suma_x3 = 0
    suma_x4 = 0
    suma_x5 = 0
    suma_x6 = 0
    # Matriz de resultados
    suma_y = 0
    suma_xy = 0
    suma_x2y = 0
    suma_x3y = 0
    for i = 1:n
        suma_x += x[i]
        suma_x2 += x[i]^2
        suma_x3 += x[i]^3
        suma_x4 += x[i]^4
        suma_x5 += x[i]^5
        suma_x6 += x[i]^6
        # Resultados
        suma_y += y[i]
        suma_xy += x[i]*y[i]
        suma_x2y += y[i]*x[i]^2
        suma_x3y += y[i]*x[i]^3
    end
    # Resolución de matriz con regla de Cramer
    A = [n suma_x suma_x2 suma_x3;
        suma_x suma_x2 suma_x3 suma_x4;
        suma_x2 suma_x3 suma_x4 suma_x5;
        suma_x3 suma_x4 suma_x5 suma_x6]
    b = [suma_y; suma_xy; suma_x2y; suma_x3y]
    ai = Cramer(A, b)
    # Aproximación a los resultados
    yn = []
    for i = 1:n
        # y = a0 + a1*x + a2*x^2 + a3*x^3 
        append!(yn, ai[1] + ai[2]*x[i] + ai[3]*x[i]^2 + ai[4]*x[i]^3)
    end
    # Cálculo del coeficiente de correlación
    media_y = suma_y/n
    suma_1 = 0
    suma_2 = 0
    for i = 1:n
        suma_1 += (y[i] - media_y)^2
        suma_2 += (y[i] - ai[1] - ai[2]*x[i] - ai[3]*x[i]^2 - ai[4]*x[i]^3)^2
    end
    r = (suma_1 - suma_2)/suma_1
    return ai, r, yn
end

ai, r, yn = RegresionPol_3(x, y)
scatter(x, y) 
plot(transpose(x), yn, "r") # Gráfica el ajuste
grid("True")
title("Ajuste polinomico de tercer orden")
println(" y = (", ai[1], ") + (", ai[2], ") x + (", ai[3], ") x^2  + (", ai[4],") x^3 \nCon un ajuste r = ", round(r, digits=4))
