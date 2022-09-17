using PyPlot

# Ecuación diferencial
f(x,y) = x^2-3*y

# Da resultados exactos cuando la solución es cuadratica
function RungeKutta2(fxy, x1, x2, y0, n)
    h = (x2 - x1)/n # Tamaño de paso
    # Arreglos donde se guardaran la solucion 
    x = []
    y = []
    # Solucion y(0) = y0
    append!(y, y0)
    # Generacion de los puntos xi
    for i = 0:n
        append!(x, x1+h*i)
    end
    # Aplicación del método
    for j = 1:n
        k1 = fxy(x[j], y[j])
        k2 = fxy(x[j] + h, y[j] + k1*h)
        append!(y, y[j] + h/2*(k1 + k2)) # Método de Heun
    end 
    return x, y
end 

# Datos y solución
x1, x2, y0, n = 0, 4, 1, 50
x, y = RungeKutta2(f, x1, x2, y0, n)

# Gráfica
scatter(x, y)
title("Resolucion de EDO mediante método de Runge-Kutta 2to orden")
grid("True")
