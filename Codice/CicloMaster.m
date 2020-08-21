%%
K = 3;
[OMP_tempo_1,OMP_RMSE_1,OMP_pearson_1,OMP_errore_1] = CicloTestOMP(K);
OMP_caso1 = [OMP_tempo_1,OMP_RMSE_1,OMP_pearson_1,OMP_errore_1];
[LASSO_caso1A,LASSO_caso1B,LASSO_caso1C,LASSO_caso1D,LASSO_tempo_1_ABCD,LASSO_rmse_1_ABCD,LASSO_perason_1_ABCD,LASSO_errore_1_ABCD]= CicloTestLASSO(K);

%%
K = 5;

[OMP_tempo_2,OMP_RMSE_2,OMP_pearson_2,OMP_errore_2] = CicloTestOMP(K);
OMP_caso2 = [OMP_tempo_2,OMP_RMSE_2,OMP_pearson_2,OMP_errore_2];
[LASSO_caso2A,LASSO_caso2B,LASSO_caso2C,LASSO_caso2D,LASSO_tempo_2_ABCD,LASSO_rmse_2_ABCD,LASSO_perason_2_ABCD,LASSO_errore_2_ABCD]= CicloTestLASSO(K);

%%
K = 7;

[OMP_tempo_3,OMP_RMSE_3,OMP_pearson_3,OMP_errore_3] = CicloTestOMP(K);
OMP_caso3 = [OMP_tempo_3,OMP_RMSE_3,OMP_pearson_3,OMP_errore_3];
[LASSO_caso3A,LASSO_caso3B,LASSO_caso3C,LASSO_caso3D,LASSO_tempo_3_ABCD,LASSO_rmse_3_ABCD,LASSO_perason_3_ABCD,LASSO_errore_3_ABCD]= CicloTestLASSO(K);

%%
K = 9;

[OMP_tempo_4,OMP_RMSE_4,OMP_pearson_4,OMP_errore_4] = CicloTestOMP(K);
OMP_caso4 = [OMP_tempo_4,OMP_RMSE_4,OMP_pearson_4,OMP_errore_4];
[LASSO_caso4A,LASSO_caso4B,LASSO_caso4C,LASSO_caso4D,LASSO_tempo_4_ABCD,LASSO_rmse_4_ABCD,LASSO_perason_4_ABCD,LASSO_errore_4_ABCD]= CicloTestLASSO(K);

%%
K = 15;

[OMP_tempo_5,OMP_RMSE_5,OMP_pearson_5,OMP_errore_5] = CicloTestOMP(K);
OMP_caso5 = [OMP_tempo_5,OMP_RMSE_5,OMP_pearson_5,OMP_errore_5];
[LASSO_caso5A,LASSO_caso5B,LASSO_caso5C,LASSO_caso5D,LASSO_tempo_5_ABCD,LASSO_rmse_5_ABCD,LASSO_perason_5_ABCD,LASSO_errore_5_ABCD]= CicloTestLASSO(K);

%%
K = 20;

[OMP_tempo_6,OMP_RMSE_6,OMP_pearson_6,OMP_errore_6] = CicloTestOMP(K);
OMP_caso6 = [OMP_tempo_6,OMP_RMSE_6,OMP_pearson_6,OMP_errore_6];
[LASSO_caso6A,LASSO_caso6B,LASSO_caso6C,LASSO_caso6D,LASSO_tempo_6_ABCD,LASSO_rmse_6_ABCD,LASSO_perason_6_ABCD,LASSO_errore_6_ABCD]= CicloTestLASSO(K);

%%Lamnbda per caso
rmse_val = [LASSO_caso1A(2) LASSO_caso2A(2) LASSO_caso3A(2) LASSO_caso4A(2) LASSO_caso5A(2) LASSO_caso6A(2),
    LASSO_caso1B(2) LASSO_caso2B(2) LASSO_caso3B(2) LASSO_caso4B(2) LASSO_caso5B(2) LASSO_caso6B(2),
    LASSO_caso1C(2) LASSO_caso2C(2) LASSO_caso3C(2) LASSO_caso4C(2) LASSO_caso5C(2) LASSO_caso6C(2),
    LASSO_caso1D(2) LASSO_caso2D(2) LASSO_caso3D(2) LASSO_caso4D(2) LASSO_caso5D(2) LASSO_caso6D(2)];

time_val = [LASSO_caso1A(1) LASSO_caso2A(1) LASSO_caso3A(1) LASSO_caso4A(1) LASSO_caso5A(1) LASSO_caso6A(1),
    LASSO_caso1B(1) LASSO_caso2B(1) LASSO_caso3B(1) LASSO_caso4B(1) LASSO_caso5B(1) LASSO_caso6B(1),
    LASSO_caso1C(1) LASSO_caso2C(1) LASSO_caso3C(1) LASSO_caso4C(1) LASSO_caso5C(1) LASSO_caso6C(1),
    LASSO_caso1D(1) LASSO_caso2D(1) LASSO_caso3D(1) LASSO_caso4D(1) LASSO_caso5D(1) LASSO_caso6D(1)];

pearson_val = [LASSO_caso1A(3) LASSO_caso2A(3) LASSO_caso3A(3) LASSO_caso4A(3) LASSO_caso5A(3) LASSO_caso6A(3),
    LASSO_caso1B(3) LASSO_caso2B(3) LASSO_caso3B(3) LASSO_caso4B(3) LASSO_caso5B(3) LASSO_caso6B(3),
    LASSO_caso1C(3) LASSO_caso2C(3) LASSO_caso3C(3) LASSO_caso4C(3) LASSO_caso5C(3) LASSO_caso6C(3),
    LASSO_caso1D(3) LASSO_caso2D(3) LASSO_caso3D(3) LASSO_caso4D(3) LASSO_caso5D(3) LASSO_caso6D(3)];

err_val = [LASSO_caso1A(5) LASSO_caso2A(5) LASSO_caso3A(5) LASSO_caso4A(5) LASSO_caso5A(5) LASSO_caso6A(5),
    LASSO_caso1B(5) LASSO_caso2B(5) LASSO_caso3B(5) LASSO_caso4B(5) LASSO_caso5B(5) LASSO_caso6B(5),
    LASSO_caso1C(5) LASSO_caso2C(5) LASSO_caso3C(5) LASSO_caso4C(5) LASSO_caso5C(5) LASSO_caso6C(5),
    LASSO_caso1D(5) LASSO_caso2D(5) LASSO_caso3D(5) LASSO_caso4D(5) LASSO_caso5D(5) LASSO_caso6D(5)];

%% OMP tempo per sparsità
OMP_tempo_per_caso = [OMP_tempo_1,OMP_tempo_2,OMP_tempo_3,OMP_tempo_4,OMP_tempo_5,OMP_tempo_6];

OMP_RMSE_per_caso = [OMP_RMSE_1,OMP_RMSE_2,OMP_RMSE_3,OMP_RMSE_4,OMP_RMSE_5,OMP_RMSE_6];

OMP_errore_per_caso = [OMP_errore_1,OMP_errore_2,OMP_errore_3,OMP_errore_4,OMP_errore_5,OMP_errore_6];
