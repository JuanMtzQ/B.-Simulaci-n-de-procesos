using PyPlot
using LinearAlgebra

T = [595 623 761 849 989 1076 1146 1202 1382 1445 1562] # K
k = [2.12 3.12 14.4 30.6 80.3 131 186 240 489 605 868]*10^-20 #( m^3/s)

function RegresionExponencial(x, y)
    N = length(x)
    ln_y = []
    ln_x = []
    suma_x = 0
    suma_y = 0
    suma_xy = 0
    suma_x2 = 0
    suma_y2 = 0
    for i=1:N # Acumuladores
        append!(ln_x, log(x[i]))
        append!(ln_y, log(y[i]))
        suma_x = suma_x + ln_x[i]
        suma_y = suma_y + ln_y[i]
        suma_xy = suma_xy + ln_x[i]*ln_y[i]
        suma_x2 = suma_x2 + ln_x[i]^2
        suma_y2 = suma_y2 + ln_y[i]^2
    end 
    # Coeficientes y = ax + b
    a = (N*suma_xy - suma_x*suma_y)/(N*suma_x2 - suma_x^2)
    b = (suma_x2*suma_y - suma_x*suma_xy)/(N*suma_x2 - suma_x^2)
    yn = []
    for i = 1:N
        append!(yn, exp(b)*x[i]^a)
    end
    # Calculo del ajuste r
    x_media = suma_x/N
    y_media = suma_y/N
    xy_media = suma_xy/N
    x2_media = suma_x2/N
    y2_media = suma_y2/N
    r = (xy_media - x_media*y_media)/(√(x2_media - x_media^2)*√(y2_media - y_media^2))
    scatter(x, y)
    plot(transpose(x), yn, "g", label = "Exponencial")
    legend()
    title("Ajuste exponencial")
    println("Ajuste exponencial")
    println(" y = ", exp(b), "x^", a, "\nCon r = ", r)
end
ai, r, yn = RegresionExponencial(T, k)

scatter(T, k)
plot(transpose(T), yn, "m")
title("Velocidad de reaccion respecto a la temperatura")
xlabel("Temperatura (K)")
ylabel("Velocidad (k)")
println("Ajuste cuadratico")
println(" y = (", ai[1], ") + (", ai[2], ") x + (", ai[3], ") x^2\nCon r = ", r)

# Falta forma logaritmica