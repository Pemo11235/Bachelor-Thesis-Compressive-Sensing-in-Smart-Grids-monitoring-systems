function [end_alg, RMSE , PEARSON , ERR] = TestOMP(K)
%% Genero la matrice IEEE
[phi_mat,m] = creaMatrice() 

% Definiamo le dimensioni della matrice phi = m x n
n = m; 
%% Genero il segnale sparso x
[x,s0] = creaSegnaleSparso(K,n);

%% Genero il rumore e la misurazione y
% Generiamo l'errore n_eta e la norma del rumore
[n_eta, norm_n_eta] = generaErrore(m);
% Calcolo la misurazione y
y = calcolaY(phi_mat,x,n_eta,norm_n_eta);
 
%% Richiamo l'Algoritmo OMP
% Uso la funzione tic-toc di Matlab per misurare i tempi di esecuzione
tic
x_est = OMP(y,norm_n_eta,phi_mat, dim_x)
end_alg = toc

%% Plotto i risultati per confrontare il segnale effettivo 
%% e il segnale stimato x_est
figure(3);
subplot(3,1,1);
stem(real(x))
title(['Segnale sorgente, x = ' num2str(s0)]);
xlabel('indice');
ylabel('grandezza');

subplot(3,1,2);
stem(real(x_est));
title(['Segnale stimato, ' '||rumore||_2 = ' num2str(norm_n_eta)]);
xlabel('indice');
ylabel('grandezza');

subplot(3,1,3);
j = x_est-x
stem(real(j))
title(['Errore,']);
xlabel('indice');
ylabel('grandezza');

%% Calcolo le misure di errore e correlazione
RMSE = real(sqrt((mean( x_est-x).^2)));
ERR = sum(abs(j))
PEARSON = corrcoef(x-x_est)
return