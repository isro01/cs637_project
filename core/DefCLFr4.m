classdef DefCLFr4
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
        function self = DefCLFr4(params, AffSys) %%, DefMap)
            v = AffSys.v;
            v_max = params.v_max;
            
            self.bx = v_max - v;
            
            self.lg = gradient(self.bx, AffSys.x).' * Affsys.g;
            self.lf = gradient(self.bx, AffSys.x).' * Affsys.f;
            
            sel_vec = zeros(params.udim + params.slack_dim);
            sel_vec(7) = 1;
            self.A = [ -self.lg sel_vec];
            self.b = [ self.lf + params.eps*self.bx ];
        end
    end
end
