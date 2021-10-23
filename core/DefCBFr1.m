classdef DefCBFr1
    properties
        bx; %CBF function b(x)
        lf; 
        lg;
        psi1;
        psi2;
        A;
        b;
    end
    methods
        function self = DefCBFr1(params, AffSys, map, d_minf) 
            d_1 = params.d_1;
            v = AffSys.x(4);
            eta_1 = params.eta_1;
%             d_minf = realmax;
%             for i=1:length(map.instanceList)
%                 if map.instanceList(i).type == "pedestrian"
%                     d_minf_i = sqrt( (x_curr - map.instanceList(i).x)^2 + (y_curr - map.instanceList(i).y )^2 );
%                     if d_minf_i <= d_minf
%                         d_minf = d_minf_i;
%                     end
%                 end
%             end
            
            self.bx = d_minf - d_1 - v*eta_1;
            
            self.lg = gradient(self.bx, AffSys.x).' * AffSys.g;
            self.lf = gradient(self.bx, AffSys.x).' * AffSys.f;
            
            sel_vec = zeros(1, params.slack_dim);
            sel_vec(9) = 1;
            self.A = [ -self.lg  sel_vec];
            self.b = self.lf + params.eps*self.bx ;
        end
    end
end

            
% after disk coverage formlas all written need to verify relative degree
% by using the d_min from another defMap class - ref (13) in paper and 
% lines below it.