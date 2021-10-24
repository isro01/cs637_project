classdef DefCBFr2
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
        function self = DefCBFr2(params, AffSys, d_lane) 
            % d_left, d_right; ( ego coord - road boundary coord )
            
            self.bx = d_lane;
            
            self.lg = gradient(self.bx, AffSys.x).' * AffSys.g;
            self.lf = gradient(self.bx, AffSys.x).' * AffSys.f;
            
            sel_vec = zeros(1, params.slack_dim);
            sel_vec(11) = 1;
            self.A = [ -self.lg sel_vec];
            self.b = self.lf + params.eps*self.bx ;
        end
    end
end
