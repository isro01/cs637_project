classdef DefCLFr4
    properties
        bx; %%CBF function b(x)
        lf; 
        lg;
        psi1;
        psi2;
    end
    methods
        function self = DefCLFr4(params, AffSys) %%, DefMap)
            v = AffSys.v;
            v_max = params.v_max;
            
            self.bx = v_max - v;
            
            self.lg = gradient(self.bx, AffSys.x).' * Affsys.g;
            self.lf = gradient(self.bx, AffSys.x).' * Affsys.f;
        end
    end
end
