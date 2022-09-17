using PyPlot

mu = 0.38 # Viscosidad del aceite, Ns/m
D = 30/100 # m
L = 30/100 # m
n1 = 1450 #rpm
n2 = 1398 # rpm
l = (3/1000) # Espesor de la pelicula de aceite, m

T = (2*π^2*mu*(n1-n2)*D^4)/((32*l)*60)
println("El torque ejercido es de: ", round(T, digits=4), " N*m")

espesor = collect(0.001:0.001:0.01)
Ti = []
for i in espesor
    T_cal = (2*π^2*mu*(n1-n2)*D^4)/((32*i)*60)
    append!(Ti, T_cal)
end
scatter(espesor, Ti)
title("Torque ejercido frente a distintos espesores de la película de aceite")
xlabel("Espesor (mm)")
ylabel("Torque (Nm)")
grid("True")