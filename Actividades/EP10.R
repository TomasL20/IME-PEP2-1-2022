library(dplyr)

"Pregunta 1:
�Existe diferencia en la puntuaci�n obtenida por los envases dise�ados por 
LaKajita seg�n las evaluaciones realizadas por j�venes y adultos?
"

datos <- read.csv2("C:/Users/owok1/OneDrive/Escritorio/ime/ep10/EP10 Datos.csv")

datosLaKajita <- datos[datos$Diseno == "LaKajita",]
datosJovenes <- datosLaKajita[datosLaKajita$Edad == "Joven",]
datosAdultos <- datosLaKajita[datosLaKajita$Edad == "Adulto",]

datosJovenes <- datosJovenes %>% select(Puntaje)
datosAdultos <- datosAdultos %>% select(Puntaje)

##Se utiliza la prueba de Wilcoxon para dos muestras independientes

#Las muestras son independientes ya que son distintas personas y fueron escogidas al azar
#La escala de medici�n empleada es la de Likert


#H0: no hay diferencias en el puntaje de LaKajita entre j�venes y adultos.
#Ha: si hay diferencias en el puntaje de LaKajita entre j�venes y adultos.

#Se utiliza un alpha de 0.05
alfa <- 0.05

prueba1 <- wilcox.test(datosJovenes$Puntaje,
                       datosAdultos$Puntaje,
                       alternative = "two.sided",
                       conf.level = 1-alfa)
print(prueba1)
#Se puede concluir con un p-valor>alpha que se falla en rechazar H0 en favor de
#Ha, por lo tanto no hay diferencias significativas en el Puntaje del dise�o de
#LaKajita entre j�venes y adultos.

#Como se falla en rechazar H0 no es necesaria una prueba post-hoc para ver las
#diferencias entre las preferencias de los evaluadores.


"Pregunta 2:
�Existen diferencias entre las puntuaciones obtenidas para los diferentes
envases de alfajor? De ser as�, �cu�l(es) envase(s) se diferencia(n) de los dem�s?
"
datosAlfajores <- datos[datos$Producto == "Alfajor",]

#Se elije hacer la prueba de Friedman para dos o m�s muestras, ya que cada sujeto
#eval�a un distinto dise�o de alfajor (4 dise�os)

#La variable independiente cumple con ser categorica y tener 3 o m�s niveles
#La escala de variables dependientes cumple con ser a lo menos ordinal (escala de Likert)
#Los sujetos son una muestra independiente y aleatoria de la poblaci�n

#H0: No preferencia entre los dise�os de envases para los alfajores
#H1: Existe al menos un dise�o de envase para alfajores con distinta preferencia

#Usando un alpha de 0.05

prueba2 <- friedman.test(Puntaje ~ Diseno | Id,
                         data = datosAlfajores)
print(prueba2)
#Se puede concluir con p-valor>alpha que se falla en rechazar h0 en favor a Ha,
#por lo tanto no hay diferencias signficativas entre los dise�os de alfajores.

#Como se falla en rechazar H0 no es necesaria una prueba post-hoc para ver las
#diferencias entre las preferencias de dise�o de los alfajores.

