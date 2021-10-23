classdef DefCBFStateConstraints
    properties
        bx; 
        lf; 
        lg;
        A;
        b;
    end
    methods
        function self = DefCBFStateConstraints(params, AffSys)
            v = AffSys.x(4);
            a = AffSys.x(5);
            delta = AffSys.x(6);
            w = AffSys.x(7);
            
            v_min = params.v_min;
            v_max = params.v_max;
            a_min = params.a_min;
            a_max = params.a_max;
            delta_min = params.delta_min;
            delta_max = params.delta_max;
            w_min = params.w_min;
            w_max = params.w_max;
            
            self.bx = [v - v_min + params.p1*a;
                       v_max - v - params.p2*a;
                       a - a_min;
                       a_max - a;
                       delta - delta_min + params.p3*w;
                       delta_max - delta - params.p4*w;
                       w-w_min;
                       w_max-w;];
                   
            self.lf = sym.empty;
            self.lg = sym.empty;
            self.b = sym.empty;
            for i=1:8
                self.lg(i,:) = gradient(self.bx(i), AffSys.x).' * AffSys.g;
                self.lf(i,:) = gradient(self.bx(i), AffSys.x).' * AffSys.f;
                sel_vec = zeros(1, params.slack_dim);
                sel_vec(i+1) = 1;
                self.A(i, :) = [ -self.lg(i,:) sel_vec];
                self.b(i) = self.lf(i,:) + params.eps*self.bx(i);
            end
        end
    end
end