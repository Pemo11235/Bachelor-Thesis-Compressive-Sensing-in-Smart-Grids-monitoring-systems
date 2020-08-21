function [x, s0 ] = creaSegnaleSparso(K,n)

% Sparsita' del vettore sparso
s0 = K; % Numero di elementi non-nulli in x

% L'intervallo di x e'  una distribuzione uniforme gaussina
% Quindi costruiremo una simulazione del segnale da cui prelevare
% casualmente dei campioni
pd = makedist('Normal');
 t = truncate(pd,0.1, 0.9);

x = zeros(n,1); % Inizializziamo x

% Decidiamo le posizioni casuali di x, 
% che contengono valori diversi da zero
x_pos = [];
while length(x_pos)<s0
    x_pos = unique(randi(n, [1 s0]));
end
    
% Associamo i valori diversi da zero da una distribuzione uniforme
for j=1:s0
    
   
    % Tracciamo il valore casuale uniforme dall'intervallo scelto
    r = random(t,1);
    curr_val = r;
    % Riempimento delle posizioni diverse da zero
    x(x_pos(j)) = curr_val;
    
end

% Rappresentiamo il vettore x
 figure(1);
 subplot(2,1,1);
 stem(real(x));
 title('Il vettore sparso x');