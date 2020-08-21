function [x,status,history] = l1_ls(A,varargin)
%
% l1-Regularized Least Squares 
%   l1_ls risolve il pronlema nella seguente forma:
%       minimize ||A*x-y||^2 + lambda*sum|x_i|,
%  dove A e y sono gli input e x e' il segnale campionato.

		[ . . . ]

%               Ciclo principale
cput0 = cputime;

for ntiter = 0:MAX_NT_ITER
    
    z = A*x-y;
	
    %       Calcolo del Duality Gap
    nu = 2*z;
    maxAnu = norm(At*nu,inf);
	
    if (maxAnu > lambda)
        nu = nu*lambda/maxAnu;
    end
	
    pobj  =  z'*z+lambda*norm(x,1);
    dobj  =  max(-0.25*nu'*nu-nu'*y,dobj);
    gap   =  pobj - dobj;

    pobjs = [pobjs pobj]; dobjs = [dobjs dobj]; sts = [sts s];
    pflgs = [pflgs pflg]; pitrs = [pitrs pitr];
    cputs = [cputs cputime - cput0];
    
    %   Criterio di fermata
    if (~quiet) disp(sprintf('%4d %12.2e %15.5e %15.5e %11.1e %8d',...
        ntiter, gap, pobj, dobj, s, pitr)); end

    if (gap/dobj < reltol) 
        status  = 'Solved';
        history = [pobjs-dobjs; pobjs; dobjs; sts; pitrs; pflgs; cputs];
        if (~quiet) disp('Absolute tolerance reached.'); end
        
        return;
    end
	
    %       Agggiornamento t

    if (s >= 0.5)
        t = max(min(2*n*MU/gap, MU*t), t);
    end
    
    %       Calcoliamo lo step del metodo di Newton   
    q1 = 1./(u+x);          q2 = 1./(u-x);
    d1 = (q1.^2+q2.^2)/t;   d2 = (q1.^2-q2.^2)/t;

    % Calcolo del gradiente
    gradphi = [At*(z*2)-(q1-q2)/t; lambda*ones(n,1)-(q1+q2)/t];  
	
    % Calcolo dei vettori usati per la predizione
    prb     = diagxtx+d1;
    prs     = prb.*d1-(d2.^2);
	
    % Settaggio della tolleranza
    normg   = norm(gradphi);
    pcgtol  = min(1e-1,eta*gap/min(1,normg));
    
    if (ntiter ~= 0 && pitr == 0) pcgtol = pcgtol*0.1; end
    [dxu,pflg,prelres,pitr,presvec] = ...
        pcg(@AXfunc_l1_ls,-gradphi,pcgtol,pcgmaxi,@Mfunc_l1_ls,...
            [],dxu,A,At,d1,d2,d1./prs,d2./prs,prb./prs);
    if (pflg == 1) pitr = pcgmaxi; end 
	
    dx  = dxu(1:n);
    du  = dxu(n+1:end);
	
    %   Backtracking line search
    phi = z'*z+lambda*sum(u)-sum(log(-f))/t;
    s = 1.0;
    gdx = gradphi'*dxu;
	
    for lsiter = 1:MAX_LS_ITER
        newx = x+s*dx; newu = u+s*du;
        newf = [newx-newu;-newx-newu];
		
        if (max(newf) < 0)
            newz   =  A*newx-y;
            newphi =  newz'*newz+lambda*sum(newu)-sum(log(-newf))/t;
			
            if (newphi-phi <= ALPHA*s*gdx)
                break;
            end
        end
        s = BETA*s;
    end
	
    if (lsiter == MAX_LS_ITER) break; end % uscita
        
    x = newx; u = newu; f = newf;
end
history = [pobjs-dobjs; pobjs; dobjs; sts; pitrs; pflgs; cputs];
return;

[ . . . ]