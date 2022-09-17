using PyPlot

Temperaturas = [20, 40, 60] #°F
Velocidades = collect(4:40) # mi/h

# Conversion de temperatura y velocidades
function F_to_C(F)
    C = (F - 32)*5/9
    return C
end

function mi_to_km(mi)
    km = mi*1.609344
    return km
end

# Ecuaciones de temperatura
function Tequiv_F(Tambiente, Velocidad)
    Tequiv_F = 91.4 - (91.4 - Tambiente) * 0.475 - 0.0203 * Velocidad + 0.304 * √Velocidad
    return Tequiv_F
end

# Ciclo para obtener perfiles
Temp_F = []
for T in Temperaturas
    for V in Velocidades 
        T_F = Tequiv_F(T, V)
        append!(Temp_F, T_F)
    end
end

# Segmentación de los resultados de acuerdo a la temperatura usada
Temp_F_20 = Temp_F[1:37]
Temp_F_40 = Temp_F[38:74] 
Temp_F_60 = Temp_F[75:end]

# Gráfico
# Unidades inglesas
figure(1)
plot(Velocidades, Temp_F_20, label = "20 °F")
plot(Velocidades, Temp_F_40, label = "40 °F")
plot(Velocidades, Temp_F_60, label = "60 °F")
legend()
title("Temperaturas equivalentes por enfriamiento de viento")
xlabel("Velocidad (mi/h)")
ylabel("Temperatura equivalente (°F)")

# Unidades internacionales 
figure(2)
plot(mi_to_km(Velocidades), F_to_C.(Temp_F_20), label = "-6.6 °C")
plot(mi_to_km(Velocidades), F_to_C.(Temp_F_40), label = "4.40 °C")
plot(mi_to_km(Velocidades), F_to_C.(Temp_F_60), label = "15.5 °C")
legend()
title("Temperaturas equivalentes por enfriamiento de viento")
xlabel("Velocidad (km/h)")
ylabel("Temperatura equivalente (°C)")