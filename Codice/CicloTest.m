mis = 5
sum_end_alg = 0;
sum_RMSE = 0;
sum_Pearson = 0;
sum_errore = 0;

for i =1 : mis
    [end_alg, RMSE, PEARSON, errore] = Omp_ML()

    sum_end_alg = sum_end_alg + end_alg;
    sum_RMSE = RMSE + sum_RMSE;
    sum_Pearson = PEARSON + sum_Pearson;
    sum_errore = errore + sum_errore;
end


media_tempo = sum_end_alg/mis;
media_RMSE = sum_RMSE / mis;
media_pearson =  sum_Pearson / mis;
media_errore = sum_errore/mis;