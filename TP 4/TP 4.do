*Parte A
*1
use wine_data
reg q xper cap lab
outreg2 using vinos, excel
*Por cada año más de experiencia del manager del viñedo ceteris paribus y en promedio aumenta la q en 0,1306651. Esta variable es significativa al 5%
*Por cada unidad de capital extra que se utiliza en el viñedo ceteris paribus y en promedio la q aumenta en 0,4652914. Esta variable es significativa al 1%
*Por cada unidad extra de cantidad de trabajo utilizado ceteris paribus y en promedio la q aumenta en 0,2325992. Esta variable es significativa al 1%
*2
*La variable xper puede considerarse un regresor endógeno dado que se puede estar dando causalidad simultánea, es decir que dado que a medida que aumenta la q el xper aumenta y viceversa. Cuanto mejor es la producción de vinos, mejores managers y de más experiencia se van a estar buscando.
*3
corr age xper
corr age xper, cov
*La variable age correlaciona con xper, por lo tanto, se cumple con la condición de relevancia. En cuanto a la exogeneidad el problema que puede haber es que la edad del manager si tenga que ver con el modelo, pero creo que la edad no afecta directamente el q, por lo tanto el age del manager funciona como variable instrumental.
ivregress 2sls q (xper=age) cap lab, first
outreg2 using vinos, excel append
*4
ivregress 2sls q (xper=age) cap lab, first
estat firststage
*El estádistico F es > a 10, por lo tanto es un instrumento fuerte. En la estimación con MC2E no da un coeficiente mayor al de MCO, por lo tanto se puede decir que si la variable instrumental es correcta, se estaba subestimando al beta que acompaña a la variable xper.

*Parte B
*1
use resumenames , clear
encode ethnicity , gen (black)
replace black=0 if black==2
*No estoy de acuerdo. Hay muchas variables relevantes omitidas y se genera un sesgo, por ejemplo la educación y el nivel de ingresos. Los negros tienen una menor educación y menores ingresos, lo cual podría generar una correlación con el término de error.
encode call_back , gen(llamada)
replace llamada=0 if llamada==1
replace llamada=1 if llamada==2
reg llamada black , robust
outreg2 using black, excel
*agregar regresión
*el ser negro implica una desventaja al buscar un empleo comparado con los blancos
*eso podría quitar sesgo de la variable dummy de raza y tener una estimación más certera

*2
encode gender , gen(female)
replace female=0 if female==2
gen female_black = female*black
reg llamada black female* , robust
outreg2 using black, excel append
*Si, difiere. El coeficiente de black es menor en términos absolutos, se podría decir que se le quitó sesgo por parte de estas variables agregadas. Cabe destacar que female y female_black no son significativas.
*Los varones blancos tuvieron una tasa de respuesta del 8,9%
*Varones negros = 5,9%
*Mujeres blancas = 9,9%
*Mujeres negras = 6,7%

*3
