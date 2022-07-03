/* Parte 1 */

*a 
use coffee.dta
reg coffqty coffpric
*b 
display 774.9168+(2*-693.3334)
*c
*d 
gen coffqty_ln=ln(coffqty)
gen coffpric_ln=ln(coffpric)
reg coffqty_ln coffpric_ln

clear

/* Parte 2 */

/* Parte 3 */

*a 
use ingresos.dta
graph bar IngMensual , over(sexo)
graph bar IngMensual , over(est_civil)
preserve
egen IngMensual_m = mean(IngMensual), by(n_educ)
sort n_educ
line IngMensual_m n_educ
restore
preserve
egen IngMensual_m = mean(IngMensual), by(edad)
sort edad
line IngMensual_m edad
restore
preserve
egen IngMensual_m = mean(IngMensual), by(miemhog)
sort miemhog
line IngMensual_m miemhog
restore
graph bar IngMensual , over(percepho)
graph bar IngMensual , over(jefe_hogar)
*b 
gen ln_ing = ln(IngMensual)
*c 
*d 
reg ln_ing edad est_civil jefe_hogar miemhog n_educ percepho sexo
display 5*0.0826983
*e 
display 0.21119773/0.0826983

clear