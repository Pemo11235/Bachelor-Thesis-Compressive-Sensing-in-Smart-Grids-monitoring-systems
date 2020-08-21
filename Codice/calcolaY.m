function y = calcolaY(phi_mat,x,n_eta,norm_n_eta)
% Definiamo la misurazione y
y = phi_mat*x + n_eta;

% Rappresentiamo y
figure(2);
stem(real(y));
title(['Il segnale misurato y, ' '||rumore||_2 = ' num2str(norm_n_eta)]);
xlabel('indice');
ylabel('grandezza');