# Problema 24
D = 1.52e-6 # cm^2/s

# Derivada hacia atras
# Menor tamaño de paso = mejor
dcdx = ((0.06 - 0.32)*10e-6)/(1-0) # g/cm^4

Flujo_masa = -D*dcdx

A = 3.6e6 # m^2
S_to_anio = 3600*24*365
Cant_contaminante = Flujo_masa*A*S_to_anio
println("Contaminante transportado al lago en un año: ", round(Cant_contaminante, digits=4) , " g")