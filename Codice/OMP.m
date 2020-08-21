function [x_est] = OMP(y,norm_n_eta,phi_mat, dim_x)

%% L'algoritmo OMP

% Settaggio dei parametri iniziali per l'OMP
gamma_curr = y; % gamma_0, residuo iniziale
I_set = []; % insieme di colonne che contribuiscono a y
col_set = []; % indice delle colonne
max_iter = 100; % numero massimo di iterazioni
iter_no = 1; % inizializzazione della variabile di iterazione
error_iter = Inf; % errore iniziale

% Soglia di arresto per errore
if norm_n_eta > 0
    thresh = norm_n_eta;
else
thresh = 10^-10; 
end

% Inizializziamo la norma del residuo
norm_gamma = [norm(gamma_curr)];
% Verifichiamo i criteri di arresto
while((iter_no < max_iter+1) && error_iter > thresh) 
    % numero iterazioni
    max_ip = 0;
    
    % Troviamo la colonna che contribuisce maggiormente
    for col_no = 1:size(phi_mat,2)
        curr_ip = abs(gamma_curr'*phi_mat(:,col_no));
        if curr_ip > max_ip
            max_ip = curr_ip;
            curr_col = col_no;
        end
    end
    col_set = [col_set curr_col]; % Unione degli indici 
    I_set = [I_set phi_mat(:,curr_col)]; % Troviamo la base 

    % Troviamo la proiezione del segnale misurato sulla base,
    % usiamo la funzione apposita
    z_curr = projection_meg(y, I_set);
    
    % Aggiornamento del residuo
    gamma_curr = y - z_curr;
    
    % Verifica dei criteri di arresto
    if norm(gamma_curr) > norm_gamma(end)
        break
    else
        norm_gamma = [norm_gamma norm(gamma_curr)];
    end
    
    % aggiornamento errore  e indice di iterazione
    error_iter = norm(gamma_curr);
    iter_no = iter_no+1;
end

% Troviamo la stima finale di x
col_set = unique(col_set);
I_set = [];

% Trovariamo  x da I_set
for col=1:length(col_set)
    I_set = [I_set phi_mat(:, col_set(col))];
end

% Risoluzione del problema nella dimensione ridotta di I_set
y_reduced_dim =zeros(length(col_set),1);
phi_reduced_dim = zeros(length(col_set),length(col_set));
x_reduced_dim = zeros(length(col_set),1);

for col = 1:length(col_set)
    y_reduced_dim(col) = y'*I_set(:, col);
end

for row = 1:length(col_set)
    for col = 1:length(col_set)
        phi_reduced_dim(row, col) = I_set(:, row)'*I_set(:, col);
    end
end

% Troviamo la versione ridotta di x
x_reduced_dim = pinv(phi_reduced_dim)*y_reduced_dim;

% Riempiamo il vettore sparso x con gli elementi 
% della versione ridotta di x
x_est = zeros(dim_x);
for pos = 1:length(col_set)
    x_est(col_set(pos)) = x_reduced_dim(pos);
end


