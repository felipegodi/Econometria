/* Parte 1 */

*a
use boston_airbnb
save boston_airbnb.dta, replace
count if property_type=="Apartment" 
count if property_type=="Apartment" & room_type=="Private room"
display 783/2605

*b
replace price="1300.00" if price=="1,300.00"
replace price="1250.00" if price=="1,250.00"
replace price="1000.00" if price=="1,000.00"
destring price, replace
mean price if neighbourhood_cleansed=="Dorchester"

*c
mean square_feet
display  858.4643/10.764 /* en metros cuadrados */
preserve
drop if square_feet==.
count
restore

*d
summ review_scores_value /* responde en mean y el std dev */

*e 
replace review_scores_value=9.168234 if review_scores_value==.

*f 
hist availability_30 , discrete frequency width(5) title("Disponibilidad") note("Hay poca disponibilidad en el tiempo inmediato.")

*g
twoway scatter price review_scores_value if price<800 , title("Precio segun puntuacion")|| lfit price review_scores_value, lpattern(-)

clear 

/* Parte 2 */

import excel usu_individual_T120, firstrow

*a 

*b 
drop if CH06<0
summ CH06 /* La edad mínima es 1 y la máxima es 99 */
drop if P47T<0
summ P47T /* El ingreso mínimo es 0 y el máximo es 8.760.000 */
corr CH06 P47T /* La correlación entre estas dos variables es de 0,2438 lo cual es una correlación baja */

*c
reg P47T CH06
/* El coeficiente que da para el beta es 540,6451 lo cual implica que a mayor edad mayor el ingreso individual */

clear

/* Parte 3 */

use young_lives.dta

*a 

*b 
summ , detail /*Hay que exportarlo y ponerlo en el PDF */

*c 

*d 
reg score_ppvt bwght

*e 
twoway scatter score_ppvt bwght || lfit score_ppvt bwght

clear