function leggi(caso,i)

if i == 1 
    fprintf('OMP \n\t Tempo %f \n\t RMSE %f \n\t Pearson %f \n\t Errore %f \n\n',caso(1), caso(2),caso(3),caso(4));
else
     fprintf('LASSO \n\t Tempo %f \n\t RMSE %f \n\t Pearson %f \n\t Errore %f \n\n',caso(1), caso(2),caso(3),caso(5));
end