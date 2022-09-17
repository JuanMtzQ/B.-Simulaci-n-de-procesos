using PyPlot
# Datos del problema
# Corriente externa
fm_ext = 5.0 # kg/s
Cp_ext = 4.0 # kJ/kg °C
T1_e = 100 # °C
T2_s = 50 # °C

#Corriente interna
fm_int = 5.0 # kg/s
Cp_int = 4.0  # kJ/kg °C
T1_e = float(collect(15:25)) # °C

# Datos supuestos de momento
U = 230 # W/m^2 °C

# Balance de energia
function Q(fm, Cp, T2, T1)
    Q = fm*Cp*(T2-T1)
    return Q
end 

# Despeje del balance de energia para la corriente interna
function T_s(Q, fm, Cp, T_e)
    T_s = Q/(fm*Cp) + T_e
    return T_s
end

# Media logaritmica de las temperaturas
# Me da error al momento de evaluar esta función
function DT_lm(T2_s, T2_e, T1_s, T1_e)
    # DT_lm = ((T1_e-T2_s) - (T1_s-T2_e)) / log((T1_e-T2_s)/(T1_s-T2_e))
    DT_lm = ((T2_s-T2_e)-(T1_s-T1_e))/(log(T2_s-T2_e)-log(T1_s-T1_e))
    return DT_lm
end 

# Calculo del área
function A(Q, U, DT_lm)
    A = Q/(U*DT_lm)
    return A
end 

Q_ext = Q(fm_ext, Cp_ext, T2_s, T2_e)
Q_int = Q_total = -Q_ext
println("Calor obtenido: ", Q_total)

# Generando los datos para cada posible temperatura de la entrada
T1_s = []
DT_lm_list = []
A_list = []
for i in T1_e # Para cada valor de la temperatura de entrada
    T1_s_cal = T_s(Q_int, fm_int, Cp_int, i) # Calcula la temperatura de salida
    DT_lm_cal = DT_lm(T2_s, T2_e, T1_s_cal, i) # Calcula la media logaritmica de las temperaturas
    A_cal = A(Q_int, U, DT_lm_cal)
    append!(T1_s, T1_s_cal)
    append!(DT_lm_list, DT_lm_cal)
    append!(A_list, A_cal)
end

A_promedio = sum(A_list)/length(A_list)

# Grafica
# Corriente interna
# Temperatura de entrada vs temperatura de salida
figure(1)
plot(T1_e, T1_s)
title("Corriente interna")
xlabel("Temperatura de entrada (T1 @ °C)")
ylabel("Temperatura de salida (T1' @ °C)")
grid("True")

# Temperatura de entrada vs área de transferencia
figure(2)
plot(T1_e, A_list)
title("Corriente interna")
xlabel("Temperatura de entrada (T1 @ °C)")
ylabel("Área de transferencia (m^2)")
grid("True")