using LinearAlgebra
using PyPlot

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
function RegresionPol_2(x, y)
    x = float(x)
    y = float(y)
    n = length(x)
    # Matriz de coeficiente
    suma_x = 0
    suma_x2 = 0
    suma_x3 = 0
    suma_x4 = 0
    # Matriz de resultados
    suma_y = 0
    suma_xy = 0
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
    ai = Cramer(A, b)
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

ai, r, yn = RegresionPol_2(x, y)
scatter(x, y) 
plot(transpose(x), yn, "r") # Gráfica el ajuste
grid("True")
title("Ajuste polinomico de segundo orden")
println(" y = (", ai[1], ") + (", ai[2], ") x + (", ai[3], ") x^2 \nCon un ajuste r = ", round(r, digits=4))
