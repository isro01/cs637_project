classdef DefCLFr7
    properties
        bx; %%CBF function b(x)
        lf; 
        lg;
        psi1;
        psi2;
    end
    methods
        function self = DefCLFr1(params, AffSys) %%, DefMap)
            d_7 = params.d_7;
            v = AffSys.x(4);
            eta_7 = params.eta_7;
            %% d_min_i = DefMap.d_min_i;
            
            self.bx = d_min_i - d_7 - v*eta_7;
            
            self.lg = gradient(self.bx, AffSys.x).' * Affsys.g;
            self.lf = gradient(self.bx, AffSys.x).' * Affsys.f;
        end
    end
end

%% might have to change variable nam of d_min as unline rule 1 here it is 
%% distance between ego footprints and parked vehicle.
            