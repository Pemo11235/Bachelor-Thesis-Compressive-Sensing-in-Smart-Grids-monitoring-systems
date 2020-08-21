function [casoA,casoB,casoC,casoD,tot_tempo,tot_rmse,tot_pearson,tot_errore] = CicloTestLASSO(K)

mis = 5

l= 0

%% Lamba 1
l = 1
[media_tempo_A,media_RMSE_A,media_pearson_A,media_errore_A] = cicloMisurazioniLambda(mis,l,K);
l = 0.1
[media_tempo_B,media_RMSE_B,media_pearson_B,media_errore_B] = cicloMisurazioniLambda(mis,l,K);
l = 0.01
[media_tempo_C,media_RMSE_C,media_pearson_C,media_errore_C] = cicloMisurazioniLambda(mis,l,K);
l = 0.001
[media_tempo_D,media_RMSE_D,media_pearson_D,media_errore_D] = cicloMisurazioniLambda(mis,l,K);



casoA = [media_tempo_A,media_RMSE_A,media_pearson_A,media_errore_A]
casoB = [media_tempo_B,media_RMSE_B,media_pearson_B,media_errore_B]
casoC = [media_tempo_C,media_RMSE_C,media_pearson_C,media_errore_C]
casoD = [media_tempo_D,media_RMSE_D,media_pearson_D,media_errore_D]
tot_tempo = [media_tempo_A,media_tempo_B,media_tempo_C,media_tempo_D]
tot_rmse =  [media_RMSE_A,media_RMSE_B,media_RMSE_C,media_RMSE_D]
tot_pearson = [ media_pearson_A,media_pearson_B,media_pearson_C,media_pearson_D]
tot_errore = [media_errore_A,media_errore_B,media_errore_C,media_errore_D]