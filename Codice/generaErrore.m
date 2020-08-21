function [n_eta, norm_n_eta] = generaRumore(m)

% Generiamo rumore n_eta
sigma_eta = 1; % La varianza del segnale di errore
mean_eta = 0; % La media del rumore e' zero (assegnamento)
n_eta = sigma_eta*randn([m 1]) + mean_eta;
n_eta = n_eta/norm(n_eta);% Normalizzazione unitaria del rumore
norm_n_eta = 0.5; % Settaggio della norma del rumore
n_eta = norm_n_eta*n_eta; 