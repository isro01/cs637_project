classdef Controller
    properties
        A;
        b;
        H;
        f;
    end
    methods
        function self = Controller(params, Clf)
                        
            self.A = [Clf.A;
                      -eye(params.udim)  zeros(params.udim, params.slack_dim);
                       eye(params.udim)  zeros(params.udim, params.slack_dim) ];
                  
            self.b = [ Clf.b;
                       -params.umin;
                        params.umax ];
                   
            self.f = zeros(params.udim + params.slack_dim, 1);
            
            self.H = [ 2*eye(params.udim)             zeros(params.udim, params.slack_dim);
                       zeros(params.slack_dim, params.udim)  2*params.slack_weight ];
        end
        
        function [u_exp] = optimize(self, AffSys, params, Clf)
            A_double = double(subs(self.A));
            b_double = double(subs(self.b));
            [u_exp, ~, exitflag, ~] = quadprog(self.H, self.f,A_double, b_double);
                       
            if exitflag ==-2 
                disp("Infeasible QP");
                for i = 1:params.udim
                AffSys.u(i) = params.umin * (Clf.lg(i) > 0) + params.umax * (Clf.lg(i) <= 0);
                end            
            else
                AffSys.u = u_exp(1:params.udim);
            end
            
            AffSys.slack = u_exp(params.udim+1:end);
        end
    end
end
                

    