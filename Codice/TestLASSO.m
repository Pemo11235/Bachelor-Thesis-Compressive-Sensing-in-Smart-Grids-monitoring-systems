function [end_alg, RMSE , PEARSON ,errore] = TestLASSO(K,l)

%% Genero la matrice IEEE 
[phi_mat,m] = creaMatrice() 
% Definiamo le dimensioni della matrice phi = m x n
n = m; 
%% Genero il segnale sparso x
[x,s0] = creaSegnaleSparso(K,n);

%% Genero il rumore e la misurazione y
% Generiamo l'errore n_eta e la norma del rumore
[n_eta, norm_n_eta] = generaErrore(m);

% Calcoliamo la msiurazione y
y = calcolaY(phi_mat,x,n_eta,norm_n_eta);

%% L1 Regulation o LASSO
% Richiamo la funzione lasso
% diamo per paramentri, la matrice, la misurazione e lambda
lambda = l

% Uso la funzione tic-toc di Matlab per misurare i tempi di esecuzione
tic
z = l1_ls(phi_mat,y,lambda);
end_alg = toc

% Plottiamo per confrontare il segnale effettivo e il segnale stimato x_est
figure(3);
subplot(3,1,1);
stem(real(x))
title(['Segnale sorgente, s = ' num2str(s0)]);
xlabel('indice');
ylabel('grandezza');

subplot(3,1,2);
stem(real(z));
title(['Segnale stimato, ' 'con Lamda = ' num2str(lambda)]);
xlabel('indice');
ylabel('grandezza');

q = (z - x)

subplot(3,1,3);
stem(real(q ));
title(['Errore, ']);
xlabel('indice');
ylabel('grandezza');

%% Calcolo le misure di errore e correlazione
RMSE = (sqrt(mean( z - x).^2)));
ERR= sum(abs(q))
PEARSON = corrcoef(x-z)

return

