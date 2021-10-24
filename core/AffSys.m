classdef AffSys
    properties
        x;
        f;
        g;
        u;
        slack;
        xdot;
        k;
        egoX;
        egoY;
    end
    methods
        function self = AffSys(s, d, mu, v, a, delta, w, ujerk, usteer, params, k, slack, xCl, yCl)
            self.x = [ s;
                       d;
                       mu;
                       v;
                       a;
                       delta;
                       w];
            self.egoX = xCl - 0.7*d;
            self.egoY = yCl - 0.7*d;
            
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
            
            self.k = k;
            
            beta = atan(params.lr * tan(self.x(6))/(params.lr+params.lf));
            
            self.f = [ (self.x(4)*cos(beta+self.x(3)))/(1-self.x(2)*self.k);
                        self.x(4)*sin(beta+self.x(3));
                        self.x(4)*sin(beta)/params.lr - (self.k*self.x(4)*cos(beta+self.x(3))/(1-self.x(2)*self.k));
                        self.x(5);
                        0;
                        self.x(7);
                        0 ];
            self.xdot = self.f + self.g*self.u;
        end
    end
end