using PyPlot

x = [2 4 6 8 10 12]
y = [1.4 3.5 8.0 7.3 9.2 10.0]

function RegresionLineal(x, y)
    N = length(x) # Elementos totales 
    suma_x = 0 # Inicializadores 
    suma_y = 0
    suma_xy = 0
    suma_x2 = 0
    suma_y2 = 0
    for i=1:N # Acumuladores
        suma_x = suma_x + x[i]
        suma_y = suma_y + y[i]
        suma_xy = suma_xy + x[i]*y[i]
        suma_x2 = suma_x2 + x[i]^2
        suma_y2 = suma_y2 + y[i]^2
    end 
    # Coeficientes y = ax + b
    a = (N*suma_xy - suma_x*suma_y)/(N*suma_x2 - suma_x^2)
    b = (suma_x2*suma_y - suma_x*suma_xy)/(N*suma_x2 - suma_x^2)
    yn = []
    for i=1:N
        append!(yn, a*x[i]+b)
    end
    # Calculo del ajuste r
    x_media = suma_x/N
    y_media = suma_y/N
    xy_media = suma_xy/N
    x2_media = suma_x2/N
    y2_media = suma_y2/N
    r = (xy_media - x_media*y_media)/(√(x2_media - x_media^2)*√(y2_media - y_media^2))
    return a, b, yn, r
end 

a, b, yn, r = RegresionLineal(x, y)
scatter(x, y)
plot(transpose(x), yn, "r")
title("Ajuste lineal")
println("Ajuste lineal")
println(" y = ", a, "x ", b, "\nCon r = ", r)