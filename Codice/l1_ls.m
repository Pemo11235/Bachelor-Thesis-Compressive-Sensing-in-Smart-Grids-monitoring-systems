function [x,status,history] = l1_ls(A,varargin)
%
% l1-Regularized Least Squares 
%   l1_ls risolve il pronlema nella seguente forma:
%       minimize ||A*x-y||^2 + lambda*sum|x_i|,
%  dove A e y sono gli input e x e' il segnale campionato.

%       Inizializzo
% Parametri IPM 
MU              = 2;        % aggiorno t
MAX_NT_ITER     = 200;      % massimo di iterazioni IPM (Newton) 
% Parametri Ricerca lineare
ALPHA           = 0.01;     % frazione minima di riduzione dell'obiettivo
BETA            = 0.5;      % fattore di riduzione della dimensione del passo
MAX_LS_ITER     = 100;      % iterazione di line search backtracking massima
% Gestione delle variabili a seconda dell'input
if ( (isobject(varargin{1}) || ~isvector(varargin{1})) && nargin >= 6)
    At = varargin{1};
    m  = varargin{2};
    n  = varargin{3};
    y  = varargin{4};
    lambda = varargin{5};
    varargin = varargin(6:end); 
elseif (nargin >= 3)
    At = A';
    [m,n] = size(A);
    y  = varargin{1};
    lambda = varargin{2};
    varargin = varargin(3:end);
else
    if (~quiet) disp('Insufficient input arguments'); end
    x = []; status = 'Failed'; history = [];
    return;
end

% Gestione degli argomenti delle variabili
t0         = min(max(1,1/lambda),2*n/1e-3);
defaults   = {1e-3,false,1e-3,5000,zeros(n,1),ones(n,1),t0};
given_args = ~cellfun('isempty',varargin);
defaults(given_args) = varargin(given_args);
[reltol,quiet,eta,pcgmaxi,x,u,t] = deal(defaults{:});
f = [x-u;-x-u];

% Variabili risultato
pobjs = [] ; dobjs = [] ; sts = [] ; pitrs = []; pflgs = []; cputs = [];
pobj  = Inf; dobj  =-Inf; s   = Inf; pitr  = 0 ; pflg  = 0 ;
ntiter  = 0; lsiter  = 0; zntiter = 0; zlsiter = 0;
normg   = 0; prelres = 0; dxu =  zeros(2*n,1);
diagxtx = 2*ones(n,1);
if (~quiet) disp(sprintf('\nSolving a problem of size (m=%d, n=%d), with lambda=%.5e',...
            m,n,lambda)); end
if (~quiet) disp('-----------------------------------------------------------------------------');end
if (~quiet) disp(sprintf('%5s %9s %15s %15s %13s %11s',...
            'iter','gap','primobj','dualobj','step len','pcg iters')); end

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
        %disp(sprintf('total pcg iters = %d\n',sum(pitrs)));
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
%       Calcolo AX (PCG)
function [y] = AXfunc_l1_ls(x,A,At,d1,d2,p1,p2,p3)
%
% y = hessphi*[x1;x2],
%
% dove hessphi = [A'*A*2+D1 , D2;
%                  D2        , D1];

n  = length(x)/2;
x1 = x(1:n);
x2 = x(n+1:end);

y = [(At*((A*x1)*2))+d1.*x1+d2.*x2; d2.*x1+d1.*x2];

%       Calcololo P^{-1}X (PCG)
function [y] = Mfunc_l1_ls(x,A,At,d1,d2,p1,p2,p3)
%
% y = P^{-1}*x,
%

n  = length(x)/2;
x1 = x(1:n);
x2 = x(n+1:end);

y = [ p1.*x1-p2.*x2;...
     -p2.*x1+p3.*x2];

