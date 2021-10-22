classdef DefCLFr5
    properties
        bx; %%CBF function b(x)
        lf; 
        lg;
        psi1;
        psi2;
    end
    methods
        function self = DefCLFr5(params, AffSys) %%, DefMap)
            v = AffSys.v;
            v_min = params.v_min;
            
            self.bx = v - v_min;
            
            self.lg = gradient(self.bx, AffSys.x).' * Affsys.g;
            self.lf = gradient(self.bx, AffSys.x).' * Affsys.f;
        end
    end
end
