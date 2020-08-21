%%Creazione matrice di rilevamento
function [A,n] = creaMatrice()

% Directory data di MATPOWER contenente
% diversi modelli standard IEEE
cd C:\Users\matte\Desktop\matpower7.0\data
addpath 'C:\Users\matte\Desktop\matpower7.0\lib'
% Richiamo il modello desiderato e definisco
% il numero di nodi n
caseCall = case300;
n = 300;
% Richiamo la funzione ext2int che permette
% di associare correttamente
% inidci e nodi

mpc = ext2int(caseCall)

cd ..
cd lib
% Chiamo la funzione makeYbus per la
% creazione del modello completo di
% nodi, bus e parametri
[Ybus, Yf, Yt] = makeYbus(mpc.baseMVA, mpc.bus, mpc.branch);

A = full(Ybus);
% Rendiamo la phi_mat una Uniform Spherical Ensemble (USE)
for col_no = 1:size(A,2)
    A(:, col_no) = A(:, col_no)/norm(A(:, col_no));
end
