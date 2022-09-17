#Problema 6
# ETL: etilbenceno
# T: tolueno

pE=250 # en mmHg
pT=343 # en mmhg
#parámetros Ley de Antoine
AE=6.95719; BE=1424.255; CE=213.21
AT=6.95464; BT=1344.8; CT=219.48
PT=pE+pT
println("La presión total es: ",PT, " mmHg")
yE=pE/PT
yT=pT/PT
println("La fracción molar del etilbenceno es: ",yE)
println("La fracción molar del tolueno es: ",yT)
PE0=pE/yE # Relacion incorrecta
PT0=pT/yT 
println("La presión de saturación del etilbenceno es: ",PE0)
println("La presión de saturación del tolueno es: ",PT0)
#Para calcular la temperatura de cada compuesto podemos usar la ecuación de Antonie despejando la... T
#T=(-B-C*log(Pi0)+AC)/(log(Pi0)-A)
TE=(-BE-CE*log(PE0)+AE*CE)/(log(PE0)-AE)
TT=(-BT-CT*log(PT0)+AT*CT)/(log(PT0)-AT)
println("La Temperatura del etilbenceno es: ",TE, " ºC")
println("La Temperatura del tolueno es: ",TT, " ºC")