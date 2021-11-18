% Rule 5 - Satisfy the minimum speed limit
classdef DefCBFr5
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
        function self = DefCBFr5(params, AffSys) %%, DefMap)
            v = AffSys.x(4);
            v_min = params.v_min;
            
            self.bx = v - v_min;
            
            self.lg = gradient(self.bx, AffSys.x).' * AffSys.g;
            self.lf = gradient(self.bx, AffSys.x).' * AffSys.f;
            
            sel_vec = zeros(1, params.slack_dim);
            sel_vec(14) = 1;
            self.A = [ -self.lg sel_vec];
            self.b =  self.lf + params.eps*self.bx ;
        end
    end
end
