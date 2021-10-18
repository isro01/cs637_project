classdef Controller
    properties
        A;
        b;
        H;
        f;
    end
    methods
        
        function self = Controller(params, AffSys, Clf)
            udim = size(AffSys.u, 1);
            slack_dim = size(AffSys.slack, 1);
            
            self.A = [ Clf.lg     params.slack_mat_clf;
                      -eye(udim)  zeros(udim, slack_dim);
                       eye(udim)  zeros(udim, slack_dim) ];
                  
            self.b = [ -Clf.lf-params.eps*Clf.V;
                       -params.umin.';
                        params.umax.' ];
                   
            self.f = zeros(udim + slack_dim, 1);
            
            self.H = [ 2*eye(udim)             zeros(udim, slack_dim);
                       zeros(slack_dim, udim)  2*params.slack_weight ];
        end
        
        function [] = optimize(self, AffSys, params, Clf)
            udim = size(AffSys.u, 1);
                        
            [u_exp, ~, exitflag, ~] = quadprog(self.H, self.f, self.A, self.b);
                       
            if exitflag ==-2 
                disp("Infeasible QP");
                for i = 1:udim
                AffSys.u(i) = params.u_min * (Clf.lg(i) > 0) + params.u_max * (Clf.lg(i) <= 0);
                end            
            else
                AffSys.u = u_exp(1:udim);
            end
            
            AffSys.slack = u_exp(udim+1:end);
        end
    end
end
                

    