using PyPlot
using LinearAlgebra

# Funcion a resolver
f(x,y) = x^2-3*y

#Busqueda de puntos mediante Runge-Kutta 4to orden
function RungeKutta4(fxy, x1, x2, y0, n)
    h = (x2-x1)/n # Tamaño de paso
    xi = [] # Solucion de x
    yi = [] # Solucion de y
    append!(yi, y0) # El primer valor de y(0) = b
    # Generación de puntos xi
    for i = 0:n # Generación de puntos xi
        append!(xi, x1+h*i)
    end
    # Aplicación del método
    for i=1:n 
        k1 = h*fxy(xi[i], yi[i])
        k2 = h*fxy(xi[i] + h/2, yi[i] + k1/2)
        k3 = h*fxy(xi[i] + h/2, yi[i] + k2/2)
        k4 = h*fxy(xi[i] + h, yi[i] + k3)
        append!(yi, yi[i] + 1/6*(k1 + 2*k2 + 2*k3 + k4))
    end
    return xi, yi # Ajustar a una función después
end

# Asignación de datos
xi, yi = RungeKutta4(0, 1, 4, 50, f)

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
function RegresionCuadratica(x, y)
    # x = float(x)
    # y = float(y)
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

# Generación de gráfico
ai, r, yn = RegresionCuadratica(xi, yi)
scatter(xi, yi) # Grafica los puntos arrojados por Runge-Kutta 4to orden
plot(transpose(xi), yn, "r") # Gráfica el ajuste
title("Ajuste polinomico de segundo orden")
println(" y = (", ai[1], ") + (", ai[2], ") x + (", ai[3], ") x^2\nCon un ajuste r = ", round(r, digits=4))
