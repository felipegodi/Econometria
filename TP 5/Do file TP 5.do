import excel data.xls , firstrow

gen ldef = log(def)

gen lcpi = log(cpi)

tsline inf_cpi

tsline inf_def

varsoc lcpi

dfuller lcpi, lags(3) trend regress

varsoc inf_cpi

dfuller inf_cpi, lags(2) trend regress

gen Dinf_cpi = D.inf_cpi

varsoc Dinf_cpi

dfuller Dinf_cpi, lags(1) trend regress

varsoc ldef

dfuller ldef, lags(3) trend regress

varsoc inf_def

dfuller inf_def, lags(2) trend regress

gen Dinf_def = D.inf_def

varsoc Dinf_def

dfuller Dinf_def, lags(1) trend regress

egranger inf_cpi inf_def , trend regress

gen CP = D.L.inf_cpi + D.L.L.inf_cpi

reg D.inf_cpi L.inf_cpi L.inf_def CP

