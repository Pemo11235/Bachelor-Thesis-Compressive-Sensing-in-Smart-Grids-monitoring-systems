function [media_tempo, media_RMSE, media_pearson,media_errore]= cicloMisurazioniLambda(mis,l,K)
sum_end_alg = 0;
sum_RMSE = 0;
sum_Pearson = 0;
sum_errore = 0;
for i =1 : mis
    [end_alg, RMSE, PEARSON, errore] = LASSO(K,l)

    sum_end_alg = sum_end_alg + end_alg;
    sum_RMSE = RMSE + sum_RMSE;
    if ~(any(isnan(PEARSON(:))))
        sum_Pearson = PEARSON + sum_Pearson;      
    else
        sum_Pearson = 0 + sum_Pearson;
    end
    sum_errore = errore + sum_errore;
    
    
end
    media_tempo = sum_end_alg/mis;
    media_RMSE = sum_RMSE / mis;
    media_pearson =  min(sum_Pearson) / mis;
    media_errore = sum_errore/mis;