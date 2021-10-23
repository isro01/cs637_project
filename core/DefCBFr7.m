classdef DefCBFr7
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
        function self = DefCBFr7(params, AffSys) %%, DefMap)
            d_7 = params.d_7;
            v = AffSys.x(4);
            eta_7 = params.eta_7;
            %% d_min_i = DefMap.d_min_i;
            
            self.bx = d_min_i - d_7 - v*eta_7;
            
            self.lg = gradient(self.bx, AffSys.x).' * AffSys.g;
            self.lf = gradient(self.bx, AffSys.x).' * AffSys.f;
            
            sel_vec = zeros(1, params.slack_dim);
            sel_vec(14) = 1;
            self.A = [ -self.lg sel_vec];
            self.b = self.lf + params.eps*self.bx ;
        end
    end
end

%% might have to change variable nam of d_min as unline rule 1 here it is 
%% distance between ego footprints and parked vehicle.
            