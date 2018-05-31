runif(10)
x=runif(1000)
y=runif(1000)
require(ggplot2)
qplot(x,y)
#rnorm genera valores aleatorios seguindo unha distribución normal
sueldos= rnorm(5000, 2000, 200)
summary(sueldos)
stem(sueldos)
hist(sueldos)
qplot(sueldos)

edades=rpois(5000, sueldos/40)
summary(edades)
qplot(edades, sueldos)
qplot(edades, sueldos, geom=c('smooth', 'point'))
qplot(edades, sueldos, alpha=I(0.1), size= I(2))    
#Calcula la frecuencia de cada valor en los datos
table(edades)
#Con la funcion factor categorizas la variable. Ya no es contínua si no que es categorica
qplot(factor(edades), sueldos, geom= 'boxplot')
#Cambiamos el orden de las coordenadas
qplot(factor(edades), sueldos, geom= 'boxplot') + coord_flip()
#Esto fagoo para facer caixas da variable que caegorizaches (edades), e falo de 5 en 5 entre 15 e 90
gr.edades=cut(edades, breaks=seq(15,90,5))
qplot(gr.edades, sueldos, geom= 'boxplot') + coord_flip()
#Vamos a generar outra variable que vai ser os sexos.
#Para sacar números ou letras o azar. O replace e para que che repita as letras xa que non hai
#50 letras distintas
sample(letters,50, replace=TRUE)
sexos=sample(c('hombre',' mujer'), 5000, replace = TRUE)
datos=data.frame(sueldo=sueldos, sexo=sexos, edad=edades, gr.edad=gr.edades)
#En tidiverse a función data frame é 'data_frame', en r base é 'data.frame'.
qplot(gr.edad, sueldo, data=datos, fill='lightblue', geom= 'boxplot')
library(tidyverse)

#EJERCICIO: 
#Representar la distribución de la altura de 
#los alumnos de la universidad de Adelaide y su variación con el sexo, a partir de la base 
#de datos survey del paquete MASS

require(MASS)
library(dplyr)
library(ggplot2)
?survey
survey <- survey %>%  filter (!is.na(Sex))
qplot(Sex, Height, data= survey, fill= 'red', geom='boxplot')
#EJERCICIO
#Representar la distribución de los hábitos con el tabaco según el sexo, en la muestra 
#de alumnos de la universidad de Adelaide. Averiguar cual podría ser la mejor representación
#(¡hay tantos chicos como chicas!)
qplot(Sex, data= survey, fill= Smoke)
#♠EJERCICIO
#Utilizando los base de datos survey, describir la relación entre la altura del alumno 
#y la distancia entre sus dedos (pulgar y auricular) de la mano usada para escribir. 
#En un mismo gráfico, describir como esta relación cambia con el sexo.
qplot(Height, Wr.Hnd, data= survey, color= Sex, geom= c('smooth', 'point'))
#EJERCICIO
#Describir con un gráfico similar al anterior, los datos de la base de datos islands sobre 
#superficies de islas. Puede ser oportuno recurrir a una escala log.
islands
summary(islands)
library(dplyr)
qplot(islands, reorder (names(islands), islands), log='x')
#-------------seugunda parte da clase --------------------------------
paro <- read.csv("data/paro.csv")

p <- ggplot(survey)
p <- p + aes(x=Height, y=Wr.Hnd, col=Sex)
p <- p +geom_point() + geom_smooth(se= FALSE, method = 'lm')
p <- p + facet_wrap (~Smoke)

VADeaths
library(tidyr)
tmp <- VADeaths %>% as_tibble() %>% mutate(edad = row.names(VADeaths))
# el -edad coge todo menos la edad
mortalidad <- gather(tmp,grupo,tasa,-edad)
p <- ggplot (mortalidad, aes(x = edad, y = tasa, fill = grupo, group= grupo))
p + geom_point(size=10, shape= '*') + geom_line()
p + geom_bar(stat= 'identity', position= 'dodge')

ggplot(mpg, aes(x=class, fill=drv)) + geom_bar(position= 'dodge', col='gray60')
ggplot(survey, aes(x=Sex, fill=Smoke)) + geom_bar(position= 'dodge', col='gray60')
#Un factor es una variable categorica
x=c(0,1,0,1,0,0,1)
sexo=factor(x, level=c(0,1), labels=c('hombre', 'mujer'))
class(sexo)
survey$Tabaco= factor(survey$Smoke, levels=c('Never','Ocass', 'Regul', 'Heavy'))
ggplot(survey, aes(x= Sex, fill= Tabaco)) + geom_bar(position= 'dodge',col =' gray60')
#EJERCICIO
#Elaborar el siguientes gráfico sobre la evolución del paro en España. Utilizar la capa 
#geom_smooth para suavizar la tendencia y la estética linetype para distintos tipos de curvas.
ggplot(paro, aes(x=AÃ.o, y=Tasa.paro, colour= Trimestre, linetype= Sexo)) + geom_smooth(se=FALSE)
ggplot(mortalidad, aes(x = edad, y = tasa)) + 
  geom_bar(stat="identity") +
  facet_grid(~grupo)
#EJERCICIO
#Elaborar los siguientes gráficos sobre la evolución del paro. Para el segundo gráfico, 
#se puede filtrar la base original con el comando:
ggplot(paro, aes(x=Trimestre, y=Tasa.paro, color=Sexo)) + geom_boxplot() + facet_grid(Sexo ~ AÃ.o)

paro.ZHT <- paro %>% filter(Provincia %in% c('Zaragoza', 'Huesca', 'Teruel'))
paro_impreso <- ggplot(paro.ZHT, aes(x=AÃ.o, y= Tasa.paro, col=Sexo)) + geom_line() + geom_point() + facet_grid(Provincia ~ Trimestre)  
ggsave('paro_impreso.jpg', width = 10, height = 8)

#Esto es para guardar el gráfico que acabamos de generar
obesidad<-read.csv("data/obesidad.csv")
#☻Poner etiqueas a los ejes y el título al gráfico
ggplot(obesidad, aes(x=imc, y=renta, color= region)) + geom_smooth(method='lm') + ggtitle('obesidad Asia-Europa') + labs (x= 'renta €', y= 'kg/m2', color= 'continente')
#ESCALAS
p<-ggplot(obesidad, aes(x=imc, y=renta, color=region)) + geom_point(size= 0.01) + scale_x_log10() + scale_y_continuous(breaks = c(10,40,100), trans= 'log') + scale_color_manual("Continente",values=c("green4","red4"),limits=c("Europa","Asia"))
p + facet_grid(~region) + theme_classic()
install.packages(ggthemes)
#Mapas
library(ggmap)
kschool <- geocode('Calle Magallanes 1, madrid, spain')
mapa <- get_map(location = kschool, zoom = 12,color = "bw")
library(tidyverse)
terrazas<-read.csv("data/terrazas.csv") 
ggmap (mapa) + geom_point(data=terrazas, aes(x= lon, y= lat), size= 1, alpha= .5, color='orange')

                      