using PyPlot

Tiempo = [10 15 20 25 40 50 55 60 75]
Esfuerzo = [5 20 18 40 33 54 70 60 78]
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
    return a, b, r, yn
end

a, b , r, yn = RegresionLineal(Tiempo, Esfuerzo)
# Primer analisis: regresion original
figure(1)
scatter(Tiempo, Esfuerzo)
plot(transpose(Tiempo), yn, "r")
title("Ajuste lineal")
xlabel("Tiempo")
ylabel("Esfuerzo a la tensión")
grid("True")
println("Ajuste lineal")
println(" y = ", round(a, digits=4), "x +", round(b, digits=4), "\nCon r = ", round(r, digits=4))
t_32 = a*32 + b
println("Esfuerzo a la tensión en a los 32 min: ", round(t_32, digits = 4))


# Usar ajuste proporcional
# Segundo analisis: ajuste proporcional
function AjusteProporcional(x, y)
    N = length(x)
    sum_xy = 0
    sum_x2 = 0
    for i=1:N # Acumuladores
        sum_xy = sum_xy + x[i]*y[i]
        sum_x2 = sum_x2 + x[i]^2
    end 
    # Coeficientes y = ax
    a_p = sum_xy/sum_x2
    yn_p = []
    for i=1:N
        append!(yn_p, a*x[i])
    end
    return a_p, yn_p
end

a_p, yn_p = AjusteProporcional(Tiempo, Esfuerzo)

# Gráfico
figure(2)
scatter(Tiempo, Esfuerzo)
plot(transpose(Tiempo), yn_p, "m")
title("Ajuste proporcional")
xlabel("Tiempo")
ylabel("Esfuerzo a la tensión")
grid("True")
println("\nAjuste proporcional")
println(" y = ", round(a_p, digits=4), "x")
t_32_p = a_p*32 
println("Esfuerzo a la tensión en a los 32 min: ", round(t_32_p, digits=4))