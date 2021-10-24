classdef DefCBFr1
    properties
        bx; %CBF function b(x)
        lf; 
        lg;
        psi1;
        psi2;
        A;
        b;
    end
    methods
        function self = DefCBFr1(params, AffSys, xp, yp) 
            d_1 = params.d_1;
            v = AffSys.x(4);
            eta_1 = params.eta_1;

            d_minf = sqrt( (AffSys.egoX - xp)^2 + (AffSys.egoY - yp )^2 );
                   
            
            self.bx = d_minf - d_1 - v*eta_1 - params.p5*AffSys.x(7);
            
            self.lg = gradient(self.bx, AffSys.x).' * AffSys.g;
            self.lf = gradient(self.bx, AffSys.x).' * AffSys.f;
            
            sel_vec = zeros(1, params.slack_dim);
            sel_vec(10) = 1;
            self.A = [ -self.lg  sel_vec];
            self.b = self.lf + params.eps*self.bx ;
        end
    end
end

            
% after disk coverage formlas all written need to verify relative degree
% by using the d_min from another defMap class - ref (13) in paper and 
% lines below it.