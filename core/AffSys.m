classdef AffSys
    properties
        x;
        f;
        g;
        u;
        slack;
    end
    methods
        function self = AffSys(s, d, mu, v, a, delta, w, ujerk, usteer, params, k, slack)
            self.x = [ s;
                       d;
                       mu;
                       v;
                       a;
                       delta;
                       w];
     
            self.u = [ ujerk;
                       usteer];
            
            self.slack = slack; 
                   
            self.g = [0 0; 
                      0 0;
                      0 0;
                      0 0;
                      1 0;
                      0 0;
                      0 1];
            
            beta = atan(params.lr * tan(self.x(6))/(params.lr+params.lf));
            
            self.f = [ (self.x(4)*cos(beta+self.x(3)))/(1-self.x(2)*k);
                        self.x(4)*sin(beta+self.x(3));
                        self.x(4)*sin(beta)/params.lr - (k*self.x(4)*cos(beta+self.x(3))/(1-self.x(2)*k));
                        self.x(5);
                        0;
                        self.x(7);
                        0 ];
        end
    end
end