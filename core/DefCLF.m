classdef DefCLF
    properties
        V;  
        lf;
        lg;
        A;
        b;
    end
    methods
        function self = DefCLF(params, AffSys)
            d = AffSys.x(2);
            mu = AffSys.x(3);
            a = AffSys.x(5);
            v = AffSys.x(4);
            vd = params.vd;
            c0 = params.c0;
            k1 = params.k1;
            
            self.V = (d^2) + (mu^2) + c0*((a + k1*(v-vd))^2);
            
            self.lf = gradient(self.V, AffSys.x).' * AffSys.f; 
            self.lg = gradient(self.V, AffSys.x).' * AffSys.g; 
            
            sel_vec = zeros(1, params.slack_dim);
            sel_vec(1) = -1;
            self.A = [self.lg  sel_vec];
            self.b = -self.lf-params.eps*self.V;
        end
    end
end
