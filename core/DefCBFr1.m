classdef DefCBFr1
    properties
        bx; %%CBF function b(x)
        lf; 
        lg;
        psi1;
        psi2;
        A;
        b;
    end
    methods
        function self = DefCLFr1(params, AffSys) %%, DefMap)
            d_1 = params.d_1;
            v = AffSys.x(4);
            eta_1 = params.eta_1;
            %% d_min_i = DefMap.d_min_i;
            
            self.bx = d_min_i - d_1 - v*eta_1;
            
            self.lg = gradient(self.bx, AffSys.x).' * Affsys.g;
            self.lf = gradient(self.bx, AffSys.x).' * Affsys.f;
            
            sel_vec = zeros(params.udim + params.slack_dim);
            sel_vec(2) = 1;
            self.A = [ -self.lg sel_vec];
            self.b = [ self.lf + params.eps*self.bx ];
        end
    end
end

            
%% after disk coverage formlas all written need to verify relative degree
%% by using the d_min from another defMap class - ref (13) in paper and 
%% lines below it.