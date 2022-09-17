using PyPlot

# Ecuación diferencial
f(x,y) = x^2-3*y
# f(x, y) = x - y 

function Euler(fxy, x1, x2, y0, n)
    h = (x2 - x1)/n # Tamaño de paso
    x = [] # Solucion de x
    y = [] # Solucion de y
    append!(y, y0) # El primer valor de y(0) = b
    # Generación de los puntos en el vector xi
    for i = 0:n
        append!(x, x1+h*i)
    end
    # Aplicación del método
    for j = 1:n
        append!(y, y[j] + fxy(x[j], y[j])*h)
    end
    return x, y
end

# Datos 
x1, x2, y0, n = 0, 4, 1, 50
x, y = Euler(f, x1, x2, y0, n)

# Gráfica
scatter(x, y)
title("Resolucion de EDO mediante método de Euler")
grid("True")