using LinearAlgebra
# Alimentaciones
A = 70
Ben_A = 0.2*A
Tol_A = 0.4*A
Est_A = 0.25*A
Xil_A = 0.15*A

Bal_Especies = [0.35 0.16 0.21 0.01;
                0.54 0.42 0.54 0.10;
                0.04 0.24 0.1 0.65;
                0.07 0.18 0.15 0.24]

Alimentacion = [Ben_A; Tol_A; Est_A; Xil_A]

D1, B1, D2, B2 = inv(Bal_Especies)*Alimentacion

# Balance para D
D = D1 + B2
# Balance para B
B = D2 + B2

println("Flujo en la corriente D: ", round(D, digits=4), " mol/min")
println("Flujo en la corriente B: ", round(B, digits=4), " mol/min")
println("Flujo en la corriente D1: ", round(D1, digits=4), " mol/min")
println("Flujo en la corriente B1: ", round(B1, digits=4), " mol/min")
println("Flujo en la corriente D2: ", round(D2, digits=4), " mol/min")
println("Flujo en la corriente B2: ", round(B2, digits=4), " mol/min")

# Composiciones de D
xD_1 = (D1*0.35+B1*0.16)/D
xD_2 = (D1*0.54+B1*0.42)/D
xD_3 = (D1*0.04+B1*0.24)/D
xD_4 = (D1*0.07+B1*0.18)/D
xD = [xD_1, xD_2, xD_3, xD_4]

println("\nComposiciones de la corriente D")
for i = 1:4
    println("xD[", i, "] : ", round(xD[i], digits=4))
end 

# Composiciones de B
xB_1 = (D2*0.21+B2*0.01)/B
xB_2 = (D2*0.54+B2*0.10)/B
xB_3 = (D2*0.10+B2*0.65)/B
xB_4 = (D2*0.15+B2*0.24)/B
xB = [xB_1, xB_2, xB_3, xB_4]

println("\nComposiciones de la corriente B")
for i = 1:4
    println("xB[", i, "] : ", round(xB[i], digits=4))
end 
