using PyPlot

# Funcion
f(x,y) = x^2-3*y


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

# Datos y solución 
x1, x2, y0, n = 0, 4, 1, 50
x, y = RungeKutta4(f, x1, x2, y0, n)

# Gráfica
scatter(x, y)
title("Resolucion de EDO mediante método de Runge-Kutta 4to orden")
grid("True")