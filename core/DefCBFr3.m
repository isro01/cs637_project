classdef DefCBFr3
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
            %% d_left, d_right; ( ego coord - lane boundary )
            
            self.bx = d_left + d_right;
            
            self.lg = gradient(self.bx, AffSys.x).' * Affsys.g;
            self.lf = gradient(self.bx, AffSys.x).' * Affsys.f;
            
            sel_vec = zeros(params.udim + params.slack_dim);
            sel_vec(4) = 1;
            self.A = [ -self.lg sel_vec];
            self.b = [ self.lf + params.eps*self.bx ];
        end
    end
end
