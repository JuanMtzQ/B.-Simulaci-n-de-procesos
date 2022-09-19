using PyPlot 

# Datos 
x = [2 4 6 8 10 12]
y = [1.4 3.5 8.0 7.3 9.2 10.0]

function RegresionLog(x, y)
    x = float(x)
    y = float(y)
    n = length(x)
    # Vectores de solución
    Log10_y = []
    Log10_x = []
    # Matriz de coeficientes
    suma_x = 0
    suma_x2 = 0
    # Matriz de resultados
    suma_y = 0
    suma_y2 = 0
    suma_xy = 0
    for i = 1:n
        append!(Log10_x, log10(x[i]))
        append!(Log10_y, log10(y[i]))
        suma_x += Log10_x[i]
        suma_y += Log10_y[i]
        suma_x2 += Log10_x[i]^2
        suma_y2 += Log10_y[i]^2
        suma_xy += Log10_x[i]*Log10_y[i]
    end
    # Cálculo de los coeficientes de ajuste
    a = (n*suma_xy - suma_x*suma_y) / (n*suma_x2 - suma_x^2)
    b = (suma_x2*suma_y - suma_x*suma_xy) / (n*suma_x2 - suma_x^2)
    # Valores para gráficar la función obtenida
    yn = []
    for i = 1:n
        append!(yn, 10^(b)*x[i]^a)
    end
    # Cálculo del indice de correlación
    media_x = suma_x/n
    media_y = suma_y/n
    media_x2 = suma_x2/n
    media_y2 = suma_y2/n
    media_xy = suma_xy/n
    r = (media_xy - media_x*media_y)/(sqrt(media_x2-media_x^2)*sqrt(media_y2-media_y^2))
    return a, b, yn, r
end

a, b, yn, r = RegresionLog(x, y)
# Gráfico
scatter(x, y)
plot(transpose(x), yn)
grid("True")
# Respuesta
println("Ajuste logaritmico")
println("y = 10^",b,"x^",a,"\nCon r = ", r)
